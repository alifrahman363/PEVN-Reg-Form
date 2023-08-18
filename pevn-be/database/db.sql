-- Active: 1690813928102@@127.0.0.1@5432@pevn
CREATE DATABASE pevn;

CREATE TABLE professor(
    id_p serial PRIMARY KEY,
    p_name TEXT NOT NULL,
    p_email TEXT NOT NULL UNIQUE,
    p_password TEXT NOT NULL
);

CREATE Table student(
    id_s serial PRIMARY KEY,
    s_name TEXT NOT NULL,
    s_email TEXT NOT NULL UNIQUE,
    s_password TEXT NOT NULL
);

CREATE TABLE course(
    id_c serial PRIMARY KEY,
    p_id INTEGER REFERENCES professor(id_p),
    c_name TEXT NOT NULL,
    c_description TEXT NOT NULL
);

CREATE TABLE studentvscourse( 
    s_id INTEGER NOT NULL REFERENCES student(id_s),
    c_id INTEGER NOT NULL REFERENCES course(id_c)
);

CREATE TABLE assignments(
    id_a serial PRIMARY KEY,
    c_id INTEGER NOT NULL REFERENCES course(id_c),
    a_name TEXT NOT NULL,
    a_description TEXT,
    a_file TEXT NOT NULL
);

create Table delivery(
    id_d serial PRIMARY KEY,
    a_id INTEGER NOT NULL REFERENCES assignments(id_a),
    s_id INTEGER NOT NULL REFERENCES student(id_s),
    d_file TEXT NOT NULL,
    d_filename TEXT

);
 
ALTER TABLE student
ADD UNIQUE(s_email);
ALTER TABLE professor
ADD UNIQUE(p_email);