from init import app, db
import dbOzean
from flask_restless import APIManager

apimanager = APIManager(app, flask_sqlalchemy_db=db)

def initAPI():
	db.create_all()
	apimanager.create_api(dbOzean.student,  methods=['GET', 'POST', 'PUT'])
	apimanager.create_api(dbOzean.folder,   methods=['GET'])
	apimanager.create_api(dbOzean.lent,     methods=['GET', 'POST', 'DELETE'])
	apimanager.create_api(dbOzean.returned, methods=['GET', 'POST'])

if __name__ == '__main__':
	initAPI()
	app.run()

