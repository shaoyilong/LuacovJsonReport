local reporter = require'luacov.reporter'

local json
for _,j in ipairs({'cjson','dkjson'}) do
  local ok, mod = pcall(require,j)
  if ok then
    json = mod
    break
  end
end

if not json then
  return error('no json module available')
end

local gcovr = setmetatable({},reporter.ReporterBase)
gcovr.__index = gcovr

function gcovr:on_start()
  self._gcovr_data    = {}
  self._total_hits    = 0
  self._total_missed    = 0
end

function gcovr:on_new_file(filename)

end

function gcovr:on_empty_line(filename, lineno)

end

function gcovr:on_mis_line(filename, lineno, _)

end

function gcovr:on_hit_line(filename, lineno, _, hits)

end

local function coverage_to_number(hits, missed)
   local total = hits + missed

   if total == 0 then
      total = 1
   end

   return tonumber(("%.4f"):format(hits/total))
end

function gcovr:on_end_file(filename, hits, missed)

  self._total_hits = self._total_hits + hits
  self._total_missed = self._total_missed + missed

  self._gcovr_data[filename] = { hits = hits, miss = missed, coverage = coverage_to_number(hits, missed)}

end

local function reportJsonCoverage (coverageData)

   local filepath = "luacoverage.json"
   local file = io.open(filepath, "w")

   if file then
      local jsonResult = json.encode(coverageData)
      file:write(jsonResult)
      file:close()
      print("File '" .. filepath .. "' created and content saved.")
   else
      print("Error: Unable to create file '" .. filepath .. "'.")
   end

end

function gcovr:on_end()
  local totalCoverage = {}
  totalCoverage["hits"] = self._total_hits
  totalCoverage["miss"] = self._total_missed
  totalCoverage["coverage"] = coverage_to_number(self._total_hits, self._total_missed)
  self._gcovr_data["total"] = totalCoverage

  reportJsonCoverage(self._gcovr_data)
  self._gcovr_data = nil
end

return {
  GcovrReporter = gcovr,
  report = function()
    return reporter.report(gcovr)
  end,
}
