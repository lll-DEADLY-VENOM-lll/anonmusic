# Python version 3.11 ya 3.12 use karna zyada stable hai music bots ke liye
FROM python:3.11-slim-buster

# System dependencies install karein
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    unzip \
    git \
    build-essential \
    python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Deno install karein
RUN curl -fsSL https://deno.land/install.sh | sh

# Deno Environment variables set karein
ENV DENO_INSTALL="/root/.deno"
ENV PATH="$DENO_INSTALL/bin:$PATH"

# Work directory set karein
WORKDIR /app

# Requirements install karein
COPY requirements.txt .
RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -U -r requirements.txt

# Baaki saara code copy karein
COPY . .

# Bot start karne ki command
CMD ["bash", "start"]
