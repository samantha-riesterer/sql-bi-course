
-- ===================================================================
-- PART 1
-- ===================================================================

--TASK 1.1 (cont)

-- Insert Customers (50 customers)
INSERT INTO customers (first_name, last_name, email, phone, registration_date, city, state) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '2024-01-15', 'New York', 'NY'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '2024-01-18', 'Los Angeles', 'CA'),
('Michael', 'Brown', 'mbrown@email.com', '555-0103', '2024-01-22', 'Chicago', 'IL'),
('Emily', 'Davis', 'emily.davis@email.com', '555-0104', '2024-02-01', 'Houston', 'TX'),
('David', 'Wilson', 'dwilson@email.com', '555-0105', '2024-02-05', 'Phoenix', 'AZ'),
('Jessica', 'Miller', 'jmiller@email.com', '555-0106', '2024-02-10', 'Philadelphia', 'PA'),
('Christopher', 'Moore', 'cmoore@email.com', '555-0107', '2024-02-15', 'San Antonio', 'TX'),
('Amanda', 'Taylor', 'ataylor@email.com', '555-0108', '2024-02-20', 'San Diego', 'CA'),
('Matthew', 'Anderson', 'manderson@email.com', '555-0109', '2024-02-25', 'Dallas', 'TX'),
('Ashley', 'Thomas', 'athomas@email.com', '555-0110', '2024-03-01', 'San Jose', 'CA'),
('Anthony', 'Jackson', 'ajackson@email.com', '555-0111', '2024-03-05', 'Austin', 'TX'),
('Melissa', 'White', 'mwhite@email.com', '555-0112', '2024-03-10', 'Jacksonville', 'FL'),
('Joshua', 'Harris', 'jharris@email.com', '555-0113', '2024-03-15', 'Fort Worth', 'TX'),
('Stephanie', 'Martin', 'smartin@email.com', '555-0114', '2024-03-20', 'Columbus', 'OH'),
('Daniel', 'Garcia', 'dgarcia@email.com', '555-0115', '2024-03-25', 'Charlotte', 'NC'),
('Nicole', 'Martinez', 'nmartinez@email.com', '555-0116', '2024-04-01', 'San Francisco', 'CA'),
('Ryan', 'Robinson', 'rrobinson@email.com', '555-0117', '2024-04-05', 'Indianapolis', 'IN'),
('Jennifer', 'Clark', 'jclark@email.com', '555-0118', '2024-04-10', 'Seattle', 'WA'),
('Andrew', 'Rodriguez', 'arodriguez@email.com', '555-0119', '2024-04-15', 'Denver', 'CO'),
('Brittany', 'Lewis', 'blewis@email.com', '555-0120', '2024-04-20', 'Washington', 'DC'),
('Brandon', 'Lee', 'blee@email.com', '555-0121', '2024-04-25', 'Boston', 'MA'),
('Samantha', 'Walker', 'swalker@email.com', '555-0122', '2024-05-01', 'El Paso', 'TX'),
('Justin', 'Hall', 'jhall@email.com', '555-0123', '2024-05-05', 'Nashville', 'TN'),
('Rebecca', 'Allen', 'rallen@email.com', '555-0124', '2024-05-10', 'Detroit', 'MI'),
('Jason', 'Young', 'jyoung@email.com', '555-0125', '2024-05-15', 'Oklahoma City', 'OK'),
('Rachel', 'King', 'rking@email.com', '555-0126', '2024-05-20', 'Portland', 'OR'),
('Kevin', 'Wright', 'kwright@email.com', '555-0127', '2024-05-25', 'Las Vegas', 'NV'),
('Laura', 'Lopez', 'llopez@email.com', '555-0128', '2024-06-01', 'Louisville', 'KY'),
('Steven', 'Hill', 'shill@email.com', '555-0129', '2024-06-05', 'Baltimore', 'MD'),
('Michelle', 'Scott', 'mscott@email.com', '555-0130', '2024-06-10', 'Milwaukee', 'WI'),
('Timothy', 'Green', 'tgreen@email.com', '555-0131', '2024-06-15', 'Albuquerque', 'NM'),
('Kimberly', 'Adams', 'kadams@email.com', '555-0132', '2024-06-20', 'Tucson', 'AZ'),
('Brian', 'Baker', 'bbaker@email.com', '555-0133', '2024-06-25', 'Fresno', 'CA'),
('Angela', 'Gonzalez', 'agonzalez@email.com', '555-0134', '2024-07-01', 'Sacramento', 'CA'),
('Robert', 'Nelson', 'rnelson@email.com', '555-0135', '2024-07-05', 'Mesa', 'AZ'),
('Crystal', 'Carter', 'ccarter@email.com', '555-0136', '2024-07-10', 'Kansas City', 'MO'),
('Alexander', 'Mitchell', 'amitchell@email.com', '555-0137', '2024-07-15', 'Atlanta', 'GA'),
('Courtney', 'Perez', 'cperez@email.com', '555-0138', '2024-08-01', 'Colorado Springs', 'CO'),
('Gregory', 'Roberts', 'groberts@email.com', '555-0139', '2024-08-05', 'Raleigh', 'NC'),
('Lisa', 'Turner', 'lturner@email.com', '555-0140', '2024-08-10', 'Omaha', 'NE'),
('Patrick', 'Phillips', 'pphillips@email.com', '555-0141', '2024-08-15', 'Miami', 'FL'),
('Kelly', 'Campbell', 'kcampbell@email.com', '555-0142', '2024-08-20', 'Cleveland', 'OH'),
('Eric', 'Parker', 'eparker@email.com', '555-0143', '2024-08-25', 'Tulsa', 'OK'),
('Shannon', 'Evans', 'sevans@email.com', '555-0144', '2024-09-01', 'Oakland', 'CA'),
('Aaron', 'Edwards', 'aedwards@email.com', '555-0145', '2024-09-05', 'Minneapolis', 'MN'),
('Heather', 'Collins', 'hcollins@email.com', '555-0146', '2024-09-10', 'Wichita', 'KS'),
('Adam', 'Stewart', 'astewart@email.com', '555-0147', '2024-09-15', 'Arlington', 'TX'),
('Catherine', 'Sanchez', 'csanchez@email.com', '555-0148', '2024-09-20', 'New Orleans', 'LA'),
('Nathan', 'Morris', 'nmorris@email.com', '555-0149', '2024-09-25', 'Honolulu', 'HI'),
('Amy', 'Reed', 'areed@email.com', '555-0150', '2024-10-01', 'Tampa', 'FL');

