# coding: UTF-8
"""
Script: sae23/app
Création: maurelji, le 13/05/2022
"""


# Imports
from flask import Flask, render_template
import util

# Routes
app = Flask(__name__)
app.config['SECRET_KEY'] = '2033090bb1a123046aef055a852e254ca3f056f0a4454af930cffc019b601465'
app.config['DATABASE'] = 'bdd/bdd_v2.sqlite'
app.teardown_appcontext(util.close_db)


@app.route("/")
def home():
    return render_template("home.html", vacataires=util.get_data())


if __name__ == '__main__':
    app.run(debug=True, port=5001)
