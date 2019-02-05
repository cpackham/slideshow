SED ?= sed
JQUERY_MIN_JS ?= jquery-3.3.1.min.js
JQUERY_CYCLE2_JS ?= jquery.cycle2.min.js
JQUERY_CYCLE2_CENTER_JS ?= jquery.cycle2.center.js

SNIPPET = <img src="$(1)" alt="$(1)">\n
FILES = $(shell find $(SRC) -name '*.jpg' -o -name '*.JPG' | $(SED) 's| |%20|g')
SLIDESHOW = $(foreach img,$(FILES),$(call SNIPPET,$(img)))

ifeq ($(V),)
Q=@
endif

%.html: %.html.in stylesheet.css Makefile
	@printf "SED\t$@\n"
	$(Q)$(SED) \
		-e 's|@JQUERY_MIN_JS@|$(JQUERY_MIN_JS)|' \
		-e 's|@JQUERY_CYCLE2_JS@|$(JQUERY_CYCLE2_JS)|' \
		-e 's|@JQUERY_CYCLE2_CENTER_JS@|$(JQUERY_CYCLE2_CENTER_JS)|' \
		-e 's|@SLIDESHOW@|$(SLIDESHOW)|' \
		$< >$@

all: index.html

clean:
	$(Q)rm -f index.html

.PHONY: all clean
