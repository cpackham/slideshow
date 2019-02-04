SED ?= sed
JQUERY_MIN_JS ?= https://code.jquery.com/jquery-latest.min.js

SNIPPET = <img src="$(1)" alt="$(1)">\n
FILES = $(shell find $(SRC) -name '*.jpg' -o -name '*.JPG' | $(SED) 's| |%20|g')
SLIDESHOW = $(foreach img,$(FILES),$(call SNIPPET,$(img)))

ifeq ($(V),)
Q=@
endif

%.html: %.html.in
	$(Q)$(SED) \
		-e 's|@JQUERY_MIN_JS@|$(JQUERY_MIN_JS)|' \
		-e 's|@SLIDESHOW@|$(SLIDESHOW)|' \
		$^ >$@

all: slideshow.css slideshow.js Makefile index.html

clean:
	$(Q)rm -f index.html
