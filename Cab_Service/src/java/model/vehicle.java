/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author 94775
 */
public class vehicle {
    
    private int vehicle_id;
    private String vehicle_model;
    private String plate_number;
    private String available;
    private int type_id;

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
     * @return the vehicle_model
     */
    public String getVehicle_model() {
        return vehicle_model;
    }

    /**
     * @param vehicle_model the vehicle_model to set
     */
    public void setVehicle_model(String vehicle_model) {
        this.vehicle_model = vehicle_model;
    }

    /**
     * @return the plate_number
     */
    public String getPlate_number() {
        return plate_number;
    }

    /**
     * @param plate_number the plate_number to set
     */
    public void setPlate_number(String plate_number) {
        this.plate_number = plate_number;
    }

    /**
     * @return the available
     */
    public String getAvailable() {
        return available;
    }

    /**
     * @param available the available to set
     */
    public void setAvailable(String available) {
        this.available = available;
    }

    /**
     * @return the type_id
     */
    public int getType_id() {
        return type_id;
    }

    /**
     * @param type_id the type_id to set
     */
    public void setType_id(int type_id) {
        this.type_id = type_id;
    } 
    
}
