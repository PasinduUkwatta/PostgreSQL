--complete ztm database table

CREATE DOMAIN Rating SMALLINT CHECK(VALUE >0 AND VALUE <=5);
CREATE TYPE Feedback AS(
student_id UUID,
rating Rating,
feedack TEXT

)


CREATE TABLE student(
student_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() ,
first_name VARCHAR (255) NOT NULL,
last_name VARCHAR (255) NOT NULL,
date_of_birth DATe  NOT NULL

)


CREATE TABLE subject(
subject_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() ,
subject TEXT NOT NULL,
description TEXT 
)

CREATE TABLE teacher(
teacher_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
first_name VARCHAR (255) NOT NULL,
last_name VARCHAR (255) NOT NULL,
date_of_birth DATe  NOT NULL,
email TEXT 

)

ALTER TABLE student
ADD COLUMN email TEXT

CREATE TABLE course(
course_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
"name" TEXT NOT NULL,
description TEXT,
subject_id uuid REFERENCES subject(subject_id),
teacher_id uuid REFERENCES teacher(teacher_id),
feedback feedback[]
)

CREATE TABLE enrollment(
course_id uuid REFERENCES course(course_id) ,
student_id uuid REFERENCES student(student_id) ,
enrollment_date DATE NOT NULL,
CONSTRAINT pk_enrollment PRIMARY KEY (course_id,student_id)

)

--insert data into student table

INSERT INTO student(
first_name,
last_name,
email,
date_of_birth
)
VALUES(
'Pasindu',
'Thiwanka',
'pasindu@gmail.com',
'1996-03-06' ::DATE
);


INSERT INTO teacher(
first_name,
last_name,
email,
date_of_birth
)
VALUES(
'Pasindu',
'Thiwanka',
'pasindu@gmail.com',
'1996-03-06' ::DATE
);
-------------------------------------------------------------------------------------------------------------

INSERT INTO subject(
subject,
description
)VALUES(
'SQL ',
'Database Managment')


INSERT INTO subject(
subject,
description
)VALUES(
'SQL ',
'Database Managment')

INSERT INTO course(
"name",
description
)VALUES(
'SQL zero to Mastery ',
'Database Managment best course')

ALTER TABLE course ALTER COLUMN subject_id SET NOT NULL

UPDATE course
SET subject_id ='36b05ece-c910-40d0-ab1b-df7d46fc8288'
WHERE subject_id IS NULL

UPDATE course
SET teacher_id ='1e610c8a-ad87-440d-b767-f9a54abcda7a'
WHERE teacher_id IS NULL

ALTER TABLE course ALTER COLUMN teacher_id SET NOT NULL

INSERT INTO enrollment (student_id,course_id,enrollment_date)
VALUES('624e68c2-646f-4176-813b-7efaefc37ba8',
'efee6871-6fe8-4ada-b30d-3d6bd6c9f112',
now()::DATE)

UPDATE course
SET feedback =array_append(
feedback,
ROW(
'624e68c2-646f-4176-813b-7efaefc37ba8',
5,
'Good Course'
)::feedback
)
WHERE course_id='efee6871-6fe8-4ada-b30d-3d6bd6c9f112'


CREATE TABLE feedback(
student_id uuid NOT NULL REFERENCES student(student_id),
course_id uuid NOT NULL REFERENCES course(course_id),
feedback TEXT,
rating rating,
CONSTRAINT pk_feedback PRIMARY KEY (student_id,course_id)
)

INSERT INTO feedback(
student_id,course_id,feedback,rating)
VALUES(
'624e68c2-646f-4176-813b-7efaefc37ba8',
'efee6871-6fe8-4ada-b30d-3d6bd6c9f112',
'good course for sql',
5
)