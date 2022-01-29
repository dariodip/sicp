FROM racket/racket

RUN apt-get update \
        && apt-get -y install --no-install-recommends curl xvfb git build-essential xauth \
        && apt-get autoremove -y \
        && apt-get clean -y

RUN raco pkg install --auto racket-langserver sicp
RUN raco setup

RUN echo 'export FONTCONFIG_PATH=/etc/fonts' >>~/.bashrc
