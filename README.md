This application will take text input from stdin and output a list of drivers, their miles driven, and their average speeds.

Structure

As I approach this project I want to make it as representative of a real-life application without going overboard on structure. There are basically 4 parts that interact to solve this task:

1. The main.rb file is executed from the command line.  It will read from stdin and pass the information into an instance of Report.

2. The Report class instantiates each Driver, passes a Driver its relevant trip information, and generates a report by requesting information from its Drivers.  The Report is responsible for injecting the parameters for which trips should be discarded to the Driver when it asks for a Driver's data.  It doesn't do any of the calculations itself because that logic belongs in the Driver, but I wanted to make the constraints available at the top level of the program.  I imagine in the real world a Report would accept these constraints (and others e.g. what time of day the trip occurred) as parameters so this is where they are stored in this application as constants.

3. The Driver class creates and stores a collection of Trips that it will use to calculate the driver's average speed and distance traveled.  It also handles the logic of deciding which trips to ignore as outliers based on the constraints that are passed in.

4. The Trip class will calculate the values needed when asked by the Driver object that owns it.

Testing

I will be using TDD to develop this application.  This will guide my design of the application, ensure I write code that works, and allow me to refactor without fear of breaking something.  Most of my tests will be unit tests, with a few acceptance tests to test the functionality of the application as a whole.  I believe writing tests is a balance between cost and benefit, so I don't want to go overboard testing every edge-case.  My goal is to write enough tests that I can be confident in the performance of this application.