-- Insert Products (30 products across electronics categories)
INSERT INTO products (product_name, category, brand, unit_price, cost_price, stock_quantity, created_date) VALUES
('iPhone 15 Pro', 'Smartphones', 'Apple', 999.00, 750.00, 25, '2024-01-01'),
('Samsung Galaxy S24', 'Smartphones', 'Samsung', 899.00, 680.00, 30, '2024-01-01'),
('Google Pixel 8', 'Smartphones', 'Google', 699.00, 520.00, 20, '2024-01-01'),
('OnePlus 12', 'Smartphones', 'OnePlus', 799.00, 600.00, 15, '2024-01-01'),
('MacBook Air M3', 'Laptops', 'Apple', 1299.00, 980.00, 12, '2024-01-01'),
('Dell XPS 13', 'Laptops', 'Dell', 1199.00, 900.00, 18, '2024-01-01'),
('Lenovo ThinkPad X1', 'Laptops', 'Lenovo', 1599.00, 1200.00, 10, '2024-01-01'),
('HP Spectre x360', 'Laptops', 'HP', 1399.00, 1050.00, 14, '2024-01-01'),
('iPad Air', 'Tablets', 'Apple', 599.00, 450.00, 22, '2024-01-01'),
('Samsung Galaxy Tab S9', 'Tablets', 'Samsung', 549.00, 410.00, 25, '2024-01-01'),
('Surface Pro 9', 'Tablets', 'Microsoft', 999.00, 750.00, 16, '2024-01-01'),
('AirPods Pro', 'Audio', 'Apple', 249.00, 180.00, 40, '2024-01-01'),
('Sony WH-1000XM5', 'Audio', 'Sony', 399.00, 290.00, 35, '2024-01-01'),
('Bose QuietComfort', 'Audio', 'Bose', 329.00, 240.00, 28, '2024-01-01'),
('JBL Flip 6', 'Audio', 'JBL', 129.00, 90.00, 50, '2024-01-01'),
('Apple Watch Series 9', 'Wearables', 'Apple', 399.00, 290.00, 30, '2024-01-01'),
('Samsung Galaxy Watch 6', 'Wearables', 'Samsung', 329.00, 240.00, 25, '2024-01-01'),
('Fitbit Charge 5', 'Wearables', 'Fitbit', 179.00, 130.00, 45, '2024-01-01'),
('Nintendo Switch OLED', 'Gaming', 'Nintendo', 349.00, 260.00, 20, '2024-01-01'),
('PlayStation 5', 'Gaming', 'Sony', 499.00, 380.00, 8, '2024-01-01'),
('Xbox Series X', 'Gaming', 'Microsoft', 499.00, 380.00, 10, '2024-01-01'),
('Logitech MX Master 3', 'Accessories', 'Logitech', 99.00, 70.00, 60, '2024-01-01'),
('Anker PowerCore 10000', 'Accessories', 'Anker', 29.99, 20.00, 80, '2024-01-01'),
('USB-C Hub', 'Accessories', 'Anker', 49.99, 35.00, 70, '2024-01-01'),
('Wireless Charger', 'Accessories', 'Belkin', 39.99, 28.00, 55, '2024-01-01'),
('4K Webcam', 'Accessories', 'Logitech', 199.00, 140.00, 25, '2024-01-01'),
('Mechanical Keyboard', 'Accessories', 'Corsair', 159.00, 110.00, 35, '2024-01-01'),
('Gaming Mouse', 'Accessories', 'Razer', 89.99, 60.00, 40, '2024-01-01'),
('Monitor Stand', 'Accessories', 'Amazon Basics', 79.99, 55.00, 30, '2024-01-01'),
('Phone Case', 'Accessories', 'OtterBox', 49.99, 30.00, 100, '2024-01-01');

