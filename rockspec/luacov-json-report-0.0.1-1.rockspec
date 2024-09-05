package = "luacov-json-report"
version = "0.0.1-1"

source = {
    url = "https://github.com/shaoyilong/LuacovJsonReport/archive/refs/heads/develop.tar.gz",
    file = "LuacovJsonReport-develop.tar.gz",
}

description = {
    summary = "A luacov reporter that generates JSON file",
    homepage = "https://github.com/shaoyilong/LuacovJsonReport",
    license = "MIT";
}

build = {
    type = "builtin",
    modules = {
        ["luacov.reporter.jsonreport"] = "src/jsonreport.lua",
    }
}


dependencies = {
    "lua >= 5.1",
    "luacov",
}
