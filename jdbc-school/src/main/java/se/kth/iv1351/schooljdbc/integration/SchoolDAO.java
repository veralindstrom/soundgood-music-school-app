/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package se.kth.iv1351.schooljdbc.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;

import java.time.LocalDateTime; 

/**
 * This data access object (DAO) encapsulates all database calls in the school
 * application. No code outside this class shall have any knowledge about the
 * database.
 */
public class SchoolDAO {
    private Connection connection;

    /**
     * Constructs a new DAO object connected to the school database.
     */
    public SchoolDAO() throws SchoolDBException {
        try {
            connectToSchoolDB();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SchoolDBException("Could not connect to datasource.", exception);
        }
    }


    public void getAvailableRentalInstruments(String instrument)throws SchoolDBException{
        String failureMsg = "Could not get instrument: " + instrument;
        String query;
        ResultSet rs = null;
        if (instrument.equals("all")) query = "SELECT * FROM available_rental_instruments_view";
        else query = "SELECT * FROM available_rental_instruments_view WHERE instrument_id = '" + instrument + "'";
        try (Statement stmt = connection.createStatement()) {
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                String rental_instrument_id = rs.getString("rental_instrument_id");
                String instrument_id = rs.getString("instrument_id");
                String price = rs.getString("price");
                String brand = rs.getString("brand");
                System.out.println("ID: " + rental_instrument_id +
                                    " Instrument: " + instrument_id +
                                    " Price: " + price + 
                                    " Brand: " + brand);
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }
    }

    private boolean instrumentAvailable(int rentalInstrumentID) throws SchoolDBException{
        String query = "SELECT left_to_rent FROM all_rental_instruments_view WHERE rental_instrument_id = " + rentalInstrumentID;
        boolean available = false;
        ResultSet rs = null;
        String failureMsg = "Could not check instrument availability";
        try (Statement stmt = connection.createStatement()) {
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                int left_to_rent = rs.getInt("left_to_rent");
                if(left_to_rent > 0) available = true;
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }
        return available;
    }

    private int getStudentRentalQuota(int studentID) throws SchoolDBException{
        String failureMsg = "Couldn't get student " + studentID + "'s item quota";
        String query = "SELECT item_quota_for_rental FROM student WHERE student_id = " + studentID;
        int quota = 0;
        ResultSet rs = null;
            try (Statement stmt = connection.createStatement()) {
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    quota = rs.getInt("item_quota_for_rental");
                }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }

