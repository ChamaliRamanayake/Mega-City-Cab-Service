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
import model.customer;
import model.driver;
import service.CustomerService;
import service.DriverService;

/**
 *
 * @author 94775
 */

@Path("/customers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)

public class CustomerServiceResource {
    
    private CustomerService customerService = new CustomerService();
    
    // Get All Customers
    @GET
    @Path("/getAllCustomers")
    public Response getAllCustomer() {
        try {
            List<customer> customers = customerService.getAllCustomers();
            return Response.status(Response.Status.OK).entity(customers).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving customers: " + e.getMessage()).build();
        }
    }
    
    // Get Customer By ID
    @GET
    @Path("/getCustomerById/{id}")
    public Response getCustomerById(@PathParam("id") int id) {
        try {
            customer cu = customerService.getCustomerByID(id);
            if (cu != null) {
                return Response.status(Response.Status.OK).entity(cu).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("Customer not found with ID: " + id).build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error retrieving Customer: " + e.getMessage()).build();
        }
    }
    
    // Add Customer
    @POST
    @Path("/addCustomer")
    public Response addCustomer(customer cu) {
        try {
            String result = customerService.addCustomer(cu);
            return Response.status(Response.Status.CREATED).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error adding customer: " + e.getMessage()).build();
        }
    }
    
    // Update Customer
    @PUT
    @Path("/updateCustomer")
    public Response updateCustomer(customer cu) {
        try {
            String result = customerService.updateCustomer(cu);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error updating customer: " + e.getMessage()).build();
        }
    }
    
    // Delete Customer
    @DELETE
    @Path("/deleteCustomer/{id}")
    public Response deleteCustomer(@PathParam("id") int id) {
        try {
            String result = customerService.deleteCustomer(id);
            return Response.status(Response.Status.OK).entity(result).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error deleting Customer: " + e.getMessage()).build();
        }
    }
    
}
