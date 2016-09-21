# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

# delete all record
User.delete_all
Project.delete_all
Affiliation.delete_all
Allocation.delete_all
Number.delete_all
Mark.delete_all
Marking.delete_all
NumberFormat.delete_all
NumberPart.delete_all
DatePart.delete_all
FixedPart.delete_all
SequentialPart.delete_all

# reset auto increament
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='users' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='projects' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='affiliations' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='allocations' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='numbers' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='marks' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='number_formats' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='number_parts' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='date_parts' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='fixed_parts' ))
ActiveRecord::Base.connection.execute(%q( delete from sqlite_sequence where name='sequential_parts' ))


user = User.create(email: 'ta_kondoh@actis.co.jp', password: 'Kppnn3')

project1 = Project.create(name: 'popa', description: 'project description test01')
number_format1 = NumberFormat.create(project_id: project1.id)
date_part = DatePart.create(number_format_id: number_format1.id,       format: '%Y%m%d')
fixed_part = FixedPart.create(number_format_id: number_format1.id,      format: 'hoge')
sequential_part = SequentialPart.create(number_format_id: number_format1.id, format: '%03d', current: 3)

number1 = project1.numbers.create(val: '20160831hoge001')
number2 = project1.numbers.create(val: '20160831hoge002')
user.numbers << number1
user.numbers << number2

#marking1 = number1.markings.create
#marking2 = number1.markings.create
#mark1 = marking1.create_mark(owner_id: user.id,     owner_type: 'User',    label: 'mark test01', description: 'mark description test01')
#mark2 = marking2.create_mark(owner_id: project1.id, owner_type: 'Project', label: 'mark test01', description: 'mark description test02')
mark1 = number1.marks.create(owner_id: user.id,     owner_type: 'User',    label: 'mark test01', description: 'mark description test01')
mark2 = number2.marks.create(owner_id: project1.id, owner_type: 'Project', label: 'mark test02', description: 'mark description test02')


