DROP TABLE IF EXISTS "school";
CREATE TABLE "public"."school" (
	"school_id" integer NOT NULL,
	"name" character varying(100) NOT NULL,
	"available_spots" integer NOT NULL,
	"minimum_age" integer NOT NULL,
	CONSTRAINT "pk_school" PRIMARY KEY ("school_id")
);

DROP TABLE IF EXISTS "administration";
CREATE TABLE "public"."administration" (
	"admin_id" integer NOT NULL,
	"school_id" integer NOT NULL,
	CONSTRAINT "pk_administration" PRIMARY KEY ("admin_id"),
	CONSTRAINT "fk_administration_0" FOREIGN KEY (school_id) REFERENCES school(school_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "personal_data";
CREATE TABLE "public"."personal_data" (
	"personal_data_id" integer NOT NULL,
	"first_name" character varying(50) NOT NULL,
	"last_name" character varying(50) NOT NULL,
	"age" character varying(10) NOT NULL,
	"social_security_number" character varying(13),
	"phone_number" character varying(12) NOT NULL,
	"email" character varying(500) NOT NULL,
	"zip" character varying(5),
	"street" character varying(100),
	"city" character varying(100),
	CONSTRAINT "pk_personal_data" PRIMARY KEY ("personal_data_id")
);

DROP TABLE IF EXISTS "application";
CREATE TABLE "public"."application" (
	"application_id" integer NOT NULL,
	"personal_data_id" integer NOT NULL,
	"accepted" boolean NOT NULL,
	CONSTRAINT "pk_application" PRIMARY KEY ("application_id", "personal_data_id"),
	CONSTRAINT "fk_application_0" FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id) NOT DEFERRABLE
) WITH (oids = false);

DROP TABLE IF EXISTS "student";
CREATE TABLE "public"."student" (
	"student_id" integer NOT NULL,
	"reached_item_quota_for_rental" character varying(10) NOT NULL,
	"personal_data_id" integer NOT NULL,
	CONSTRAINT "pk_student" PRIMARY KEY ("student_id"),
	CONSTRAINT "fk_student_0" FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "audition";
CREATE TABLE "public"."audition" (
	"student_id" integer NOT NULL,
	"audition_id" integer NOT NULL,
	"instrument" character varying(50) NOT NULL,
	"result" boolean NOT NULL,
	CONSTRAINT "pk_audition" PRIMARY KEY ("student_id", "audition_id"),
	CONSTRAINT "fk_audition_0" FOREIGN KEY (student_id) REFERENCES student(student_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "available_time_slot";
CREATE TABLE "public"."available_time_slot" (
	"available_time_slot_id" character(10) NOT NULL,
	"available_time_slot" timestamp(6),
	CONSTRAINT "pk_available_time_slot" PRIMARY KEY ("available_time_slot_id")
);

DROP TABLE IF EXISTS "skill_level";
CREATE TABLE "public"."skill_level" (
	"skill_level_id" character varying(50) NOT NULL,
	"skill_level" character varying(50),
	CONSTRAINT "pk_skill_level" PRIMARY KEY ("skill_level_id")
);

DROP TABLE IF EXISTS "price";
CREATE TABLE "public"."price" (
	"price_id" integer NOT NULL,
	"day_of_week" character varying(100) NOT NULL,
	"skill_level_id" character varying(50) NOT NULL,
	"amount" real,
	CONSTRAINT "pk_price" PRIMARY KEY ("price_id"),
	CONSTRAINT "fk_price_0" FOREIGN KEY (skill_level_id) REFERENCES skill_level(skill_level_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "instrument";
CREATE TABLE "public"."instrument" (
	"instrument_id" character varying(50) NOT NULL,
	CONSTRAINT "pk_instrument" PRIMARY KEY ("instrument_id")
);

DROP TABLE IF EXISTS "instructor";
CREATE TABLE "public"."instructor" (
	"instructor_id" integer NOT NULL,
	"personal_data_id" integer NOT NULL,
	CONSTRAINT "pk_instructor" PRIMARY KEY ("instructor_id"),
	CONSTRAINT "fk_instructor_0" FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "booked_lesson";
CREATE TABLE "public"."booked_lesson" (
	"booked_lesson_id" integer NOT NULL,
	"price_id" integer NOT NULL,
	"maximum_enrollments" integer,
	"minimum_enrollments" integer,
	"date" timestamp,
	"instructor_id" integer NOT NULL,
	"admin_id" integer NOT NULL,
	CONSTRAINT "pk_booked_lesson" PRIMARY KEY ("booked_lesson_id"),
	CONSTRAINT "fk_booked_lesson_0" FOREIGN KEY (price_id) REFERENCES price(price_id) NOT DEFERRABLE,
	CONSTRAINT "fk_booked_lesson_1" FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) NOT DEFERRABLE,
	CONSTRAINT "fk_booked_lesson_2" FOREIGN KEY (admin_id) REFERENCES administration(admin_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "ensamble";
CREATE TABLE "public"."ensamble" (
	"ensamble_id" integer NOT NULL,
	"genre" character varying(50),
	"booked_lesson_id" integer NOT NULL,
	CONSTRAINT "pk_ensamble" PRIMARY KEY ("ensamble_id"),
	CONSTRAINT "fk_ensamble_0" FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson(booked_lesson_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "ensamble_instrument";
CREATE TABLE "public"."ensamble_instrument" (
	"instrument_id" character varying(50) NOT NULL,
	"ensamble_id" integer NOT NULL,
	CONSTRAINT "pk_ensamble_instrument" PRIMARY KEY ("instrument_id", "ensamble_id"),
	CONSTRAINT "fk_ensamble_instrument_0" FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) NOT DEFERRABLE,
	CONSTRAINT "fk_ensamble_instrument_1" FOREIGN KEY (ensamble_id) REFERENCES ensamble(ensamble_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "group_lesson";
CREATE TABLE "public"."group_lesson" (
	"group_lesson_id" integer NOT NULL,
	"booked_lesson_id" integer NOT NULL,
	CONSTRAINT "pk_group_lesson" PRIMARY KEY ("group_lesson_id"),
	CONSTRAINT "fk_group_lesson_0" FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson(booked_lesson_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "group_lesson_instrument";
CREATE TABLE "public"."group_lesson_instrument" (
	"instrument_id" character varying(50) NOT NULL,
	"group_lesson_id" integer NOT NULL,
	CONSTRAINT "pk_group_lesson_instrument" PRIMARY KEY ("instrument_id", "group_lesson_id"),
	CONSTRAINT "fk_group_lesson_instrument_0" FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) NOT DEFERRABLE,
	CONSTRAINT "fk_group_lesson_instrument_1" FOREIGN KEY (group_lesson_id) REFERENCES group_lesson(group_lesson_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "guardian_of_student";
CREATE TABLE "public"."guardian_of_student" (
	"guardian_id" integer NOT NULL,
	"personal_data_id" integer NOT NULL,
	"phone_number" character varying(12) NOT NULL,
	"email" character varying(500) NOT NULL,
	CONSTRAINT "pk_guardian_of_student" PRIMARY KEY ("guardian_id", "personal_data_id"),
	CONSTRAINT "fk_guardian_of_student_0" FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "individual_lesson";
CREATE TABLE "public"."individual_lesson" (
	"individual_lesson_id" integer NOT NULL,
	"instrument_id" character varying(50) NOT NULL,
	"booked_lesson_id" integer NOT NULL,
	CONSTRAINT "pk_individual_lesson" PRIMARY KEY ("individual_lesson_id"),
	CONSTRAINT "fk_individual_lesson_0" FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) NOT DEFERRABLE,
	CONSTRAINT "fk_individual_lesson_1" FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson(booked_lesson_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "instructor_available_time_slot";
CREATE TABLE "public"."instructor_available_time_slot" (
	"instructor_id" integer NOT NULL,
	"available_time_slot_id" character(10) NOT NULL,
	CONSTRAINT "pk_instructor_available_time_slot" PRIMARY KEY ("instructor_id", "available_time_slot_id"),
	CONSTRAINT "fk_instructor_available_time_slot_0" FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) NOT DEFERRABLE,
	CONSTRAINT "fk_instructor_available_time_slot_1" FOREIGN KEY (available_time_slot_id) REFERENCES available_time_slot(available_time_slot_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "instructor_instrument_skill";
CREATE TABLE "public"."instructor_instrument_skill" (
	"instructor_id" integer NOT NULL,
	"instrument_id" character varying(50) NOT NULL,
	CONSTRAINT "pk_instructor_instrument_skill" PRIMARY KEY ("instructor_id", "instrument_id"),
	CONSTRAINT "fk_instructor_instrument_skill_0" FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) NOT DEFERRABLE,
	CONSTRAINT "fk_instructor_instrument_skill_1" FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "salary";
CREATE TABLE "public"."salary" (
	"salary_id" integer NOT NULL,
	"month" character varying(50),
	"amount" real,
	CONSTRAINT "pk_salary" PRIMARY KEY ("salary_id")
);

DROP TABLE IF EXISTS "instructor_monthly_salary";
CREATE TABLE "public"."instructor_monthly_salary" (
	"instructor_id" integer NOT NULL,
	"salary_id" integer NOT NULL,
	CONSTRAINT "pk_instructor_monthly_salary" PRIMARY KEY ("instructor_id", "salary_id"),
	CONSTRAINT "fk_instructor_monthly_salary_0" FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) NOT DEFERRABLE,
	CONSTRAINT "fk_instructor_monthly_salary_1" FOREIGN KEY (salary_id) REFERENCES salary(salary_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "rental_instrument";
CREATE TABLE "public"."rental_instrument" (
	"rental_instrument_id" integer NOT NULL,
	"brand" character varying(100),
	"quantity" integer NOT NULL,
	"instrument_id" character varying(50) NOT NULL,
	"price" real NOT NULL,
	CONSTRAINT "pk_rental_instrument" PRIMARY KEY ("rental_instrument_id"),
	CONSTRAINT "fk_rental_instrument_0" FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "rental";
CREATE TABLE "public"."rental" (
	"rental_id" integer NOT NULL,
	"lease_period" date NOT NULL,
	"rental_instrument_id" integer NOT NULL,
	"terminated_rental" date,
	CONSTRAINT "pk_rental" PRIMARY KEY ("rental_id"),
	CONSTRAINT "fk_rental_0" FOREIGN KEY (rental_instrument_id) REFERENCES rental_instrument(rental_instrument_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "sibling";
CREATE TABLE "public"."sibling" (
	"student_id_1" integer NOT NULL,
	"student_id_2" integer NOT NULL,
	CONSTRAINT "pk_sibling" PRIMARY KEY ("student_id_1", "student_id_2"),
	CONSTRAINT "fk_sibling_0" FOREIGN KEY (student_id_1) REFERENCES student(student_id) NOT DEFERRABLE,
	CONSTRAINT "fk_sibling_1" FOREIGN KEY (student_id_2) REFERENCES student(student_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "student_booked_lesson";
CREATE TABLE "public"."student_booked_lesson" (
	"student_id" integer NOT NULL,
	"booked_lesson_id" integer NOT NULL,
	CONSTRAINT "pk_student_booked_lesson" PRIMARY KEY ("student_id", "booked_lesson_id"),
	CONSTRAINT "fk_student_booked_lesson_0" FOREIGN KEY (student_id) REFERENCES student(student_id) NOT DEFERRABLE,
	CONSTRAINT "fk_student_booked_lesson_1" FOREIGN KEY (booked_lesson_id) REFERENCES booked_lesson(booked_lesson_id) NOT DEFERRABLE
);

DROP TABLE IF EXISTS "student_in_line";
CREATE TABLE "public"."student_in_line" (
	"admin_id" integer NOT NULL,
	"personal_data_id" integer NOT NULL,
	CONSTRAINT "student_in_line_personal_data_id_admin_id" PRIMARY KEY ("personal_data_id", "admin_id"),
	CONSTRAINT "fk_student_in_line_0" FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id) NOT DEFERRABLE,
	CONSTRAINT "fk_student_in_line_1" FOREIGN KEY (admin_id) REFERENCES administration(admin_id) NOT DEFERRABLE
);


DROP TABLE IF EXISTS "student_monthly_fee";
CREATE TABLE "public"."student_monthly_fee" (
	"student_id" integer NOT NULL,
	"amount" real,
	"extra_charge" real,
	"sibling_discount" real,
	CONSTRAINT "pk_student_monthly_fee" PRIMARY KEY ("student_id"),
	CONSTRAINT "fk_student_monthly_fee_0" FOREIGN KEY (student_id) REFERENCES student(student_id) NOT DEFERRABLE
);


DROP TABLE IF EXISTS "student_rental";
CREATE TABLE "public"."student_rental" (
	"student_id" integer NOT NULL,
	"rental_id" integer NOT NULL,
	"delivery" character(10),
	CONSTRAINT "pk_student_rental" PRIMARY KEY ("student_id", "rental_id"),
	CONSTRAINT "fk_student_rental_0" FOREIGN KEY (student_id) REFERENCES student(student_id) NOT DEFERRABLE,
	CONSTRAINT "fk_student_rental_1" FOREIGN KEY (rental_id) REFERENCES rental(rental_id) NOT DEFERRABLE
);