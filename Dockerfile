FROM python:3.14-slim

# Первая переменная запрещает создание pyc файлов, вторая переменная запрещает буферизацию вывода и ошибок,
# что позволяет видеть вывод в реальном времени.
ENV PYTHONDONTWRITEBYTECODE 1 && \
    PYTHONUNBUFFERED 1

RUN groupadd -r app_user && useradd -r -g app_user app_user

WORKDIR /app

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY pyproject.toml .

RUN uv pip install --system --no-cache-dir .

COPY --chown=app_user:app_user . .

USER app_user

RUN chmod +x ./run.sh

CMD ["./run.sh"]
