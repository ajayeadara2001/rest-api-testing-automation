-- Local independent database schema. Run against api_testing_db.
CREATE TABLE IF NOT EXISTS customers (
    customer_id BIGSERIAL PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL CONSTRAINT customers_email_key UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bookings (
    booking_id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    deposit_paid BOOLEAN NOT NULL DEFAULT FALSE,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'CREATED',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT chk_booking_price CHECK (total_price >= 0),
    CONSTRAINT chk_booking_dates CHECK (checkout_date > checkin_date),
    CONSTRAINT chk_booking_status CHECK (booking_status IN ('CREATED', 'CONFIRMED', 'CANCELLED', 'COMPLETED'))
);
