CREATE TABLE employee (
    employee_id    CHAR(5) PRIMARY KEY,
    employee_fname VARCHAR(25) NOT NULL,
    employee_lname VARCHAR(25) NOT NULL,
    employee_dob   DATE NOT NULL,
    employee_type  CHAR(3),
    CHECK (employee_type IN ('TRR','TRE','MAN'))
) ENGINE=InnoDB;

CREATE TABLE customer (
    customer_id    CHAR(5) PRIMARY KEY,
    customer_fname VARCHAR(25) NOT NULL,
    customer_lname VARCHAR(25) NOT NULL,
    customer_dob   DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE item (
    item_id          CHAR(5) PRIMARY KEY,
    item_name        VARCHAR(25) NOT NULL,
    item_description VARCHAR(35) NOT NULL,
    item_price       DECIMAL(4,2),
    CHECK (item_price BETWEEN 0 AND 99.99)
) ENGINE=InnoDB;

CREATE TABLE item_order (
    order_id      CHAR(5),
    customer_id   CHAR(5) NOT NULL,
    item_id       CHAR(5) NOT NULL,
    item_quantity INT NOT NULL,
    cost          DECIMAL(5,2) NOT NULL,

    PRIMARY KEY (order_id, item_id),

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (item_id)
        REFERENCES item(item_id)
) ENGINE=InnoDB;

CREATE TABLE receipt (
    receipt_id CHAR(5) PRIMARY KEY,
    order_id   CHAR(5) NOT NULL,
    tip        DECIMAL(5,2),
    total_cost DECIMAL(7,2),

    FOREIGN KEY (order_id)
        REFERENCES item_order(order_id)
) ENGINE=InnoDB;

CREATE TABLE transaction_tbl (
    transaction_id   CHAR(5) PRIMARY KEY,
    transaction_date DATE NOT NULL,
    receipt_id       CHAR(5) NOT NULL,
    card_check_digit CHAR(4) NOT NULL,
    employee_id      CHAR(5) NOT NULL,

    FOREIGN KEY (receipt_id)
        REFERENCES receipt(receipt_id),

    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
) ENGINE=InnoDB;

CREATE TABLE schedule (
    employee_id    CHAR(5),
    date_scheduled DATE,
    start_time     DECIMAL(4,2),
    end_time       DECIMAL(4,2),

    PRIMARY KEY (employee_id, date_scheduled),

    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    CHECK (start_time BETWEEN 6.00 AND 21.00),
    CHECK (end_time BETWEEN 6.00 AND 21.00)
) ENGINE=InnoDB;

CREATE TABLE manager (
    employee_id   CHAR(5) PRIMARY KEY,
    manager_id    CHAR(5) NOT NULL,
    office_phone  CHAR(8),
    company_email VARCHAR(35),

    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
) ENGINE=InnoDB;

CREATE TABLE trainer (
    employee_id      CHAR(5) PRIMARY KEY,
    trainer_id       CHAR(5) NOT NULL,
    cert_issuer      VARCHAR(35) NOT NULL,
    cert_expiry_date DATE NOT NULL,

    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id)
) ENGINE=InnoDB;

CREATE TABLE trainee (
    employee_id        CHAR(5) PRIMARY KEY,
    trainer_id         CHAR(5) NOT NULL,
    trial_period_begin DATE NOT NULL,
    trial_period_end   DATE NOT NULL,

    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY (trainer_id)
        REFERENCES trainer(trainer_id)
) ENGINE=InnoDB;