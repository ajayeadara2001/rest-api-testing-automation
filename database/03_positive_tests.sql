-- DB_POS_001..006. Changes are rolled back after results are displayed.
BEGIN;
CREATE TEMP TABLE db_positive_results (test_id TEXT, scenario TEXT, result TEXT) ON COMMIT DROP;
DO $$
DECLARE v_customer_id BIGINT; v_booking_id BIGINT; v_count BIGINT; v_price NUMERIC(10,2); v_status TEXT;
BEGIN
  SELECT customer_id INTO v_customer_id FROM customers WHERE email = 'ajay.test@example.com';
  IF v_customer_id IS NULL THEN RAISE EXCEPTION 'Required seed customer missing'; END IF;
  INSERT INTO bookings(customer_id,total_price,deposit_paid,checkin_date,checkout_date,booking_status)
  VALUES(v_customer_id,350,TRUE,'2027-04-10','2027-04-15','CREATED') RETURNING booking_id INTO v_booking_id;
  INSERT INTO db_positive_results VALUES ('DB_POS_001','Insert valid booking',CASE WHEN v_booking_id IS NOT NULL THEN 'PASS' ELSE 'FAIL' END);
  SELECT COUNT(*) INTO v_count FROM bookings b JOIN customers c ON c.customer_id=b.customer_id WHERE b.booking_id=v_booking_id AND c.email='ajay.test@example.com';
  INSERT INTO db_positive_results VALUES ('DB_POS_002','Retrieve booking using JOIN',CASE WHEN v_count=1 THEN 'PASS' ELSE 'FAIL' END);
  UPDATE bookings SET total_price=600 WHERE booking_id=v_booking_id; SELECT total_price INTO v_price FROM bookings WHERE booking_id=v_booking_id;
  INSERT INTO db_positive_results VALUES ('DB_POS_003','Update booking price',CASE WHEN v_price=600 THEN 'PASS' ELSE 'FAIL' END);
  UPDATE bookings SET booking_status='CONFIRMED' WHERE booking_id=v_booking_id; SELECT booking_status INTO v_status FROM bookings WHERE booking_id=v_booking_id;
  INSERT INTO db_positive_results VALUES ('DB_POS_004','Update booking status',CASE WHEN v_status='CONFIRMED' THEN 'PASS' ELSE 'FAIL' END);
  DELETE FROM bookings WHERE booking_id=v_booking_id; SELECT COUNT(*) INTO v_count FROM bookings WHERE booking_id=v_booking_id;
  INSERT INTO db_positive_results VALUES ('DB_POS_005','Delete booking',CASE WHEN v_count=0 THEN 'PASS' ELSE 'FAIL' END);
  SELECT COUNT(*) INTO v_count FROM customers WHERE customer_id=v_customer_id;
  INSERT INTO db_positive_results VALUES ('DB_POS_006','Verify customer remains',CASE WHEN v_count=1 THEN 'PASS' ELSE 'FAIL' END);
END $$;
SELECT * FROM db_positive_results ORDER BY test_id;
SELECT COUNT(*) total_tests, COUNT(*) FILTER (WHERE result='PASS') passed, COUNT(*) FILTER (WHERE result='FAIL') failed FROM db_positive_results;
ROLLBACK;
