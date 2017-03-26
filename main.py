from init import app, initAPI
from flask import send_from_directory

@app.route('/')
def index():
    return send_from_directory('frontend', 'index.html')

if __name__ == '__main__':
	initAPI()
	#pp.run();
	app.run(host="0.0.0.0", port=int(80))