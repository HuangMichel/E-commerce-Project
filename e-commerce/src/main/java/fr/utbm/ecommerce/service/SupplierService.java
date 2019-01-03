package fr.utbm.ecommerce.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import fr.utbm.ecommerce.dto.Supplier;
import fr.utbm.ecommerce.repository.SupplierDao;
@Service("SupplierService")
@Transactional
public class SupplierService {
	@Autowired
	private SupplierDao supplierDao;

	public Supplier addSupplier(Supplier supplier) {
		return supplierDao.save(supplier);
	}

	public Supplier updateSupplier(Supplier supplier) {
		return supplierDao.save(supplier);
	}

	public void deleteSupplier(Supplier supplier) {
		 supplierDao.delete(supplier);
	}

	public List<Supplier> getAllSupplier() {
		return (List<Supplier>) supplierDao.findAll();
	}

}