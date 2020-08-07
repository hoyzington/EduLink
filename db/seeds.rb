# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Teachers

Teacher.create(id_number: 1, first_name: 'William', last_name: 'McKinley', dept: 'Admin', email: 'william@email.com', password: 'password', id: 1)

hector = Teacher.create(id_number: 100, first_name: 'Hector', last_name: 'LaCovara', dept: 'Science', email: 'hector@email.com', password: 'password')

leslie = Teacher.create(id_number: 101, first_name: 'Leslie', last_name: 'Foote', dept: 'Social Studies', email: 'leslie@email.com', password: 'password')

frank = Teacher.create(id_number: 102, first_name: 'Frank', last_name: 'Kowchevski', dept: 'Math', email: 'frank@email.com', password: 'password')

## Klasses

klasses = []

klasses << hector.klasses.create(name: 'Chemistry', period: '1', dept: hector.dept)

klasses << leslie.klasses.create([{name: 'American History 1', period: '3', dept: leslie.dept}, {name: 'AP Government', period: '6', dept: leslie.dept}])

klasses << frank.klasses.create([{name: 'Geometry', period: '2', dept: frank.dept}, {name: 'Calculus', period: '5', dept: frank.dept}])

klasses = klasses.flatten

## Students

students = Student.create([{id_number: 1, first_name: 'Default', last_name: 'Student', email: 'default@email.com', password: 'password', id: 1}, {id_number: 1000, first_name: 'Lindsay', last_name: 'Weir', email: 'lindsay@email.com', password: 'password'}, {id_number: 1001, first_name: 'Daniel', last_name: 'Desario', email: 'daniel@email.com', password: 'password'}, {id_number: 1002, first_name: 'Nick', last_name: 'Andopolis', email: 'nick@email.com', password: 'password'}, {id_number: 1003, first_name: 'Ken', last_name: 'Miller', email: 'ken@email.com', password: 'password'}])

## StudentStatuses

def ss_data(students)
  array = []
  students.each do |s|
    array << {id_number: s.id_number, first_name: s.first_name, last_name: s.last_name, student_id: s.id}
  end
  array
end

klasses.each do |klass|
  klass.student_statuses.create(ss_data(students))
end

klasses.each do |klass|
  klass.student_statuses.create(id_number: 1004, first_name: 'Kim', last_name: 'Kelly', student_id: 1)
end

## Homeworks

def days(qty)
  (60*60*24) * qty
end

def start_date(today)
  if today.thursday? || today.friday?
    days_back = days(3)
  elsif today.saturday?
    days_back = days(4)
  else
    days_back = days(5)
  end
  today - days_back
end

def increment(date)
  if date.friday?
    date += days(3)
  elsif date.saturday?
    date += days(2)
  else
    date += days(1)
  end
end

def h_data(students)
  array = []
  chap_num = 1
  date = start_date(Time.now)
  6.times do 
    students.each do |s|
      done = (s.id_number == 0 ? true : false)
      array << {date: date, read: "Chapter #{chap_num}", exercises: "All from chapter #{chap_num}", other: 'Lorem ipsum dolor sit amet consectetur adipisicing elit.', notes: 'Dolore et perferendis, facilis quos odit quibusdam.', done: done, student_id: s.id}
    end
    chap_num += 1
    increment(date)
  end
  array
end

klasses.each do |klass|
  klass.homeworks.create(h_data(students))
end
