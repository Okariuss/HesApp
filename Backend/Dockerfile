FROM python:3.10-slim-buster

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# copy project files
COPY . /app
WORKDIR /app

# install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# run the service
CMD ["python", "-m", "src"]
