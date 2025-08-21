--1 แสดงชื่อประเภทสินค้า ชื่อสินค้า และ ราคาสินค้า
--CARTESIAN PRODUCT เชื่อมโยงที่ค าสั่ง WHERE
Select CategoryName, ProductName, UnitPrice
From Products as P, Categories as C
where P.CategoryID=C.CategoryID
and categoryName = 'seafood'

--JOIN OPERATOR เชื่อมโยงที่คำสั่ง FROM...ON...
Select CategoryName, ProductName,UnitPrice
From Products as P Join Categories as C
On P.CategoryID=C.CategoryID
where categoryName = 'seafood'

--จงแสดงข้อมูลหมายเลขใบสั่งซื้อ และชื่อบริษัท ขนส่งสินค้า
Select CompanyName, OrderID
FROM Orders, Shippers
WHERE Shippers.ShipperID = Orders.Shipvia

Select CompanyName, OrderID
FROM Orders join Shippers
ON Shippers.ShipperID = Orders.Shipvia

--จงแสดงข้อมูลหมายเลขใบสั่งซื้อและชื่อบริษัทขนส่งสินค้าของใบสั่งซื้อหมายเลข 10275
--Cartesian Product
SELECT CompanyName, OrderID
FROM Orders, Shippers
WHERE Shippers.ShipperID = Orders.Shipvia
AND OrderID = 10275

--Join Operator
SELECT CompanyName, OrderID
FROM Orders JOIN Shippers
ON Shippers.ShipperID=Orders.Shipvia
WHERE OrderID=10275

select * from Orders where orderid = 10250
select * from [Order Details] where orderId = 10250

--ต้องการรหัสสินค้า ชื่อสินค้า บริษัทผู้จัดจำหน่าย ประเทศ
SELECT p.ProductID, p.ProductName, s.CompanyName, s.Country 
FROM Products p join Suppliers s on p.SupplierID = s.SupplierID 
where Country in ('uas', 'uk')

--ต้องการรหัสพนักงาน ชื่อพนักงาน รหัสใบสั่งซื้อที่เกี่ยวข้อง เรียงลำดับตามรหัสพนักงาน
select e.EmployeeID, FirstName, o.OrderID
from Employees e join orders o on e.EmployeeID = o.EmployeeID
order by EmployeeID

--จงแสดงหมายเลขใบคำสั่งซื้อ, ชื่อบริษัทลุกค้า, สถานที่ส่งของ, และพนักงานผู้ดูแล
--JOIN Operator
SELECT O.OrderID เลขใบสั่งซื้อ, C.CompanyName ลูกค้า,
E.FirstName พนักงาน, O.ShipAddress ส่งไปที่
FROM Orders O
join Customers C on O.CustomerID=C.CustomerID
join Employees E on O.EmployeeID=E.EmployeeID

--ต้องการชื่อบริษัทขนส่ง และจำนวนใบสั่งซื้อที่เกี่ยวข้อง
Select s.CompanyName, count(*) จำนวนorders 
from Shippers s join orders o on s.ShipperID = o.ShipVia
Group By s.CompanyName
Order By 2 desc

--ต้องการรหัสสินค้า ชื่อสินค้า และจำนวนทั้งหมดที่ขายได้
Select p.ProductID, p.ProductName, sum(Quantity) จำนวนที่ขายได้ 
from Products p join [Order Details] od on p.ProductID = od.ProductID
Group By p.ProductID, p.ProductName

--ต้องการรหัสสินค้า ชื่อสินค้า ที่ nancy ขายได้ทั้งหมด เรียงตามลำดับรหัสสินค้า
Select distinct p.ProductID, P.ProductName
from Employees e join Orders o on e.EmployeeID = O.EmployeeID
                          join [Order Details] od on o.OrderID = od.OrderID
                          join Products p on p.ProductID = od.ProductID
where e.FirstName = 'Nancy'
order by ProductID

--ต้องการชื่อบริษัท Around the horn ซื้อสินค้าที่มาจากประเทศอะไรบ้าง
Select distinct s.Country 
from customers c join orders o on c.CustomerID = o.CustomerID
                          join [Order Details] od on o.OrderID = od.OrderID
                          join products p on od.ProductID = od.ProductID
                          join Suppliers s on s.SupplierID = p.SupplierID
where c.CompanyName = 'Around the horn'

--บริษัทลูกค้าชื่อ Around the hirn ซื้อสินค้าอะไย้าง จำนวนเท่าไหร่
Select p.ProductID, p.ProductName, sum(Quantity) จำนวนที่ซื้อ
from customers c join orders o on c.CustomerID = o.CustomerID
                          join [Order Details] od on o.OrderID = od.OrderID
                          join products p on od.ProductID = od.ProductID
where c.CompanyName = 'Around the horn'
Group By p.ProductID, p.ProductName

--ต้องการหมายเลขใบสั่งซื้อ ชื่อพนักงาน และยอดขายในใบสั่งซื้อนั้น
Select o.OrderID, FirstName, round (sum(od.Quantity * od.UnitPrice * (1-Discount)),2) TotalCash 
from Orders o join Employees e on o.EmployeeID = e.EmployeeID
                       join [Order Details] od on o.OrderID = od.OrderID
Group By o.OrderID, FirstName
   