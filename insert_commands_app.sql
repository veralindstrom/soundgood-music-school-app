INSERT INTO personal_data (personal_data_id, first_name, last_name, age, social_security_number, phone_number, email, zip, street, city) VALUES (1, 'Vera', 'Lindström', '20', '20000615-1234', '072-3331046', 'vera@kth.se', '12345', 'Kistagången 16', 'Kista');

INSERT INTO personal_data (personal_data_id, first_name, last_name, age, social_security_number, phone_number, email, zip, street, city) VALUES (2, 'Clara', 'Lindström', '17', '20030112-1234', '072-3331041','clara@kth.se', '12345', 'Kistagången 16', 'Kista');

INSERT INTO personal_data (personal_data_id, first_name, last_name, age, social_security_number, phone_number, email, zip, street, city) VALUES (3, 'Boris', 'Johansson', '56', '19641212-1234', '072-3331011', 'boris@kth.se', '12345', 'Kistagången 16', 'Kista');

INSERT INTO school (school_id, name, available_spots, minimum_age) VALUES (1, 'Soundgood Music School', 53, 13);

INSERT INTO student (student_id, reached_item_quota_for_rental, personal_data_id, school_id) VALUES (1, 'false', 1, 1);

INSERT INTO sibling (sibling_id, sibling) VALUES (1, 'Clara Lindström');

INSERT INTO individual_lesson (individual_lesson_id, maximum_enrollments, price,instrument, date, skill_level) values (1, 1, '5', 'piano', '2020-06-22 19:10:25', 'beginner');

INSERT INTO ensamble (ensamble_id, genre, minimum_enrollments, maximum_enrollments, price, date, skill_level) values (1, 'rock', 5, '30', 10, '2020-06-22 19:10:25', 'beginner');

INSERT INTO group_lesson (group_lesson_id, minimum_enrollments, maximum_enrollments, price, date, skill_level) values (1, 5, '30', 10, '2020-06-22 19:10:25', 'beginner');

INSERT INTO instrument (instrument_id, instrument) VALUES (1, 'piano');
INSERT INTO instrument (instrument_id, instrument) VALUES (2, 'guitar');
INSERT INTO instrument (instrument_id, instrument) VALUES (3, 'bass');

INSERT INTO  group_lesson_instrument (instrument_id, group_lesson_id) VALUES (1, 1);
INSERT INTO ensamble_instrument (instrument_id, ensamble_id) VALUES (2, 1);

INSERT INTO administration (school_id) VALUES (1);
INSERT INTO audition (student_id, audition_id, result, instrument) VALUES (1, 1, 'pass', 'piano');
INSERT INTO available_time_slot (available_time_slot_id, available_time_slot) VALUES (1, '2020-06-22 10:00:00');

INSERT INTO students_in_line (school_id, students_in_line) VALUES (1, '0');
INSERT INTO student_sibling (student_id, sibling_id) VALUES (1,1);
INSERT INTO student_monthly_fee (student_id, amount, extra_charge, sibling_discount) VALUES (1, 100, 0, 0.1);

INSERT INTO instrument_skill (instrument_skill_id, instrument, skill_level) VALUES (1, 'piano', 'beginner');
INSERT INTO instrument_skill (instrument_skill_id, instrument, skill_level) VALUES (3, 'piano', 'master');
INSERT INTO instrument_skill (instrument_skill_id, instrument, skill_level) VALUES (2, 'guitar', 'master');
INSERT INTO student_instrument_skill (student_id, instrument_skill_id) VALUES (1,1);

INSERT INTO rental_instrument (rental_instrument_id, brand, quantity, type, price) VALUES (1, 'rock n roll', 1, 'guitar', '9.99');

INSERT INTO rental (rental_id, school_id, lease_period, student_id, delivery, monthly_fee, exceeded_two_item_quota, rental_instrument_id) VALUES (1, 1, INTERVAL '1 month', 1, 'yes', '14.99', 'f', 1);

INSERT INTO pricing_scheme (pricing_scheme_id, lesson_type, skill_level, day_of_week, school_id) VALUES (1, 'ensamble', 'beginner', 'tuesday', 1);

INSERT INTO instructor (instructor_id, personal_data_id, school_id) VALUES (1, 3, 1);

INSERT INTO instructor_available_time_slot (available_time_slot_id, instructor_id) VALUES (1,1);

INSERT INTO instructor_group_lesson (group_lesson_id, instructor_id) VALUES (1,1);

INSERT INTO  instructor_individual_lesson (individual_lesson_id, instructor_id) VALUES (1,1);

INSERT INTO instructor_instrument_skill (instructor_id, instrument_skill_id) VALUES (1, 1);

INSERT INTO instructor_instrument_skill (instructor_id, instrument_skill_id) VALUES (1, 2);

INSERT INTO instructor_instrument_skill (instructor_id, instrument_skill_id) VALUES (1, 3);

INSERT INTO instructor_monthly_salary (amount, instructor_id) VALUES (300, 1);

INSERT INTO  guardian_of_student (guardian_id, personal_data_id, phone_number, email) VALUES (1, 1, '085903248', 'blabla@gmail.com');

INSERT INTO  guardian_of_student (guardian_id, personal_data_id, phone_number, email) VALUES (1, 2, '085903248', 'blabla@gmail.com');

INSERT INTO student (student_id, reached_item_quota_for_rental, personal_data_id, school_id) VALUES (2, 't', 2, 1);

INSERT INTO sibling (sibling_id, sibling) VALUES (2, 'Clara Lindström');
INSERT INTO student_sibling (student_id, sibling_id) VALUES (1, 2);

INSERT INTO group_lesson_instrument (instrument_id, group_lesson_id) VALUES (2, 1);