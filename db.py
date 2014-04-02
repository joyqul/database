import MySQLdb

# Database's password
f = open("flight/password")
for line in f:
    db_passwd = line.split()
    db_passwd = db_passwd[0]
    
def db_login():
    db = MySQLdb.connect(host="localhost", user="root_flight", passwd= db_passwd, db="db_flight")
    return db
