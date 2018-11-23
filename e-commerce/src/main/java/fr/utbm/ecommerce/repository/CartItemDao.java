package fr.utbm.ecommerce.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import fr.utbm.ecommerce.dto.CartItem;
import org.springframework.data.repository.query.Param;

@Repository("CartItemDao")
@Transactional
public interface CartItemDao extends CrudRepository<CartItem, Integer> {

	@Query("SELECT ci from CartItem ci where ci.Order.OrderID =:orderid ")
	List<CartItem> getAllOrders(@Param("orderid") int orderid);
 
}
