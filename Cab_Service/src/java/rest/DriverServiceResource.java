/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package rest;

import java.sql.SQLException;
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
import service.DriverService;

/**
 *
 * @author 94775
 */

@Path("/drivers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)

public class DriverServiceResource {
    
    private DriverService driverService = new DriverService();
    
   // Get All Drivers
    @GET
    @Path("/getAllDrivers")
    public Response getAllDrivers() {
        try {
            List<driver> drivers = driverService.getAllDrivers();
            return Response.status(Response.Status.OK).entity(drivers).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving drivers: " + e.getMessage()).build();
        }
    }
    
    // Get Driver By ID
    @GET
    @Path("/getDriverById/{id}")
    public Response getDriverById(@PathParam("id") int id) {
        try {
            driver bk = driverService.getDriverByID(id);
            if (bk != null) {
                return Response.status(Response.Status.OK).entity(bk).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("Driver not found with ID: " + id).build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving Driver: " + e.getMessage()).build();
        }
    }
    
    // Add Driver
    @POST
    @Path("/addDriver")
    public Response addDriver(driver bk) {
        try {
            String result = driverService.addDriver(bk);
            return Response.status(Response.Status.CREATED).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error adding driver: " + e.getMessage()).build();
        }
    }
    
    // Update Driver
    @PUT
    @Path("/updateDriver")
    public Response updateDriver(driver bk) {
        try {
            String result = driverService.updateDriver(bk);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error updating driver: " + e.getMessage()).build();
        }
    }
    
    // Delete Book
    @DELETE
    @Path("/deleteDriver/{id}")
    public Response deleteDriver(@PathParam("id") int id) {
        try {
            String result = driverService.deleteDriver(id);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error deleting Driver: " + e.getMessage()).build();
        }
    }
    
}
