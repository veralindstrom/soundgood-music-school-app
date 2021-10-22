CREATE TABLE available_time_slot (
 available_time_slot_id CHAR(10) NOT NULL,
 available_time_slot TIMESTAMP(10)
);

ALTER TABLE available_time_slot ADD CONSTRAINT PK_available_time_slot PRIMARY KEY (available_time_slot_id);


CREATE TABLE instrument (
 instrument_id VARCHAR(50) NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE personal_data (
 personal_data_id INT NOT NULL,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 age VARCHAR(10) NOT NULL,
 social_security_number VARCHAR(13),
 phone_number VARCHAR(12) NOT NULL,
 email VARCHAR(500) NOT NULL,
 zip VARCHAR(5),
 street VARCHAR(100),
 city VARCHAR(100)
);

ALTER TABLE personal_data ADD CONSTRAINT PK_personal_data PRIMARY KEY (personal_data_id);


CREATE TABLE rental_instrument (
 rental_instrument_id INT NOT NULL,
 brand VARCHAR(100),
 quantity INT NOT NULL,
 price VARCHAR(100) NOT NULL,
 instrument_id VARCHAR(50) NOT NULL
);

ALTER TABLE rental_instrument ADD CONSTRAINT PK_rental_instrument PRIMARY KEY (rental_instrument_id);


CREATE TABLE salary (
 salary_id INT NOT NULL,
 month VARCHAR(50),
 amount FLOAT(10)
);

ALTER TABLE salary ADD CONSTRAINT PK_salary PRIMARY KEY (salary_id);


CREATE TABLE school (
 school_id INT NOT NULL,
 name VARCHAR(100) NOT NULL,
 available_spots INT NOT NULL,
 minimum_age INT NOT NULL
);

ALTER TABLE school ADD CONSTRAINT PK_school PRIMARY KEY (school_id);


CREATE TABLE skill_level (
 skill_level_id VARCHAR(50) NOT NULL,
 skill_level VARCHAR(50)
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (skill_level_id);


CREATE TABLE student (
 student_id INT NOT NULL,
 reached_item_quota_for_rental VARCHAR(10) NOT NULL,
 personal_data_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_monthly_fee (
 student_id INT NOT NULL,
 amount FLOAT(10),
 extra_charge FLOAT(10),
 sibling_discount FLOAT(10)
);

ALTER TABLE student_monthly_fee ADD CONSTRAINT PK_student_monthly_fee PRIMARY KEY (student_id);


CREATE TABLE administration (
 admin_id INT NOT NULL,
 school_id INT NOT NULL
);

ALTER TABLE administration ADD CONSTRAINT PK_administration PRIMARY KEY (admin_id);


CREATE TABLE application (
 application_id INT NOT NULL,
 personal_data_id INT NOT NULL,
 accepted INT
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (application_id,personal_data_id);


CREATE TABLE audition (
 student_id INT NOT NULL,
 audition_id INT NOT NULL,
 result VARCHAR(50),
 instrument VARCHAR(50) NOT NULL
);

ALTER TABLE audition ADD CONSTRAINT PK_audition PRIMARY KEY (student_id,audition_id);


CREATE TABLE guardian_of_student (
 guardian_id INT NOT NULL,
 personal_data_id INT NOT NULL,
 phone_number VARCHAR(12) NOT NULL,
 email VARCHAR(500) NOT NULL
);

ALTER TABLE guardian_of_student ADD CONSTRAINT PK_guardian_of_student PRIMARY KEY (guardian_id,personal_data_id);


CREATE TABLE instructor (
 instructor_id INT NOT NULL,
 personal_data_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_available_time_slot (
 instructor_id INT NOT NULL,
 available_time_slot_id CHAR(10) NOT NULL
);

ALTER TABLE instructor_available_time_slot ADD CONSTRAINT PK_instructor_available_time_slot PRIMARY KEY (instructor_id,available_time_slot_id);


CREATE TABLE instructor_instrument_skill (
 instructor_id INT NOT NULL,
 instrument_id VARCHAR(50) NOT NULL
);

ALTER TABLE instructor_instrument_skill ADD CONSTRAINT PK_instructor_instrument_skill PRIMARY KEY (instructor_id,instrument_id);


CREATE TABLE instructor_monthly_salary (
 instructor_id INT NOT NULL,
 salary_id INT NOT NULL
);

ALTER TABLE instructor_monthly_salary ADD CONSTRAINT PK_instructor_monthly_salary PRIMARY KEY (instructor_id,salary_id);


CREATE TABLE price (
 price_id INT NOT NULL,
 day_of_week VARCHAR(100) NOT NULL,
 skill_level_id VARCHAR(50) NOT NULL,
 amount FLOAT(10)
);

ALTER TABLE price ADD CONSTRAINT PK_price PRIMARY KEY (price_id);


CREATE TABLE rental (
 rental_id INT NOT NULL,
 lease_period DATE NOT NULL,
 monthly_fee VARCHAR(100) NOT NULL,
 rental_instrument_id INT
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (rental_id);


CREATE TABLE sibling (
 student_id_1 INT NOT NULL,
 student_id_2 INT NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id_1,student_id_2);


CREATE TABLE student_in_line (
 admin_id INT NOT NULL,
 personal_data_id INT NOT NULL
);

ALTER TABLE student_in_line ADD CONSTRAINT PK_student_in_line PRIMARY KEY (admin_id,personal_data_id);


CREATE TABLE student_rental (
 student_id INT NOT NULL,
 rental_id INT NOT NULL,
 delivery CHAR(10)
);

ALTER TABLE student_rental ADD CONSTRAINT PK_student_rental PRIMARY KEY (student_id,rental_id);


CREATE TABLE booked_lesson (
 booked_lesson_id INT NOT NULL,
 price_id INT NOT NULL,
 maximun_enrollments INT,
 minimum_enrollments INT,
 date TIMESTAMP(10),
 instructor_id INT NOT NULL,
 admin_id INT NOT NULL
);

ALTER TABLE booked_lesson ADD CONSTRAINT PK_booked_lesson PRIMARY KEY (booked_lesson_id);


CREATE TABLE ensamble (
 ensamble_id INT NOT NULL,
 genre VARCHAR(50),
 booked_lesson_id INT
);

ALTER TABLE ensamble ADD CONSTRAINT PK_ensamble PRIMARY KEY (ensamble_id);


CREATE TABLE ensamble_instrument (
 instrument_id VARCHAR(50) NOT NULL,
 ensamble_id INT NOT NULL
);

ALTER TABLE ensamble_instrument ADD CONSTRAINT PK_ensamble_instrument PRIMARY KEY (instrument_id,ensamble_id);


CREATE TABLE group_lesson (
 group_lesson_id INT NOT NULL,
 booked_lesson_id INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id);


CREATE TABLE group_lesson_instrument (
 instrument_id VARCHAR(50) NOT NULL,
 group_lesson_id INT NOT NULL
);

ALTER TABLE group_lesson_instrument ADD CONSTRAINT PK_group_lesson_instrument PRIMARY KEY (instrument_id,group_lesson_id);


CREATE TABLE individual_lesson (
 individual_lesson_id INT NOT NULL,
 instrument_id VARCHAR(50) NOT NULL,
 booked_lesson_id INT
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individual_lesson_id);


CREATE TABLE student_booked_lesson (
 student_id INT NOT NULL,
 booked_lesson_id INT NOT NULL
);

ALTER TABLE student_booked_lesson ADD CONSTRAINT PK_student_booked_lesson PRIMARY KEY (student_id,booked_lesson_id);


ALTER TABLE rental_instrument ADD CONSTRAINT FK_rental_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE student_monthly_fee ADD CONSTRAINT FK_student_monthly_fee_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE administration ADD CONSTRAINT FK_administration_0 FOREIGN KEY (school_id) REFERENCES school (school_id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE audition ADD CONSTRAINT FK_audition_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE guardian_of_student ADD CONSTRAINT FK_guardian_of_student_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE instructor_available_time_slot ADD CONSTRAINT FK_instructor_available_time_slot_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_available_time_slot ADD CONSTRAINT FK_instructor_available_time_slot_1 FOREIGN KEY (available_time_slot_id) REFERENCES available_time_slot (available_time_slot_id);


ALTER TABLE instructor_instrument_skill ADD CONSTRAINT FK_instructor_instrument_skill_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_instrument_skill ADD CONSTRAINT FK_instructor_instrument_skill_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE instructor_monthly_salary ADD CONSTRAINT FK_instructor_monthly_salary_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_monthly_salary ADD CONSTRAINT FK_instructor_monthly_salary_1 FOREIGN KEY (salary_id) REFERENCES salary (salary_id);


ALTER TABLE price ADD CONSTRAINT FK_price_0 FOREIGN KEY (skill_level_id) REFERENCES skill_level (skill_level_id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (rental_instrument_id) REFERENCES rental_instrument (rental_instrument_id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id_1) REFERENCES student (student_id);
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (student_id_2) REFERENCES student (student_id);


ALTER TABLE student_in_line ADD CONSTRAINT FK_student_in_line_0 FOREIGN KEY (admin_id) REFERENCES administration (admin_id);
ALTER TABLE student_in_line ADD CONSTRAINT FK_student_in_line_1 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE student_rental ADD CONSTRAINT FK_student_rental_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_rental ADD CONSTRAINT FK_student_rental_1 FOREIGN KEY (rental_id) REFERENCES rental (rental_id);


ALTER TABLE booked_lesson ADD CONSTRAINT FK_booked_lesson_0 FOREIGN KEY (price_id) REFERENCES price (price_id);
ALTER TABLE booked_lesson ADD CONSTRAINT FK_booked_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE booked_lesson ADD CONSTRAINT FK_booked_lesson_2 FOREIGN KEY (admin_id) REFERENCES administration (admin_id);


ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_0 FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson (booked_lesson_id);


ALTER TABLE ensamble_instrument ADD CONSTRAINT FK_ensamble_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE ensamble_instrument ADD CONSTRAINT FK_ensamble_instrument_1 FOREIGN KEY (ensamble_id) REFERENCES ensamble (ensamble_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson (booked_lesson_id);


ALTER TABLE group_lesson_instrument ADD CONSTRAINT FK_group_lesson_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE group_lesson_instrument ADD CONSTRAINT FK_group_lesson_instrument_1 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (group_lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson (booked_lesson_id);


ALTER TABLE student_booked_lesson ADD CONSTRAINT FK_student_booked_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_booked_lesson ADD CONSTRAINT FK_student_booked_lesson_1 FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson (booked_lesson_id);


