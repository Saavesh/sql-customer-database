-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS customer_plan;
DROP TABLE IF EXISTS call_traffic;
DROP TABLE IF EXISTS cancellation;
DROP TABLE IF EXISTS `transaction`;
DROP TABLE IF EXISTS plan;
DROP TABLE IF EXISTS customer;


-- CUSTOMER TABLE -- Customers table created before others due to foreign key dependencies
CREATE TABLE customer (
    customer_id    INT          NOT NULL   AUTO_INCREMENT,
    full_name      VARCHAR(100) NOT NULL,
    address        VARCHAR(255) NOT NULL,
    phone          VARCHAR(20)  NOT NULL,
    email          VARCHAR(100) NOT NULL,
    birth_date     DATE         NULL,

    PRIMARY KEY (customer_id),
    UNIQUE KEY uk_customer_phone (phone),
    UNIQUE KEY uk_customer_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- PLANS TABLE
CREATE TABLE plan (
    plan_id             INT            NOT NULL  AUTO_INCREMENT,
    plan_type           VARCHAR(50)    NOT NULL,
    plan_name           VARCHAR(100)   NOT NULL,
    plan_duration_days  INT            NOT NULL,
    plan_cost           DECIMAL(10,2)  NOT NULL,
    plan_features       VARCHAR(255)   NULL,

    PRIMARY KEY (plan_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- TRANSACTIONS TABLE
CREATE TABLE `transaction` (
    transaction_id      INT            NOT NULL  AUTO_INCREMENT,
    transaction_type    VARCHAR(50)    NOT NULL,
    transaction_date    TIMESTAMP      NOT NULL,
    transaction_amount  DECIMAL(10,2)  NOT NULL,
    customer_id         INT            NOT NULL,
    plan_id             INT            NOT NULL,

    PRIMARY KEY (transaction_id),
    KEY fk_tx_plan_id (plan_id),
    KEY fk_tx_customer_id_idx (customer_id),
    CONSTRAINT fk_tx_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT fk_tx_plan_id FOREIGN KEY (plan_id) REFERENCES plan (plan_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- CALL_TRAFFIC TABLE
CREATE TABLE call_traffic (
    call_id       INT            NOT NULL AUTO_INCREMENT,
    call_start    TIMESTAMP      NOT NULL,
    call_end      TIMESTAMP      NOT NULL,
    call_type     VARCHAR(50)    NOT NULL,
    call_cost     DECIMAL(10,2)  NOT NULL,
    customer_id   INT            NOT NULL,

    PRIMARY KEY (call_id),
    KEY fk_call_traffic_customer_id (customer_id),
    CONSTRAINT fk_call_traffic_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- CUSTOMER_PLAN TABLE
CREATE TABLE customer_plan (
    customer_id  INT  NOT NULL,
    plan_id      INT  NOT NULL,

    PRIMARY KEY (customer_id,plan_id),
    KEY customer_plan_plan_id_idx (plan_id),
    CONSTRAINT fk_cp_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT fk_cp_plan_id FOREIGN KEY (plan_id) REFERENCES plan (plan_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- CANCELLATIONS TABLE
CREATE TABLE cancellation (
    cancellation_id      INT           NOT NULL   AUTO_INCREMENT,
    cancellation_date    DATE          NOT NULL,
    cancellation_reason  VARCHAR(255)  NULL,
    customer_id          INT           NOT NULL,

    PRIMARY KEY (cancellation_id),
    CONSTRAINT fk_cancel_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