-- Insert Orders (75 orders)
INSERT INTO orders (customer_id, order_date, total_amount, status, shipping_address, payment_method) VALUES
(1, '2024-02-01', 1299.00, 'completed', '123 Main St, New York, NY 10001', 'credit_card'),
(2, '2024-02-03', 948.00, 'completed', '456 Oak Ave, Los Angeles, CA 90210', 'paypal'),
(3, '2024-02-05', 249.00, 'completed', '789 Pine St, Chicago, IL 60601', 'credit_card'),
(4, '2024-02-07', 1598.00, 'completed', '321 Elm St, Houston, TX 77001', 'credit_card'),
(5, '2024-02-10', 399.00, 'completed', '654 Maple Dr, Phoenix, AZ 85001', 'debit_card'),
(6, '2024-02-12', 179.00, 'completed', '987 Cedar Ln, Philadelphia, PA 19101', 'credit_card'),
(7, '2024-02-15', 1199.00, 'completed', '147 Birch St, San Antonio, TX 78201', 'paypal'),
(8, '2024-02-18', 899.00, 'completed', '258 Spruce Ave, San Diego, CA 92101', 'credit_card'),
(9, '2024-02-20', 599.00, 'completed', '369 Walnut St, Dallas, TX 75201', 'credit_card'),
(10, '2024-02-22', 329.00, 'completed', '741 Hickory Dr, San Jose, CA 95101', 'paypal'),
(11, '2024-02-25', 699.00, 'completed', '852 Dogwood Ln, Austin, TX 78701', 'credit_card'),
(12, '2024-02-28', 999.00, 'completed', '963 Poplar St, Jacksonville, FL 32201', 'credit_card'),
(13, '2024-03-02', 549.00, 'completed', '159 Willow Ave, Fort Worth, TX 76101', 'debit_card'),
(14, '2024-03-05', 1399.00, 'completed', '267 Ash St, Columbus, OH 43201', 'credit_card'),
(15, '2024-03-08', 799.00, 'completed', '378 Cherry Dr, Charlotte, NC 28201', 'paypal'),
(16, '2024-03-10', 249.00, 'completed', '489 Peach Ln, San Francisco, CA 94101', 'credit_card'),
(17, '2024-03-12', 129.00, 'completed', '591 Plum St, Indianapolis, IN 46201', 'credit_card'),
(18, '2024-03-15', 999.00, 'completed', '612 Grape Ave, Seattle, WA 98101', 'paypal'),
(19, '2024-03-18', 349.00, 'completed', '723 Berry Dr, Denver, CO 80201', 'credit_card'),
(20, '2024-03-20', 399.00, 'completed', '834 Lime St, Washington, DC 20001', 'debit_card'),
(21, '2024-03-22', 499.00, 'completed', '945 Orange Ln, Boston, MA 02101', 'credit_card'),
(22, '2024-03-25', 159.00, 'completed', '156 Lemon Ave, El Paso, TX 79901', 'credit_card'),
(23, '2024-03-28', 89.99, 'completed', '267 Apple St, Nashville, TN 37201', 'paypal'),
(24, '2024-03-30', 599.00, 'completed', '378 Banana Dr, Detroit, MI 48201', 'credit_card'),
(25, '2024-04-02', 329.00, 'completed', '489 Coconut Ln, Oklahoma City, OK 73101', 'credit_card'),
(1, '2024-04-05', 79.99, 'completed', '123 Main St, New York, NY 10001', 'credit_card'),
(2, '2024-04-08', 199.00, 'completed', '456 Oak Ave, Los Angeles, CA 90210', 'paypal'),
(3, '2024-04-10', 49.99, 'completed', '789 Pine St, Chicago, IL 60601', 'credit_card'),
(26, '2024-04-12', 1299.00, 'completed', '591 Mango St, Portland, OR 97201', 'credit_card'),
(27, '2024-04-15', 899.00, 'completed', '612 Pear Ave, Las Vegas, NV 89101', 'debit_card'),
(28, '2024-04-18', 179.00, 'completed', '723 Kiwi Dr, Louisville, KY 40201', 'credit_card'),
(29, '2024-04-20', 999.00, 'completed', '834 Fig Ln, Baltimore, MD 21201', 'paypal'),
(30, '2024-04-22', 549.00, 'completed', '945 Date St, Milwaukee, WI 53201', 'credit_card'),
(4, '2024-04-25', 29.99, 'completed', '321 Elm St, Houston, TX 77001', 'credit_card'),
(5, '2024-04-28', 99.00, 'completed', '654 Maple Dr, Phoenix, AZ 85001', 'debit_card'),
(31, '2024-05-01', 699.00, 'completed', '156 Olive Ave, Albuquerque, NM 87101', 'credit_card'),
(32, '2024-05-03', 499.00, 'completed', '267 Mint St, Tucson, AZ 85701', 'credit_card'),
(33, '2024-05-05', 399.00, 'completed', '378 Sage Dr, Fresno, CA 93701', 'paypal'),
(34, '2024-05-08', 1599.00, 'completed', '489 Basil Ln, Sacramento, CA 95801', 'credit_card'),
(35, '2024-05-10', 249.00, 'completed', '591 Thyme St, Mesa, AZ 85201', 'debit_card'),
(6, '2024-05-12', 49.99, 'completed', '987 Cedar Ln, Philadelphia, PA 19101', 'credit_card'),
(7, '2024-05-15', 39.99, 'completed', '147 Birch St, San Antonio, TX 78201', 'paypal'),
(36, '2024-05-18', 329.00, 'completed', '612 Rosemary Ave, Kansas City, MO 64101', 'credit_card'),
(37, '2024-05-20', 129.00, 'completed', '723 Oregano Dr, Atlanta, GA 30301', 'credit_card'),
(38, '2024-05-22', 89.99, 'completed', '834 Parsley Ln, Colorado Springs, CO 80901', 'debit_card'),
(39, '2024-05-25', 999.00, 'completed', '945 Cilantro St, Raleigh, NC 27601', 'credit_card'),
(40, '2024-05-28', 799.00, 'completed', '156 Dill Ave, Omaha, NE 68101', 'paypal'),
(8, '2024-06-01', 599.00, 'completed', '258 Spruce Ave, San Diego, CA 92101', 'credit_card'),
(9, '2024-06-03', 349.00, 'completed', '369 Walnut St, Dallas, TX 75201', 'credit_card'),
(41, '2024-06-05', 179.00, 'completed', '267 Ginger Dr, Miami, FL 33101', 'debit_card'),
(42, '2024-06-08', 1399.00, 'completed', '378 Garlic Ln, Cleveland, OH 44101', 'credit_card'),
(43, '2024-06-10', 499.00, 'completed', '489 Chive St, Tulsa, OK 74101', 'paypal'),
(44, '2024-06-12', 299.00, 'completed', '591 Fennel Ave, Oakland, CA 94601', 'credit_card'),
(45, '2024-06-15', 699.00, 'completed', '612 Cumin Dr, Minneapolis, MN 55401', 'credit_card'),
(10, '2024-06-18', 29.99, 'completed', '741 Hickory Dr, San Jose, CA 95101', 'paypal'),
(11, '2024-06-20', 159.00, 'completed', '852 Dogwood Ln, Austin, TX 78701', 'credit_card'),
(46, '2024-06-22', 549.00, 'completed', '723 Paprika Ln, Wichita, KS 67201', 'debit_card'),
(47, '2024-06-25', 899.00, 'completed', '834 Curry St, Arlington, TX 76001', 'credit_card'),
(48, '2024-06-28', 249.00, 'completed', '945 Turmeric Ave, New Orleans, LA 70112', 'paypal'),
(12, '2024-07-01', 79.99, 'completed', '963 Poplar St, Jacksonville, FL 32201', 'credit_card'),
(13, '2024-07-03', 39.99, 'completed', '159 Willow Ave, Fort Worth, TX 76101', 'debit_card'),
(49, '2024-07-05', 999.00, 'completed', '156 Garam Dr, Honolulu, HI 96801', 'credit_card'),
(50, '2024-07-08', 1299.00, 'completed', '267 Masala St, Tampa, FL 33601', 'credit_card'),
(14, '2024-07-10', 99.00, 'completed', '267 Ash St, Columbus, OH 43201', 'paypal'),
(15, '2024-07-12', 129.00, 'completed', '378 Cherry Dr, Charlotte, NC 28201', 'credit_card'),
(16, '2024-07-15', 499.00, 'pending', '489 Peach Ln, San Francisco, CA 94101', 'credit_card'),
(17, '2024-07-16', 329.00, 'pending', '591 Plum St, Indianapolis, IN 46201', 'debit_card'),
(18, '2024-07-17', 179.00, 'pending', '612 Grape Ave, Seattle, WA 98101', 'paypal'),
(19, '2024-07-17', 89.99, 'pending', '723 Berry Dr, Denver, CO 80201', 'credit_card'),
(20, '2024-07-17', 49.99, 'pending', '834 Lime St, Washington, DC 20001', 'credit_card'),
(21, '2024-07-17', 199.00, 'pending', '945 Orange Ln, Boston, MA 02101', 'paypal'),
(22, '2024-07-17', 299.00, 'pending', '156 Lemon Ave, El Paso, TX 79901', 'credit_card'),
(23, '2024-07-17', 399.00, 'pending', '267 Apple St, Nashville, TN 37201', 'debit_card'),
(24, '2024-07-17', 699.00, 'pending', '378 Banana Dr, Detroit, MI 48201', 'credit_card'),
(25, '2024-07-17', 899.00, 'pending', '489 Coconut Ln, Oklahoma City, OK 73101', 'paypal');

