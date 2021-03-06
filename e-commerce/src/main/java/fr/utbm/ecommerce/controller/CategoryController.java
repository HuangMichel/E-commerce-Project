package fr.utbm.ecommerce.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import fr.utbm.ecommerce.dto.Category;
import fr.utbm.ecommerce.service.CategoryService;
/**
 * Category controller
 *
 */
@RestController
@RequestMapping("category")
public class CategoryController {
	public static final Logger logger = LoggerFactory.getLogger(CategoryController.class);

	@Autowired
	private CategoryService CategoryService;

	/**
	 * Creates a new category
	 * @param Category the object category
	 * @return response http created
	 */
	@CrossOrigin
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public ResponseEntity<?> createCategory(@RequestBody Category Category){
		boolean created = CategoryService.addCategory(Category);
		logger.info(Category.toString());
		if(created == false){
			logger.info("item is not created");
			return new ResponseEntity<Object>(HttpStatus.CONFLICT);
		}
		logger.info("item created");
		return new ResponseEntity<Category>(Category, HttpStatus.CREATED);
	}

	/**
	 * Updates the category
	 * @param Category the object category
	 * @return response http ok
	 */
	@CrossOrigin
	@RequestMapping(value="/update", method=RequestMethod.PUT)
	public ResponseEntity<?> updateCategory(@RequestBody Category Category){
		boolean updated = CategoryService.updateCategory(Category);
		if(updated == false){
			logger.info("item not found to update");
			return new ResponseEntity<Object>(HttpStatus.CONFLICT);
		}
		logger.info("item updated");
		return new ResponseEntity<Category>(Category, HttpStatus.OK);
	}

	/**
	 * Deletes the category
	 * @param Category the object category
	 * @return response http no content
	 */
	@CrossOrigin
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<?> deleteCategory(@RequestBody Category Category){
		boolean deleted = CategoryService.deleteCategory(Category);
		logger.info(Category.toString());
		if(deleted == false){
			logger.info("item not found to delete");
			return new ResponseEntity<Object>(HttpStatus.CONFLICT);

		}
		logger.info("item deleted");
		return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
	}

	/**
	 * Gets the list of categories
	 * @return the list of categories
	 */
	@CrossOrigin
	@RequestMapping(value="/categories", method=RequestMethod.GET)
	public ResponseEntity<List<Category>> getAllCategorys(){
		return new  ResponseEntity<List<Category>>(CategoryService.getAllCategory(), HttpStatus.OK);
	}
}
