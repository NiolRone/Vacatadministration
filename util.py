import sqlite3
from flask import current_app, g
import bcrypt


def get_db():
    if 'db' not in g:
        g.db = sqlite3.connect(current_app.config['DATABASE'])
        g.db.row_factory = sqlite3.Row
        current_app.logger.info(f'Connexion à la BDD')
    return g.db


def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()
        current_app.logger.info(f'Déconnexion de la BDD')


def get_data():
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT * FROM vacataires""")
    return cursor.fetchall()


def get_user(user):
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""SELECT login, mdp, role FROM comptes
                          WHERE login = :login""",
                   {'login': user})
    user = cursor.fetchone()
    return user


def password_hash(password):
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode("utf-8")


def password_verify(password, hash):
    return bcrypt.checkpw(password.encode('utf-8'),
                          hash.encode('utf-8') if isinstance(hash, str) else hash)


def check_login(login, password):
    user = get_user(login)
    return user is not None and password_verify(password, user['mdp'])
