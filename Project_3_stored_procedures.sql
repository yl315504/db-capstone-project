USE little_lemon_db;
DELIMITER //
CREATE PROCEDURE CheckBooking(booking_date DATE, input_table_number INT)
BEGIN 
	DECLARE reserved_table_number INT DEFAULT NULL;
    DECLARE results VARCHAR(200);
    SELECT TableNumber INTO reserved_table_number
    FROM Bookings
    WHERE BookingDate = booking_date;
    IF reserved_table_number = input_table_number THEN 
		SET results = CONCAT("Table ", input_table_number, " is already booked");
    ELSE 
		SET results = CONCAT("Table ", input_table_number, " is not booked");
    END IF;
    SELECT results;
END //
DELIMITER ;

CALL CheckBooking("2022-11-12", 3);
CALL CheckBooking("2022-10-10", 3);

DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(booking_date DATE, input_table_number INT, customer_ID INT, staff_ID INT, booking_slot DATETIME)
BEGIN
	DECLARE isBooked INT DEFAULT 0;
    START TRANSACTION; 
    INSERT INTO Bookings (BookingDate, TableNumber, BookingCustomerID, StaffID, BookingSlot)
    VALUES (booking_date, input_table_number, customer_ID, staff_ID, booking_slot);
    
    SELECT COUNT(*) INTO isBooked
    FROM Bookings
    WHERE BookingDate = booking_date AND TableNumber = input_table_number AND BookingCustomerID = customer_ID AND BookingID != LAST_INSERT_ID();
    IF isBooked > 0 THEN
		ROLLBACK;
        SELECT"This table is already booked - booking cancelled" AS Message;
	ELSE
		COMMIT;
        SELECT"New booking added" AS Message;
	END IF;
END //
DELIMITER ;

CALL AddValidBooking("2022-11-12", 3, 3, 6, "2022-11-12 20:00:00");
CALL AddValidBooking("2022-12-12", 3, 3, 6, "2022-11-12 20:00:00");
CALL AddValidBooking("2022-12-13", 3, 3, 6, "2022-11-12 20:00:00");

SELECT *
FROM Bookings;

DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(booking_id INT, booking_date DATE)
BEGIN
	UPDATE Bookings
    SET BookingDate = booking_date
    WHERE BookingID = booking_id;
    SELECT CONCAT("Booking ", booking_id, " updated") AS Message;
END //
DELIMITER ;

CALL UpdateBooking(3, "2022-12-14");
SELECT *
FROM Bookings;

DELIMITER //
CREATE PROCEDURE CancelBooking(booking_id INT)
BEGIN 
	DELETE FROM Bookings
    WHERE BookingID = booking_id;
    SELECT CONCAT("Booking ", booking_id, " cancelled") AS Message;
END //

DELIMITER ;

CALL CancelBooking(11);
CALL CancelBooking(7);
SELECT *
FROM Bookings;