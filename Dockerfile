# Use updated Python image with security patches
FROM python:3.11-slim-bookworm

# Environment settings
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install necessary system packages securely
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    libxml2-dev \
    libxmlsec1-dev \
    libxmlsec1-openssl \
    pkg-config \
    libtool \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose Flask port
EXPOSE 5000

# Start Flask
CMD ["python", "app.py"]
