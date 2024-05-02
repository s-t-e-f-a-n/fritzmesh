FROM python:3.10-slim


LABEL stage=builder

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
COPY ./requirements.txt .
RUN python -m pip install -r requirements.txt

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
WORKDIR /data

# Copy data for add-on
COPY fritzmesh /etc/
COPY fritzmesh.py /
RUN chmod a+x /fritzmesh.py

CMD [ "/fritzmesh.py", "-nocache" ]
