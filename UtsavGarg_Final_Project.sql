-- This is the database for a centralized store\outlet of company "The Delhi's Creamery" located in Delhi which makes online delivery to customer.
-- Utsav Garg 2021108 && Yash Yadav 2021117

DROP DATABASE IF EXISTS Delhi_Store;
CREATE DATABASE Delhi_Store; 
USE Delhi_Store;

-- This stores the material supplier of the Delhi Store, which is the Head Office of the company
CREATE TABLE Supplier (
	Supplier_Name varchar(50) NOT NULL DEFAULT "The Delhi's Creamery HO",
    Permission_Level int1 NOT NULL DEFAULT 0,
    PRIMARY KEY (Supplier_Name)
) engine = InnoDB;

-- This table represents the unique store id, the operator and the location this outlet caters to
CREATE TABLE Store (
	Store_ID int NOT NULL AUTO_INCREMENT,
	Store_Admin varchar(50) NOT NULL DEFAULT 'Admin Operator',
    Store_Location varchar(50) NOT NULL DEFAULT 'Delhi',
    State_Catered varchar(50) NOT NULL DEFAULT 'Haryana',
    Permission_Level int1 NOT NULL DEFAULT 1,
    Supplier_Name varchar(50) NOT NULL,
    Admin_Code varchar(50) not null ,
    PRIMARY KEY (Store_ID),
    FOREIGN KEY (Supplier_Name) references Supplier(Supplier_Name) on DELETE CASCADE on UPDATE CASCADE
) engine = InnoDB;

-- This stores all the product categories present in the Delhi Outlet.
CREATE TABLE Product_Category (
	Category_ID int NOT NULL AUTO_INCREMENT,
	Category_Name varchar(50) NOT NULL,
    PRIMARY KEY (Category_ID)
) engine = InnoDB;

-- This stores all the products present in the respective categories of the outlet.
CREATE TABLE Product(
	Product_ID int NOT NULL auto_increment,
    Product_Name varchar(50) NOT NULL,
    Price int NOT NULL DEFAULT 0,
    Stock int NOT NULL DEFAULT 0,
	Category_ID int NOT NULL,
	Product_Details varchar(100) NOT NULL DEFAULT '-',
    PRIMARY KEY (Product_ID),
    FOREIGN KEY (Category_ID) references Product_Category(Category_ID) on DELETE CASCADE on UPDATE CASCADE
) engine = InnoDB;

-- This table stores the entire data of the customer which orders from the outlet. 
CREATE TABLE Customer (
	Customer_ID int NOT NULL AUTO_INCREMENT,
	Customer_Name varchar(50) NOT NULL,
    Contact_Number varchar(50) NOT NULL,
	Street varchar(30) NOT NULL DEFAULT '-',
	City varchar(20) NOT NULL DEFAULT '-',
	State varchar(20) NOT NULL DEFAULT '-',
	Pincode int NOT NULL,
    Permission_Level int1 NOT NULL DEFAULT 2,
    User_Password varchar(10) NOT NULL DEFAULT '0000',
    PRIMARY KEY (Customer_ID)
) engine = InnoDB;

-- This is at a time products present in the cart of the person
CREATE TABLE Cart (
    Customer_ID int NOT NULL,
	Product_ID int NOT NULL,
	Quantity int NOT NULL DEFAULT 0,
    Delivery_Charges int NOT NULL DEFAULT 0,
	Item_Total int NOT NULL DEFAULT 0,
    Grand_Total int NOT NULL DEFAULT 0,
	FOREIGN KEY (Product_ID) references Product(Product_ID) on DELETE CASCADE on UPDATE CASCADE,
	FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
) engine = InnoDB;

-- This contains the total of all the products price and also notes the mode of payment returning a payment ID in return for the Order
CREATE TABLE `Payment`(
	Payment_ID int NOT NULL AUTO_INCREMENT,
	Customer_ID int NOT NULL,
    Payment_Mode varchar(50) NOT NULL,
    Total_Amount int NOT NULL DEFAULT 0,
	PRIMARY KEY (Payment_ID),
	FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
) engine = InnoDB;

CREATE TABLE Delivery(
	Delivery_ID int NOT NULL AUTO_INCREMENT,
    Customer_ID int NOT NULL,
	Person_Name varchar(20) NOT NULL,
    Contact_Number varchar(50) NOT NULL,
    `Status` varchar(20) NOT NULL,
    PRIMARY KEY (Delivery_ID),
    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
) engine = InnoDB;

CREATE TABLE Delivery_Log(
	Delivery_ID int NOT NULL AUTO_INCREMENT,
    Customer_ID int NOT NULL,
	Person_Name varchar(20) NOT NULL,
    Contact_Number varchar(50) NOT NULL,
    `Status` varchar(20) NOT NULL,
    PRIMARY KEY (Delivery_ID),
    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
) engine = InnoDB;

-- This stores the main item of a specific order, used for invoice generation, will also contain the product list and delivery id
-- The history part is one which I am still worried about, will see about that later
CREATE TABLE `Order`(
	Order_ID int NOT NULL AUTO_INCREMENT,
    Customer_ID int NOT NULL,
    Payment_ID int NOT NULL,
	Delivery_ID int NOT NULL,
    PRIMARY KEY (Order_ID),
    FOREIGN KEY (Payment_ID) references Payment(Payment_ID) on DELETE CASCADE on UPDATE CASCADE,
    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE,
    FOREIGN KEY (Delivery_ID) references Delivery_Log(Delivery_ID) on DELETE CASCADE on UPDATE CASCADE
) engine = InnoDB;

INSERT INTO Supplier VALUES ();

INSERT INTO Store VALUES (101, 'Admin Operator', 'Delhi', 'Haryana', 1, "The Delhi's Creamery HO","0000");

INSERT INTO Product_Category VALUES (-1, 'User');
INSERT INTO Product_Category VALUES (1, 'Milk');
INSERT INTO Product_Category VALUES (2, 'Paneer & Tofu');
INSERT INTO Product_Category VALUES (3, 'Curd & Yogurt');
INSERT INTO Product_Category VALUES (4, 'Butter & Cheese');
INSERT INTO Product_Category VALUES (5, 'Cream Whitener & Condensed Milk');

