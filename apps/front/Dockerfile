FROM node:10

WORKDIR /front

COPY package.json .
COPY package-lock.json .

RUN npm ci

COPY . .

VOLUME [ "./apps/front:/front" ]

ENV HOST=0.0.0.0
ENV PORT=8080

EXPOSE 8080

CMD ["npm", "start"]
