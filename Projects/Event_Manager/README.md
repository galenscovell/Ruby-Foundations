Event Manager
================

Jumpstart Lab project working with CSV files. Focus on reading, writing, sorting and cleaning large amounts of data using standard Ruby practices. 

Utilizes Ruby's CSV module to parse through dense data, locating individuals first names, ID's, and zipcodes. The program then uses the Sunlight Congress gem to locate local information on government officials based on zipcodes, creating a customized ERB letter to each individual with their pertinent information. Finally, each personalized letter is saved to a separate HTML file named with their individual ID.


Additional utilities added and integrated within HTML output: 

1. Parses through phone numbers and cleans errors. If number given in data is less than 10 digits or greater than 11 digits, it is invalid and replaced with 0's. If number is 11 digits and doesn't begin with 1, it is also invalid. If number is 11 digits and begins with 1, the 1 is stripped. All values are organized for consistency in output.

2. Uses registration dates and times in each individuals area to determine hours of the day had the most voter registrations.

3. Determines what day of the week had the most people registering.

NOTE:
Only run program with data sample (default). Full data is very large and will have a runtime to match!