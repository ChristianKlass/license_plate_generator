FROM debian:stable-slim
WORKDIR /app

RUN apt-get update && \
    apt-get install -y imagemagick potrace curl --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY plategen.sh .
COPY CharlesWright-Bold.otf .

RUN chmod +x ./plategen.sh
ENTRYPOINT ["./plategen.sh"]

CMD ["--help"]
