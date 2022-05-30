import sqlite3
from flask import current_app, g, flash
import bcrypt


def get_db():
    """Open a new database connection if there is none yet for the current application context"""
    if 'db' not in g:
        g.db = sqlite3.connect(current_app.config['DATABASE'])
        g.db.row_factory = sqlite3.Row
        current_app.logger.info(f'Connexion à la BDD')
    return g.db


def close_db(e=None):
    """Close database connection on app teardown"""
    db = g.pop('db', None)
    if db is not None:
        db.close()
        current_app.logger.info(f'Déconnexion de la BDD')


def get_all_vacataires():
    """Get all vacataires from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM vacataires""")
    return cursor.fetchall()


def get_vacataire(id_vacataire):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""SELECT * FROM vacataires WHERE id_vacataire = :id""", {'id': id_vacataire})
    except sqlite3.Error as e:
        current_app.logger.error(f"Pas de vacataire avec l'identifiant {id_vacataire}")
    return cursor.fetchall()


def delete_vacataire(id_vacataire):
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""DELETE FROM vacataires WHERE id_vacataire = :id""", {'id': id_vacataire})
    db.commit()
    if cursor.rowcount == 1:
        current_app.logger.info(f'Utilisateur {id_vacataire} supprimé')
        flash(f"Utilisateur {id_vacataire} supprimé", "error")
    else:
        current_app.logger.info(f'Utilisateur {id_vacataire} pas supprimé (n’existe pas)')


def get_all_enseignants():
    """Get all enseignants from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM enseignants""")
    return cursor.fetchall()


def get_enseignant(id_enseignant):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""SELECT * FROM enseignants WHERE id_enseignant = :id""", {'id': id_enseignant})
    except sqlite3.Error as e:
        current_app.logger.error(f"Pas d'enseignant avec l'identifiant {id_enseignant}")
    return cursor.fetchall()


def delete_enseignant(id_enseignant):
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""DELETE FROM enseignants WHERE id_enseignant = :id""", {'id': id_enseignant})
    db.commit()
    if cursor.rowcount == 1:
        current_app.logger.info(f'Utilisateur {id_enseignant} supprimé')
        flash(f"Utilisateur {id_enseignant} supprimé", "error")
    else:
        current_app.logger.info(f'Utilisateur {id_enseignant} pas supprimé (n’existe pas)')


def get_modules():
    """Get all modules from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM modules""")
    return cursor.fetchall()


def get_interventions():
    """Get all interventions from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM interventions""")
    return cursor.fetchall()


def get_all_contrats():
    """Get all contrats from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM contrats""")
    return cursor.fetchall()


def get_contrat(id_contrat):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""SELECT * FROM contrats WHERE id_contrat = :id""", {'id': id_contrat})
    except sqlite3.Error as e:
        current_app.logger.error(f"Pas de de contrat avec l'identifiant {id_contrat}")
    return cursor.fetchall()


def add_contrat(contrat):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""INSERT INTO contrats (date_deb, date_fin, id_vacataire, id_referent) 
        VALUES (:date_deb, :date_fin, :id_vacataire, :id_referent)""", contrat)
        current_app.logger.info(f'Contrat {contrat} ajouté')
        db.commit()
        flash("Contrat ajouté", "success")
    except sqlite3.Error as e:
        print(e)
        # à modifier
        flash('Une erreur est survenu', "error")
        current_app.logger.error(f"Impossible d'ajouter {contrat}")


def delete_contrat(id_contrat):
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""DELETE FROM contrats WHERE id_contrat = :id""", {'id': id_contrat})
    db.commit()
    if cursor.rowcount == 1:
        current_app.logger.info(f'Contrat {id_contrat} supprimé')
        flash(f"Contrat {id_contrat} supprimé", "error")
    else:
        current_app.logger.info(f'Contrat {id_contrat} pas supprimé (n’existe pas)')


def get_comptes():
    """Get all contrats from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT login, role FROM comptes""")
    return cursor.fetchall()


def add_compte(compte):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""INSERT INTO comptes (login, mdp, role) VALUES (:login, :password, :role)""", compte)
        current_app.logger.info(f'Compte {compte} ajouté')
        db.commit()
    except sqlite3.Error as e:
        print(e)
        current_app.logger.error(f"Impossible d'ajouter {compte}")


def del_compte(login):
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""DELETE FROM comptes WHERE login = :login""", {'login': login})
    db.commit()
    if cursor.rowcount == 1:
        current_app.logger.info(f'Compte {login} supprimé')
        flash(f"Utilisateur {login} supprimé", "error")
    else:
        current_app.logger.info(f'Utilisateur {login} pas supprimé (n’existe pas)')


def get_user(user):
    """Get data of an user by login"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT login, mdp, role FROM comptes
                          WHERE login = :login""",
                   {'login': user})
    user = cursor.fetchone()
    return user


def add_vacataire(vacataire):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""INSERT INTO vacataires (nom, prenom, email, tel, statut, employeur,
        login, recrutable) VALUES (:nom, :prenom, :email, :tel, :statut, :employeur,
        :login, :recrutable)""", vacataire)
        db.commit()
        current_app.logger.info(f'Utilisateur {vacataire} ajouté')
        flash("Vacataire ajouté", "success")
    except sqlite3.Error as e:
        current_app.logger.error(f"Impossible d'ajouter {vacataire}")


def add_enseignant(enseignant):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""INSERT INTO enseignants (nom, prenom, email, tel, login) 
                            VALUES (:nom, :prenom, :email, :tel, :login)""", enseignant)
        db.commit()
        current_app.logger.info(f'Utilisateur {enseignant} ajouté')
        flash("Enseignant ajouté", "success")
    except sqlite3.Error as e:
        current_app.logger.error(f"Impossible d'ajouter {enseignant}")


def password_hash(password):
    """Hash a password for storing"""
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode("utf-8")


def password_verify(password, hash):
    """Verify a stored password against one provided by user"""
    return bcrypt.checkpw(password.encode('utf-8'),
                          hash.encode('utf-8') if isinstance(hash, str) else hash)


def check_login(login, password):
    """Check if login and password are correct"""
    user = get_user(login)
    return user is not None and password_verify(password, user['mdp'])

