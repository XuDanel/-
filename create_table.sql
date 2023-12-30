-- 学生基本信息表
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    gender CHAR(1),
    phone_number CHAR(11),
    email VARCHAR(100),
    password VARCHAR(50),
    grade INT
);

-- 教师基本信息表
CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(50),
    gender CHAR(1),
    phone_number VARCHAR(20),
    email VARCHAR(50),
    password VARCHAR(50)
);

-- 学院信息表
CREATE TABLE college (
    college_id INT PRIMARY KEY,
    college_name VARCHAR(20)
);

-- 学生表与学院表以学院编号作为外键连接
ALTER TABLE student
ADD COLUMN college_id INT,
ADD FOREIGN KEY (college_id) REFERENCES college(college_id);

-- 教师表与学院表以学院编号作为外键连接
ALTER TABLE teacher
ADD COLUMN college_id INT,
ADD FOREIGN KEY (college_id) REFERENCES college(college_id);

-- 创建课程基本信息表
CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(20),
    academic_year_semester VARCHAR(20),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

-- 记录学生的选课信息
CREATE TABLE course_enrollment (
    course_id INT,
    student_id INT,
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- 管理课程材料
CREATE TABLE course_materials (
    material_id INT PRIMARY KEY,
    course_id INT,
    title VARCHAR(50),
    uploader_id INT,
    content TEXT,
    visibility VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (uploader_id) REFERENCES teacher(teacher_id)
);

-- 作业管理表
CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY,
    course_id INT,
    title VARCHAR(50),
    creator_id INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (creator_id) REFERENCES teacher(teacher_id)
);

-- 题目信息表
CREATE TABLE questions (
    question_id INT PRIMARY KEY,
    question_type VARCHAR(20),
    question_text TEXT,
    creator_id INT,
    answer TEXT,
    score DECIMAL(4,2),
    FOREIGN KEY (creator_id) REFERENCES teacher(teacher_id)
);

-- 选择项表
CREATE TABLE choices (
    choice_id INT PRIMARY KEY,
    question_id INT,
    choice_text TEXT,
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);


-- 关联作业和题目
CREATE TABLE assignment_questions (
    question_id INT,
    assignment_id INT,
    question_text TEXT,
    PRIMARY KEY (assignment_id, question_id),
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id)
);


-- 存储学生提交的作业信息
CREATE TABLE student_assignments (
    student_assignment_id INT PRIMARY KEY,
    student_id INT,
    assignment_id INT,
    submission_time DATETIME,
    grade DECIMAL(4,2),
    comment TEXT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id)
);

-- 讨论区设计
-- 板块表
CREATE TABLE board (
  board_id INT PRIMARY KEY,
  name VARCHAR(50),
  creator_id INT,
  FOREIGN KEY (creator_id) REFERENCES teacher (teacher_id)
);

-- 帖子表
CREATE TABLE post (
  post_id INT PRIMARY KEY,
  board_id INT,
  author_id INT,
  title VARCHAR(100),
  content TEXT,
  post_time TIMESTAMP,
  views INT DEFAULT 0, -- 记录浏览量
  likes INT DEFAULT 0, -- 记录点赞数
  FOREIGN KEY (board_id) REFERENCES board (board_id),
  FOREIGN KEY (author_id) REFERENCES student (student_id) ON DELETE CASCADE -- 如果在 student 表中删除了一个学生的记录，那么与该学生相关的 post 表中的帖子记录也会被自动删除。这样可以确保数据的一致性，避免出现存在无效引用的情况。
);

-- 回复表
CREATE TABLE reply (
  reply_id INT PRIMARY KEY,
  post_id INT,
  author_id INT,
  content TEXT,
  reply_time TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES post (post_id) ON DELETE CASCADE,
  FOREIGN KEY (author_id) REFERENCES student (student_id) ON DELETE CASCADE
);

# 导入数据库相关的库和模块

# 创建LearningPage表
CREATE TABLE LearningPage (
    LearningPage_id INT PRIMARY KEY,
    student_id INT,
    SelectedCourses VARCHAR(255),
    UpcomingAssignments VARCHAR(255),
    RecentCourseMaterials VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


-- 创建板块表
CREATE TABLE forum_section (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    section_name VARCHAR(100) NOT NULL,
    -- 其他板块信息字段
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

-- 创建帖子表
CREATE TABLE forum_post (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    section_id INT,
    teacher_id INT,
    post_content TEXT NOT NULL,
    post_time DATETIME NOT NULL,
    -- 其他帖子信息字段
    FOREIGN KEY (section_id) REFERENCES forum_section(section_id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

-- 创建回复表
CREATE TABLE forum_reply (
    reply_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    teacher_id INT,
    reply_content TEXT NOT NULL,
    reply_time DATETIME NOT NULL,
    -- 其他回复信息字段
    FOREIGN KEY (post_id) REFERENCES forum_post(post_id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);



