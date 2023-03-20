FROM python:3.7
WORKDIR /app
ADD . .
ENV DATABASE_URI="localhost"
RUN pip install -r requirements.txt
CMD ["python", "main.py"]