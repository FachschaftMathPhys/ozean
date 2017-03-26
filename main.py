from init import app, initAPI
from flask import send_from_directory

@app.route('/')
def index():
    return send_from_directory('frontend', 'index.html')

if __name__ == '__main__':
	initAPI()
	app.run();