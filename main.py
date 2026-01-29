from flask import Flask,render_template

app=Flask()

@app.route("/")
def display_index():
    return render_template('index.html')

@app.route("/about")
def display_about():
    return render_template('about.html')