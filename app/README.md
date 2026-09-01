docker build -t mi-app:1.0 .
docker run -d -p 3000:3000 --name devops-app mi-app:1.0
docker stop devops-app
docker rm devops-app


docker compose up -d --build
docker compose ps
docker compose logs -f

mkdir -p .github/workflows