        return quota;

    }

    private void updateItemQuota(int studentID, int i) throws SchoolDBException{
         String failureMsg = "Couldn't update student " + studentID + "'s item quota";
         int itemQuota = getStudentRentalQuota(studentID) + i;
         String updatequery = "UPDATE student SET item_quota_for_rental = " + itemQuota +
                             " WHERE student_id = " + studentID;
            try (Statement stmt = connection.createStatement()) {
                stmt.executeUpdate(updatequery);

        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }


    private void createRental(int rentalInstrumentID, int rentID) throws SchoolDBException{
         String query = "INSERT INTO rental (rental_id, lease_period, rental_instrument_id) VALUES (" + 
         rentID + ", NOW() , " + rentalInstrumentID + ")";
            try (Statement stmt = connection.createStatement()) {
                stmt.executeUpdate(query);
        } catch (SQLException sqle) {
            handleException("Could not create rental", sqle);
        }
    }

    public void makeStudentRental(int studentID, int rentalInstrumentID, String delivery) throws SchoolDBException{
        if(getStudentRentalQuota(studentID) >= 2){
            handleException("Student has exceeded the allowed 2 item rental quota", null);
        }
        else if (!instrumentAvailable(rentalInstrumentID)) {
            handleException("Instrument is not available", null);
        }

        int rentID = getRentalCount()+1;
        String insertquery = "INSERT INTO student_rental (student_id, rental_id, delivery) VALUES (" +
                             studentID + ", " + rentID + ", '" + delivery + "')";
            try (Statement stmt = connection.createStatement()) {
                createRental(rentalInstrumentID, rentID);
                stmt.executeUpdate(insertquery);
                updateItemQuota(studentID, 1);
                System.out.println("student rental executed");
            
                connection.commit();
            } catch (SQLException sqle) {
              handleException("Could not create student rental", sqle);
            }
    }

    private int getRentalCount() throws SchoolDBException{
        String query = "SELECT count(rental_id) FROM rental";
        int count = 0;
        ResultSet rs = null;
        String failureMsg = "Couldn't get rental count";
            try (Statement stmt = connection.createStatement()) {
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    count = rs.getInt("count");
                }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }
        return count;
    }

    private void getRental(int rentalID) throws SchoolDBException{
        String query = "SELECT * FROM rental WHERE rental_id = " + rentalID;
        String failureMsg = "Could not get rental";
        ResultSet rs = null;
        try (Statement stmt = connection.createStatement()) {
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                String rental_id = rs.getString("rental_id");
                String lease_period = rs.getString("lease_period");
                String rental_instrument_id = rs.getString("rental_instrument_id");
                String terminated_rental = rs.getString("terminated_rental");
                if(terminated_rental == null) terminated_rental = "ongoing rental";
                System.out.println("Rental ID: " + rental_id +
                                    " Leased: " + lease_period +
                                    " Rented instrument ID: " + rental_instrument_id + 
                                    " Terminated: " + terminated_rental);
            }
        } catch (SQLException sqle) {
              handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }
    }

    public void getStudentRental(int studentID) throws SchoolDBException{
        String query = "SELECT rental_id from student_rental where student_id = " + studentID;
        String failureMsg = "Could not get student rental";
        ResultSet rs = null;
        try (Statement stmt = connection.createStatement()) {
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                int rental_id = rs.getInt("rental_id");
                getRental(rental_id);
            }
        } catch (SQLException sqle) {
              handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }
    }

    private String getRentalTerminated(int rentalID) throws SchoolDBException{
        String query = "SELECT terminated_rental FROM rental WHERE rental_id = " + rentalID;
        String failureMsg = "Could not get terminated rental";
        ResultSet rs = null;
        String terminated_rental = "";
        try (Statement stmt = connection.createStatement()) {
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                terminated_rental = rs.getString("terminated_rental");
                if(terminated_rental == null) terminated_rental = "ongoing rental";
            }
        } catch (SQLException sqle) {
              handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }

        return terminated_rental;
    }

    private int getStudentIdOfRental(int rentalID) throws SchoolDBException{
        String query = "SELECT student_id, rental.rental_id from rental, student_rental WHERE student_rental.rental_id = rental.rental_id AND rental.rental_id = " + rentalID;
        int student_id = -1;
        String failureMsg = "Could not get studentID of rental";
        ResultSet rs = null;
        try (Statement stmt = connection.createStatement()) {
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                student_id = rs.getInt("student_id");
            }
        } catch (SQLException sqle) {
              handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, rs);
        }

        return student_id;
    }

    public void terminateStudentRental(int rentalID) throws SchoolDBException{
       String terminatedRental = getRentalTerminated(rentalID);
       if(terminatedRental == null){
             handleException("No rental for specified id", null);
        }
        else if(terminatedRental != "ongoing rental") {
             handleException("Rental is already terminated", null);
        }

        String updatequery = "UPDATE rental SET terminated_rental = NOW() WHERE rental_id = " + rentalID;
            try (Statement stmt = connection.createStatement()) {
                stmt.executeUpdate(updatequery);
                updateItemQuota(getStudentIdOfRental(rentalID), -1);
                System.out.println("student rental terminated");
            
                connection.commit();
            } catch (SQLException sqle) {
              handleException("Could not terminate rental", sqle);
            }

    }

    public void closeConnectionToDatabase() throws SchoolDBException{
        try {
            connection.close();
        } catch (Exception e) {
            throw new SchoolDBException(" Could not close connection", e);
        }
    }

    private void connectToSchoolDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/school",
                                                 "postgres", "example");
        // connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb",
        //                                          "root", "javajava");
        connection.setAutoCommit(false);
    }

    private void handleException(String failureMsg, Exception cause) throws SchoolDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg + 
            ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SchoolDBException(failureMsg, cause);
        } else {
            throw new SchoolDBException(failureMsg);
        }
    }

    private void closeResultSet(String failureMsg, ResultSet result) throws SchoolDBException {
        try {
            result.close();
        } catch (Exception e) {
            throw new SchoolDBException(failureMsg + " Could not close result set.", e);
        }
    }
}
