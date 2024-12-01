SQL de migración
-- Tabla COMPANY DOAR
CREATE TABLE Company (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tabla EMPLOYEE
CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (company_id) REFERENCES Company(id)
);

-- Tabla INTERVIEW_TYPE
CREATE TABLE InterviewType (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- Tabla INTERVIEW_FLOW
CREATE TABLE InterviewFlow (
    id SERIAL PRIMARY KEY,
    description TEXT
);

-- Tabla INTERVIEW_STEP
CREATE TABLE InterviewStep (
    id SERIAL PRIMARY KEY,
    interview_flow_id INT NOT NULL,
    interview_type_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    order_index INT NOT NULL,
    FOREIGN KEY (interview_flow_id) REFERENCES InterviewFlow(id),
    FOREIGN KEY (interview_type_id) REFERENCES InterviewType(id)
);

-- Tabla POSITION
CREATE TABLE Position (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL,
    interview_flow_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50),
    is_visible BOOLEAN DEFAULT TRUE,
    location VARCHAR(255),
    job_description TEXT,
    requirements TEXT,
    responsibilities TEXT,
    salary_min NUMERIC(10, 2),
    salary_max NUMERIC(10, 2),
    employment_type VARCHAR(50),
    benefits TEXT,
    company_description TEXT,
    application_deadline DATE,
    contact_info VARCHAR(255),
    FOREIGN KEY (company_id) REFERENCES Company(id),
    FOREIGN KEY (interview_flow_id) REFERENCES InterviewFlow(id)
);

-- Tabla CANDIDATE
CREATE TABLE Candidate (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT
);

-- Tabla APPLICATION
CREATE TABLE Application (
    id SERIAL PRIMARY KEY,
    position_id INT NOT NULL,
    candidate_id INT NOT NULL,
    application_date DATE NOT NULL,
    status VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (position_id) REFERENCES Position(id),
    FOREIGN KEY (candidate_id) REFERENCES Candidate(id)
);

-- Tabla INTERVIEW
CREATE TABLE Interview (
    id SERIAL PRIMARY KEY,
    application_id INT NOT NULL,
    interview_step_id INT NOT NULL,
    employee_id INT NOT NULL,
    interview_date DATE NOT NULL,
    result VARCHAR(50),
    score INT,
    notes TEXT,
    FOREIGN KEY (application_id) REFERENCES Application(id),
    FOREIGN KEY (interview_step_id) REFERENCES InterviewStep(id),
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

-- Índices adicionales
CREATE INDEX idx_employee_email ON Employee(email);
CREATE INDEX idx_application_status ON Application(status);
CREATE INDEX idx_position_status ON Position(status);
CREATE INDEX idx_interview_date ON Interview(interview_date);

