Event Manager
================

Jumpstart Lab project working with CSV files. Focus on reading, writing, sorting and cleaning large amounts of data using standard Ruby practices. 

Utilizes Ruby's CSV module to parse through dense data, locating individuals first names, ID's, and zipcodes. The program then uses the Sunlight Congress gem to locate local information on government officials based on zipcodes, creating a customized ERB letter to each individual with their pertinent information. Finally, each personalized letter is saved to a separate HTML file named with their individual ID.

Additional utilities added: 
  Parses through phone numbers and cleans errors.
  Uses registration dates and times in each individuals area to determine which hours of the day have the most voter registrations.
  Also determines what day of the week has the most people registering.

NOTE:
Only run program with data sample (default). Full data is very large and will have a runtime to match!