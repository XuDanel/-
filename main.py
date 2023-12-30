from model import teacher
from ui.loginUi import LoginUi
from view import LoginView
import sys
from PyQt5 import QtWidgets


if __name__ == '__main__':
    app=QtWidgets.QApplication(sys.argv)
    loginUi=LoginUi()
    loginUi.show()
    sys.exit(app.exec_())

