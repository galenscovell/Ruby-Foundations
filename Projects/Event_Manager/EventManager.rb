
require 'csv'
require 'sunlight/congress'
require 'erb'
require 'date'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone_number(homephone)
  number = homephone.to_s.gsub(/([-() .])/, '')
  if number.length < 10 || number.length > 11
    number = "000 000 0000"
    number
  elsif number.length == 11 && number[0] != "1"
    number = "000 000 000"
    number
  elsif number.length == 11 && number[0] == "1"
    number = "#{number[1..3]} #{number[4..6]} #{number[7..10]}"
    number
  else
    number = "#{number[0..2]} #{number[3..5]} #{number[6..9]}"
    number
  end
end

def parse_registration_time(registration)
  date_time = DateTime.strptime(registration, '%m/%d/%y %k:%M').to_s
  time = date_time[11..12]
  if time[0] == "0"
    time = 12 + time[1].to_i
  end
  time.to_i
end

def parse_registration_date(registration)
  date_time = DateTime.strptime(registration, '%m/%d/%y %k:%M').to_s
  date = date_time[8..9]
  date.to_i
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_output(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def time_popularity(registration_times)
  time_hash = Hash.new(0)
  registration_times.each do |time|
    time_hash[time] += 1
  end
  max_value = []
  time_hash.each do |time, count|
    if count == time_hash.values.max
      max_value << time
    end
  end
 max_value
end

def date_popularity(registration_dates)
  date_hash = Hash.new(0)
  registration_dates.each do |day|
    date_hash[day] += 1
  end
  max_value = []
  date_hash.each do |day, count|
    if count == date_hash.values.max
      max_value << day
    end
  end
 max_value
end


puts "Event Manager Initialized."

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents = CSV.open "event_attendees_sample.csv", headers: true, header_converters: :symbol


registration_times = []
registration_dates = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  registration_time = parse_registration_time(row[:regdate])
  registration_date = parse_registration_date(row[:regdate])
  phone_number = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)
  registration_times << registration_time
  registration_dates << registration_date

  form_letter = erb_template.result(binding)
  save_output(id, form_letter)
end

popular_reg_time = time_popularity(registration_times)
puts "Most popular registration time was #{popular_reg_time} o'clock."
popular_reg_date = date_popularity(registration_dates)
puts "Most popular registration date was the #{popular_reg_date}th."