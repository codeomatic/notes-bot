FROM codeomatic/base-uwsgi-cloud-run:v20.07.3

# Copy python requirements file
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
RUN pip3 install gunicorn
# Remove pip cache. We are not going to need it anymore
RUN rm -r /root/.cache


# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY ./app ./


#CMD exec uwsgi \
#    --http-socket 0.0.0.0:$PORT \
#    --static-map /static=/app/static/ \
#    --callable app \
#    --wsgi-file /app/main.py

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app