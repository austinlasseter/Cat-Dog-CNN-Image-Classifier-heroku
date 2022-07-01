FROM python:3.9-slim
ARG port

USER root
COPY . /Cat-Dog-CNN-Image-Classifier-heroku
WORKDIR /Cat-Dog-CNN-Image-Classifier-heroku

ENV PORT=$port

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y install curl \
    && apt-get install libgomp1

RUN chgrp -R 0 /Cat-Dog-CNN-Image-Classifier-heroku \
    && chmod -R g=u /Cat-Dog-CNN-Image-Classifier-heroku \
    && pip install pip --upgrade \
    && pip install -r requirements.txt
EXPOSE $PORT

CMD gunicorn app:server --bind 0.0.0.0:$PORT --preload
