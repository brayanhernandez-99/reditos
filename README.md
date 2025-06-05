# Grupo Reditos
Prueba técnica para el Grupo Reditos, con el objetivo de evaluar las habilidades en los siguientes temas:

- Infraestructura como Código **(IaC - Terraform).**
- Automatización **(Ansible).**
- Integración y Despliegue Continuo **(CI/CD - GitHub Actions).**
- Manejo de contenedores **(Docker - Kubernetes).**
- Seguridad en la infraestructura

## Estructura Principal 
```bash
reditos/
├── README.md                    # Documentación principal del proyecto.
├── .github/workflows            # Automatización con GitHub Actions (CI/CD).
├── ansible/
│   ├── .gitignore               # Ignora archivos temporales o sensibles.
│   ├── inventory.ini            # Lista de hosts para ejecutar los playbooks.
│   ├── site.yml                 # Playbook principal: define las tareas a ejecutar.
│   ├── group_vars/              # Variables globales y encriptadas (vault).
│   └── roles/
│       └── nginx/               # Rol específico para instalar/configurar NGINX.
│           ├── tasks/           # Tareas que define el rol.
│           ├── templates/       # Archivos plantilla (HTML, config, etc).
│           └── vars/            # Variables locales al rol.
├── docker/
│   ├── .gitignore               # Ignora archivos temporales o sensibles.
│   ├── .env                     # Variables de entorno para contenedores.
│   ├── Dockerfile               # Imagen base del servicio (probablemente web).
│   ├── index.js                 # Código fuente principal del servicio Node.js.
│   ├── package.json             # Dependencias y scripts de Node.js.
│   ├── kubernetes/              # Archivos de despliegue para clúster k8s.
│   │   ├── cluster.yml          # Configuración del clúster.
│   │   ├── deployment.yaml      # Despliegue de la app en k8s.
│   │   ├── fluentd.yaml         # Agente de logging (Fluentd) "DaemonSet".
│   │   └── service.yaml         # Servicio expuesto (LoadBalancer o ClusterIP).
│   └── test/                    # Pruebas automáticas para la app.
│       ├── health.test.js       # Test de endpoint `/health`.
│       ├── index.test.js        # Test general del index.
│       └── notfound.test.js     # Test para rutas 404.
└── terraform/
    ├── .gitignore               # Ignora archivos temporales o sensibles.
    ├── main.tf                  # Infraestructura principal (recursos raíz).
    ├── provider.tf              # Proveedor configurado (AWS, GCP, etc).
    ├── terraform.tfvars         # Valores concretos para variables.
    ├── variables.tf             # Definición de variables reutilizables.
    └── modules/                 # Módulos reutilizables para componentes clave.
        ├── ec2/                 # Recursos relacionados con instancias EC2.
        ├── network/             # Recursos de red (VPC, subnets, etc).
        └── rds/                 # Configuración de base de datos RDS.
```

---

# 1. Infraestructura como Código (IaC) con Terraform
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Instalar **Terraform**: https://developer.hashicorp.com/terraform/downloads
- Poseer una cuenta activa en **AWS**: https://aws.amazon.com/es/free
- Tener instalado y configurado el **AWS CLI**: https://aws.amazon.com/es/cli/

Una vez cumplidos los requisitos, seguir los siguientes pasos:

**1. Inicializar el proyecto:**
- Prepara tu entorno de trabajo.
- Descarga los proveedores (como aws).
- Inicializa el backend si estás usando almacenamiento remoto de estado (por ejemplo, S3).
```bash
cd terraform 
terraform init
```

**2. Verificar el plan de ejecución:**
- Muestra un plan de lo que Terraform va a hacer, sin ejecutar nada todavía.
- Compara tu configuración (.tf files) con el estado actual y calcula qué recursos crear, cambiar o destruir.
```bash
terraform plan
```

**3. Aplicar los cambios (desplegar infraestructura):**
- Aplica los cambios necesarios para alcanzar el estado deseado definido en tus archivos .tf.
- Te pedirá confirmación antes de ejecutar, a menos que uses -auto-approve.
```bash
terraform apply
```

**4. Borrar los cambios:**
- Elimina todos los recursos que Terraform haya creado previamente según el archivo de estado.
- Ideal para limpiar recursos en entornos de desarrollo o pruebas.
- Te pedirá confirmación antes de ejecutar, a menos que uses -auto-approve.
```bash
terraform destroy
```
---