INSERT INTO Product VALUES (-1,'Empty',0,100,-1,'-');
INSERT INTO Product VALUES (1,'Toned Milk 500ml',26,100,1,'-');
INSERT INTO Product VALUES (2,'Full Cream Milk 500ml',32,100,1,'-');
INSERT INTO Product VALUES (3,'Cow Milk 500ml',27,100,1,'-');
INSERT INTO Product VALUES (4,'Moti Toned 500ml',32,100,1,'-');
INSERT INTO Product VALUES (5,'Lactose Free Milk 500ml',50,100,1,'-');
INSERT INTO Product VALUES (6,'Oat Milk 500ml',150,100,1,'-');
INSERT INTO Product VALUES (7,'Slimmed Milk 500ml',91,100,1,'-');
INSERT INTO Product VALUES (8,'Malai Paneer 200g',83,100,2,'-');
INSERT INTO Product VALUES (9,'Normal Paneer 200g',65,100,2,'-');
INSERT INTO Product VALUES (10,'Classic Cubed Paneer 200g',100,100,2,'-');
INSERT INTO Product VALUES (11,'Classic Tofu 200g',46,100,2,'-');
INSERT INTO Product VALUES (12,'Masala Tofu 200g',53,100,2,'-');
INSERT INTO Product VALUES (13,'Diet Tofu 200g',50,100,2,'-');
INSERT INTO Product VALUES (14,'Bio Nutrients Tofu 200g',80,100,2,'-');
INSERT INTO Product VALUES (15,'Classic Curd 400g',32,100,3,'-');
INSERT INTO Product VALUES (16,'Masti Curd 400g',36,100,3,'-');
INSERT INTO Product VALUES (17,'Nutrifit Probiotic Curd 400g',56,100,3,'-');
INSERT INTO Product VALUES (18,'A+ Nourish Curd 400g',70,100,3,'-');
INSERT INTO Product VALUES (19,'Mishti Doi Curd 400g',102,100,3,'-');
INSERT INTO Product VALUES (20,'Ultimate Curd 400g',55,100,3,'-');
INSERT INTO Product VALUES (21,'Blueberry Yogurt 400g',132,100,3,'-');
INSERT INTO Product VALUES (22,'Mango Yogurt 400g',132,100,3,'-');
INSERT INTO Product VALUES (23,'Raspeberry Yogurt 400g',132,100,3,'-');
INSERT INTO Product VALUES (24,'Mango Shrikand 400g',88,100,3,'-');
INSERT INTO Product VALUES (25,'Kesar Shrikand 400g',98,100,3,'-');
INSERT INTO Product VALUES (26,'Salted Butter 500g',265,100,4,'-');
INSERT INTO Product VALUES (27,'Lite Milk Fat Spread 500g',222,100,4,'-');
INSERT INTO Product VALUES (28,'Doodh Shakti Probiotic Butter 500g',270,100,4,'-');
INSERT INTO Product VALUES (29,'Garlic Butter 500g',285,100,4,'-');
INSERT INTO Product VALUES (30,'Cheese Slices 200g',156,100,4,'-');
INSERT INTO Product VALUES (31,'Cheese Cubes 200g',122,100,4,'-');
INSERT INTO Product VALUES (32,'Cheddar Cheese 200g',210,100,4,'-');
INSERT INTO Product VALUES (33,'Mozzarella Shredded 200g',122,150,4,'-');
INSERT INTO Product VALUES (34,'Cream Cheese 200g',200,100,4,'-');
INSERT INTO Product VALUES (35,'Low Fat Cream 200ml',57,100,5,'-');
INSERT INTO Product VALUES (36,'Dairy Fresh Cream 200ml',53,100,5,'-');
INSERT INTO Product VALUES (37,'Nestle Whitener Dairy 200g',113,100,5,'-');
INSERT INTO Product (Product_Name,Price,Stock,Category_ID,Product_Details) VALUES ('Sweetened Condensed Milk 400g',57,139,5,'-');

