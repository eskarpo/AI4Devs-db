Prompts Danilo Alarcoom

Convierte el diagrama de entidad-relación (ERD) proporcionado en formato Mermaid a un script SQL. Luego, analiza la base de datos actual para expandir la estructura de datos necesaria y generar las correspondientes migraciones en Prisma, aplicando buenas prácticas de definición de índices y normalización.

# Pasos

1. **Convertir el ERD Mermaid a SQL**: Convierte el diagrama de entidades y relaciones en formato Mermaid a un script SQL. Define las entidades de manera que reflejen la estructura de la base de datos, incluyendo tablas, columnas, relaciones, y asegurándote de aplicar buenas prácticas como la normalización adecuada de cada entidad y la inclusión de índices para la mejora del rendimiento de consultas.

2. **Analizar la base de datos existente**: Examina la estructura actual de la base de datos para identificar las entidades que ya están presentes y aquellas que deberán ser actualizadas o añadidas. Analiza el esquema para determinar si tienen los índices apropiados para relaciones y consultas eficientes. 

3. **Generar cambios de estructura con Prisma**:
   - Compara la estructura actual con las entidades y relaciones definidas en el script SQL generado.
   - Realiza actualizaciones y crea nuevas tablas asegurándote de que éstas mantengan un buen nivel de normalización.
   - Ajusta las migraciones necesarias para Prisma, y utiliza el comando prisma migrate para generar las migraciones necesarias que reflejen adecuadamente los cambios descritos en el script SQL.

4. **Definir índices e integridad referencial**: 
   - Asegúrate de definir índices en las columnas frecuentemente consultadas.
   - Utiliza llaves foráneas para las relaciones entre entidades, respetando siempre las restricciones de integridad necesarias.

# Output Format

- **Script SQL**: Debe incluir instrucciones CREATE, ALTER, y INDEX, definiendo todas las tablas, llaves primarias y relaciones foráneas necesarias. Además, deben estar definidos los índices para optimizar las consultas frecuentes y completar correctamente el proceso de normalización. 

- **Prisma Migration**: El script de migración debe mantener compatibilidad con la estructura del código existente y estar listo para aplicación con el comando prisma migrate dev.

# Ejemplo

### Diagrama Mermaid
mermaid
classDiagram
    User --> Profile : has
    Job --* Application : receives
    User --* Application : submits


