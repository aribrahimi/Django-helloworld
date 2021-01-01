FROM python:3.8-alpine

ENV PATH="/scripts:${PATH}"
COPY ./requirements.txt /requirements.txt

RUN apk add --update --no--cache --virtual .tmp gcc libs-dev linux-headers

RUN pip install -r /requirements.txt

RUN apk del .tmp

RUN mkdir /app

COPY ./app /app

WORKDIR /app

WORKDIR /client

COPY package*.json /client/

RUN npm install

COPY . /client/

EXPOSE 3000
CMD [ "npm", "start"]