INSERT INTO Customer VALUES (1, 'Kaine Veregan', '7866247327', '6262 Schmedeman Trail', 'Miami', 'Florida', '33164', 2, '0000');
INSERT INTO Customer VALUES (2, 'Michale Morrid', '6087286062', '6405 Anniversary Road', 'Madison', 'Wisconsin', '53705', 2, '0000');
INSERT INTO Customer VALUES (3, 'Ezmeralda Santore', '5083396856', '1 Randy Crossing', 'Newton', 'Massachusetts', '02162', 2, '0000');
INSERT INTO Customer VALUES (4, 'Amy Clendinning', '2023370497', '686 Artisan Alley', 'Washington', 'District of Columbia', '20470', 2, '0000');
INSERT INTO Customer VALUES (5, 'Hew Schuster', '9044553185', '2 Glendale Lane', 'Jacksonville', 'Florida', '32204', 2, '0000');
INSERT INTO Customer VALUES (6, 'Nancee Glabach', '8034364689', '84 Moland Junction', 'Columbia', 'South Carolina', '29215', 2, '0000');
INSERT INTO Customer VALUES (7, 'Fionnula Lees', '7042495021', '56 Graedel Court', 'Charlotte', 'North Carolina', '28220', 2, '0000');
INSERT INTO Customer VALUES (8, 'Ragnar Espie', '4085484981', '71 Caliangt Crossing', 'San Jose', 'California', '95133', 2, '0000');
INSERT INTO Customer VALUES (9, 'Tedmund Kollach', '2032055484', '83433 Jackson Place', 'Danbury', 'Connecticut', '06816', 2, '0000');
INSERT INTO Customer VALUES (10, 'Nikki Newvell', '9073272966', '0 Sunfield Lane', 'Anchorage', 'Alaska', '99599', 2, '0000');
INSERT INTO Customer VALUES (11, 'Sol Ferrige', '4154825466', '6209 Fallview Avenue', 'San Francisco', 'California', '94147', 2, '0000');
INSERT INTO Customer VALUES (12, 'Bartram Lipgens', '3525092013', '923 Goodland Street', 'Spring Hill', 'Florida', '34611', 2, '0000');
INSERT INTO Customer VALUES (13, 'Bliss Chastanet', '4108734388', '8 Village Green Point', 'Baltimore', 'Maryland', '21275', 2, '0000');
INSERT INTO Customer VALUES (14, 'Elene Sparke', '5408956393', '6547 Eastwood Parkway', 'Roanoke', 'Virginia', '24048', 2, '0000');
INSERT INTO Customer VALUES (15, 'Gideon McLelland', '3046410466', '20239 Russell Crossing', 'Huntington', 'West Virginia', '25775', 2, '0000');
INSERT INTO Customer VALUES (16, 'Aldrich Gallgher', '9172261917', '86269 Moulton Parkway', 'Bronx', 'New York', '10474', 2, '0000');
INSERT INTO Customer VALUES (17, 'Corella Hazley', '2052750478', '054 Loeprich Hill', 'Tuscaloosa', 'Alabama', '35487', 2, '0000');
INSERT INTO Customer VALUES (18, 'Moll Demke', '5867932412', '46551 Gale Pass', 'Detroit', 'Michigan', '48224', 2, '0000');
INSERT INTO Customer VALUES (19, 'Johan Shrive', '7325151520', '9 Monica Plaza', 'New Brunswick', 'New Jersey', '08922', 2, '0000');
INSERT INTO Customer VALUES (20, 'Langston Petrakov', '5719317702', '98176 Shelley Drive', 'Fairfax', 'Virginia', '22036', 2, '0000');
INSERT INTO Customer VALUES (21, 'Mae Mompesson', '9187150554', '9 Portage Point', 'Tulsa', 'Oklahoma', '74116', 2, '0000');
INSERT INTO Customer VALUES (22, 'Lanni Gawen', '4045115583', '18700 Sundown Plaza', 'Gainesville', 'Georgia', '30506', 2, '0000');
INSERT INTO Customer VALUES (23, 'Darrelle Groves', '7063870706', '65 Hauk Circle', 'Columbus', 'Georgia', '31914', 2, '0000');
INSERT INTO Customer VALUES (24, 'Evvy Pye', '3105677662', '387 Walton Court', 'Santa Monica', 'California', '90410', 2, '0000');
INSERT INTO Customer VALUES (25, 'Ermin Wrout', '5121145809', '9574 Sutteridge Alley', 'Austin', 'Texas', '78710', 2, '0000');
INSERT INTO Customer VALUES (26, 'Gerta Lippitt', '6147138294', '04162 Jenifer Alley', 'Columbus', 'Ohio', '43215', 2, '0000');
INSERT INTO Customer VALUES (27, 'Rollin Huyge', '6023747035', '03120 Thierer Alley', 'Phoenix', 'Arizona', '85035', 2, '0000');
INSERT INTO Customer VALUES (28, 'Justen Drinan', '3379441157', '3842 Transport Alley', 'Lake Charles', 'Louisiana', '70607', 2, '0000');
INSERT INTO Customer VALUES (29, 'Maye De Angelis', '5594809526', '96475 Fisk Drive', 'Fresno', 'California', '93721', 2, '0000');
INSERT INTO Customer VALUES (30, 'Mario Guice', '5615592152', '331 Maple Wood Lane', 'Lake Worth', 'Florida', '33467', 2, '0000');
INSERT INTO Customer VALUES (31, 'Van Garrood', '3342289395', '8040 Bluejay Park', 'Montgomery', 'Alabama', '36177', 2, '0000');
INSERT INTO Customer VALUES (32, 'Vale Caddan', '2137131356', '5 Kipling Trail', 'Los Angeles', 'California', '90087', 2, '0000');
INSERT INTO Customer VALUES (33, 'Jillane Reside', '9153085832', '40 Pepper Wood Lane', 'El Paso', 'Texas', '79950', 2, '0000');
INSERT INTO Customer VALUES (34, 'Hector Ravens', '5156712030', '664 Mallory Junction', 'Des Moines', 'Iowa', '50981', 2, '0000');
INSERT INTO Customer VALUES (35, 'Bram Stucksbury', '2121429844', '491 Vahlen Avenue', 'New York City', 'New York', '10275', 2, '0000');
INSERT INTO Customer VALUES (36, 'Harper Husher', '5047568413', '0666 Sage Center', 'New Orleans', 'Louisiana', '70179', 2, '0000');
INSERT INTO Customer VALUES (37, 'Odell Putten', '4106054779', '33 Straubel Trail', 'Baltimore', 'Maryland', '21282', 2, '0000');
INSERT INTO Customer VALUES (38, 'Cassaundra Attril', '3058140896', '5 Sutteridge Drive', 'Miami', 'Florida', '33261', 2, '0000');
INSERT INTO Customer VALUES (39, 'Kelsy Broady', '2031351567', '114 Garrison Plaza', 'Fairfield', 'Connecticut', '06825', 2, '0000');
INSERT INTO Customer VALUES (40, 'Waiter Gorke', '9715109274', '43 Hoard Point', 'Portland', 'Oregon', '97229', 2, '0000');
INSERT INTO Customer VALUES (41, 'Forest Bellard', '2177994172', '1024 Lerdahl Crossing', 'Springfield', 'Illinois', '62705', 2, '0000');
INSERT INTO Customer VALUES (42, 'Agace Calabry', '8561173140', '4753 Johnson Road', 'Camden', 'New Jersey', '08104', 2, '0000');
INSERT INTO Customer VALUES (43, 'Abelard Lentsch', '9015826513', '32 Di Loreto Plaza', 'Memphis', 'Tennessee', '38109', 2, '0000');
INSERT INTO Customer VALUES (44, 'Eyde Hawse', '3349418951', '76 Towne Pass', 'Montgomery', 'Alabama', '36109', 2, '0000');
INSERT INTO Customer VALUES (45, 'Tuck Barton', '9164803358', '5052 Bultman Lane', 'Sacramento', 'California', '94280', 2, '0000');
INSERT INTO Customer VALUES (46, 'Allene Mechic', '9547089930', '57 Bluejay Pass', 'Fort Lauderdale', 'Florida', '33325', 2, '0000');
INSERT INTO Customer VALUES (47, 'Teresita Impey', '3526114198', '9138 Pawling Avenue', 'Gainesville', 'Florida', '32627', 2, '0000');
INSERT INTO Customer VALUES (48, 'Jacquelynn Farrimond', '8647698143', '9887 Longview Street', 'Greenville', 'South Carolina', '29615', 2, '0000');
INSERT INTO Customer VALUES (49, 'Meggi Edwicke', '7132942765', '76973 Messerschmidt Way', 'Houston', 'Texas', '77223', 2, '0000');
INSERT INTO Customer VALUES (50, 'Daren Robelow', '4359425242', '5050 Mandrake Crossing', 'Salt Lake City', 'Utah', '84105', 2, '0000');
INSERT INTO Customer VALUES (51, 'Cody Myerscough', '5402012359', '8478 Gale Crossing', 'Roanoke', 'Virginia', '24024', 2, '0000');
INSERT INTO Customer VALUES (52, 'Nariko Edgell', '3104925294', '60 Onsgard Alley', 'Los Angeles', 'California', '90035', 2, '0000');
INSERT INTO Customer VALUES (53, 'Cirilo Duddan', '9714679953', '192 Delladonna Place', 'Portland', 'Oregon', '97271', 2, '0000');
INSERT INTO Customer VALUES (54, 'Lula Cokely', '3237246027', '94244 Kropf Trail', 'Los Angeles', 'California', '90076', 2, '0000');
INSERT INTO Customer VALUES (55, 'Cris Bridgwood', '3141222919', '999 Burning Wood Way', 'Saint Louis', 'Missouri', '63136', 2, '0000');
INSERT INTO Customer VALUES (56, 'Hedwig Crossdale', '3139719699', '503 Tony Park', 'Detroit', 'Michigan', '48217', 2, '0000');
INSERT INTO Customer VALUES (57, 'Loydie Jowitt', '2024428154', '88415 Elmside Parkway', 'Washington', 'District of Columbia', '20566', 2, '0000');
INSERT INTO Customer VALUES (58, 'Amber Golsthorp', '4059182273', '62 Mayfield Parkway', 'Norman', 'Oklahoma', '73071', 2, '0000');
INSERT INTO Customer VALUES (59, 'Alene Koch', '2066835726', '287 Russell Crossing', 'Seattle', 'Washington', '98158', 2, '0000');
INSERT INTO Customer VALUES (60, 'Jodie Caizley', '9413949731', '10 Pepper Wood Circle', 'Orlando', 'Florida', '32819', 2, '0000');
INSERT INTO Customer VALUES (61, 'Merilyn Pleming', '2604244454', '02 Gina Court', 'Fort Wayne', 'Indiana', '46867', 2, '0000');
INSERT INTO Customer VALUES (62, 'Quinta Lantuff', '3233485777', '705 Saint Paul Park', 'North Hollywood', 'California', '91606', 2, '0000');
INSERT INTO Customer VALUES (63, 'Evanne Couvet', '8141647544', '11 Acker Court', 'Erie', 'Pennsylvania', '16510', 2, '0000');
INSERT INTO Customer VALUES (64, 'Ainslee Linny', '9072047409', '47305 Spenser Drive', 'Anchorage', 'Alaska', '99517', 2, '0000');
INSERT INTO Customer VALUES (65, 'Turner Hollerin', '7655644585', '8 Di Loreto Plaza', 'Crawfordsville', 'Indiana', '47937', 2, '0000');
INSERT INTO Customer VALUES (66, 'Roseanne Gellibrand', '6465179868', '1 Florence Park', 'New York City', 'New York', '10045', 2, '0000');
INSERT INTO Customer VALUES (67, 'Theda Pratten', '2023578474', '83872 Springs Point', 'Washington', 'District of Columbia', '20430', 2, '0000');
INSERT INTO Customer VALUES (68, 'August Rambaut', '4027710433', '63953 Esch Point', 'Omaha', 'Nebraska', '68117', 2, '0000');
INSERT INTO Customer VALUES (69, 'Margret Cominetti', '6157633144', '7829 Prairieview Pass', 'Nashville', 'Tennessee', '37245', 2, '0000');
INSERT INTO Customer VALUES (70, 'Doris Teece', '3105764661', '0738 Fairfield Drive', 'Inglewood', 'California', '90398', 2, '0000');
INSERT INTO Customer VALUES (71, 'Vonny MacKall', '9723940137', '549 Maple Wood Drive', 'Dallas', 'Texas', '75246', 2, '0000');
INSERT INTO Customer VALUES (72, 'Christean Reubens', '5012587446', '363 Fairview Hill', 'North Little Rock', 'Arkansas', '72199', 2, '0000');
INSERT INTO Customer VALUES (73, 'Herbert Gipp', '8174559579', '9 Vermont Circle', 'Fort Worth', 'Texas', '76121', 2, '0000');
INSERT INTO Customer VALUES (74, 'Caitlin Rollings', '7725816615', '4024 Dwight Junction', 'Vero Beach', 'Florida', '32964', 2, '0000');
INSERT INTO Customer VALUES (75, 'Fina Cobbledick', '7852530582', '789 Nancy Way', 'Topeka', 'Kansas', '66629', 2, '0000');
INSERT INTO Customer VALUES (76, 'Loretta Duffie', '2027999593', '83702 Carey Terrace', 'Washington', 'District of Columbia', '20078', 2, '0000');
INSERT INTO Customer VALUES (77, 'Ethelin Heeley', '3363803989', '08 Superior Pass', 'Winston Salem', 'North Carolina', '27150', 2, '0000');
INSERT INTO Customer VALUES (78, 'Orin Elford', '8131036465', '47 Dwight Road', 'Tampa', 'Florida', '33686', 2, '0000');
INSERT INTO Customer VALUES (79, 'Daron Mosco', '6262497751', '586 Starling Street', 'Whittier', 'California', '90605', 2, '0000');
INSERT INTO Customer VALUES (80, 'Kareem Hirth', '5039615317', '24 Golf Way', 'Portland', 'Oregon', '97216', 2, '0000');
INSERT INTO Customer VALUES (81, 'Mylo Parkins', '2564558631', '745 Meadow Valley Pass', 'Gadsden', 'Alabama', '35905', 2, '0000');
INSERT INTO Customer VALUES (82, 'Bartie Etock', '8014384539', '57 Melvin Hill', 'Salt Lake City', 'Utah', '84140', 2, '0000');
INSERT INTO Customer VALUES (83, 'Anatola Monk', '5203034685', '5034 Thackeray Crossing', 'Tucson', 'Arizona', '85725', 2, '0000');
INSERT INTO Customer VALUES (84, 'Blinnie Robez', '7132327934', '355 Holmberg Pass', 'Pasadena', 'Texas', '77505', 2, '0000');
INSERT INTO Customer VALUES (85, 'Hannie Kondratowicz', '4198587992', '4732 Delaware Crossing', 'Toledo', 'Ohio', '43615', 2, '0000');
INSERT INTO Customer VALUES (86, 'Elladine Perell', '2129931211', '0729 Ridge Oak Crossing', 'New York City', 'New York', '10280', 2, '0000');
INSERT INTO Customer VALUES (87, 'Sergent Reason', '9199708119', '0780 Union Place', 'Raleigh', 'North Carolina', '27621', 2, '0000');
INSERT INTO Customer VALUES (88, 'Caril Atcock', '2812940627', '586 Pennsylvania Crossing', 'Humble', 'Texas', '77346', 2, '0000');
INSERT INTO Customer VALUES (89, 'Aubert Fevers', '9255160782', '49126 Riverside Drive', 'Concord', 'California', '94522', 2, '0000');
INSERT INTO Customer VALUES (90, 'William Hambleton', '2026315933', '4 Gulseth Avenue', 'Washington', 'District of Columbia', '20591', 2, '0000');
INSERT INTO Customer VALUES (91, 'Thea Dudny', '4127269601', '6 Kings Crossing', 'Pittsburgh', 'Pennsylvania', '15235', 2, '0000');
INSERT INTO Customer VALUES (92, 'Rogerio Curwood', '2146756390', '1 Sutherland Street', 'Dallas', 'Texas', '75277', 2, '0000');
INSERT INTO Customer VALUES (93, 'Olympie Dunbobbin', '2121385535', '32064 Cherokee Crossing', 'New York City', 'New York', '10203', 2, '0000');
INSERT INTO Customer VALUES (94, 'Alicea Attlee', '8083315354', '46050 Warrior Point', 'Honolulu', 'Hawaii', '96815', 2, '0000');
INSERT INTO Customer VALUES (95, 'Miguel Maginot', '5044608343', '1956 Sycamore Street', 'New Orleans', 'Louisiana', '70160', 2, '0000');
INSERT INTO Customer VALUES (96, 'Livvyy Heavens', '5861789575', '92087 Dryden Place', 'Detroit', 'Michigan', '48224', 2, '0000');
INSERT INTO Customer VALUES (97, 'Vince Jumel', '6011847180', '69776 Carpenter Hill', 'Jackson', 'Mississippi', '39204', 2, '0000');
INSERT INTO Customer VALUES (98, 'Kori Spraggon', '4156997979', '5823 Di Loreto Road', 'Oakland', 'California', '94616', 2, '0000');
INSERT INTO Customer VALUES (99, 'Prue Hardey', '6017174030', '140 Dayton Parkway', 'Jackson', 'Mississippi', '39216', 2, '0000');
INSERT INTO Customer VALUES (100, 'Daryl Straine', '8186417827', '28 Almo Alley', 'North Hollywood', 'California', '91606', 2, '0000');


