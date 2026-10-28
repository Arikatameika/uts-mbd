-- 1. Buat Schema SALAM
CREATE SCHEMA IF NOT EXISTS SALAM;

-- 2. Buat Tabel mahasiswas dengan Primary Key, Unique, dan Check Constraint
CREATE TABLE IF NOT EXISTS SALAM.mahasiswas (
    nim VARCHAR(15) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    ipk NUMERIC(3,2) CHECK (ipk >= 0.00 AND ipk <= 4.00),
    angkatan INT CHECK (angkatan >= 2020),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Data Sample untuk Pembuktian Awal
INSERT INTO SALAM.mahasiswas (nim, nama, email, ipk, angkatan) 
VALUES ('1247050134', 'Salwa Aulia Nasywa', 'salwa@student.uin.ac.id', 3.95, 2024);

-- 3. Pembentukan User & Role (Sesuai Soal)

-- a. backend_dev: CRUD semua tabel
CREATE USER backend_dev WITH PASSWORD 'backend123';
GRANT CONNECT ON DATABASE postgres TO backend_dev;
GRANT USAGE ON SCHEMA SALAM TO backend_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;

-- b. bi_dev: hanya READ / SELECT semua tabel & view
CREATE USER bi_dev WITH PASSWORD 'bidev123';
GRANT CONNECT ON DATABASE postgres TO bi_dev;
GRANT USAGE ON SCHEMA SALAM TO bi_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT ON TABLES TO bi_dev;

-- c. data_engineer: DDL (CREATE, MODIFY, DROP) & DML (CRUD)
CREATE USER data_engineer WITH PASSWORD 'dataeng123';
GRANT CONNECT ON DATABASE postgres TO data_engineer;
GRANT ALL PRIVILEGES ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT ALL PRIVILEGES ON TABLES TO data_engineer;