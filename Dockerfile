FROM python:3.5.2-slim

RUN apt-get update
RUN apt-get install -y g++ libc-dev unixodbc-dev curl apt-transport-https

RUN pip install pyodbc
RUN pip install pandas

# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017#microsoft-odbc-driver-131-for-sql-server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update

RUN ACCEPT_EULA=Y apt-get -y install msodbcsql
# optional: for bcp and sqlcmd
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
ENV PATH="/opt/mssql-tools/bin:${PATH}"

# https://github.com/Microsoft/mssql-docker/issues/163
RUN apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen
