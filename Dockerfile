FROM centos

# Update and basic installations
RUN yum update -y
RUN yum install -y vim

# Install pdns 4.0.x
RUN yum install -y epel-release yum-plugin-priorities
RUN curl -o /etc/yum.repos.d/powerdns-auth-40.repo https://repo.powerdns.com/repo-files/centos-auth-40.repo
RUN yum install -y pdns-4.0.3-1 pdns-backend-sqlite pdns-tools

RUN mkdir /pdns
COPY ./entrypoint.sh /pdns/entrypoint.sh
COPY ./init.sql /pdns/init.sql
RUN mkdir /data

WORKDIR /pdns

VOLUME ["/data"]
EXPOSE 53/udp 53/tcp
ENTRYPOINT ["/pdns/entrypoint.sh"]
