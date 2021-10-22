# A JDBC application with an appropriately layered architecture

This is an example of how an integration layer can be used to organize an application containing database calls.

## How to execute

1. Clone this git repository
1. Change to the newly created directory `cd jdbc-bank`
1. Make sure there is a database which can be reached with the url on line 235-236 or 237-238 in `BankDAO.java`. There are two ways to do this.
   1. Create a database that can be reached with one of the existing urls. If
      postgres is used, that is a database called bankdb, wich can be
      reached on port 5432 at localhost, by the user 'postgres' with the
      password 'postgres'. If MySQL is used, that is a database called
      bankdb, which can be reached on port 3306 at localhost, by the user
      'root' with the password 'javajava'.
   1. Change the url to match your database.
1. Create the tables described by `src/main/resources/mysql-bankdb.sql` (if yo use mysql) or `src/main/resources/postgres-bankdb.sql` (if you use postgres).
1. Build the project with the command `mvn install`
1. Run the program with the command `mvn exec:java`

## Commands for the bank program

* `help` displays all commands.
* `rental_instrument <specified instrument or all>` shows specified/all instruments that is available to rent
* `rent <student id> <rental instrument id> <optional: delivery yes/no? >` creates a rental for student of student id for instrument of rental instrument
* `student_rental <student id>` shows all info on all rentals of specified student
* `terminate_rental <rental id>` terminates specified rental
* `quit` quits the application.
