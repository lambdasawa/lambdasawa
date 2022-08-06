FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update &&\
  apt-get install -y curl &&\
  rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - &&\
  apt-get install -y nodejs

COPY application/package.json /app

RUN npm install

RUN npx playwright install --with-deps

COPY application/index.js /app

CMD [ "node", "index.js" ]
