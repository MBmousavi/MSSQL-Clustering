FROM mcr.microsoft.com/mssql/server:2019-CU12-ubuntu-20.04

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD="vei3aec4foo}C~iopiet"
ENV MSSQL_PID=Developer
ENV MSSQL_TCP_PORT=3342

ENV CERTFILE "certificate/dbm_certificate.cer"
ENV CERTFILE_PWD "certificate/dbm_certificate.pvk"

RUN mkdir /usr/certificate
WORKDIR /usr/
COPY ${CERTFILE} ./certificate
COPY ${CERTFILE_PWD} ./certificate

USER root
RUN /opt/mssql/bin/mssql-conf set hadr.hadrenabled 1
RUN /opt/mssql/bin/mssql-conf set sqlagent.enabled true

RUN chown mssql:root /usr/certificate/dbm_certificate.pvk
RUN chown mssql:root /usr/certificate/dbm_certificate.cer

CMD /opt/mssql/bin/sqlservr
