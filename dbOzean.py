from init import app, db
from datetime import datetime

class student(db.Model):
    id    = db.Column(db.Integer, primary_key=True)
    name  = db.Column(db.String(80))
    uniid = db.Column(db.String(5))
    matriculationnumber = db.Column(db.String(7))
    refund = db.Column(db.Boolean)
    report = db.Column(db.Boolean)
    comment = db.Column(db.String(255))

    def __init__(self, name, uniId,
        matriculationNumber, refund, report,
        comment):
        self.name = name
        self.uniid = uniId
        self.matriculationnumber = matriculationNumber
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
    studentId = db.Column(db.Integer)
    folderId = db.Column(db.Integer)
    lentAt = db.Column(db.DateTime)

    def __init__(self, studentId, folderId):
        self.studentId = studentId
        self.folderId = folderId
        self.lentAt = datetime.now()

class returned(db.Model):
    id    = db.Column(db.Integer, primary_key=True)
    studentId = db.Column(db.Integer)
    folderId = db.Column(db.Integer)
    lentAt = db.Column(db.DateTime)
    returnedAt = db.Column(db.DateTime)

    def __init__(self, studentId, folderId, lentAt):
        self.studentId = studentId
        self.folderId = folderId
        self.lentAt = lentAt
        self.returnedAt = datetime.now()