# 2.  Automatización de Configuración con Ansible.
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Instalar **Python 3**: https://www.python.org/downloads/
- Instalar **Ansible**: https://www.ansible.com/
- Acceso a una instancia **EC2**
- Llave privada **SSH** (PEM): https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/create-key-pairs.html

Una vez cumplidos los requisitos, seguir los siguientes pasos:

**1. Ejecución local del Playbook en Ansible:**
```bash
# Encriptar contraseñas 
ansible-vault encrypt group_vars/vault.yml

# Cambiar la contraseña del vault:
ansible-vault rekey group_vars/vault.yml

# Editar el vault:
ansible-vault edit vault.yml

# Ejecutar Playbook
ansible-playbook -i inventory.ini site.yml --ask-vault-pass
  
# Nota: Password vault.yml
  password: ansible
```

**2. Ejecución del Playbook desde un contenedor con Ansible:**
```bash
# Descargar imagen de Ansible
docker pull alpine/ansible:latest

# Ejecutar contenedor de Ansible
docker run -it alpine/ansible:latest "/bin/bash"
```

---

# 3. Contenedores y Orquestación con Docker y Kubernetes
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Instalar **Docker**: https://www.docker.com/products/docker-desktop/
- Cuenta en Docker Hub: https://hub.docker.com/repositories/
- Descargar **Kubernetes** (Kind): https://kind.sigs.k8s.io/
- Descargar **kubectl**: https://kubernetes.io/docs/tasks/tools/
- Descargar **Node.js**: https://nodejs.org/en/download
- Crear cuenta en **loggly.com**: https://loggly.com con el fin de crear un **Daemonset**

Una vez cumplidos los requisitos, seguir los siguientes pasos:

**1. Crear variables de entorno .evn** 
```bash
cd docker
touch .env

# File .evn
APP_NAME=reditos-app
VERSION=1.0.0
PORT=3000
```

**2. Ejecutar aplicacion en Docker**
```bash
# Ingresar al dir de docker
cd docker
docker build -t brayanhernandez99/reditos-app:latest .
docker run -p 3000:3000 brayanhernandez99/reditos-app:latest
```

**3. Publicar imagen en DockerHub**
```bash
docker login
docker push brayanhernandez99/reditos-app:latest
```

**4. Ejecutar localmente un Cluster en Kubernetes**
```bash
# Crear un Cluster con multi nodo con Kind 
kind create cluster --config docker/kubernetes/cluster.yml

# Ver informacion del Cluster
kubectl cluster-info --context kind-reditos-cluster

# Eliminar un Cluster 
kind delete cluster

# Aplicar manifiestos sobre el Cluster
kubectl apply -f docker/kubernetes/deployment.yaml
kubectl apply -f docker/kubernetes/service.yaml

# Validar estado service
kubectl get service reditos-app
kubectl get nodes
kubectl get pods -o wide

# Outputs
NAME          TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
reditos-app   LoadBalancer   10.96.75.193   <pending>     80:30962/TCP   17s

NAME                            STATUS   ROLES           AGE   VERSION
reditos-cluster-control-plane   Ready    control-plane   13m   v1.33.1
reditos-cluster-worker          Ready    <none>          13m   v1.33.1
reditos-cluster-worker2         Ready    <none>          13m   v1.33.1

NAME                           READY   STATUS    RESTARTS      AGE     IP           NODE                      
reditos-app-7ccb5d5c47-bjmfn   0/1     Running   2 (78s ago)   9m13s   10.244.2.2   reditos-cluster-worker2 
reditos-app-7ccb5d5c47-s4h2n   0/1     Running   2 (78s ago)   9m13s   10.244.1.2   reditos-cluster-worker
```

---

# 4. Pipeline CI/CD con GitHub Actions.
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Poseer con una cuenta en Github: https://github.com/
- Contar con un repositorio y crear al menos un archivo de workflow
- Acceso al clúster Kubernetes (`KUBECONFIG` como secreto).
- YAMLs o manifiestos definidos en la carpeta `docker/kubernetes/*.yml`.
- Instalar y poseer una cuenta **Ngrok**: https://dashboard.ngrok.com/get-started/setup/windows con el fin de publicar el Cluster local hacia **Internet**

Este proyecto contiene una aplicación Node.js con integración y despliegue continuo (CI/CD) usando GitHub Actions Docker y Kubernetes.
Una vez cumplidos los requisitos, seguir los siguientes pasos:

