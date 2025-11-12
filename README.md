# Ironhack Proyecto Universitaria

## 1. Problema u oportunidad detectada
La universidad enfrenta un **porcentaje relevante de abandono estudiantil**, especialmente en los primeros años de carrera. Este fenómeno impacta negativamente:

- **Estudiantes:** interrupción de la formación, menor empleabilidad.
- **Institución:** pérdida de ingresos, baja eficiencia académica y reputación.

**Oportunidad:** utilizar Big Data y analítica predictiva para **detectar tempranamente a los estudiantes con riesgo de deserción**, permitiendo:

- Implementar estrategias personalizadas de retención.
- Optimizar procesos de reclutamiento.
- Fortalecer la propuesta educativa.

> **Usuario principal**
> - *Gestión Académica y Bienestar Estudiantil: responsables del acompañamiento y soporte a los estudiantes.*

## 3. Arquitectura del proyecto

### 3.1. Modelo Relacional

El modelo relacional representa las entidades principales de la universidad y sus relaciones, permitiendo almacenar y gestionar la información académica de manera estructurada. Este modelo se centra en estudiantes, profesores, cursos, departamentos y horarios, y soporta análisis predictivo sobre deserción estudiantil.

![MER Universidad](./static/mer_univeridad.png)


````text
          ┌─────────────────────────────┐
          │      Cloud SQL (Postgres)   │
          │  - Base de datos student_data│
          │  - Usuarios: admin, app_user1, app_user2 │
          └─────────────┬──────────────┘
                        │ (extract)
                        ▼
          ┌─────────────────────────────┐
          │    Cloud Function ELT       │
          │  - download_kaggle_to_gcs  │
          │  - Python runtime          │
          │  - Usa credenciales Kaggle │
          │  - Despliegue con Terraform│
          └───────┬───────────┬────────┘
                  │           │
                  │           │
                  ▼           ▼
      ┌─────────────────┐   ┌─────────────────┐
      │  Bucket Bronze  │   │  Bucket Silver  │
      │  - Ficheros raw │   │  - Datos DB     │
      │  - Versioning   │   │  - Versioning   │
      │  - IAM: Viewer  │   │  - IAM: Viewer  │
      └────────┬────────┘   └────────┬────────┘
               │                     │
               ▼                     ▼
          ┌─────────────────────────────┐
          │       Bucket Gold           │
          │  - Datos limpios / finales  │
          │  - Acceso controlado        │
          └─────────────┬──────────────┘
                        │
                        ▼
                 ┌────────────┐
                 │ BigQuery   │
                 │ - Dataset  │
                 │ - Tablas   │
                 └────────────┘
```

medallion arquitectura


## 4. Objetivo del repositorio
Este repositorio contiene la **infraestructura como código (IaC)** en **Google Cloud Platform** usando **Terraform**, para desplegar y gestionar los recursos necesarios para el proyecto de analítica predictiva:

- Buckets de Cloud Storage para almacenamiento de datos.
- Compute Engine o recursos de procesamiento para análisis.
- IAM roles y permisos para acceso seguro a los datos.
- Cloud SQL para almacenamiento relacional de datos académicos.

## 5. Estructura del repositorio

```text
ironhack_proyecto_universitaria/
├─ terraform/
│   ├─ main.tf
│   ├─ variables.tf
│   ├─ outputs.tf
│   ├─ terraform.tfvars
│   └─ modules/
│       ├─ storage/
│       │   ├─ main.tf
│       │   ├─ variables.tf
│       │   └─ outputs.tf
│       ├─ compute/
│       │   ├─ main.tf
│       │   ├─ variables.tf
│       │   ├─ outputs.tf
│       │   └─ cloud_function/
│       │       ├─ main.tf
│       │       ├─ variables.tf
│       │       └─ outputs.tf
│       ├─ bigquery/
│       │   ├─ main.tf
│       │   ├─ variables.tf
│       │   └─ outputs.tf
│       ├─ cloudsql/
│       │   ├─ main.tf
│       │   ├─ variables.tf
│       │   └─ outputs.tf
│       │   └─ sql/
│       │       └─ create_tables.sql
│       └─ iam/
│           ├─ main.tf
│           ├─ variables.tf
│           └─ outputs.tf
├─ README.md
└─ .env
```

## 6. Requisitos

- Cuenta de Google Cloud Platform con permisos de creación de proyectos y recursos.
- Archivo de credenciales JSON para autenticación.
- Terraform 1.5 o superior instalado localmente.

## 7. Configuración inicial
- **7.1 Clonar el repositorio**

```bash
git clone https://github.com/TU_USUARIO/ironhack_proyecto_universitaria.git
cd ironhack_proyecto_universitaria
```

**7.2 Crear un proyecto en GCP**

1. Ir a Google Cloud Console → Manage Resources → Create Project.
2. Seleccionar “No organization” o dejar el campo de organización vacío.

- **7.3 Crear una cuenta de servicio**

1. Selecciona tu proyecto en GCP.
2. Ve a IAM & Admin → Service Accounts → Crear cuenta de servicio.
3. Ingresa un nombre, por ejemplo: terraform-sa.
4. Asigna roles mínimos necesarios:
  - roles/storage.admin
  - roles/cloudsql.admin
  - roles/bigquery.admin

5. Haz clic en Crear y continuar, luego en Listo.

- **7.4 Configurar variables en .env y terraform.tfvars**

# Activar variables de entorno

```bash
# Cargar variables con credenciales
source .env

# Configuración de Terraform
project_id       = "mi-proyecto-terraform"
bucket_name      = "mi-bucket-terraform-001"
region           = "us-central1"

# Cloud SQL
db_connection_name = "proyecto-universitaria:europe-west3:universitaria-sql"
db_instance_name   = "universitaria-sql"
db_name            = "student_data"
```

- **7.5 Inicializar y aplicar Terraform**
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

- **7.6 Eliminar recursos**
```bash
terraform destroy
```