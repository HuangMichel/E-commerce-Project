package fr.utbm.ecommerce.repository;

import fr.utbm.ecommerce.dto.User;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
//This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
//CRUD refers Create, Read, Update, Delete
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;



@Repository("UserDao")
@Transactional
public interface UserDao extends CrudRepository<User, Integer> {
//
	@Query("SELECT u FROM User u WHERE LOWER(u.Mail) LIKE LOWER(:mail) ")
	User getUserByMail(@Param("mail") String mail);
	@Modifying
	@Query("DELETE  FROM User WHERE LOWER(Mail) LIKE LOWER(:mail) ")
	int deleteUserByMail(@Param("mail") String mail);
	@Query("SELECT u FROM User u WHERE LOWER(u.Role) LIKE LOWER(:admin) OR LOWER(u.Role) LIKE LOWER(:worker) ")
	List<User> getUsers(@Param("admin") String admin,@Param("worker") String worker);
	@Modifying
	@Query("UPDATE User u set u.FirstName=:firstname,u.LastName=:lastname,u.Password=:password,u.DateOfBirth=:dateofbirth,u.Gender=:gender"
			+ ",u.Address=:address,u.Country=:country,u.Town=:town,u.PostalCode=:postalcode,u.PhoneNumber=:phonenumber,u.Role=:role WHERE LOWER(u.Mail) LIKE LOWER(:mail) ")
	int updateUserByMail(@Param("firstname") String firstname,@Param("lastname") String lastname ,@Param("password") String password,@Param("dateofbirth") Date dateofbith,@Param("gender") String gender,@Param("address") String address,@Param("country") String country,@Param("town") String town,@Param("postalcode") String postalcode,@Param("phonenumber") String phonenumber,@Param("role") String role,@Param("mail") String mail);
	

}
