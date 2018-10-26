DROP TABLE IF EXISTS 'customer';
CREATE TABLE 'customer'(
	'IDUSER' INT(5) NOT NULL,
	'FIRSTNAME' VARCHAR(10) NOT NULL,
	'LASTNAME' VARCHAR(10) NOT NULL,
	'MAIL' VARCHAR(25) NOT NULL,
	'PHONENUMBER' VARCHAR(15) NOT NULL,
	'DATEOFBIRTH' DATE NOT NULL,
	'ADDRESS' VARCHAR(255) NOT NULL,
	'POSTALCODE' VARCHAR(10) NOT NULL,
	'TOWN' VARCHAR(25) NOT NULL,
	'COUNTRY' VARCHAR(15) NOT NULL,
	'DATEOPEN' DATE NOT NULL,
	'GENDER' VARCHAR(1) NOT NULL,
	'WEBUSERID' INT(5) NOT NULL,
	CONSTRAINT 'PK_CUSTOMER' PRIMARY KEY('IDUSER'),
	CONSTRAINT 'FK_WEBUSER' FOREIGN KEY 'WEBUSERID' REFERENCES 'webuser'('WEBUSERID')
);

DROP TABLE IF EXISTS 'admin';
CREATE TABLE 'admin'(
	'ADMINID' INT(5) NOT NULL,
	'FIRSTNAME' VARCHAR(15) NOT NULL,
	'LASTNAME' VARCHAR(15) NOT NULL,
	'DATEOPEN' DATE NOT NULL,
	'STATE' VARCHAR(10) NOT NULL,
	'WEBUSERID' INT(5) NOT NULL,
	CONSTRAINT 'PK_ADMIN' PRIMARY KEY('ADMINID'),
	CONSTRAINT 'FK_WEBUSER' FOREIGN KEY 'WEBUSERID' REFERENCES 'webuser'('WEBUSERID')
);

DROP TABLE IF EXISTS 'worker';
CREATE TABLE 'worker'(
	'WORKERID' INT(5) NOT NULL,
	'FIRSTNAME' VARCHAR(15) NOT NULL,
	'LASTNAME' VARCHAR(15) NOT NULL,
	'MAIL' VARCHAR(25) NOT NULL,
	'PHONENUMBER' VARCHAR(15) NOT NULL,
	'DATEOPEN' DATE NOT NULL,
	'ADMINID' INT(5) NOT NULL,
	'WEBUSERID' INT(5) NOT NULL,
	CONSTRAINT 'PK_WORKER' PRIMARY KEY('WORKERID'),
	CONSTRAINT 'FK_ADMIN' FOREIGN KEY('ADMINID') REFERENCES 'admin'('ADMINID'),
	CONSTRAINT 'FK_WEBUSER' FOREIGN KEY 'WEBUSERID' REFERENCES 'webuser'('WEBUSERID')
);

DROP TABLE IF EXISTS 'webuser';
CREATE TABLE 'webuser'(
	'WEBUSERID' INT(5) NOT NULL,
	'LOGIN' VARCHAR(30) NOT NULL,
	'PASSWORD' VARCHAR(15) NOT NULL,
	CONSTRAINT 'PK_WEBUSER' PRIMARY KEY('WEBUSERID')
);

DROP TABLE IF EXISTS 'category';
CREATE TABLE 'category'(
	'IDCATEGORY' INT(5) NOT NULL,
	'NAME' VARCHAR(25) NOT NULL,
	'WORKERID' INT(5) NOT NULL,
	CONSTRAINT 'PK_CATEGORY' PRIMARY KEY('IDCATEGORY'),
	CONSTRAINT 'FK_WORKER' FOREIGN KEY ('WORKERID') REFERENCES 'worker'('WORKERID')
);

DROP TABLE IF EXISTS 'product';
CREATE TABLE 'product'(
	'PRODUCTID' INT(5) NOT NULL,
	'REFERENCE' VARCHAR(5) NOT NULL,
	'NAME' VARCHAR(10) NOT NULL,
	'DESCRIPTION' VARCHAR(255) NOT NULL,
	'IDCATEGORY' INT(5) NOT NULL,
	'PRICE' FLOAT NOT NULL,
	'VAT' FLOAT NOT NULL,
	'QUANTITYSTOCK' INT(5) NOT NULL,
	'SUPPLIERID' INT(5) NOT NULL,
	CONSTRAINT 'PK_PRODUCT' PRIMARY KEY('PRODUCTID'),
	CONSTRAINT 'FK_CATEGORY' FOREIGN KEY ('IDCATEGORY') REFERENCES 'category'('IDCATEGORY'),
	CONSTRAINT 'FK_SUPPLIER' FOREIGN KEY ('SUPPLIERID') REFERENCES 'supplier'('SUPPLIERID')
);

