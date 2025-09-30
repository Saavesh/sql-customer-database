-- sql/02_seed.sql
-- Reset data first, so this script can run without any errors
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `transaction`;
TRUNCATE TABLE call_traffic;
TRUNCATE TABLE cancellation;
TRUNCATE TABLE customer_plan;
TRUNCATE TABLE customer;
TRUNCATE TABLE plan;

SET FOREIGN_KEY_CHECKS = 1;

-- 1) Add 4 Customers
INSERT INTO customer (full_name, address, phone, email, birth_date)
VALUES
    ('Nelson Mandela',  '123 Cat St, Napa, CA',   '555-234-1234', 'n.mandela@emsn.com',   '1985-07-18'),
    ('Claudette Colvin','456 Dog Rd, Miami, FL',  '555-555-5678', 'c.colvin@kemail.com',  '1992-09-05'),
    ('Patrice Lumumba', '789 Croc St, Irvine, CA','555-555-9101', 'p.lumumba@inlook.com', '1975-07-02'),
    ('Ibrahim Traore',  '101 Wolf Rd, Boston, MA','555-555-1213', 'i.traore@ucloud.com',  '1988-03-14');

-- 2) Add 4 Plans
INSERT INTO plan (plan_type, plan_name, plan_duration_days, plan_cost, plan_features)
VALUES
    ('Individual', 'Simple',     90,  120.00, 'Unlimited calls and text, 10GB data'),
    ('Shared',     'Family',     180, 180.00, 'Unlimited calls and text, Shared 70GB, up to 4 lines'),
    ('Individual', 'Influencer', 180, 300.00, 'Unlimited calls and text, 70GB data'),
    ('Data Only',  'Data',       60,  100.00, 'No calls or text, Unlimited data');

-- 3) Add several Transactions for each customer
INSERT INTO `transaction` (transaction_type, transaction_date, transaction_amount, customer_id, plan_id)
VALUES
  -- Nelson (1,1)
    ('activation','2024-07-01 10:15:34',120.00,1,1),
    ('payment',   '2024-08-01 09:00:00',120.00,1,1),
    ('payment',   '2024-09-01 09:00:00',120.00,1,1),
    ('renewal',   '2024-10-01 09:00:00',120.00,1,1),
  -- Claudette (2,2)
    ('activation','2024-07-05 12:00:00',180.00,2,2),
    ('payment',   '2024-08-05 12:00:00',180.00,2,2),
    ('payment',   '2024-09-05 12:00:00',180.00,2,2),
    ('renewal',   '2024-10-05 12:00:00',180.00,2,2),
  -- Patrice (3,3)
    ('activation','2024-07-10 14:30:00',300.00,3,3),
    ('payment',   '2024-08-10 14:30:00', 99.99,3,3),
    ('payment',   '2024-09-10 14:30:00', 99.99,3,3),
    ('renewal',   '2024-10-10 14:30:00',300.00,3,3),
  -- Ibrahim (4,4)
    ('activation','2024-07-15 08:00:00',100.00,4,4),
    ('payment',   '2024-08-15 08:00:00', 39.99,4,4),
    ('payment',   '2024-09-15 08:00:00', 39.99,4,4),
    ('renewal',   '2024-10-15 08:00:00',100.00,4,4);

-- 4) Add several Calls for each customer
INSERT INTO call_traffic (call_start, call_end, call_type, call_cost, customer_id)
VALUES
  -- Nelson (1)
    ('2024-07-02 10:00:00','2024-07-02 10:05:00','local',         0.75, 1),
    ('2024-07-03 21:10:00','2024-07-03 21:25:00','international', 6.40, 1),
    ('2024-07-05 08:00:00','2024-07-05 08:03:00','national',      0.45, 1),
  -- Claudette (2)
    ('2024-07-06 12:10:00','2024-07-06 12:25:00','local',         0.90, 2),
    ('2024-07-08 20:00:00','2024-07-08 20:12:00','international', 5.25, 2),
    ('2024-07-10 14:00:00','2024-07-10 14:05:00','national',      0.60, 2),
  -- Patrice (3)
    ('2024-07-11 09:30:00','2024-07-11 09:42:00','local',         0.85, 3),
    ('2024-07-12 23:05:00','2024-07-12 23:40:00','international', 8.90, 3),
  -- Ibrahim (4)
    ('2024-07-16 18:00:00','2024-07-16 18:10:00','local',         1.10, 4),
    ('2024-07-18 07:45:00','2024-07-18 07:55:00','national',      0.80, 4);

-- 5) Add One cancellation for one customer
INSERT INTO cancellation (cancellation_date, cancellation_reason, customer_id)
VALUES ('2024-10-20', 'Switching providers', 2);

-- 6) Map customers to their chosen plan
INSERT INTO customer_plan (customer_id, plan_id)
VALUES
    (1,1), -- Nelson Mandela → Simple
    (2,2), -- Claudette Colvin → Family
    (3,3), -- Patrice Lumumba → Influencer
    (4,4); -- Ibrahim Traore → Data