## Configurar Ngrok
```bash
# Crear file ngrok.yml con el token 
ngrok config add-authtoken ${{ngrok_token}}

# Averigua el puerto del API server de Kind
kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}'

# Exponer puerto hacia Internet
ngrok http https://127.0.0.1:60892 --host-header=rewrite
```

## Flujo del Pipeline

1. **Test**
   - Usa `npm install` para instalar dependencias.
   - Ejecuta `npm test` con pruebas unitarias localizadas en `docker/test/*.test.js`.

2. **Build & Push**
   - Construye la imagen con Docker.
   - Publica la imagen en Docker Hub.

3. **Deploy**
   - Usa `kubectl` para aplicar los manifiestos .yml al clúster Kubernetes.

4. **Variables de entorno (GitHub Secrets)**
```bash
  https://github.com/${{username}}/${{repository}}/settings/secrets/  
  
| Nombre           | Descripción                      |
|------------------|----------------------------------|
| DOCKER_USERNAME  | Usuario Docker Hub               |
| DOCKER_PASSWORD  | Token o contraseña Docker Hub    |
| KUBECONFIG       | Contenido completo de kubeconfig |

# Obtener secreto kubeconfig
kubectl config view --raw > kubeconfig

# Crear Token para GitHub
kubectl create serviceaccount github --namespace default
kubectl create clusterrolebinding github-ci-binding --clusterrole=cluster-admin --serviceaccount=default:github
kubectl create token github --namespace default

# Editar archivo 
vim kubeconfig
  - Remplazar ip Cluster Kubernetes https://127.0.0.1:60892 por server: https://abc123.ngrok-free.app
  - Remplazar certificate-authority-data: LS0tLS1.... por insecure-skip-tls-verify: true

# Ejemplo KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://abc123.ngrok-free.app
  name: kind-reditos-cluster
...
...
users: 
- name: kind-reditos-cluster
  user:
    token: eyJhbG...
```

---

# 5. Seguridad y Buenas Prácticas.
Para la implementación de esta solución, se tuvieron en cuenta criterios como posibles mejoras, buenas prácticas ademas de implementar seguridad las cuales seran descritas acontinuación:

### 1. Infraestructura como Código (Terraform) [Ver archivo](terraform/)

- **Modularización**
  He dividido la infraestructura en módulos reutilizables (network, ec2, rds). De este modo:
  - Puedo aislar responsabilidades (VPC/Subnets, instancias EC2, clúster RDS) y facilitar la reutilización de código en otros proyectos.  
  - Cada módulo se prueba y versiona de forma independiente, manteniendo la configuración más limpia y reduciendo el riesgo de cambios accidentales.

- **Variables**
  - Definí variables explícitas en `variables.tf` y `terraform.tfvars`, evitando “hardcodear” valores dentro de los recursos.  
  - Marqué las credenciales (por ejemplo, `db_username`, `db_password`) como **sensitive = true**, de manera que no aparezcan expuestas en la salida de consola ni en el estado de Terraform por error.

- **Seguridad en la red redes**  
  - El Security Group del RDS sólo permite tráfico entrante en el puerto 3306 desde el SG de EC2, evitando exponer MySQL al público.  
  - El Security Group de EC2 está restringido a los puertos estrictamente necesarios (SSH, HTTP/HTTPS).  
  - Etiqueté todos los recursos con `tags` para facilitar la identificación y trazabilidad en AWS.

---

### 2. Automatización con Ansible

- **Roles y organización** - [Ver archivo](ansible\roles\nginx)
  Separé la lógica por rol (`roles/nginx`), siguiendo la convención de Ansible y asi:
  - Poder agregar nuevos roles en el futuro (p. ej. base de datos, usuarios, monitoreo) sin desorden.  
  - Agrupé parámetros comunes en `group_vars/all.yml` (intérprete de Python, usuario SSH, llave privada), evitando duplicar valores.

- **Gestión de secretos** - [Ver archivo](ansible\group_vars)
  - Utilizo **Ansible Vault** (`group_vars/vault.yml`) para almacenar credenciales y datos sensibles. De ese modo, ninguna contraseña viaja en texto plano dentro del repositorio.  
  - Ademas de cifrar el Vault para mantener secretos ocultos y incluyéndolo en `.gitignore`.

