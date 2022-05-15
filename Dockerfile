FROM debian:9 as build-stage


RUN apt-get update \
    && apt-get install -y \
    texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-bibtex-extra \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Set the default working directory
WORKDIR /usr/src


RUN mkdir /public
# Copy the relevant files to the working directory
COPY cv.tex ./
COPY sidebar.tex ./
COPY sidebar2.tex ./
COPY altacv.cls ./
COPY Image.png ./
RUN pdflatex cv.tex && gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/public/cv.pdf cv.pdf


FROM scratch AS export-stage
COPY --from=build-stage /public/cv.pdf /cv.pdf