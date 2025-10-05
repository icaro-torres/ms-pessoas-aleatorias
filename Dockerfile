FROM python:3.13-slim AS builder

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt .

RUN pip wheel --no-cache-dir --wheel-dir /app/wheels -r requirements.txt

FROM python:3.13-slim

WORKDIR /app

COPY --from=builder /app/wheels /app/wheels

COPY . .

RUN pip install --no-cache-dir /app/wheels/*

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]