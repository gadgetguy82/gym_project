DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS gym_classes;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS gyms;

CREATE TABLE gyms (
  id SERIAL2 PRIMARY KEY,
  name VARCHAR(255),
  start_peak TIME,
  stop_peak TIME
);

CREATE TABLE instructors (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE members (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  date_of_birth VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255),
  postcode VARCHAR(255),
  phone VARCHAR(255),
  member_level VARCHAR(255)
);

CREATE TABLE rooms (
  id SERIAL2 PRIMARY KEY,
  name VARCHAR(255),
  capacity INT2
);

CREATE TABLE gym_classes (
  id SERIAL8 PRIMARY KEY,
  type VARCHAR(255),
  date_time TIMESTAMP,
  duration INTERVAL,
  spaces_taken INT2,
  room_id INT2 REFERENCES rooms(id) ON DELETE CASCADE,
  instructor_id INT8 REFERENCES instructors(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
  id SERIAL8 PRIMARY KEY,
  member_id INT8 REFERENCES members(id) ON DELETE CASCADE,
  gym_class_id INT8 REFERENCES gym_classes(id) ON DELETE CASCADE
);
