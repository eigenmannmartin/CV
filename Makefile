TECTONIC ?= tectonic
PDFLATEX ?= pdflatex
BUILD_DIR := .build
PDF := public/index.pdf

.PHONY: pdf docker clean
.DEFAULT_GOAL := pdf

pdf:
	@mkdir -p "$(BUILD_DIR)" public
	@if command -v "$(TECTONIC)" >/dev/null 2>&1; then \
		"$(TECTONIC)" --keep-logs --outdir "$(BUILD_DIR)" cv.tex; \
	elif command -v "$(PDFLATEX)" >/dev/null 2>&1; then \
		"$(PDFLATEX)" -interaction=nonstopmode -halt-on-error -file-line-error -output-directory="$(BUILD_DIR)" cv.tex && \
		"$(PDFLATEX)" -interaction=nonstopmode -halt-on-error -file-line-error -output-directory="$(BUILD_DIR)" cv.tex; \
	else \
		printf '%s\n' 'Install Tectonic or pdfLaTeX, or use make docker. See Readme.md.' >&2; \
		exit 1; \
	fi
	cp "$(BUILD_DIR)/cv.pdf" "$(PDF)"
	@printf '%s\n' 'Built $(PDF)'

docker:
	docker build --output type=local,dest=./public .

clean:
	rm -rf "$(BUILD_DIR)"
	rm -f "$(PDF)"
