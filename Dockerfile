# 🐳 Dockerfile for SGP Ticket Bot with Headless Chrome
FROM python:3.11-slim

# Install system dependencies (Chrome, fonts, etc.)
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    gnupg \
    libnss3 \
    libgconf-2-4 \
    libxi6 \
    libxcursor1 \
    libxcomposite1 \
    libxdamage1 \
    libxtst6 \
    libappindicator1 \
    libasound2 \
    fonts-liberation \
    xdg-utils \
    chromium \
    chromium-driver \
 && rm -rf /var/lib/apt/lists/*

# Set display for headless chrome
ENV CHROME_BIN=/usr/bin/chromium 
ENV PATH="$PATH:/usr/lib/chromium/"

# Create app directory
WORKDIR /app

# Copy requirements and install Python packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy app source code
COPY . .

# Start the Flask server
CMD ["python", "main.py"]
