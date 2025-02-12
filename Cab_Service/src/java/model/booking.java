/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author 94775
 */
public class booking {
    
    private int booking_id;
    private int customer_id;
    private int driver_id;
    private int vehicle_id;
    private String destination;
    private Timestamp bookingDate;  
    private BigDecimal amount;  
    private String status;

    /**
     * @return the booking_id
     */
    public int getBooking_id() {
        return booking_id;
    }

    /**
     * @param booking_id the booking_id to set
     */
    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    /**
     * @return the customer_id
     */
    public int getCustomer_id() {
        return customer_id;
    }

    /**
     * @param customer_id the customer_id to set
     */
    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    /**
     * @return the driver_id
     */
    public int getDriver_id() {
        return driver_id;
    }

    /**
     * @param driver_id the driver_id to set
     */
    public void setDriver_id(int driver_id) {
        this.driver_id = driver_id;
    }

    /**
     * @return the vehicle_id
     */
    public int getVehicle_id() {
        return vehicle_id;
    }

    /**
     * @param vehicle_id the vehicle_id to set
     */
    public void setVehicle_id(int vehicle_id) {
        this.vehicle_id = vehicle_id;
    }

    /**
     * @return the destination
     */
    public String getDestination() {
        return destination;
    }

    /**
     * @param destination the destination to set
     */
    public void setDestination(String destination) {
        this.destination = destination;
    }

    /**
     * @return the bookingDate
     */
    public Timestamp getBookingDate() {
        return bookingDate;
    }

    /**
     * @param bookingDate the bookingDate to set
     */
    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    /**
     * @return the amount
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * @param amount the amount to set
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }
    
}
