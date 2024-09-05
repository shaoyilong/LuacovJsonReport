PKGCONFIG = pkg-config
LUA = lua
INSTALL_LMOD = $(shell $(PKGCONFIG) --variable=INSTALL_LMOD $(LUA))

.PHONY: install

install:
	install -Dm0644 src/jsonreport.lua $(DESTDIR)$(INSTALL_LMOD)/luacov/reporter/jsonreport.lua
