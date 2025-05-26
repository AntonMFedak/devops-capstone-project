FROM python:3.9-slim

# Create working directory and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy service package to the folder with the same name
COPY service/ ./service/

# Create new user, non-root, change to new user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Execute an app
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