INSERT INTO Cart VALUES (25,10,2,11,0,0);
INSERT INTO Cart VALUES (37,15,1,60,0,0);
INSERT INTO Cart VALUES (27,32,1,41,0,0);
INSERT INTO Cart VALUES (3,15,4,96,0,0);
INSERT INTO Cart VALUES (19,36,2,67,0,0);
INSERT INTO Cart VALUES (30,10,2,63,0,0);
INSERT INTO Cart VALUES (5,3,1,95,0,0);
INSERT INTO Cart VALUES (43,11,3,40,0,0);
INSERT INTO Cart VALUES (5,4,5,51,0,0);
INSERT INTO Cart VALUES (22,13,3,58,0,0);
INSERT INTO Cart VALUES (27,32,3,96,0,0);
INSERT INTO Cart VALUES (34,19,4,82,0,0);
INSERT INTO Cart VALUES (18,2,4,57,0,0);
INSERT INTO Cart VALUES (11,36,2,20,0,0);
INSERT INTO Cart VALUES (17,31,4,88,0,0);
INSERT INTO Cart VALUES (12,28,5,3,0,0);
INSERT INTO Cart VALUES (33,35,1,94,0,0);
INSERT INTO Cart VALUES (35,1,5,62,0,0);
INSERT INTO Cart VALUES (8,30,2,14,0,0);
INSERT INTO Cart VALUES (11,36,2,6,0,0);
INSERT INTO Cart VALUES (10,28,4,27,0,0);
INSERT INTO Cart VALUES (33,16,2,18,0,0);
INSERT INTO Cart VALUES (18,15,3,60,0,0);
INSERT INTO Cart VALUES (43,28,3,85,0,0);
INSERT INTO Cart VALUES (25,19,4,40,0,0);
INSERT INTO Cart VALUES (41,24,3,37,0,0);
INSERT INTO Cart VALUES (25,6,3,80,0,0);
INSERT INTO Cart VALUES (14,6,1,1,0,0);
INSERT INTO Cart VALUES (37,4,4,39,0,0);
INSERT INTO Cart VALUES (49,3,3,85,0,0);
INSERT INTO Cart VALUES (31,20,2,59,0,0);
INSERT INTO Cart VALUES (4,26,3,18,0,0);
INSERT INTO Cart VALUES (28,15,3,42,0,0);
INSERT INTO Cart VALUES (5,18,4,76,0,0);
INSERT INTO Cart VALUES (39,9,4,94,0,0);
INSERT INTO Cart VALUES (18,31,5,24,0,0);
INSERT INTO Cart VALUES (22,22,4,41,0,0);
INSERT INTO Cart VALUES (26,4,2,53,0,0);
INSERT INTO Cart VALUES (43,23,5,73,0,0);
INSERT INTO Cart VALUES (47,27,5,12,0,0);
INSERT INTO Cart VALUES (13,12,1,77,0,0);
INSERT INTO Cart VALUES (6,38,4,51,0,0);
INSERT INTO Cart VALUES (15,27,2,23,0,0);
INSERT INTO Cart VALUES (49,34,4,67,0,0);
INSERT INTO Cart VALUES (26,14,5,24,0,0);
INSERT INTO Cart VALUES (43,22,4,95,0,0);
INSERT INTO Cart VALUES (43,29,4,27,0,0);
INSERT INTO Cart VALUES (36,21,4,96,0,0);
INSERT INTO Cart VALUES (11,24,2,29,0,0);
INSERT INTO Cart VALUES (24,7,1,24,0,0);
INSERT INTO Cart VALUES (42,8,4,9,0,0);
INSERT INTO Cart VALUES (6,38,1,13,0,0);
INSERT INTO Cart VALUES (5,35,3,49,0,0);
INSERT INTO Cart VALUES (30,13,3,46,0,0);
INSERT INTO Cart VALUES (42,16,4,9,0,0);
INSERT INTO Cart VALUES (38,17,3,26,0,0);
INSERT INTO Cart VALUES (29,8,3,70,0,0);
INSERT INTO Cart VALUES (31,13,3,75,0,0);
INSERT INTO Cart VALUES (36,32,1,68,0,0);
INSERT INTO Cart VALUES (22,37,2,92,0,0);
INSERT INTO Cart VALUES (23,37,4,27,0,0);
INSERT INTO Cart VALUES (38,24,3,13,0,0);
INSERT INTO Cart VALUES (49,15,1,11,0,0);
INSERT INTO Cart VALUES (19,22,3,35,0,0);
INSERT INTO Cart VALUES (19,3,3,14,0,0);
INSERT INTO Cart VALUES (32,11,5,88,0,0);
INSERT INTO Cart VALUES (47,18,1,40,0,0);
INSERT INTO Cart VALUES (50,37,2,6,0,0);
INSERT INTO Cart VALUES (32,19,1,48,0,0);
INSERT INTO Cart VALUES (13,2,4,1,0,0);
INSERT INTO Cart VALUES (26,14,3,67,0,0);
INSERT INTO Cart VALUES (38,22,3,94,0,0);
INSERT INTO Cart VALUES (21,1,2,48,0,0);
INSERT INTO Cart VALUES (30,3,2,55,0,0);
INSERT INTO Cart VALUES (19,30,4,14,0,0);
INSERT INTO Cart VALUES (5,15,5,39,0,0);
INSERT INTO Cart VALUES (31,37,4,80,0,0);
INSERT INTO Cart VALUES (32,7,1,68,0,0);
INSERT INTO Cart VALUES (47,8,5,53,0,0);
INSERT INTO Cart VALUES (28,34,2,100,0,0);
INSERT INTO Cart VALUES (10,34,1,17,0,0);
INSERT INTO Cart VALUES (4,6,2,42,0,0);
INSERT INTO Cart VALUES (5,34,3,56,0,0);
INSERT INTO Cart VALUES (15,14,4,93,0,0);
INSERT INTO Cart VALUES (43,37,4,20,0,0);
INSERT INTO Cart VALUES (13,6,1,75,0,0);
INSERT INTO Cart VALUES (20,5,4,62,0,0);
INSERT INTO Cart VALUES (39,15,3,39,0,0);
INSERT INTO Cart VALUES (32,36,5,21,0,0);
INSERT INTO Cart VALUES (46,1,3,1,0,0);
INSERT INTO Cart VALUES (27,9,2,38,0,0);
INSERT INTO Cart VALUES (6,17,4,76,0,0);
INSERT INTO Cart VALUES (10,4,4,95,0,0);
INSERT INTO Cart VALUES (22,8,3,56,0,0);
INSERT INTO Cart VALUES (39,22,4,84,0,0);
INSERT INTO Cart VALUES (11,30,3,81,0,0);
INSERT INTO Cart VALUES (31,29,4,12,0,0);
INSERT INTO Cart VALUES (33,13,4,55,0,0);
INSERT INTO Cart VALUES (11,33,1,71,0,0);
INSERT INTO Cart VALUES (24,22,2,64,0,0);
INSERT INTO Cart VALUES (1, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (2, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (3, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (4, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (5, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (6, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (7, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (8, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (9, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (10, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (11, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (12, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (13, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (14, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (15, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (16, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (17, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (18, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (19, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (20, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (21, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (22, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (23, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (24, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (25, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (26, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (27, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (28, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (29, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (30, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (31, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (32, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (33, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (34, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (35, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (36, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (37, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (38, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (39, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (40, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (41, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (42, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (43, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (44, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (45, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (46, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (47, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (48, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (49, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (50, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (51, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (52, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (53, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (54, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (55, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (56, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (57, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (58, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (59, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (60, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (61, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (62, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (63, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (64, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (65, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (66, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (67, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (68, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (69, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (70, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (71, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (72, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (73, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (74, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (75, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (76, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (77, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (78, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (79, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (80, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (81, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (82, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (83, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (84, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (85, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (86, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (87, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (88, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (89, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (90, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (91, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (92, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (93, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (94, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (95, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (96, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (97, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (98, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (99, -1, 0, 0, 0,0);
INSERT INTO Cart VALUES (100, -1, 0, 0, 0,0);
        
INSERT INTO `Payment` VALUES (1, 1, 'Card', 0);
INSERT INTO `Payment` VALUES (2, 2, 'Wallet', 0);
INSERT INTO `Payment` VALUES (3, 3, 'Card', 0);
INSERT INTO `Payment` VALUES (4, 4, 'Wallet', 0);
INSERT INTO `Payment` VALUES (5, 5, 'Wallet',0);
INSERT INTO `Payment` VALUES (6, 6, 'Card', 0);
INSERT INTO `Payment` VALUES (7, 7, 'Card', 0);
INSERT INTO `Payment` VALUES (8, 8, 'Wallet', 0);
INSERT INTO `Payment` VALUES (9, 9, 'Card', 0);
INSERT INTO `Payment` VALUES (10, 10, 'Wallet', 0);
INSERT INTO `Payment` VALUES (11, 11, 'Wallet',0);
INSERT INTO `Payment` VALUES (12, 12, 'Card', 0);
INSERT INTO `Payment` VALUES (13, 13, 'Card', 0);
INSERT INTO `Payment` VALUES (14, 14, 'Card', 0);
INSERT INTO `Payment` VALUES (15, 15, 'Wallet', 0);
INSERT INTO `Payment` VALUES (16, 16, 'Card', 0);
INSERT INTO `Payment` VALUES (17, 17, 'Wallet', 0);
INSERT INTO `Payment` VALUES (18, 18, 'Wallet', 0);
INSERT INTO `Payment` VALUES (19, 19, 'Wallet', 0);
INSERT INTO `Payment` VALUES (20, 20, 'Wallet', 0);
INSERT INTO `Payment` VALUES (21, 21, 'Card', 0);
INSERT INTO `Payment` VALUES (22, 22, 'Card', 0);
INSERT INTO `Payment` VALUES (23, 23, 'Card', 0);
INSERT INTO `Payment` VALUES (24, 24, 'Card',0);
INSERT INTO `Payment` VALUES (25, 25, 'Wallet', 0);
INSERT INTO `Payment` VALUES (26, 26, 'Card', 0);
INSERT INTO `Payment` VALUES (27, 27, 'Card',0);
INSERT INTO `Payment` VALUES (28, 28, 'Card',0);
INSERT INTO `Payment` VALUES (29, 29, 'Card', 0);
INSERT INTO `Payment` VALUES (30, 30, 'Card', 0);
INSERT INTO `Payment` VALUES (31, 31, 'Card', 0);
INSERT INTO `Payment` VALUES (32, 32, 'Card',0);
INSERT INTO `Payment` VALUES (33, 33, 'Wallet', 0);
INSERT INTO `Payment` VALUES (34, 34, 'Wallet',0);
INSERT INTO `Payment` VALUES (35, 35, 'Card', 0);
INSERT INTO `Payment` VALUES (36, 36, 'Card', 0);
INSERT INTO `Payment` VALUES (37, 37, 'Card', 0);
INSERT INTO `Payment` VALUES (38, 38, 'Card', 0);
INSERT INTO `Payment` VALUES (39, 39, 'Wallet', 0);
INSERT INTO `Payment` VALUES (40, 40, 'Wallet', 0);
INSERT INTO `Payment` VALUES (41, 41, 'Card', 0);
INSERT INTO `Payment` VALUES (42, 42, 'Card', 0);
INSERT INTO `Payment` VALUES (43, 43, 'Card', 0);
INSERT INTO `Payment` VALUES (44, 44, 'Card', 0);
INSERT INTO `Payment` VALUES (45, 45, 'Wallet', 0);
INSERT INTO `Payment` VALUES (46, 46, 'Card',0);
INSERT INTO `Payment` VALUES (47, 47, 'Wallet', 0);
INSERT INTO `Payment` VALUES (48, 48, 'Card', 0);
INSERT INTO `Payment` VALUES (49, 49, 'Card', 0);
INSERT INTO `Payment` VALUES (50, 50, 'Wallet', 0);
INSERT INTO `Payment` VALUES (51, 51, 'Wallet',0);
INSERT INTO `Payment` VALUES (52, 52, 'Card', 0);
INSERT INTO `Payment` VALUES (53, 53, 'Card', 0);
INSERT INTO `Payment` VALUES (54, 54, 'Card',0);
INSERT INTO `Payment` VALUES (55, 55, 'Card', 0);
INSERT INTO `Payment` VALUES (56, 56, 'Wallet', 0);
INSERT INTO `Payment` VALUES (57, 57, 'Card', 0);
INSERT INTO `Payment` VALUES (58, 58, 'Card', 0);
INSERT INTO `Payment` VALUES (59, 59, 'Card', 0);
INSERT INTO `Payment` VALUES (60, 60, 'Wallet', 0);
INSERT INTO `Payment` VALUES (61, 61, 'Card', 0);
INSERT INTO `Payment` VALUES (62, 62, 'Card', 0);
INSERT INTO `Payment` VALUES (63, 63, 'Card', 0);
INSERT INTO `Payment` VALUES (64, 64, 'Card', 0);
INSERT INTO `Payment` VALUES (65, 65, 'Wallet', 0);
INSERT INTO `Payment` VALUES (66, 66, 'Card',0);
INSERT INTO `Payment` VALUES (67, 67, 'Wallet', 0);
INSERT INTO `Payment` VALUES (68, 68, 'Card', 0);
INSERT INTO `Payment` VALUES (69, 69, 'Card',0);
INSERT INTO `Payment` VALUES (70, 70, 'Card', 0);
INSERT INTO `Payment` VALUES (71, 71, 'Card',0);
INSERT INTO `Payment` VALUES (72, 72, 'Card', 0);
INSERT INTO `Payment` VALUES (73, 73, 'Card', 0);
INSERT INTO `Payment` VALUES (74, 74, 'Wallet', 0);
INSERT INTO `Payment` VALUES (75, 75, 'Card', 0);
INSERT INTO `Payment` VALUES (76, 76, 'Card',0);
INSERT INTO `Payment` VALUES (77, 77, 'Wallet', 0);
INSERT INTO `Payment` VALUES (78, 78, 'Wallet', 0);
INSERT INTO `Payment` VALUES (79, 79, 'Card', 0);
INSERT INTO `Payment` VALUES (80, 80, 'Card', 0);
INSERT INTO `Payment` VALUES (81, 81, 'Wallet', 0);
INSERT INTO `Payment` VALUES (82, 82, 'Card', 0);
INSERT INTO `Payment` VALUES (83, 83, 'Card', 0);
INSERT INTO `Payment` VALUES (84, 84, 'Card', 0);
INSERT INTO `Payment` VALUES (85, 85, 'Card',0);
INSERT INTO `Payment` VALUES (86, 86, 'Card', 0);
INSERT INTO `Payment` VALUES (87, 87, 'Wallet',0);
INSERT INTO `Payment` VALUES (88, 88, 'Card', 0);
INSERT INTO `Payment` VALUES (89, 89, 'Card', 0);
INSERT INTO `Payment` VALUES (90, 90, 'Card', 0);
INSERT INTO `Payment` VALUES (91, 91, 'Card', 0);
INSERT INTO `Payment` VALUES (92, 92, 'Wallet', 0);
INSERT INTO `Payment` VALUES (93, 93, 'Card', 0);
INSERT INTO `Payment` VALUES (94, 94, 'Wallet',0);
INSERT INTO `Payment` VALUES (95, 95, 'Wallet', 0);
INSERT INTO `Payment` VALUES (96, 96, 'Card', 0);
INSERT INTO `Payment` VALUES (97, 97, 'Card', 0);
INSERT INTO `Payment` VALUES (98, 98, 'Wallet', 0);
INSERT INTO `Payment` VALUES (99, 99, 'Wallet', 0);
INSERT INTO `Payment` VALUES (100, 100, 'Wallet', 0);

INSERT INTO Delivery VALUES (1, 1, 'Sauveur Hayworth', '9198597698', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (2, 2, 'Brady Nutley', '4325999337', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (3, 3, 'Hannah Hercules', '7860074613', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (4, 4, 'Findley Alejandre', '6849108387', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (5, 5, 'Welsh Gohier', '6955331795', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (6, 6, 'Conn Hannabus', '6630059050', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (7, 7, 'Alonzo Hacket', '9818761596', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (8, 8, 'Nanni Grasner', '2140343727', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (9, 9, 'Eolanda Ruos', '4740570742', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (10, 10, 'Katti Maxfield', '7352377263', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (11, 11, 'Wilton Whymark', '2251086110', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (12, 12, 'Filmer Look', '9020075764', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (13, 13, 'Rebekkah Giottoi', '1402139187', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (14, 14, 'Frederick Chopy', '8438122795', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (15, 15, 'Kristofer Croad', '5270165716', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (16, 16, 'Sascha Franzonello', '3013016264', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (17, 17, 'Pren Petracco', '9876078186', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (18, 18, 'Hugibert Holme', '8390960036', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (19, 19, 'Vasili Hansford', '7510634016', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (20, 20, 'Zarah Houldcroft', '9046399001', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (21, 21, 'Bev Mac Geaney', '8884115701', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (22, 22, 'Wren Gason', '2346433039', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (23, 23, 'Chuck Rickert', '3943341259', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (24, 24, 'Myrlene Mityashin', '5062145902', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (25, 25, 'Lulu Trigwell', '1093314184', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (26, 26, 'Lavina Ivanikov', '6454341186', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (27, 27, 'Cyrill Vannini', '4763107895', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (28, 28, 'Nicko Tench', '3446773851', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (29, 29, 'Nil Gauvain', '4632632244', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (30, 30, 'Marchelle Sola', '1979897700', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (31, 31, 'Ethel Sabbin', '4647314219', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (32, 32, 'Link Bohills', '2281986942', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (33, 33, 'Consuelo Kubasek', '4069419306', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (34, 34, 'Ricky Jaukovic', '9039078122', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (35, 35, 'Vally Blackaller', '4339411094', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (36, 36, 'Phil Dorracott', '4172061028', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (37, 37, 'Clemmie Paolillo', '3134893797', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (38, 38, 'Marius Bundey', '4897547660', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (39, 39, 'Karly Taillant', '7999324418', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (40, 40, 'Brooke Baytrop', '8386084480', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (41, 41, 'Amelie Rofe', '8003214637', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (42, 42, 'Val Prewer', '9763059615', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (43, 43, 'Gaspar Dewes', '1086064712', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (44, 44, 'Ina Gilmore', '5602586202', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (45, 45, 'Ruthie Kardos', '0363100075', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (46, 46, 'Felizio Sunnucks', '8666997834', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (47, 47, 'Valenka Wybrew', '3616561124', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (48, 48, 'Mindy Antos', '0914410601', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (49, 49, 'Arvie Daymond', '1336281952', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (50, 50, 'Yovonnda Delooze', '6938847827', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (51, 51, 'Adrea Wakeman', '1499907575', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (52, 52, 'Jorge Astbury', '0696601753', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (53, 53, 'Violet Eliyahu', '7587970673', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (54, 54, 'Murray Garnett', '9835293600', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (55, 55, 'Giff Chapling', '6275235039', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (56, 56, 'Etti Clyburn', '2555051546', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (57, 57, 'Ayn Lewin', '8822163095', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (58, 58, 'Kellsie Merrgan', '8030449925', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (59, 59, 'Legra Torr', '4512673903', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (60, 60, 'Douglas Honacker', '2539399266', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (61, 61, 'Gibbie Sporgeon', '0309077443', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (62, 62, 'Joscelin Ryles', '0432684972', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (63, 63, 'Kipp Strognell', '5024605829', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (64, 64, 'Gayle Arnaut', '2958196267', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (65, 65, 'Nadean Bassill', '6090348341', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (66, 66, 'Yetta Donisi', '1247663868', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (67, 67, 'Sula Kuhnwald', '3798790922', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (68, 68, 'Kerwin Worsnap', '3370381192', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (69, 69, 'Kimbra Heckner', '3930013681', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (70, 70, 'Allsun Flooks', '3181235539', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (71, 71, 'Almeta MacCahey', '0126894698', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (72, 72, 'Louie Taunton', '3662030470', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (73, 73, 'Davita Fitzroy', '5269318598', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (74, 74, 'Evonne Palmby', '2170089780', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (75, 75, 'Daniele Vivash', '9558879797', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (76, 76, 'Estelle Fiander', '9200545378', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (77, 77, 'Napoleon Hestrop', '0747265259', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (78, 78, 'Heriberto Risebo', '2369170026', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (79, 79, 'Cchaddie Van Baaren', '2696935467', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (80, 80, 'Merry Simone', '8008816899', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (81, 81, 'Ellwood Elsmore', '8469934201', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (82, 82, 'Richardo Hysom', '5912345785', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (83, 83, 'Cristine Ketchaside', '0401292282', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (84, 84, 'Deane Lathwood', '9550574563', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (85, 85, 'Debor Killingworth', '7962193379', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (86, 86, 'Shaylah Olyonov', '2158827378', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (87, 87, 'Willabella Childs', '4237578917', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (88, 88, 'Orelee Rapley', '4607955922', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (89, 89, 'Thebault Vidgen', '5039598122', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (90, 90, 'Joela Poundford', '6950830572', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (91, 91, 'Mic Brinded', '8201029461', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (92, 92, 'Hanna Brade', '6051108432', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (93, 93, 'Mella Merck', '6905099600', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (94, 94, 'Sergent MacNeilly', '0653749627', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (95, 95, 'Erasmus Ritchley', '3899422546', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (96, 96, 'Rozalin Blei', '2265934305', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (97, 97, 'Barbey Ambrosio', '5751825438', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (98, 98, 'Niall Milsap', '6663865544', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (99, 99, 'Darren Charle', '0071127631', 'Delivery by 7AM');
INSERT INTO Delivery VALUES (100, 100, 'Lita Strelitz', '4000869841', 'Delivery by 7AM');

-- UPDATE (Updation Query) and JOIN Queries -> No.1

UPDATE Cart
JOIN Product ON Product.Product_ID = Cart.Product_ID
SET Cart.Item_Total = Cart.Quantity*Product.Price,
	Cart.Grand_Total = Cart.Quantity*Product.Price + Cart.Delivery_Charges
WHERE Cart.Customer_ID > 0;

-- UPDATE Cart
-- JOIN Product ON Product.Product_ID = Cart.Product_ID
-- SET Cart.Grand_Total = Cart.Quantity*Product.Price + Cart.Delivery_Charges
-- WHERE Cart.Customer_ID > 0;
-- -----------------------------------

-- CREATE TABLE (Updation Query) And DROP TABLE (Deletion Query) Query -> No.2

CREATE TABLE Pay_Tracker AS
	SELECT Customer_ID, sum(Grand_Total) as Total
	FROM Cart
	GROUP BY Customer_ID;

UPDATE `Payment`
JOIN Pay_Tracker ON Payment.Customer_ID = Pay_Tracker.Customer_ID
SET Payment.Total_Amount = Pay_Tracker.Total
WHERE Payment.Payment_ID >0;

-- DROP TABLE Pay_Tracker;

-- -----------------------------------

-- INSERT INTO (Insertion Query), SELECT, FROM, WHERE Query -> No.3

INSERT INTO Delivery_Log (Customer_ID, Person_Name, Contact_Number, `Status`)
	SELECT Payment.Customer_ID, Person_Name, Contact_Number, `Status`
	FROM Delivery, Payment
	WHERE Payment.Total_Amount > 0 and Delivery.Customer_ID = Payment.Customer_ID;	

-- DROP TABLE Delivery;  

INSERT INTO `Order` (Customer_ID, Payment_ID, Delivery_ID)
	SELECT Customer_ID, Customer_ID, Delivery_ID
    FROM Delivery_Log;

-- ----------------------------------
CREATE TABLE All_Data AS
SELECT * 
FROM ((Cart natural join product) natural join product_category) natural join pay_tracker
Where Category_ID!=-1;

DROP TRIGGER IF EXISTS check_valid_cart;

delimiter //
CREATE TRIGGER check_valid_cart
BEFORE DELETE ON Customer
FOR EACH ROW
BEGIN
DELETE FROM Cart WHERE Customer_ID = OLD.Customer_ID;
END //

-- SELECT * FROM Cart WHERE Customer_ID = 50;
-- DELETE FROM Customer WHERE Customer_ID = 50;
-- SELECT * FROM Cart WHERE Customer_ID = 50;

DROP TRIGGER IF EXISTS check_valid_product;

delimiter //
CREATE TRIGGER check_valid_product
BEFORE DELETE ON Product_Category
FOR EACH ROW
BEGIN
DELETE FROM Product WHERE Category_ID = OLD.Category_ID;
END //

-- SELECT * FROM Product WHERE Product_ID = 10;
-- DELETE FROM Product_Category WHERE Category_ID = 2;
-- SELECT * FROM Product WHERE Product_ID = 10;

DROP TRIGGER IF EXISTS check_cart_existence;

delimiter //
CREATE TRIGGER check_cart_existence -- CHECKKKKKKK
AFTER INSERT ON Customer
FOR EACH ROW
BEGIN
INSERT INTO Cart VALUES (NEW.Customer_ID, -1, 0, 0, 0, 0);
END //

-- SELECT * FROM Cart WHERE Customer_ID = 101;
-- SELECT * FROM Customer WHERE Customer_ID = 101;
-- INSERT INTO Customer VALUES (101, 'Rames', '9899197543', '1120 Antica Colony', 'Madison', 'Florida', 32219, 2);
-- SELECT * FROM Customer WHERE Customer_ID = 101;
-- SELECT * FROM Cart WHERE Customer_ID = 101;

-- OLAP Queries

-- Dicing Query
SELECT * FROM all_data
WHERE Customer_ID < 10 AND
Product_ID < 10 AND
Grand_Total < 500;	

-- INDEX Queries 
CREATE INDEX Customer_ID_index on Customer (Customer_ID);
CREATE INDEX Delivery_ID_index on Delivery_Log (Delivery_ID);
CREATE INDEX Payment_ID_index on `Payment`(Payment_ID);
CREATE INDEX Order_ID_index on `Order`(Order_ID); 