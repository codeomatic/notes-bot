FROM codeomatic/base-uwsgi-cloud-run:v20.07.3

# Copy python requirements file
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
# Remove pip cache. We are not going to need it anymore
RUN rm -r /root/.cache

# Add our application files
RUN mkdir app
COPY ./app /app
WORKDIR /app

EXPOSE 8080

CMD ["/usr/local/bin/uwsgi", "--ini", "/etc/uwsgi.ini"]