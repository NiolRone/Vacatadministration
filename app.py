# coding: UTF-8
"""
Script: sae23/app
Création: maurelji, le 13/05/2022
"""


# Imports
from flask import Flask, render_template, request, flash, redirect, url_for, session
import util
from flask_wtf.csrf import CSRFProtect

# Initialisation
app = Flask(__name__)
app.config['SECRET_KEY'] = '2033090bb1a123046aef055a852e254ca3f056f0a4454af930cffc019b601465'
app.config['DATABASE'] = 'bdd/bdd_v2.sqlite'
app.teardown_appcontext(util.close_db)
csrf = CSRFProtect(app)


# Routes
@app.route("/")
def home():
    return render_template("home.html", vacataires=util.get_vacataires())


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')
    login = request.form.get('login')
    password = request.form.get('password')
    if util.check_login(login, password):
        flash("Connexion réussie", "success")
        session['login'] = login
        return redirect(url_for('home'))
    flash("Identifiants invalides", "error")
    return redirect(url_for('login'))


@app.route('/logout')
def logout():
    if 'login' in session:
        session.pop('login')
        flash('Déconnexion réussie', 'success')
    return redirect(url_for('login'))

@app.route('/vacataires/add', methods=['GET', 'POST'])
def add_vacataire():
    if request.method == 'GET':
        return render_template('add_vacataire.html')
    nom = request.form.get('nom')
    prenom = request.form.get('prenom')
    email = request.form.get('email')
    tel = request.form.get('tel')
    statut = request.form.get('statut')
    employeur = request.form.get('employeur')
    login = request.form.get('login')
    recrutable = request.form.get('recrutable')
    flash("Vacataire ajouté", "success")
    return redirect(url_for('home'))



@app.route('/enseignants')
def liste_enseignants():
    return render_template(f'enseignants.html', enseignants=util.get_ensignants())


@app.route('/vacataires')
def liste_vacataires():
    return render_template(f'vacataires.html', vacataires=util.get_vacataires())


@app.route('/modules')
def liste_modules():
    return render_template(f'modules.html', modules=util.get_modules())


@app.route('/interventions')
def liste_interventions():
    return render_template(f'interventions.html', interventions=util.get_interventions())


@app.route('/contrats')
def liste_contrats():
    return render_template(f'contrats.html', contrats=util.get_contrats())


@app.route('/comptes')
def liste_comptes():
    return render_template(f'comptes.html', comptes=util.get_comptes())


if __name__ == '__main__':
    app.run(debug=True, port=5001)
