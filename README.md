This application will take text input from stdin and output a list of drivers, their miles driven, and their average speeds.

Structure

As I approach this project I want to make it as representative of a real-life application without going overboard on structure.  To me, there are basically 4 parts that interact to solve this task:

1. The main.rb file which is executed from the command line.  It will read from stdin and pass the information into an instance of Report.

2. The Report class instantiates each Driver and Trip based on what is in the datastream and will later generate a report by requesting information from it's Drivers.  The Report is responsible for injecting the constraints for which trips should be discarded to the Driver when it asks for a Driver's data.  It doesn't do any of the calculations itself, it is meant to pass the information down the line and get back a report to print out.

3. The Driver class has a collection of Trips that it will use to calculate a driver's average speed and distance traveled.  It also handles the logic of deciding which trips to ignore as outliers based on the constraints that are passed in.  

4. The Trip class will calculate the values needed when asked by the Driver object that owns it.


Testing

In order to make sure my code is fully tested, I will be using TDD to develop this application.  I will write the tests first, ensure they fail for the correct reasons, and then write code to make the test pass.  I'll add supplemental tests as I go for edge-cases and integration tests when it is reasonable to.