USE little_lemon_db;

INSERT INTO Bookings (`BookingDate`, `TableNumber`, `BookingCustomerID`, `StaffID`, `BookingSlot`)
               VALUES("2022-10-10", 5, 1, 1, "2022-10-10 19:00:00"),
                     ("2022-11-12", 3, 3, 2, "2022-11-12 18:30:00"),
                     ("2022-10-11", 2, 2, 3, "2022-10-11 18:45:00"),
                     ("2022-10-13", 2, 1, 4, "2022-10-13 20:00:00");
SELECT * 
FROM Bookings;

INSERT INTO Orders(OrderID, MenuID, BookingID, StatusID, TableNo, Quantity, TotalCost, OrderCustomerID)
            VALUES(543666861, 1, 1, 1, 1, 2, 125, 720557985),
				  (637613686, 1, 2, 2, 2, 1, 235, 653530657),
                  (653516434, 2, 3, 1, 3, 3, 75, 908766799),
                  (369172834, 2, 4, 2, 4, 3, 220, 738734827),
                  (861149232, 1, 5, 1, 5, 2, 320, 809275246);
SELECT *
FROM Orders;

INSERT INTO Customer(CustomerID, CustomerFullName, Email, ContactNumber)
	   VALUES(720557985, "Laney Fadden", "Laney_Fadden@gmail.com", "469-227-7587"),
             (653530657, "Giacopo Bramich", "Giacopo_Bramich@msn.com", "468-235-7678"),
             (908766799, "Lia Bonar", "Lia_Bonar@gmail.com", "817-271-5677"),
             (738734827, "Merrill Baudon", "Merrill_Baudon@gmail.com", "614-276-5667"),
             (809275246, "Tasia Fautly", "Tasia_Fautly@yahoo.com", "615-479-2846");

SELECT CustomerFullname, Email, ContactNumber, Orders.TotalCost
FROM Customer
INNER JOIN Orders ON Customer.CustomerID = Orders.OrderCustomerID
WHERE Orders.TotalCost > 60;
                 

