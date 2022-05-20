# coding: UTF-8
"""
Script: sae23/app
Création: maurelji, le 13/05/2022
"""


# Imports
from flask import Flask, render_template, request, flash, redirect, url_for, session
import util

# Routes
app = Flask(__name__)
app.config['SECRET_KEY'] = '2033090bb1a123046aef055a852e254ca3f056f0a4454af930cffc019b601465'
app.config['DATABASE'] = 'bdd/bdd_v2.sqlite'
app.teardown_appcontext(util.close_db)


@app.route("/")
def home():
    return render_template("home.html", vacataires=util.get_data())


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')
    login = request.form.get('login')
    password = request.form.get('password')
    if util.check_login(login, password):
        flash("Connexion réussie")
        session['login'] = login
        return redirect(url_for('home'))
    flash("Identifiants invalides")
    return redirect(url_for('login'))


@app.route('/logout')
def logout():
    if 'login' in session:
        session.pop('login')
        flash('Déconnexion réussie')
    return redirect(url_for('login'))


if __name__ == '__main__':
    app.run(debug=True, port=5001)
