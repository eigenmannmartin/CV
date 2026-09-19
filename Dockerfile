FROM debian:13-slim AS build-stage

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       make texlive-latex-base texlive-latex-extra \
       texlive-fonts-extra \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/cv

COPY Makefile cv.tex sidebar.tex sidebar2.tex altacv.cls martin_portrait.jpeg ./
RUN make pdf PDFLATEX=pdflatex

FROM scratch AS export-stage
COPY --from=build-stage /usr/src/cv/public/index.pdf /index.pdf
