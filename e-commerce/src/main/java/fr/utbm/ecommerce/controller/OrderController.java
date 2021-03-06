package fr.utbm.ecommerce.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import fr.utbm.ecommerce.dto.Order;
import fr.utbm.ecommerce.service.OrderService;

/**
 * Order controller
 *
 */
@RestController
@RequestMapping("order")
public class OrderController {
	public static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService OrderService;

	/**
	 * Creates a new order
	 * @param Order the object order
	 * @return response http created
	 */
	@CrossOrigin
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public ResponseEntity<?> createOrder(@RequestBody Order Order){
		boolean created = OrderService.addOrder(Order);
		logger.info(Order.toString());
		if(created == false){
			logger.info("item is not created");
			return new ResponseEntity<Object>(HttpStatus.CONFLICT);
		}
		logger.info("item created");
		return new ResponseEntity<Order>(Order, HttpStatus.CREATED);
	}

	/**
	 * Updates the order
	 * @param Order the object order
	 * @return response http ok
	 */
	@CrossOrigin
	@RequestMapping(value="/update", method=RequestMethod.PUT)
	public ResponseEntity<?> updateOrder(@RequestBody Order Order){
		boolean updated = OrderService.updateOrder(Order);
		if(updated == false){
			logger.info("item not found to update");
			return new ResponseEntity<Object>(HttpStatus.CONFLICT);
		}
		logger.info("item updated");
		return new ResponseEntity<Order>(Order, HttpStatus.OK);
	}

	/**
	 * Deletes the order 
	 * @param Order the object order
	 * @return response http no content
	 */
	@CrossOrigin
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<?> deleteOrder(@RequestBody Order Order){
		boolean deleted = OrderService.deleteOrder(Order);
		logger.info(Order.toString());
		if(deleted == false){
			logger.info("item not found to delete");
			return new ResponseEntity<Object>(HttpStatus.CONFLICT);

		}
		logger.info("item deleted");
		return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
	}

	/**
	 * Gets all order by user id
	 * @param iduser the user id
	 * @return a list of order
	 */
	@CrossOrigin
	@RequestMapping(value="/{iduser}", method=RequestMethod.GET)
	public ResponseEntity<List<Order>> getAllOrders(@PathVariable("iduser") int iduser){
		System.out.println(iduser);
		return new  ResponseEntity<List<Order>>(OrderService.getAllOrder(iduser), HttpStatus.OK);
	}
}
