FROM python:3.5.2-alpine

RUN apk add --no-cache g++ libc-dev unixodbc-dev

RUN pip install pyodbc
RUN pip install pandas
