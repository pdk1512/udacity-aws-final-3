FROM python:3.10-slim-buster

USER root

RUN apt update -y && apt install build-essential libpq-dev -y

WORKDIR /src

COPY ./analytics/requirements.txt requirements.txt

# Dependencies are installed during build time in the container itself so we don't have OS mismatch
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt
RUN pip install Werkzeug==2.2.2

COPY ./analytics .

EXPOSE 5153

# Start the database and Flask application
CMD python app.py