- **Configuracion** - [Ver archivo](ansible\roles\nginx\tasks\main.yml)
  - En los playbooks uso módulos como `apt` con `state: present` y `update_cache: true` para que Nginx se instale sólo si no existe.  
  - Evito usar `shell` o `command` cuando existe un módulo específico (p. ej. utilizo `service` para levantar o validar el servicio de Nginx).

---

### 3. Contenedores (Docker)

- **Imagen base ligera** - [Ver archivo](docker\Dockerfile)
  - Seleccioné `node:18-alpine` para que la imagen final sea lo más pequeña posible y tenga menos vulnerabilidades.  

- **Variables de entorno y configuración** - [Ver archivo](docker\.env)
  - Cargo un archivo `.env` local (excluido del repositorio) para no exponer configuraciones sensibles.  

---

### 4. CI/CD con GitHub Actions - [Ver archivo](.github\workflows\deploy.yml)

- **Pipeline multinivel (tests → build → deploy)**  
  - Dividí el flujo en jobs (`tests`, `build_and_push`, `deploy`), lo cual:  
    - Aporta claridad y facilita identificar en qué fase ocurre un fallo.  
    - Impide que el build avance si las pruebas fallan, porque establecí `needs: tests`.

- **Uso de secretos**  
  - Nunca dejo credenciales en texto plano:  
    - `DOCKER_USERNAME` y `DOCKER_PASSWORD` para autenticarme en Docker Hub.  
    - `KUBECONFIG` almacenado como secret, que luego vuelco a `~/.kube/config` asi no queda expuesto en los logs.

- **Timeouts y entorno controlado**  
  - Configuré `timeout-minutes: 10` en cada job para evitar que un proceso quede “colgado” de forma indefinida.  
  - Incluí pasos de verificación (por ejemplo, `kubectl cluster-info` y `kubectl get pods`) que validan la conexión y el despliegue, en lugar de asumir éxito sin comprobar.

- **Linter de estado y salud**  
  - En la etapa de `tests` corro `npm test` antes de construir la imagen, garantizando que no se despliegue código con fallos.  
  - En la etapa de `deploy` reviso el estado de los pods con `kubectl get pods -o wide`.
---

### 5. Kubernetes (Manifiestos)

- **Definición de Recursos** - [Ver archivo](docker\kubernetes\deployment.yaml)
  - Configuré **livenessProbe** y **readinessProbe** para asegurarme de que los pods se reinicien si la aplicación deja de responder (`/health`) y no reciban tráfico hasta estar listos.  
  - Especifico **requests** y **limits** de CPU/memoria en el Deployment para:
    - Garantizar calidad de servicio y estabilidad del clúster.  
    - Evitar que un pod consuma más recursos de los asignados y provoque “evictions” en el nodo.

- **Servicio LoadBalancer** - [Ver archivo](docker\kubernetes\service.yaml) 
  - Utilizo un Service de tipo `LoadBalancer` para exponer el Deployment. De esta forma, en un proveedor cloud con soporte L4/L7 (AWS, GCP), se aprovisiona el balanceador automáticamente.

- **DaemonSet para Fluentd** **Mejora Añdida** - [Ver archivo](docker\kubernetes\fluentd.yaml) 
  - Desplegué un DaemonSet (`fluentd-es-v1.20`) que recolecta logs de todos los nodos (hostPath `/var/log`, `/var/lib/docker/containers`) y los envía a Elasticsearch/Stack.  
  - Con esto, centralizo los logs y evito pérdida de información ademas de monitorear la aplicación en tiempo real.

---

## Seguridad y Recomendaciones

- **Ambientes**: Es recomendable utilizar variables para parámetros comunes y mantener archivos de variables independientes por entorno (prod, staging, dev) para que no se mezclen configuraciones y credenciales al aplicar cambios.

- **Despliegues**: Más adelante podría parametrizar el workflow para que se ejecute en dev/staging/prod, usando distintas ramas o tags con sus respectivos `secrets`. 

- **Análisis estático**: Integrar en la pipeline alguna acción como `npm audit` o un escaneo de dependencias, bloqueando el build en caso de vulnerabilidades críticas.

- **Monitoreo y alertas**: Mas adelante por medio de Fluentd planeo agregar métricas clave (CPU, memoria, latencia) y enviarlas a Prometheus/Grafana o al servicio de monitoreo de la nube.  
