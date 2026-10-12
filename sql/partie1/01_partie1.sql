-- ============================================================
-- PROJET : CTF Arena
-- PARTIE 1 : Gestion des comptes et des droits SQL
-- Fichier : 01_partie1.sql
-- SGBD : MariaDB
-- ============================================================

USE ctfarena;

-- ============================================================
-- PARTIE 1.1 : Création des comptes
-- Objectif : créer les comptes nécessaires au projet.
-- ============================================================

CREATE USER IF NOT EXISTS 'admin_ctf'@'localhost'
IDENTIFIED BY 'AdminCTF_2026!';

CREATE USER IF NOT EXISTS 'orga_ctf'@'localhost'
IDENTIFIED BY 'OrgaCTF_2026!';

CREATE USER IF NOT EXISTS 'app_web'@'localhost'
IDENTIFIED BY 'AppWebCTF_2026!';

CREATE USER IF NOT EXISTS 'auditeur'@'localhost'
IDENTIFIED BY 'AuditeurCTF_2026!';
