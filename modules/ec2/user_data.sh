#!/bin/bash
set -e

# --- install docker ---
if command -v dnf >/dev/null 2>&1; then
  dnf install -y docker
  systemctl enable docker
  systemctl start docker
else
  yum install -y docker
  service docker start
fi

usermod -aG docker ec2-user

# --- install docker-compose ---
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
-o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# --- app folder ---
mkdir -p /opt/app/frontend
cd /opt/app

# --- docker-compose.yml ---
cat <<'EOF' > docker-compose.yml
services:

  db:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: secret123
    volumes:
      - db_data:/var/lib/postgresql/data

  backend:
    image: hashicorp/http-echo
    command: ["-text=Backend works"]
    restart: always

  frontend:
    image: nginx:alpine
    volumes:
      - ./frontend:/usr/share/nginx/html:ro

  nginx:
    image: nginx:alpine
    restart: always
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - frontend
      - backend

volumes:
  db_data:
EOF

# --- nginx.conf ---
cat <<'EOF' > nginx.conf
events {}

http {

  upstream frontend { server frontend:80; }
  upstream backend { server backend:5678; }

  server {
    listen 80;

    location / {
      proxy_pass http://frontend;
    }

    location /api/ {
      proxy_pass http://backend;
    }

    location /health {
      return 200 "ok\n";
    }
  }
}
EOF

# --- frontend ---
cat <<'EOF' > frontend/index.html
<!DOCTYPE html>
<html>
<body>

<h1>Simple Fullstack App</h1>

<button onclick="callApi()">Call backend</button>
<p id="result"></p>

<script>
function callApi(){
  fetch('/api/')
    .then(r=>r.text())
    .then(t=>document.getElementById('result').innerText=t)
}
</script>

</body>
</html>
EOF

# --- run containers ---
/usr/local/bin/docker-compose up -d
