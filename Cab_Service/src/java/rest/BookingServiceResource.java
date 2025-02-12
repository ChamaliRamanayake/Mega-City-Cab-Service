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
import model.booking;
import model.driver;
import service.BookingService;
import service.DriverService;

/**
 *
 * @author 94775
 */

@Path("/drivers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)

public class BookingServiceResource {
    
    private BookingService bookingService = new BookingService();

    
    // Get All Bookings
    @GET
    @Path("/getAllBookings")
    public Response getAllBookings() {
        try {
            List<booking> bookings = bookingService.getAllBookings();
            return Response.status(Response.Status.OK).entity(bookings).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving bookings: " + e.getMessage()).build();
        }
    }
    
    // Get Driver By ID
    @GET
    @Path("/getBookingById/{id}")
    public Response getBookingById(@PathParam("id") int id) {
        try {
            booking bk = bookingService.getBookingByID(id);
            if (bk != null) {
                return Response.status(Response.Status.OK).entity(bk).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("Booking not found with ID: " + id).build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving Booking: " + e.getMessage()).build();
        }
    }
    
    // Add Booking
    @POST
    @Path("/addBooking")
    public Response addBooking(booking bk) {
        try {
            String result = bookingService.addBooking(bk);
            return Response.status(Response.Status.CREATED).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error adding booking: " + e.getMessage()).build();
        }
    }
    
    // Update Booking
    @PUT
    @Path("/updateBooking")
    public Response updateBooking(booking bk) {
        try {
            String result = bookingService.updateBooking(bk);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error updating booking: " + e.getMessage()).build();
        }
    }
    
    // Delete Booking
    @DELETE
    @Path("/deleteBooking/{id}")
    public Response deleteBooking(@PathParam("id") int id) {
        try {
            String result = bookingService.deleteBooking(id);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error deleting Booking: " + e.getMessage()).build();
        }
    }
    
}
