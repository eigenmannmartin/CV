# Martin Eigenmann's CV

The CV is written in LaTeX using the included AltaCV class. Both build options
produce `public/index.pdf`.

## Build locally

On Linux, install [Tectonic](https://tectonic-typesetting.github.io/book/latest/installation/)
for your CPU architecture and put the `tectonic` executable on your `PATH`.
This environment is Linux ARM64 (`uname -m` reports `aarch64`). Then run:

```sh
make pdf
```

Open the resulting `public/index.pdf` in your PDF viewer.

Tectonic downloads the required LaTeX packages and fonts on the first build, so
that build needs internet access. Later builds reuse its cache.

If `pdflatex` is already installed, `make pdf` can use that instead. The document
needs the LaTeX extra packages and the Lato and Font Awesome fonts. On
Debian/Ubuntu these are provided by `texlive-latex-base`, `texlive-latex-extra`,
and `texlive-fonts-extra`.

Tectonic takes precedence when both compilers are installed. A downloaded binary
can be selected explicitly:

```sh
make pdf TECTONIC=/path/to/tectonic
```

The intermediate PDF and build log are in `.build/`. Run `make pdf` again after
editing the sources; `make clean` removes generated build files and the output PDF.

On macOS, the equivalent setup with Homebrew is:

```sh
brew install tectonic
make pdf
open public/index.pdf
```

## Build with Docker

With Docker running:

```sh
make docker
```

The equivalent command is:

```sh
docker build --output type=local,dest=./public .
```

The container includes the LaTeX dependencies and portrait. It exports only the
finished PDF, and does not require a LaTeX installation on the host.

## Source files

- `cv.tex`: profile header and professional experience.
- `sidebar.tex`: core skills, coaching and data protection courses on page one.
- `sidebar2.tex`: certifications, education and languages on page two.
- `altacv.cls`: shared layout and typography.
- `martin_portrait.jpeg`: portrait used in the document.
