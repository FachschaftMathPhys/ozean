from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_restless import APIManager
from datetime import datetime

app = Flask(__name__)
#app.config['DEBUG'] = True
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///foo.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
apimanager = APIManager(app, flask_sqlalchemy_db=db)

class student(db.Model):
    id    = db.Column(db.Integer, primary_key=True)
    name  = db.Column(db.String(80))
    uniid = db.Column(db.String(5))
    matriculationnumber = db.Column(db.String(7))
    refund = db.Column(db.Boolean)
    report = db.Column(db.Boolean)
    comment = db.Column(db.String(255))

    def __init__(self, name=None, uniid=None,
        matriculationnumber=None, refund=None, report=None,
        comment=None):
        self.name = name
        self.uniid = uniid
        self.matriculationnumber = matriculationnumber
        self.refund = refund
        self.report = report
        self.comment = comment

    def __repr__(self):
        return '<User %r>' % self.name

class folder(db.Model):
    id    = db.Column(db.Integer, primary_key=True)
    name  = db.Column(db.String(80))
    content  = db.Column(db.String(80))
    obligation_to_report = db.Column(db.Boolean)
    barcode = db.Column(db.String(80))

    def __init__(self, name, content, obligation, barcode):
        self.name = name
        self.content = content
        self.obligation_to_report = obligation
        self.barcode = barcode

    def __repr__(self):
        return '<User %r>' % self.name

class lent(db.Model):
    id    = db.Column(db.Integer, primary_key=True)
    studentid = db.Column(db.Integer)
    folderid = db.Column(db.Integer)
    lentat = db.Column(db.DateTime)

    def __init__(self, studentid=None, folderid=None):
        self.studentid = studentid
        self.folderid = folderid
        self.lentat = datetime.now()

class returned(db.Model):
    id    = db.Column(db.Integer, primary_key=True)
    studentid = db.Column(db.Integer)
    folderid = db.Column(db.Integer)
    lentat = db.Column(db.DateTime)
    returnedat = db.Column(db.DateTime)

    def __init__(self, studentid=None, folderid=None, lentat=None):
        self.studentid = studentid
        self.folderid = folderid
        self.lentat = lentat
        self.returnedat = datetime.now()

def initAPI():
	db.create_all()
	apimanager.create_api(student,  methods=['GET', 'POST', 'PUT'])
	apimanager.create_api(folder,   methods=['GET'])
	apimanager.create_api(lent,     methods=['GET', 'POST', 'DELETE'])
	apimanager.create_api(returned, methods=['GET', 'POST'])

if __name__ == '__main__':
	initAPI()
	app.run()
