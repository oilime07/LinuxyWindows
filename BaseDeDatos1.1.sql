
create database usuarios;

create table usuario (nombre VARCHAR(30) NOT NULL, contrasena VARCHAR(30) NOT NULL, publica VARCHAR(50) NOT NULL, privada VARCHAR(50), firma VARCHAR(50), PRIMARY KEY (nombre));
