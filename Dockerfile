FROM python:3.10.0

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get install netcat -y
RUN apt-get upgrade -y && apt-get install postgresql gcc python3-dev musl-dev -y
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python3 - && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

COPY ./pyproject.toml ./poetry.lock* /usr/src/app/

RUN poetry install

# Copy the entrypoint script and set executable permission
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# Copy the rest of the application code
COPY . .

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]