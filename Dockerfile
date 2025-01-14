FROM python:3.7
WORKDIR /app
ADD . .
ENV DATABASE_URI="localhost"
RUN pip install -r requirements.txt
RUN pip install psycopg2-binary
CMD ["python", "main.py"]
EXPOSE 80