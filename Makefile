SED ?= sed
TAR ?= tar
SRC ?= images
CURL ?= curl -s
JQUERY_MIN_JS ?= jquery-3.3.1.min.js
JQUERY_CYCLE2_JS ?= jquery.cycle2.min.js
JQUERY_CYCLE2_CENTER_JS ?= jquery.cycle2.center.min.js

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

slideshow.tar.gz: index.html
	@printf "TAR\t$@\n"
	$(Q)$(TAR) -czf $@ index.html stylesheet.css \
		$(JQUERY_MIN_JS) \
		$(JQUERY_CYCLE2_JS) \
		$(JQUERY_CYCLE2_CENTER_JS) \
		$(SRC)/*.jpg $(SRC)/*.JPG

clean:
	$(Q)rm -f index.html slideshow.tar.gz

dist: slideshow.tar.gz

fetch:
	$(Q)$(CURL) https://code.jquery.com/jquery-3.3.1.min.js >$(JQUERY_MIN_JS)
	$(Q)$(CURL) http://malsup.github.io/min/jquery.cycle2.min.js >$(JQUERY_CYCLE2_JS)
	$(Q)$(CURL) http://malsup.github.io/min/jquery.cycle2.center.min.js >$(JQUERY_CYCLE2_CENTER_JS)

.PHONY: all clean dist fetch
