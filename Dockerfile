FROM python:3.14-slim

# Первая переменная запрещает создание pyc файлов, вторая переменная запрещает буферизацию вывода и ошибок, 
# что позволяет видеть вывод в реальном времени.
ENV PYTHONDONTWRITEBYTECODE 1 && \
    PYTHONUNBUFFERED 1

WORKDIR /app

COPY pyproject.toml .

RUN pip install --no-cache-dir .

COPY . .

WORKDIR /app/src

RUN chmod +x ../run.sh

CMD ["bash", "../run.sh"]