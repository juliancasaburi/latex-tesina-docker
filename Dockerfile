FROM ubuntu:22.04

# Set environment variable for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnuplot \
        python3-pygments \
        texlive-binaries \
        texlive-lang-spanish \
        texlive-latex-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-luatex \
        texlive-bibtex-extra \
        latexmk \
        luatex \
        xindy \
        biber \
        make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up the working directory and volume
WORKDIR /latex
VOLUME ["/latex"]

# Copy and set up entrypoint script
COPY ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

# Create necessary directories and copy custom LaTeX support files
RUN mkdir -p /usr/local/share/texmf/tex/latex/contrib
COPY ./support/* /usr/local/share/texmf/tex/latex/contrib/
RUN texhash /usr/local/share/texmf

# Handle Xindy symbolic links for Spanish language support
RUN ln -sf /usr/share/xindy/lang/spanish/modern-utf8-lang.xdy /usr/share/xindy/lang/spanish/utf8-lang.xdy && \
    ln -sf /usr/share/xindy/lang/spanish/modern-utf8-test.xdy /usr/share/xindy/lang/spanish/utf8-test.xdy && \
    ln -sf /usr/share/xindy/lang/spanish/modern-utf8.xdy /usr/share/xindy/lang/spanish/utf8.xdy

# Set entrypoint
ENTRYPOINT ["/bin/entrypoint.sh"]
