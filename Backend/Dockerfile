FROM python:3.10-slim-buster

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# copy project files
COPY . /hesapp
WORKDIR /hesapp

# install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# run the service
CMD ["python3", "src/app.py"]