DROP TABLE IF EXISTS 'supplier';
CREATE TABLE 'supplier'(
	'SUPPLIERID' VARCHAR(5) NOT NULL,
	'NAME' VARCHAR(15) NOT NULL,
	'ADDRESS' VARCHAR(255) NOT NULL,
	'TOWN' VARCHAR(15) NOT NULL,
	'POSTALCODE' VARCHAR(10),
	'COUNTRY' VARCHAR(15) NOT NULL,
	CONSTRAINT 'PK_SUPPLIER' PRIMARY KEY('SUPPLIERID')
);

DROP TABLE IF EXISTS 'lineproduct';
CREATE TABLE 'lineproduct'(
	'LINEID' INT(5) NOT NULL,
	'IDSHOPPING' INT(5) NOT NULL,
	'PRODUCTID' INT(5) NOT NULL,
	'QUANTITY' INT(5) NOT NULL,
	CONSTRAINT 'PK_LINEPRODUCT' PRIMARY KEY('LINEID'),
	CONSTRAINT 'FK_PRODUCT' FOREIGN KEY('PRODUCTID') REFERENCES 'product'('PRODUCTID'),
	CONSTRAINT 'FK_SHOPPINGCART' FOREIGN KEY('IDSHOPPING') REFERENCES 'shoppingcart'('IDSHOPPING')
);

DROP TABLE IF EXISTS 'shoppingcart';
CREATE TABLE 'shoppingcart'(
	'IDSHOPPING' INT(5) NOT NULL,
	CONSTRAINT 'PK_SHOPPINGCART' PRIMARY KEY('IDSHOPPING')
);

DROP TABLE IF EXISTS 'order';
CREATE TABLE 'order'(
	'ORDERID' INT(5) NOT NULL,
	'IDUSER' INT(5) NOT NULL,
	'IDSHOPPING' INT(5) NOT NULL,
	'DATE' DATE NOT NULL,
	'AMOUNT' FLOAT NOT NULL,
	'SHIPPINGINFOID' INT(5) NOT NULL,
	'PAYMENTID' INT(5) NOT NULL,
	CONSTRAINT 'PK_ORDER' PRIMARY KEY ('ORDERID'),
	CONSTRAINT 'FK_CUSTOMER' FOREIGN KEY('IDUSER') REFERENCES 'customer'('IDUSER'),
	CONSTRAINT 'FK_SHOPPINGCART' FOREIGN KEY('IDSHOPPING') REFERENCES 'shoppingcart'('IDSHOPPING'),
	CONSTRAINT 'FK_SHIPPINGINFO' FOREIGN KEY('SHIPPINGINFOID') REFERENCES 'shippinginfo'('SHIPPINGID'),
	CONSTRAINT 'FK_PAYMENT' FOREIGN KEY('PAYMENTID') REFERENCES 'payment'('PAYMENTID')
);

DROP TABLE IF EXISTS 'payment';
CREATE TABLE 'payment'(
	'PAYMENTID' INT(5) NOT NULL,
	'PAYMENTDATE' DATE NOT NULL,
	'METHODOFPAYMENT' VARCHAR(15) NOT NULL,
	'ORDERID' INT(5) NOT NULL,
	CONSTRAINT 'PK_PAYMENT' PRIMARY KEY('PAYMENTID'),
	CONSTRAINT 'FK_ORDERID' FOREIGN KEY('ORDERID') REFERENCES 'order'('ORDERID')
);

DROP TABLE IF EXISTS 'shippinginfo';
CREATE TABLE 'shippinginfo'(
	'SHIPPINGID' INT(5) NOT NULL,
	'SHIPPINGADDRESS' VARCHAR(255) NOT NULL,
	'SHIPPINGPOSTALCODE' VARCHAR(10) NOT NULL,
	'SHIPPINGTOWN' VARCHAR(10) NOT NULL,
	'SHIPPINGCOUNTRY' VARCHAR(10) NOT NULL,
	'SHIPPINGSTATUS' VARCHAR(10) NOT NULL,
	'RECIPIENT' VARCHAR(15) NOT NULL,
	'ORDERID' INT(5) NOT NULL,
	CONSTRAINT 'PK_SHIPPINGINFO' PRIMARY KEY('SHIPPINGID'),
	CONSTRAINT 'FK_ORDERID' FOREIGN KEY('ORDERID') REFERENCES 'order'('ORDERID')
);