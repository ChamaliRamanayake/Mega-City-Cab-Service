/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package rest;

import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.driver;
import model.vehicle;
import service.DriverService;
import service.VehicleService;

/**
 *
 * @author 94775
 */

@Path("/vehicles")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)

public class VehicleServiceResource {
    
    private VehicleService vehicleService = new VehicleService();

    // Get All Vehicles
    @GET
    @Path("/getAllVehicles")
    public Response getAllVehicles() {
        try {
            List<vehicle> vehicles = vehicleService.getAllVehicles();
            return Response.status(Response.Status.OK).entity(vehicles).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving vehicles: " + e.getMessage()).build();
        }
    }
    
    // Get Driver By ID
    @GET
    @Path("/getVehicleById/{id}")
    public Response getVehicleById(@PathParam("id") int id) {
        try {
            vehicle vh = vehicleService.getVehicleByID(id);
            if (vh != null) {
                return Response.status(Response.Status.OK).entity(vh).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("Vehicle not found with ID: " + id).build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving Vehicle: " + e.getMessage()).build();
        }
    }
    
    // Add Vehicle
    @POST
    @Path("/addVehicle")
    public Response addVehicle(vehicle vh) {
        try {
            String result = vehicleService.addVehicle(vh);
            return Response.status(Response.Status.CREATED).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error adding vehicle: " + e.getMessage()).build();
        }
    }
    
    // Update Vehicle
    @PUT
    @Path("/updateVehicle")
    public Response updateVehicle(vehicle vh) {
        try {
            String result = vehicleService.updateVehicle(vh);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error updating vehicle: " + e.getMessage()).build();
        }
    }
    
    // Delete Vehicle
    @DELETE
    @Path("/deleteVehicle/{id}")
    public Response deleteVehicle(@PathParam("id") int id) {
        try {
            String result = vehicleService.deleteVehicle(id);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error deleting Vehicle: " + e.getMessage()).build();
        }
    }
    
}
