FROM python:3.14-slim

# Первая переменная запрещает создание pyc файлов, вторая переменная запрещает буферизацию вывода и ошибок, 
# что позволяет видеть вывод в реальном времени.
ENV PYTHONDONTWRITEBYTECODE 1 && \
    PYTHONUNBUFFERED 1

WORKDIR /app

# Установка uv из ghcr.io/astral-sh/uv:latest и копирование его в контейнер
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY pyproject.toml .

RUN uv pip install --system --no-cache-dir .

COPY . .

WORKDIR /app/src

RUN chmod +x ../run.sh

CMD ["bash", "../run.sh"]