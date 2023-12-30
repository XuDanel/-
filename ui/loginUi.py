import pymysql

import view
import sys

from model.student import Student
from util import dbUtil
from view.LoginView import Ui_MainWindow
from PyQt5 import QtWidgets
import util.dbUtil
from model import student


class LoginUi(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self):
        super(LoginUi, self).__init__()
        self.setupUi(self)

    def clickLoginButton(self):
        id = self.idLine.text()
        password = self.passwordLine.text()
        identity = self.identityBox.currentText()
        # 要加一个是否为空的判断
        conn = dbUtil.getConn()
        cur = conn.cursor()
        if identity == "学生":
            sql = "SELECT * FROM student where student_id={}".format(id)
            cur.execute(sql)
            student_info = cur.fetchall()
            if student_info:
                if student_info[0][5] == password:
                    print(list(student_info[0]))
                    stu = Student(list(student_info[0]))

                else:
                    print("密码错误")
            else:
                print("用户不存在")


            # elif identity=="教师":
            #
            # elif identity=="管理员":



