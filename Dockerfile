# ---- Base image ----
FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-runtime

# ---- Install system dependencies ----
RUN apt-get update && apt-get install -y ffmpeg libsndfile1 && rm -rf /var/lib/apt/lists/*

# ---- Set working directory ----
WORKDIR /app/src

# ---- Copy project files ----
COPY . /app/src

# ---- Install Python dependencies ----
RUN pip install --upgrade pip setuptools wheel && \
    pip install -r requirements.txt

# ---- Environment variable for Google credentials ----
ENV GOOGLE_APPLICATION_CREDENTIALS=/app/src/vits-tts-vi.json

# ---- Expose web server port ----
EXPOSE 7860

# ---- Start server directly ----
CMD ["python", "server.py"]