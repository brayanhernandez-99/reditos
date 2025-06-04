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
  erraform plan
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

1. Ejecución del Playbook:
  ```bash
  ansible-playbook -i inventory.ini site.yml --ask-vault-pass
  ```

---

## 3. Contenedorización y Orquestación con Docker y Kubernetes
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:
- Instalar **Docker**: https://www.docker.com/products/docker-desktop/
- Cuenta en Docker Hub: https://hub.docker.com/repositories/
- **Kubernetes** (Kind, Minikube o clúster cloud): https://kind.sigs.k8s.io/
- Descargar **kubectl** configurado: https://kubernetes.io/docs/tasks/tools/

Una vez cumplidos los requisitos, seguir los siguientes pasos:

1. Como ejecutar localmente en Docker 
```bash
docker build -t brayanhernandez99/reditos-app:latest .
docker run -p 3000:3000 brayanhernandez99/reditos-app:latest
```

2. Como publicar imagen en DockerHub
```bash
docker login
docker push brayanhernandez99/reditos-app:latest
```

3. Como ejecutar un Clouster en Kubernetes
```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl get service reditos-app
```

---

## 4. Pipeline CI/CD con GitHub Actions.
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:

Una vez cumplidos los requisitos, seguir los siguientes pasos:

---

## 5. Seguridad y Buenas Prácticas.
Para la implementación de esta solución, se deben tener en cuenta los siguientes requisitos:

Una vez cumplidos los requisitos, seguir los siguientes pasos:

