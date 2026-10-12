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

-- ============================================================
-- PARTIE 1.2 : Attribution des droits de l'administrateur
-- Objectif : donner tous les privilèges sur la base ctfarena.
-- ============================================================

GRANT ALL PRIVILEGES ON ctfarena.* TO 'admin_ctf'@'localhost';

-- ============================================================
-- PARTIE 1.3 : Attribution des droits de l'organisateur
-- Objectif : gérer les challenges et les catégories
-- sans pouvoir supprimer les challenges.
-- ============================================================

GRANT SELECT, INSERT, UPDATE
ON ctfarena.challenges
TO 'orga_ctf'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON ctfarena.categories
TO 'orga_ctf'@'localhost';

GRANT SELECT
ON ctfarena.equipes
TO 'orga_ctf'@'localhost';

-- ============================================================
-- PARTIE 1.4 : Attribution des droits de l'application web
-- Objectif : autoriser la consultation du catalogue
-- et l'enregistrement des soumissions sans exposer les flags.
-- ============================================================

GRANT SELECT
ON ctfarena.equipes
TO 'app_web'@'localhost';

GRANT SELECT
ON ctfarena.categories
TO 'app_web'@'localhost';

GRANT SELECT
ON ctfarena.validations
TO 'app_web'@'localhost';

GRANT INSERT
ON ctfarena.soumissions
TO 'app_web'@'localhost';

GRANT SELECT (id_joueur, pseudo, id_equipe, role_plateforme)
ON ctfarena.joueurs
TO 'app_web'@'localhost';

GRANT SELECT (
    id_challenge,
    titre,
    id_categorie,
    difficulte,
    points,
    statut
)
ON ctfarena.challenges
TO 'app_web'@'localhost';


-- ============================================================
-- TESTS : Permissions du compte app_web
-- ============================================================

-- Test 1 : lecture des informations publiques des challenges.
-- Requête :
-- SELECT id_challenge, titre, points, statut
-- FROM challenges LIMIT 3;
--
-- Résultat obtenu : SUCCÈS.
-- Les trois premiers challenges sont affichés.

-- Test 2 : tentative de lecture de la colonne flag.
-- Requête :
-- SELECT flag FROM challenges LIMIT 1;
--
-- Résultat obtenu : REFUS ATTENDU.
-- Erreur MariaDB 1143 : accès SELECT refusé sur la colonne flag.
--
-- Conclusion : app_web peut consulter le catalogue sans accéder
-- aux flags secrets des challenges.

-- ============================================================
-- DROITS TEMPORAIRES DE L'AUDITEUR
-- À intégrer avec la matrice RBAC de la partie 1.
-- Objectif : limiter l'accès aux données sensibles (RGPD).
-- ============================================================

-- L'auditeur peut lire les colonnes autorisées de soumissions.
GRANT SELECT (
    id_soumission,
    id_joueur,
    id_challenge,
    correct,
    date_soumission
)
ON ctfarena.soumissions
TO 'auditeur'@'localhost';

-- L'auditeur peut consulter les validations.
GRANT SELECT
ON ctfarena.validations
TO 'auditeur'@'localhost';