-- Insert Order Items (corresponding to the orders above)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
(1, 5, 1, 1299.00, 1299.00),
(2, 2, 1, 899.00, 899.00), (2, 30, 1, 49.99, 49.99),
(3, 12, 1, 249.00, 249.00),
(4, 7, 1, 1599.00, 1599.00),
(5, 13, 1, 399.00, 399.00),
(6, 18, 1, 179.00, 179.00),
(7, 6, 1, 1199.00, 1199.00),
(8, 2, 1, 899.00, 899.00),
(9, 9, 1, 599.00, 599.00),
(10, 14, 1, 329.00, 329.00),
(11, 3, 1, 699.00, 699.00),
(12, 1, 1, 999.00, 999.00),
(13, 10, 1, 549.00, 549.00),
(14, 8, 1, 1399.00, 1399.00),
(15, 4, 1, 799.00, 799.00),
(16, 12, 1, 249.00, 249.00),
(17, 15, 1, 129.00, 129.00),
(18, 11, 1, 999.00, 999.00),
(19, 19, 1, 349.00, 349.00),
(20, 16, 1, 399.00, 399.00),
(21, 20, 1, 499.00, 499.00),
(22, 27, 1, 159.00, 159.00),
(23, 28, 1, 89.99, 89.99),
(24, 9, 1, 599.00, 599.00),
(25, 17, 1, 329.00, 329.00),
(26, 29, 1, 79.99, 79.99),
(27, 26, 1, 199.00, 199.00),
(28, 30, 1, 49.99, 49.99),
(29, 5, 1, 1299.00, 1299.00),
(30, 2, 1, 899.00, 899.00),
(31, 18, 1, 179.00, 179.00),
(32, 1, 1, 999.00, 999.00),
(33, 10, 1, 549.00, 549.00),
(34, 23, 1, 29.99, 29.99),
(35, 22, 1, 99.00, 99.00),
(36, 3, 1, 699.00, 699.00),
(37, 21, 1, 499.00, 499.00),
(38, 13, 1, 399.00, 399.00),
(39, 7, 1, 1599.00, 1599.00),
(40, 12, 1, 249.00, 249.00),
(41, 25, 1, 39.99, 39.99), (41, 24, 1, 49.99, 49.99),
(42, 25, 1, 39.99, 39.99),
(43, 17, 1, 329.00, 329.00),
(44, 15, 1, 129.00, 129.00),
(45, 28, 1, 89.99, 89.99),
(46, 1, 1, 999.00, 999.00),
(47, 4, 1, 799.00, 799.00),
(48, 9, 1, 599.00, 599.00),
(49, 19, 1, 349.00, 349.00),
(50, 18, 1, 179.00, 179.00),
(51, 8, 1, 1399.00, 1399.00),
(52, 20, 1, 499.00, 499.00),
(53, 12, 1, 249.00, 249.00), (53, 24, 1, 49.99, 49.99),
(54, 3, 1, 699.00, 699.00),
(55, 23, 1, 29.99, 29.99),
(56, 27, 1, 159.00, 159.00),
(57, 10, 1, 549.00, 549.00),
(58, 2, 1, 899.00, 899.00),
(59, 12, 1, 249.00, 249.00),
(60, 29, 1, 79.99, 79.99),
(61, 25, 1, 39.99, 39.99),
(62, 1, 1, 999.00, 999.00),
(63, 5, 1, 1299.00, 1299.00),
(64, 22, 1, 99.00, 99.00),
(65, 15, 1, 129.00, 129.00),
(66, 21, 1, 499.00, 499.00),
(67, 17, 1, 329.00, 329.00),
(68, 18, 1, 179.00, 179.00),
(69, 28, 1, 89.99, 89.99),
(70, 30, 1, 49.99, 49.99),
(71, 26, 1, 199.00, 199.00),
(72, 14, 1, 329.00, 329.00), (72, 24, 1, 49.99, 49.99), (72, 23, 1, 29.99, 29.99),
(73, 16, 1, 399.00, 399.00),
(74, 3, 1, 699.00, 699.00),
(75, 2, 1, 899.00, 899.00);

--Verify data integrity

-- Check record counts
SELECT 'customers' as table_name, COUNT(*) as record_count FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;

-- Quick data preview
SELECT 'Sample Customers:' as info;
SELECT customer_id, first_name, last_name, city, state, registration_date 
FROM customers 
LIMIT 5;

SELECT 'Sample Products:' as info;
SELECT product_id, product_name, category, brand, unit_price 
FROM products 
LIMIT 5;

SELECT 'Sample Orders:' as info;
SELECT order_id, customer_id, order_date, total_amount, status 
FROM orders 
LIMIT 5;

-- TASK 1.2 DATA STRUCTURE
SELECT 
table_name, 
column_name, 
data_type, 
is_nullable
FROM information_schema.columns 
WHERE table_schema = 'public' 
ORDER BY table_name, ordinal_position; 

