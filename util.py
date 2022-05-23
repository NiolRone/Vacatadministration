import sqlite3
from flask import current_app, g
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


def get_vacataires():
    """Get all vacataires from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM vacataires""")
    return cursor.fetchall()


def get_ensignants():
    """Get all enseignants from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM enseignants""")
    return cursor.fetchall()


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


def get_contrats():
    """Get all contrats from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM contrats""")
    return cursor.fetchall()


def get_comptes():
    """Get all contrats from database"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT login, role FROM comptes""")
    return cursor.fetchall()


def get_user(user):
    """Get data of an user by login"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT login, mdp, role FROM comptes
                          WHERE login = :login""",
                   {'login': user})
    user = cursor.fetchone()
    return user


def add_compte(compte):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""INSERT INTO comptes (login, mdp, role) VALUES (:login, :password, :role)""")
        current_app.logger.info(f'Compte {compte} ajouté')
        db.commit()
    except sqlite3.Error as e:
        current_app.logger.error(f"Impossible d'ajouter {compte}")


def add_vacataire(vacataire):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("""INSERT INTO vacataires (nom, prenom, email, tel, statut, employeur,
        login, recrutable) VALUES (:nom, :prenom, :email, :tel, :statut, :employeur,
        :login, :recrutable)""", vacataire)
        db.commit()
        current_app.logger.info(f'Utilisateur {vacataire["nom"], vacataire["prenom"]} ajouté')
    except sqlite3.Error as e:
        current_app.logger.error(f"Impossible d'ajouter {vacataire}")


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

