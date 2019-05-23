SET FEEDBACK OFF
SET LINESIZE 150
SET PAGESIZE 40

REM **************************************************************************
REM BASE MEDIATHEQUE
REM Auteur : Quentin DOMINGUES, Cédric EGGER
REM ***************************************************************************

ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';


DROP TABLE users CASCADE CONSTRAINTS PURGE
/
DROP TABLE status CASCADE CONSTRAINTS PURGE
/
DROP TABLE documents CASCADE CONSTRAINTS PURGE
/
DROP TABLE typeDocuments CASCADE CONSTRAINTS PURGE
/

PROMPT CREATION DES TABLES

CREATE TABLE users
(
user_login VARCHAR(25) CONSTRAINT pk_user_login PRIMARY KEY,
user_password VARCHAR(255) NOT NULL,
status_id INTEGER NOT NULL
)
/

CREATE TABLE status
(
status_id INTEGER CONSTRAINT pk_status_id PRIMARY KEY,
status_role VARCHAR(25) NOT NULL
)
/

CREATE TABLE documents
(
documents_numDocument INTEGER CONSTRAINT pk_documents_numDocument PRIMARY KEY,
documents_titre VARCHAR(25) NOT NULL,
user_login VARCHAR(25),
documents_etat VARCHAR(15) NOT NULL,
typeDocuments_id INTEGER NOT NULL
)
/

CREATE TABLE typeDocuments
(
typeDocuments_id INTEGER CONSTRAINT pk_typeDocuments_id PRIMARY KEY,
typeDocuments_nom VARCHAR(25) NOT NULL
)
/

ALTER TABLE users
ADD CONSTRAINT fk_user_status
	FOREIGN KEY(status_id)
	REFERENCES status(status_id)
	ON DELETE CASCADE
/

ALTER TABLE documents
ADD CONSTRAINT fk_user_login
	FOREIGN KEY(user_login)
	REFERENCES users(user_login)
	ON DELETE CASCADE
ADD CONSTRAINT fk_typeDocuments_id
	FOREIGN KEY(typeDocuments_id)
	REFERENCES typeDocuments(typeDocuments_id)
	ON DELETE CASCADE
/

ALTER TABLE typeDocuments
ADD CONSTRAINT U_typeDocuments_nom
	UNIQUE (typeDocuments_nom)
/

PROMPT CREATION DES SEQUENCES


DROP SEQUENCE seq_user
/
DROP SEQUENCE seq_status
/
DROP SEQUENCE seq_documents
/
CREATE SEQUENCE seq_user start with 0 Minvalue 0
/
CREATE SEQUENCE seq_status start with 0 Minvalue 0
/
CREATE SEQUENCE seq_documents start with 0 Minvalue 0
/

PROMP INSERTION STATUS

INSERT INTO status(status_id, status_role) VALUES (0, 'Bibliothécaire');
INSERT INTO status(status_id, status_role) VALUES (1, 'Abonné');

PROMPT INSERTION DES USERS

INSERT INTO users(user_login, user_password, status_id) VALUES ('Cedric', 'egger', 0);
INSERT INTO users(user_login, user_password, status_id) VALUES ('Quentin', 'domingues', 1);

PROMPT INSERT DES DOCUMENTS

INSERT INTO typeDocuments(typeDocuments_id, typeDocuments_nom) VALUES (0, 'DVD');
INSERT INTO typeDocuments(typeDocuments_id, typeDocuments_nom) VALUES (1, 'Bande dessinée');
INSERT INTO typeDocuments(typeDocuments_id, typeDocuments_nom) VALUES (2, 'Livre');
INSERT INTO typeDocuments(typeDocuments_id, typeDocuments_nom) VALUES (3, 'Jeux vidéos');

INSERT INTO documents(documents_numDocument, documents_titre, user_login, documents_etat, typeDocuments_id) VALUES(seq_documents.nextVal, 'test', '', 'Disponible', 0); 
INSERT INTO documents(documents_numDocument, documents_titre, user_login, documents_etat, typeDocuments_id) VALUES(seq_documents.nextVal, 'test2', 'Quentin', 'Emprunte', 1);

PROMPT FIN

commit;

SET FEEDBACK ON
