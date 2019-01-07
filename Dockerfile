FROM ubuntu:18.04

RUN apt-get update && apt-get install -y tzdata && \
	echo "Africa/Johannesburg" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y \
		unzip \
		software-properties-common \
		python \
		python-boto \
    python-boto3 \
    python-dev \
    python-pip \
		jq \
		groff \
		vim \
		curl

RUN pip install --upgrade pip ansible pyopenssl awscli

WORKDIR /opt

ADD https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip /usr/local/bin/terraform_0.11.11_linux_amd64.zip
RUN unzip -q -d /usr/local/bin /usr/local/bin/terraform_0.11.11_linux_amd64.zip && \
	chmod +x /usr/local/bin/terraform && \
	rm -f /usr/local/bin/terraform_0.11.11_linux_amd64.zip

ADD https://github.com/minishift/minishift/releases/download/v1.29.0/minishift-1.29.0-linux-amd64.tgz minishift.tgz
RUN mkdir minishift && tar -xzf minishift.tgz -C minishift --strip-components 1
RUN mv minishift/minishift /usr/local/bin/minishift && \
	chmod +x /usr/local/bin/minishift && \
	rm -rf minishift.tgz minishift


