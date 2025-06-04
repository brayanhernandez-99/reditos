# Grupo Reditos
Prueba técnica para el Grupo Reditos, con el objetivo de evaluar las habilidades en los siguientes temas:

- Infraestructura como Código **(IaC - Terraform).**
- Automatización **(Ansible).**
- Integración y Despliegue Continuo **(CI/CD - GitHub Actions).**
- Manejo de contenedores **(Docker - Kubernetes).**
- Seguridad en la infraestructura

---

## 1. Infraestructura como Código (IaC) con Terraform
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:

- Instalar **Terraform**: https://developer.hashicorp.com/terraform/downloads

- Poseer una cuenta activa en **AWS**: https://aws.amazon.com/es/free

- Tener instalado y configurado el **AWS CLI**: https://aws.amazon.com/es/cli/

Una vez cumplidos los requisitos, seguir los siguientes pasos:

1. Inicializar el proyecto:
  ```bash
  terraform init
  ```

2. Verificar el plan de ejecución:
  ```bash
  terraform plan
  ```

3. Aplicar los cambios:
  ```bash
  terraform apply
  ```

---

## 2.  Automatización de Configuración con Ansible.
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Instalar **Python 3**: https://www.python.org/downloads/
- Instalar **Ansible**: https://www.ansible.com/
- Acceso a una instancia **EC2**
- Llave privada **SSH** (PEM): https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/create-key-pairs.html

Una vez cumplidos los requisitos, seguir los siguientes pasos:

1. Ejecución local del Playbook en Ansible:
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

2. Ejecución del Playbook desde un contenedor con Ansible:
  ```bash
# Descargar imagen de Ansible
docker pull alpine/ansible:latest

# Ejecutar contenedor de Ansible
docker run -it alpine/ansible:latest "/bin/bash"
```

---

## 3. Contenedores y Orquestación con Docker y Kubernetes
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Instalar **Docker**: https://www.docker.com/products/docker-desktop/
- Cuenta en Docker Hub: https://hub.docker.com/repositories/
- **Kubernetes** (Kind, Minikube o clúster cloud): https://kind.sigs.k8s.io/
- Descargar **kubectl** configurado: https://kubernetes.io/docs/tasks/tools/
- Descargar **Node.js** opcional: https://nodejs.org/en/download
- Crear cuenta en **loggly.com** opcional: https://loggly.com con el fin de crear un Daemonset

Una vez cumplidos los requisitos, seguir los siguientes pasos:

1. Crear variables de entorno **.evn** 
```bash
cd kubernetes
touch .env

# APP_NAME=reditos-app
# VERSION=1.0.0
# PORT=3000
```

2. Ejecutar aplicacion en Docker 
```bash
docker build -t brayanhernandez99/reditos-app:latest .
docker run -p 3000:3000 brayanhernandez99/reditos-app:latest
```

3. Publicar imagen en DockerHub
```bash
docker login
docker push brayanhernandez99/reditos-app:latest
```

4. Ejecutar localmente un Cluster en Kubernetes
```bash
# Crear un Cluster con multi nodo con Kind 
kind create cluster --config kubernetes/cluster.yml

# Ver informacion del Cluster
kubectl cluster-info --context kind-kind

# Aplicar manifiestos sobre el Cluster
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml

# Validar estado
kubectl get service reditos-app
kubectl get all
```

---

## 4. Pipeline CI/CD con GitHub Actions.
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Poseer con una cuenta en Github: https://github.com/
- Contar con un repositorio y crear al menos un archivo de workflow
- Acceso al clúster Kubernetes (`KUBECONFIG` como secreto).
- YAMLs o manifiestos definidos en la carpeta `docker/kubernetes/*.yml`.


Este proyecto contiene una aplicación Node.js con integración y despliegue continuo (CI/CD) usando GitHub Actions Docker y Kubernetes.

## Flujo del Pipeline

1. **Test**
   - Usa `npm install` para instalar dependencias.
   - Ejecuta `npm test` con pruebas unitarias localizadas en `docker/test/*.test.js`.

2. **Build & Push**
   - Construye la imagen con Docker.
   - Publica la imagen en Docker Hub.

3. **Deploy**
   - Usa `kubectl` para aplicar los manifiestos YAML al clúster Kubernetes.

4. **Variables de entorno (GitHub Secrets)**
```bash
  | Nombre           | Descripción                      |
  |------------------|----------------------------------|
  | DOCKER_USERNAME  | Usuario Docker Hub               |
  | DOCKER_PASSWORD  | Token o contraseña Docker Hub    |
  | KUBECONFIG       | Contenido completo de kubeconfig |
```

---

## 5. Seguridad y Buenas Prácticas.
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:

Una vez cumplidos los requisitos, seguir los siguientes pasos:

