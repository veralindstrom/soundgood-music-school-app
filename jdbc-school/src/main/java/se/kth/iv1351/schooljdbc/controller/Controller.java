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

package se.kth.iv1351.schooljdbc.controller;

import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.schooljdbc.integration.SchoolDAO;
import se.kth.iv1351.schooljdbc.integration.SchoolDBException;

/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    private final SchoolDAO schoolDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws SchoolDBException If unable to connect to the database.
     */
    public Controller() throws SchoolDBException {
        schoolDb = new SchoolDAO();
    }

    public void closeConnectionToDatabase() throws SchoolDBException{
        schoolDb.closeConnectionToDatabase();
    }

    public void getAvailableRentalInstruments(String instrument) throws SchoolDBException{
        schoolDb.getAvailableRentalInstruments(instrument);
    }

    public void rent(int studentID, int rentalInstrumentID, String delivery) throws SchoolDBException{
        schoolDb.makeStudentRental(studentID, rentalInstrumentID, delivery);
    }

    public void terminateStudentRental(int rentalID) throws SchoolDBException{
       schoolDb.terminateStudentRental(rentalID);
    }

    public void getStudentRental(int studentID) throws SchoolDBException{
        schoolDb.getStudentRental(studentID);
    }
    
}
