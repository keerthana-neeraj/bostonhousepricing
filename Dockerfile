# Use a lighter base image
FROM python:3.7-slim

# Set the working directory in the container
WORKDIR /app

# Copy only requirements.txt first to leverage Docker's cache during builds
COPY requirements.txt /app/

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Set the default PORT environment variable (Heroku uses $PORT, you can override it if needed)
ENV PORT=8080

# Expose the port the app will run on
EXPOSE $PORT

# Start the app with gunicorn
CMD ["gunicorn", "--workers=4", "--bind", "0.0.0.0:8080", "app:app"]