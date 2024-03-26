from flask import Flask, render_template, jsonify
import requests

app = Flask(__name__)

# Define the base URL of the API
API_BASE_URL = 'http://localhost:4000/api'

@app.route('/')
def index():
    response = requests.get(f'{API_BASE_URL}/items')
    items = response.json()
    return render_template('index.html', items=items)

if __name__ == '__main__':
    app.run(debug=True)