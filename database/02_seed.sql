-- Idempotent seed data: three customers and three bookings.
INSERT INTO customers (firstname, lastname, email) VALUES
    ('Ajay', 'Test', 'ajay.test@example.com'),
    ('Priya', 'Sharma', 'priya.sharma@example.com'),
    ('Rahul', 'Kumar', 'rahul.kumar@example.com')
ON CONFLICT (email) DO NOTHING;

INSERT INTO bookings (customer_id, total_price, deposit_paid, checkin_date, checkout_date, booking_status)
SELECT c.customer_id, v.total_price, v.deposit_paid, v.checkin_date, v.checkout_date, v.booking_status
FROM (VALUES
    ('ajay.test@example.com', 350.00::NUMERIC, TRUE,  DATE '2027-01-10', DATE '2027-01-15', 'CREATED'),
    ('priya.sharma@example.com', 525.00::NUMERIC, FALSE, DATE '2027-02-01', DATE '2027-02-05', 'CONFIRMED'),
    ('rahul.kumar@example.com', 275.00::NUMERIC, TRUE,  DATE '2027-03-12', DATE '2027-03-14', 'COMPLETED')
) AS v(email, total_price, deposit_paid, checkin_date, checkout_date, booking_status)
JOIN customers c ON c.email = v.email
WHERE NOT EXISTS (
    SELECT 1 FROM bookings b WHERE b.customer_id = c.customer_id
      AND b.checkin_date = v.checkin_date AND b.checkout_date = v.checkout_date
);
