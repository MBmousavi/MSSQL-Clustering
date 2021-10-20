FROM mcr.microsoft.com/mssql/server:2019-CU12-ubuntu-20.04

ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Developer

ENV CERTFILE "certificate/dbm_certificate.cer"
ENV CERTFILE_PWD "certificate/dbm_certificate.pvk"

RUN mkdir /usr/certificate
WORKDIR /usr/
COPY ${CERTFILE} ./certificate
COPY ${CERTFILE_PWD} ./certificate

USER root

RUN chown mssql:root /usr/certificate/dbm_certificate.pvk
RUN chown mssql:root /usr/certificate/dbm_certificate.cer

CMD /opt/mssql/bin/sqlservr
