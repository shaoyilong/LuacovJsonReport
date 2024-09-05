package = "luacov-json-report"
version = "0.0.1-1"

source = {
    url = "https://github.com/jprjr/luacov-reporter-gcovr/archive/0.0.1.tar.gz",
    file = "luacov-reporter-gcovr-0.0.1.tar.gz",
}

description = {
    summary = "A luacov reporter that generates gcovr JSON traces",
    homepage = "https://github.com/jprjr/luacov-reporter-gcovr",
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
