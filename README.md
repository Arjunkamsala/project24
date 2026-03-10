# 🛍️ Mahesh Shopping - TShirt Collections

A Java Web Application (WAR) with a full CI/CD pipeline using Jenkins + Docker + Tomcat.

---

## 📁 Project Structure

```
mahesh-shopping/
├── pom.xml                          ← Maven build config
├── Dockerfile                       ← Custom Docker image (Java + Tomcat)
├── Jenkinsfile                      ← Declarative CI/CD Pipeline
└── src/
    └── main/
        └── webapp/
            ├── index.jsp            ← TShirt Collections UI
            └── WEB-INF/
                └── web.xml          ← Web app descriptor
```

---

## ⚙️ Before Running the Pipeline

### Step 1 — Update Jenkinsfile Variables
Open `Jenkinsfile` and change these at the top:

```groovy
DOCKER_HUB_USER   = 'your-dockerhub-username'   // ← your Docker Hub username
GIT_REPO_URL      = 'https://github.com/your-username/mahesh-shopping.git'
APP_PORT          = '9090'                        // ← port to access app
```

### Step 2 — Add Jenkins Credentials

Go to **Jenkins → Manage Jenkins → Credentials** and add:

| Credential ID         | Type                  | What it's for         |
|-----------------------|-----------------------|-----------------------|
| `git-credentials`     | Username/Password     | GitHub access         |
| `dockerhub-credentials` | Username/Password   | Docker Hub push/pull  |

### Step 3 — Create Jenkins Pipeline Job

1. New Item → **Pipeline**
2. Under Pipeline → Definition: **Pipeline script from SCM**
3. SCM: **Git** → paste your GitHub repo URL
4. Branch: `main`
5. Script Path: `Jenkinsfile`
6. Save → **Build Now**

---

## 🐳 Pipeline Stages

| Stage | What it does |
|-------|-------------|
| 1. Fetch Code | Clones repo from GitHub |
| 2. Build WAR | `mvn clean package` → creates `mahesh-shopping.war` |
| 3. Build Docker Image | Builds custom image with Java + Tomcat |
| 4. Push to Docker Hub | Pushes image with build number tag + latest |
| 5. Deploy Container | Pulls from Docker Hub, runs container on port 9090 |
| 6. Health Check | Verifies app is live via HTTP |
| 7. Summary | Prints final access URL |

---

## 🌐 Access the App

After pipeline succeeds:

```
http://<your-ec2-public-ip>:9090/mahesh-shopping/
```

Make sure port **9090** is open in your EC2 Security Group inbound rules.

---

## 🔧 Manual Docker Commands (Optional)

```bash
# Build image manually
docker build -t mahesh-shopping:1.0 .

# Run container
docker run -d --name mahesh-app -p 9090:8080 mahesh-shopping:1.0

# Check logs
docker logs mahesh-app

# Stop container
docker stop mahesh-app && docker rm mahesh-app
```
