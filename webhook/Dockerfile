FROM python:3.8-slim

RUN pip3 install gunicorn
# Copy python requirements file
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
# Remove pip cache. We are not going to need it anymore
RUN rm -r /root/.cache

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY ./app ./

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app