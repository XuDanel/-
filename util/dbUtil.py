import pymysql

connection_info = {
    'host': 'localhost',
    'user': 'root',
    'password': '123456',
    'database': 'wm_db'
}

def getConn():
    conn=pymysql.connect(**connection_info)
    return conn
