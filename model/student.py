class Student:

    def __int__(self, stuInfo):
        header = ["student_id", "name", "gender", "phone_number", "email", "password", "grade", "college_id"]
        info = dict(zip(header, stuInfo))
        print(info)
