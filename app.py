# coding: UTF-8
"""
Script: sae23/app
Création: maurelji, le 13/05/2022
"""


# Imports
from flask import Flask, render_template, request, redirect, url_for, flash

# Routes
app = Flask(__name__)

@app.route("/")
def home():
    return render_template("home.html")

if __name__ == '__main__':
    app.run(debug=True, port=5001)
