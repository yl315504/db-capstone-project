USE little_lemon_db;
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE OrderID = ?';
SET @id = 543666861;
EXECUTE GetOrderDetail USING @id;