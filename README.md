# 🔗 Shlink - URL Shortener me Docker

Projekt i plotë URL shortener me **3 Docker Containers**:

| Container | Image | Roli |
|-----------|-------|------|
| `shlink_database` | `postgres:16-alpine` | Ruan të dhënat |
| `shlink_api` | `shlinkio/shlink:stable` | Backend API |
| `shlink_web` | `shlinkio/shlink-web-client:stable` | Frontend UI |
| `shlink_nginx` | `nginx:alpine` | Reverse proxy |

---

## 🚀 Si të Fillosh

### Hapi 1 - Kopjo variablat e mjedisit
```bash
cp .env.example .env
```

### Hapi 2 - Ndrysho `.env` sipas dëshirës
```env
DB_PASSWORD=fjalekalimi_yt_i_forte
INITIAL_API_KEY=celes_api_shume_sekret
DEFAULT_DOMAIN=localhost   # ose domain-i yt p.sh: shrt.al
```

### Hapi 3 - Ndiz të gjithë containers
```bash
docker-compose up -d
```

### Hapi 4 - Kontrollo që janë ndezur
```bash
docker-compose ps
```

---

## 🌐 Akseso Projektin

| Shërbim | URL |
|---------|-----|
| **Web UI** | http://localhost:3000 |
| **Nginx (kryesor)** | http://localhost:80 |
| **API direkt** | http://localhost:8080/rest |
| **Database** | localhost:5432 |

---

## 📋 Si të Përdorësh API-n

### Krijo URL të shkurtër
```bash
curl -X POST http://localhost/rest/v3/short-urls \
  -H "X-Api-Key: my-super-secret-api-key-change-me" \
  -H "Content-Type: application/json" \
  -d '{
    "longUrl": "https://www.example.com/faqe-shume-e-gjate",
    "customSlug": "shembull",
    "title": "Titulli im"
  }'
```

**Përgjigja:**
```json
{
  "shortUrl": "http://localhost/shembull",
  "longUrl": "https://www.example.com/faqe-shume-e-gjate"
}
```

### Listo të gjitha URL-të
```bash
curl http://localhost/rest/v3/short-urls \
  -H "X-Api-Key: my-super-secret-api-key-change-me"
```

### Shiko statistikat
```bash
curl http://localhost/rest/v3/short-urls/shembull/visits \
  -H "X-Api-Key: my-super-secret-api-key-change-me"
```

### Fshi URL
```bash
curl -X DELETE http://localhost/rest/v3/short-urls/shembull \
  -H "X-Api-Key: my-super-secret-api-key-change-me"
```

---

## 🔧 Komanda të Dobishme

```bash
# Shiko logs
docker-compose logs -f

# Shiko logs të container specifik
docker-compose logs -f api
docker-compose logs -f database

# Ndalo projektin
docker-compose down

# Ndalo dhe fshi të gjitha të dhënat
docker-compose down -v

# Rinicio një container
docker-compose restart api

# Hyr brenda container
docker exec -it shlink_api sh
docker exec -it shlink_database psql -U shlink -d shlink
```

---

## 📁 Struktura e Projektit

```
shlink-project/
├── docker-compose.yml      # Konfigurimi i containers
├── .env.example            # Template për variablat
├── .env                    # Variablat tuaja (mos e commit!)
├── database/
│   └── init.sql            # SQL fillestar për DB
├── nginx/
│   ├── nginx.conf          # Konfigurimi kryesor nginx
│   └── default.conf        # Virtual host & routing
└── README.md               # Ky file
```

---

## 🌍 Deployment me Domain Real

Nëse ke domain të vërtetë (p.sh. `shrt.al`):

1. Ndrysho `.env`:
   ```env
   DEFAULT_DOMAIN=shrt.al
   IS_HTTPS_ENABLED=true
   ```

2. Shto SSL certificate (certbot/Let's Encrypt)

3. Ndrysho `nginx/default.conf` me `server_name shrt.al;`

---

## ❓ Troubleshooting

**API nuk fillon?**
```bash
docker-compose logs api
# Prit 30 sekonda për database të jetë gati
```

**Database connection error?**
```bash
docker-compose restart api
```

**Port i zënë?**
Ndrysho port-et në `docker-compose.yml` sipas nevojës.
