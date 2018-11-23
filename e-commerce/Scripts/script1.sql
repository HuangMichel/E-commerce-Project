DROP TABLE `user` ;
DROP TABLE `category` ;
DROP TABLE `supplier` ;
DROP TABLE `shippinginfo` ;
DROP TABLE `payment` ;
DROP TABLE `product` ;
DROP TABLE `order` ;
DROP TABLE `carteitem` ;
CREATE TABLE IF NOT EXISTS  `user` (
	IDUSER INT(5) NOT NULL AUTO_INCREMENT,
	FIRSTNAME VARCHAR(10),
	LASTNAME VARCHAR(10),
	ROLE VARCHAR(10),
	PASSWORD VARCHAR(10),
	MAIL VARCHAR(25),
	PHONENUMBER VARCHAR(15),
	DATEOFBIRTH DATE,
	ADDRESS VARCHAR(255),
	POSTALCODE VARCHAR(10),
	TOWN VARCHAR(25),
	COUNTRY VARCHAR(15),
	DATEOPEN DATE,
	GENDER VARCHAR(15),
	CONSTRAINT PK_USER PRIMARY KEY(IDUSER),
	UNIQUE (MAIL),
	INDEX login (MAIL, PASSWORD)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS category(
	IDCATEGORY INT(5) NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(25),
	DESCRIPTION VARCHAR(200),
	CONSTRAINT PK_CATEGORY PRIMARY KEY(IDCATEGORY)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

 CREATE TABLE IF NOT EXISTS supplier (
	SUPPLIERID INT(5) NOT NULL AUTO_INCREMENT,
	FIRSTNAME VARCHAR(10) ,
	LASTNAME VARCHAR(10) ,
	MAIL VARCHAR(25),
	PHONENUMBER VARCHAR(15),
	DATEOFBIRTH DATE ,
	ADDRESS VARCHAR(255),
	POSTALCODE VARCHAR(10),
	TOWN VARCHAR(25),
	COUNTRY VARCHAR(15),
	CONSTRAINT PK_SUPPLIER PRIMARY KEY(SUPPLIERID)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS shippinginfo(
	SHIPPINGID INT(5) NOT NULL AUTO_INCREMENT,
	SHIPPINGADDRESS VARCHAR(255) ,
	SHIPPINGPOSTALCODE VARCHAR(10),
	SHIPPINGTOWN VARCHAR(10) ,
	SHIPPINGCOUNTRY VARCHAR(10) ,
	SHIPPINGSTATUS VARCHAR(10) ,
	RECIPIENT VARCHAR(15) , 
	CONSTRAINT PK_SHIPPINGINFO PRIMARY KEY(SHIPPINGID)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS payment (
	PAYMENTID INT(5) NOT NULL AUTO_INCREMENT,
	PAYMENTDATE DATE NOT NULL,
	METHODOFPAYMENT VARCHAR(15) NOT NULL,
	CONSTRAINT PK_PAYMENT PRIMARY KEY(PAYMENTID)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
 
CREATE TABLE IF NOT EXISTS product (
	PRODUCTID INT(5) NOT NULL AUTO_INCREMENT,
	REFERENCE VARCHAR(5),
	NAME VARCHAR(10) ,
	DESCRIPTION VARCHAR(255) ,
	IDCATEGORY INT(5) ,
	PRICE FLOAT ,
	VAT FLOAT ,
	QUANTITYSTOCK INT(5) ,
	SIZE INT(5) ,
	COLOR INT(5) ,
	PICTURE INT(5) ,
	SUPPLIERID INT(5),
	CONSTRAINT PK_PRODUCT PRIMARY KEY(PRODUCTID),
	CONSTRAINT FK_CATEGORY FOREIGN KEY (IDCATEGORY) REFERENCES category(IDCATEGORY) ,
	CONSTRAINT FK_SUPPLIER FOREIGN KEY (SUPPLIERID) REFERENCES supplier(SUPPLIERID)  
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `order`(
	ORDERID INT(5) NOT NULL AUTO_INCREMENT,
	IDUSER INT(5) ,
	DATE DATE ,
	AMOUNT FLOAT ,
	SHIPPINGINFOID INT(5) ,
	PAYMENTID INT(5) ,
	CONSTRAINT PK_ORDER PRIMARY KEY (ORDERID),
	CONSTRAINT FK_USER FOREIGN KEY(IDUSER) REFERENCES `user`(IDUSER),
	CONSTRAINT FK_SHIPPINGINFO FOREIGN KEY(SHIPPINGINFOID) REFERENCES shippinginfo(SHIPPINGID),
	CONSTRAINT FK_PAYMENT FOREIGN KEY(PAYMENTID) REFERENCES payment(PAYMENTID)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

 
CREATE TABLE IF NOT EXISTS carteitem(
	CARTEITEMID INT(5) NOT NULL AUTO_INCREMENT,
	ORDERID INT(5),
	PRODUCTID INT(5),
	QUANTITY INT(5),
	CONSTRAINT PK_LINEPRODUCT PRIMARY KEY(CARTEITEMID),
	CONSTRAINT FK_PRODUCT FOREIGN KEY(PRODUCTID) REFERENCES product(PRODUCTID),
	CONSTRAINT FK_ORDER FOREIGN KEY(ORDERID) REFERENCES `order`(ORDERID)
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;





 
