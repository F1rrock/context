FROM dart:stable

WORKDIR /app

COPY pubspec.* ./
COPY ./lib ./lib
COPY ./test ./test
COPY ./example ./example
COPY ./README.md ./README.md
COPY ./CHANGELOG.md ./CHANGELOG.md
COPY ./LICENSE ./LICENSE

RUN dart pub get

EXPOSE 8080

CMD ["/bin/bash"]