### Script SQL
sql
CREATE TABLE User (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Profile (
    id INT PRIMARY KEY,
    userId INT UNIQUE,
    bio TEXT,
    FOREIGN KEY (userId) REFERENCES User(id)
);

CREATE TABLE Job (
    id INT PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE Application (
    id INT PRIMARY KEY,
    userId INT,
    jobId INT,
    status VARCHAR(20),
    FOREIGN KEY (userId) REFERENCES User(id),
    FOREIGN KEY (jobId) REFERENCES Job(id)
);

CREATE INDEX idx_user_name ON User(name);
CREATE INDEX idx_application_status ON Application(status);


### Prisma Migration
prisma
model User {
  id           Int           @id @default(autoincrement())
  name         String        @unique
  Profile      Profile?
  applications Application[]
}

model Profile {
  id     Int    @id @default(autoincrement())
  bio    String
  userId Int    @unique
  User   User   @relation(fields: [userId], references: [id])
}

model Job {
  id           Int           @id @default(autoincrement())
  title        String
  applications Application[]
}

model Application {
  id     Int    @id @default(autoincrement())
  userId Int
  jobId  Int
  status String
  User   User   @relation(fields: [userId], references: [id])
  Job    Job    @relation(fields: [jobId], references: [id])

  @@index([status])
}


# Notes

- Asegúrate de mantener consistencia en los nombres y tipos de datos en toda la base de datos y sus migraciones.
- Revisa que las relaciones indican correctamente las restricciones de integridad que el flujo de la aplicación requiere, y que se respetan las reglas de normalización.
- Adicionalmente, asegúrate de optimizar la base de datos agregando índices en campos que se utilicen frecuentemente en consultas.
- Incluye medidas para evitar redundancia y asegúrate de aplicar la tercera forma normal (3NF) donde sea posible. no hagas nada hasta que te comparta el erD

erDiagram
     COMPANY {
         int id PK
         string name
     }
     EMPLOYEE {
         int id PK
         int company_id FK
         string name
         string email
         string role
         boolean is_active
     }
     POSITION {
         int id PK
         int company_id FK
         int interview_flow_id FK
         string title
         text description
         string status
         boolean is_visible
         string location
         text job_description
         text requirements
         text responsibilities
         numeric salary_min
         numeric salary_max
         string employment_type
         text benefits
         text company_description
         date application_deadline
         string contact_info
     }
     INTERVIEW_FLOW {
         int id PK
         string description
     }
     INTERVIEW_STEP {
         int id PK
         int interview_flow_id FK
         int interview_type_id FK
         string name
         int order_index
     }
     INTERVIEW_TYPE {
         int id PK
         string name
         text description
     }
     CANDIDATE {
         int id PK
         string firstName
         string lastName
         string email
         string phone
         string address
     }
     APPLICATION {
         int id PK
         int position_id FK
         int candidate_id FK
         date application_date
         string status
         text notes
     }
     INTERVIEW {
         int id PK
         int application_id FK
         int interview_step_id FK
         int employee_id FK
         date interview_date
         string result
         int score
         text notes
     }

     COMPANY ||--o{ EMPLOYEE : employs
     COMPANY ||--o{ POSITION : offers
     POSITION ||--|| INTERVIEW_FLOW : assigns
     INTERVIEW_FLOW ||--o{ INTERVIEW_STEP : contains
     INTERVIEW_STEP ||--|| INTERVIEW_TYPE : uses
     POSITION ||--o{ APPLICATION : receives
     CANDIDATE ||--o{ APPLICATION : submits
     APPLICATION ||--o{ INTERVIEW : has
     INTERVIEW ||--|| INTERVIEW_STEP : consists_of
     EMPLOYEE ||--o{ INTERVIEW : conducts
  genera una explicación paso a paso de lo que estas haciendo

Voy a dividir el proceso en pasos claros para convertir el ERD Mermaid en un script SQL, analizar la base de datos existente y generar las migraciones necesarias con Prisma.

Paso 1: Analizar el diagrama ERD
Primero, analizo el diagrama para identificar:

Tablas principales (entidades).
Columnas (atributos) y sus tipos.
Relaciones entre las tablas.
Llaves primarias (PK) y llaves foráneas (FK).
Propiedades específicas como índices y restricciones.
Paso 2: Convertir ERD a Script SQL
Crear las tablas:

Defino la estructura de las tablas según las entidades del ERD.
Asigno tipos de datos apropiados a las columnas.
Configuro las llaves primarias (PRIMARY KEY) y foráneas (FOREIGN KEY).
Definir relaciones:

Agrego relaciones entre las tablas utilizando FOREIGN KEY.
Aseguro integridad referencial con ON DELETE y ON UPDATE.
Crear índices:

Defino índices en columnas clave para optimizar consultas frecuentes.
Asegurar normalización:

Verifico que cada tabla cumpla con la tercera forma normal (3NF), evitando redundancias.
Paso 3: Analizar la base de datos existente
Compara las tablas actuales con las definidas en el script SQL.
Identifica:
Tablas y columnas existentes que no necesitan cambios.
Nuevas tablas o columnas que deben ser añadidas.
Índices faltantes.
Paso 4: Generar migraciones con Prisma
Actualizar el modelo de Prisma:

Traduce el script SQL a un modelo en Prisma.
Asegura que las relaciones y restricciones sean reflejadas adecuadamente.
Generar migraciones:

Utiliza prisma migrate dev para crear las migraciones necesarias.
Validar:

Comprueba que las migraciones se apliquen correctamente.
Paso 5: Definir índices e integridad referencial
Asegúrate de incluir:

Índices en columnas clave como email, status, application_date, etc.
Restricciones de integridad referencial para proteger la consistencia de datos.
Prueba las consultas para verificar que el rendimiento sea óptimo.

