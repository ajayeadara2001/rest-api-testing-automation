-- DB_NEG_001..006. Each invalid INSERT is caught and compared to its expected SQLSTATE.
BEGIN;
CREATE TEMP TABLE db_negative_results (test_id TEXT, scenario TEXT, expected_sqlstate TEXT, actual_sqlstate TEXT, result TEXT) ON COMMIT DROP;
DO $$
DECLARE v_customer_id BIGINT; actual_state TEXT;
BEGIN
  SELECT customer_id INTO v_customer_id FROM customers WHERE email='ajay.test@example.com';
  IF v_customer_id IS NULL THEN RAISE EXCEPTION 'Required seed customer missing'; END IF;
  -- 23505 duplicate email
  actual_state := '00000'; BEGIN INSERT INTO customers(firstname,lastname,email) VALUES ('Duplicate','Customer','ajay.test@example.com'); EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS actual_state=RETURNED_SQLSTATE; END;
  INSERT INTO db_negative_results VALUES ('DB_NEG_001','Duplicate email','23505',actual_state,CASE WHEN actual_state='23505' THEN 'PASS' ELSE 'FAIL' END);
  -- 23502 missing firstname
  actual_state := '00000'; BEGIN INSERT INTO customers(lastname,email) VALUES ('Missing','missing.firstname@example.com'); EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS actual_state=RETURNED_SQLSTATE; END;
  INSERT INTO db_negative_results VALUES ('DB_NEG_002','Missing firstname','23502',actual_state,CASE WHEN actual_state='23502' THEN 'PASS' ELSE 'FAIL' END);
  -- 23514 negative price
  actual_state := '00000'; BEGIN INSERT INTO bookings(customer_id,total_price,deposit_paid,checkin_date,checkout_date,booking_status) VALUES(v_customer_id,-1,FALSE,'2027-05-01','2027-05-02','CREATED'); EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS actual_state=RETURNED_SQLSTATE; END;
  INSERT INTO db_negative_results VALUES ('DB_NEG_003','Negative booking price','23514',actual_state,CASE WHEN actual_state='23514' THEN 'PASS' ELSE 'FAIL' END);
  -- 23514 checkout before checkin
  actual_state := '00000'; BEGIN INSERT INTO bookings(customer_id,total_price,deposit_paid,checkin_date,checkout_date,booking_status) VALUES(v_customer_id,1,FALSE,'2027-05-02','2027-05-01','CREATED'); EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS actual_state=RETURNED_SQLSTATE; END;
  INSERT INTO db_negative_results VALUES ('DB_NEG_004','Invalid booking dates','23514',actual_state,CASE WHEN actual_state='23514' THEN 'PASS' ELSE 'FAIL' END);
  -- 23503 invalid foreign key
  actual_state := '00000'; BEGIN INSERT INTO bookings(customer_id,total_price,deposit_paid,checkin_date,checkout_date,booking_status) VALUES(-999999,1,FALSE,'2027-05-01','2027-05-02','CREATED'); EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS actual_state=RETURNED_SQLSTATE; END;
  INSERT INTO db_negative_results VALUES ('DB_NEG_005','Nonexistent customer ID','23503',actual_state,CASE WHEN actual_state='23503' THEN 'PASS' ELSE 'FAIL' END);
  -- 23514 invalid status
  actual_state := '00000'; BEGIN INSERT INTO bookings(customer_id,total_price,deposit_paid,checkin_date,checkout_date,booking_status) VALUES(v_customer_id,1,FALSE,'2027-05-01','2027-05-02','INVALID'); EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS actual_state=RETURNED_SQLSTATE; END;
  INSERT INTO db_negative_results VALUES ('DB_NEG_006','Invalid booking status','23514',actual_state,CASE WHEN actual_state='23514' THEN 'PASS' ELSE 'FAIL' END);
END $$;
SELECT * FROM db_negative_results ORDER BY test_id;
SELECT COUNT(*) total_tests, COUNT(*) FILTER (WHERE result='PASS') passed, COUNT(*) FILTER (WHERE result='FAIL') failed FROM db_negative_results;
ROLLBACK;
