FROM python:3.8.5

MAINTAINER boruili "librchn@gmail.com"

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

RUN mkdir /code
WORKDIR /code
ADD daka.py daka.py
ADD requirements.txt requirements.txt
ADD config.json config.json
RUN pip3 install --upgrade pip \
    && pip3 install -r /code/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && apt update \
    && apt install -y tzdata \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["python3", "daka.py"]