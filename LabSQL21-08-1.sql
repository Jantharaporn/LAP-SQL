--การ Query ข้อมูลจากหลายตาราง (Join)
-- 1.จงแสดงข้อมูลรหัสใบสั่งซื้อ ชื่อบริษัทลูกค้า ชื่อและนามสกุลพนักงาน(ในคอลัมน์เดียวกัน) วันที่สั่งซื้อ ชื่อบริษัทขนส่งของ เมืองและประเทศที่ส่งของไป รวมถึงยอดเงินที่ต้องรับจากลูกค้าด้วย
SELECT o.OrderID, c.CompanyName AS CustomerName, e.FirstName + ' ' + e.LastName AS EmployeeName, o.OrderDate,
      s.CompanyName AS ShipperName,o.ShipCity,o.ShipCountry,
      SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Orders o join Customers c ON o.CustomerID = c.CustomerID
              join Employees e ON o.EmployeeID = e.EmployeeID
              join Shippers s ON o.ShipVia = s.ShipperID
              join [Order Details] od ON o.OrderID = od.OrderID
Group By o.OrderID, c.CompanyName, e.FirstName, e.LastName, 
         o.OrderDate, s.CompanyName, o.ShipCity, o.ShipCountry

-- 2.จงแสดง ข้อมูล ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เมือง ประเทศ จำนวนใบสั่งซื้อที่เกี่ยวข้องและ ยอดการสั่งซื้อทั้งหมดเลือกมาเฉพาะเดือน มกราคมถึง มีนาคม  1997
SELECT c.CompanyName, c.ContactName, c.City, c.Country, COUNT(o.OrderID), round (sum(od.Quantity * od.UnitPrice * (1- od.Discount)),2) TotalClash
FROM Orders o join Customers c ON o.CustomerID = c.CustomerID
              join [Order Details] od ON o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' AND '1997-03-31'
Group By c.CompanyName, c.ContactName, c.City, c.Country

-- 3.จงแสดงชื่อเต็มของพนักงาน ตำแหน่ง เบอร์โทรศัพท์ จำนวนใบสั่งซื้อ รวมถึงยอดการสั่งซื้อทั้งหมดในเดือนพฤศจิกายน ธันวาคม 2539  โดยที่ใบสั่งซื้อนั้นถูกส่งไปประเทศ USA, Canada หรือ Mexico
SELECT e.FirstName + ' ' + e.LastName, e.Title, e.HomePhone, COUNT(distinct o.OrderID), round (sum(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) TotalClash
FROM Employees e join Orders o ON e.EmployeeID = o.EmployeeID
                   join [Order Details] od ON o.OrderID = od.OrderID
where o.OrderDate between '1996-11-01' AND '1996-12-31' AND o.ShipCountry in ('USA', 'Canada', 'Mexico')
Group By e.FirstName, e.LastName, e.Title, e.HomePhone

-- 4.จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย  และจำนวนทั้งหมดที่ขายได้ในเดือน มิถุนายน 2540
SELECT p.ProductID, p.ProductName, p.UnitPrice, SUM(od.Quantity) TotalQuantity
FROM Products p join [Order Details] od ON p.ProductID = od.ProductID
                  join Orders o ON od.OrderID = o.OrderID
where o.OrderDate between '1997-06-01' AND '1997-06-30'
Group By p.ProductID, p.ProductName, p.UnitPrice

-- 5.จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย และยอดเงินทั้งหมดที่ขายได้ ในเดือน มกราคม 2540 แสดงเป็นทศนิยม 2 ตำแหน่ง
SELECT p.ProductID, p.ProductName, p.UnitPrice, round(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalAmount
FROM Products p join [Order Details] od ON p.ProductID = od.ProductID
                  join Orders o on od.OrderID = o.OrderID
where o.OrderDate between '1997-01-01' AND '1997-01-31'
Group By p.ProductID, p.ProductName, p.UnitPrice

-- 6.จงแสดงชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร เบอร์ Fax รหัส ชื่อสินค้า ราคา จำนวนรวมที่จำหน่ายได้ในปี 1996
SELECT s.CompanyName, s.ContactName, s.Phone, s.Fax, p.ProductID, p.ProductName, p.UnitPrice, SUM(od.Quantity) AS TotalQuantity
FROM Suppliers s join Products p ON s.SupplierID = p.SupplierID
                 join [Order Details] od ON p.ProductID = od.ProductID
                 join Orders o ON od.OrderID = o.OrderID
where YEAR(o.OrderDate) = 1996
Group By s.CompanyName, s.ContactName, s.Phone, s.Fax, p.ProductID, p.ProductName, p.UnitPrice

-- 7.จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย  และจำนวนทั้งหมดที่ขายได้เฉพาะของสินค้าที่เป็นประเภท Seafood และส่งไปประเทศ USA ในปี 1997
SELECT p.ProductID, p.ProductName, p.UnitPrice, SUM(od.Quantity) AS TotalQuantity
FROM Products p join Categories cat ON p.CategoryID = cat.CategoryID
                join [Order Details] od ON p.ProductID = od.ProductID
                join Orders o ON od.OrderID = o.OrderID
where cat.CategoryName = 'Seafood' AND o.ShipCountry = 'USA' AND YEAR(o.OrderDate) = 1997
Group By p.ProductID, p.ProductName, p.UnitPrice

-- 8.จงแสดงชื่อเต็มของพนักงานที่มีตำแหน่ง Sale Representative อายุงานเป็นปี และจำนวนใบสั่งซื้อทั้งหมดที่รับผิดชอบในปี 1998
SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, e.Title, DATEDIFF(YEAR, e.HireDate, GETDATE()) YearsOfService,
       COUNT(DISTINCT o.OrderID) AS TotalOrders
FROM Employees e LEFT join Orders o ON e.EmployeeID = o.EmployeeID AND YEAR(o.OrderDate) = 1998
Group By e.FirstName, e.LastName, e.Title, e.HireDate

-- 9.แสดงชื่อเต็มพนักงาน ตำแหน่งงาน ของพนักงานที่ขายสินค้าให้บริษัท Frankenversand ในปี  1996
SELECT DISTINCT e.FirstName + ' ' + e.LastName AS EmployeeName, e.Title
FROM Employees e join Orders o ON e.EmployeeID = o.EmployeeID
                 join Customers c ON o.CustomerID = c.CustomerID
where c.CompanyName = 'Frankenversand' AND YEAR(o.OrderDate) = 1996

-- 10.จงแสดงชื่อสกุลพนักงานในคอลัมน์เดียวกัน ยอดขายสินค้าประเภท Beverage ที่แต่ละคนขายได้ ในปี 1996
SELECT e.LastName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) BeverageSales
FROM Employees e join Orders o ON e.EmployeeID = o.EmployeeID
                 join [Order Details] od ON o.OrderID = od.OrderID
                 join Products p ON od.ProductID = p.ProductID
                 join Categories cat ON p.CategoryID = cat.CategoryID
where YEAR(o.OrderDate) = 1996 AND cat.CategoryName = 'Beverages'
Group By e.LastName

-- 11.จงแสดงชื่อประเภทสินค้า รหัสสินค้า ชื่อสินค้า ยอดเงินที่ขายได้(หักส่วนลดด้วย) ในเดือนมกราคม - มีนาคม 2540 โดย มีพนักงานผู้ขายคือ Nancy
SELECT ca.CategoryName,p.ProductID, p.ProductName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) NetSales
FROM Employees e join Orders o ON e.EmployeeID = e.EmployeeID
                 join [Order Details] od ON o.OrderID = od.OrderID
                 join Products p ON od.ProductID = p.ProductID
                 join Categories ca ON p.CategoryID = ca.CategoryID
where e.FirstName = 'Nancy' AND o.OrderDate BETWEEN '1997-01-01' AND '1997-03-31'
Group By ca.CategoryName, p.ProductID, p.ProductName

-- 12.จงแสดงชื่อบริษัทลูกค้าที่ซื้อสินค้าประเภท Seafood ในปี 1997
SELECT DISTINCT c.CompanyName
FROM Customers c join Orders o ON c.CustomerID = o.CustomerID
                 join [Order Details] od ON o.OrderID = od.OrderID
                 join Products p ON od.ProductID = p.ProductID
                 join Categories cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Seafood' AND YEAR(o.OrderDate) = 1997

-- 13.จงแสดงชื่อบริษัทขนส่งสินค้า ที่ส่งสินค้าให้ ลูกค้าที่มีที่ตั้ง อยู่ที่ถนน Johnstown Road แสดงวันที่ส่งสินค้าด้วย (รูปแบบ 106)
SELECT DISTINCT s.CompanyName, o.ShippedDate
FROM Orders o join Customers c ON o.CustomerID = c.CustomerID
              join Shippers s ON o.ShipVia = s.ShipperID
where c.Address LIKE '%Johnstown Road%'

-- 14.จงแสดงรหัสประเภทสินค้า ชื่อประเภทสินค้า จำนวนสินค้าในประเภทนั้น และยอดรวมที่ขายได้ทั้งหมด แสดงเป็นทศนิยม 4 ตำแหน่ง หักส่วนลด
SELECT ca.CategoryID, ca.CategoryName, COUNT(p.ProductID) as TotalProducts,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 4) AS TotalSales
FROM Categories ca join Products p ON ca.CategoryID = p.CategoryID
                   join [Order Details] od ON p.ProductID = od.ProductID
                   join Orders o ON od.OrderID = o.OrderID
Group By ca.CategoryID, ca.CategoryName

-- 15.จงแสดงชื่อบริษัทลูกค้า ที่อยู่ในเมือง London , Cowes ที่สั่งซื้อสินค้าประเภท Seafood จากบริษัทตัวแทนจำหน่ายที่อยู่ในประเทศญี่ปุ่นรวมมูลค่าออกมาเป็นเงินด้วย
SELECT c.CompanyName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalAmount
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
                 JOIN [Order Details] od ON o.OrderID = od.OrderID
                 JOIN Products p ON od.ProductID = p.ProductID
                 JOIN Categories ca ON p.CategoryID = ca.CategoryID
                 JOIN Suppliers s ON p.SupplierID = s.SupplierID
where ca.CategoryName = 'Seafood' AND s.Country = 'Japan' AND c.City IN ('London', 'Cowes')
Group By c.CompanyName

-- 16.แสดงรหัสบริษัทขนส่ง ชื่อบริษัทขนส่ง จำนวนorders ที่ส่ง ค่าขนส่งทั้งหมด  เฉพาะที่ส่งไปประเทศ USA
SELECT s.ShipperID, s.CompanyName, COUNT(o.OrderID) AS TotalOrders, SUM(o.Freight) AS TotalFreight
FROM Shippers s join Orders o ON s.ShipperID = o.ShipVia
where o.ShipCountry = 'USA'
Group By s.ShipperID, s.CompanyName

-- 17.จงแสดงเต็มชื่อพนักงาน ที่มีอายุมากกว่า 60ปี จงแสดง ชื่อบริษัทลูกค้า,ชื่อผู้ติดต่อ,เบอร์โทร,Fax,ยอดรวมของสินค้าประเภท Condiment ที่ลูกค้าแต่ละรายซื้อ แสดงเป็นทศนิยม4ตำแหน่ง,และแสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์
SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, c.CompanyName, c.ContactName, c.Phone,c.Fax,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 4) as TotalCondimentSales
FROM Employees e join Orders o ON e.EmployeeID = o.EmployeeID
                 join Customers c ON o.CustomerID = c.CustomerID
                 join [Order Details] od ON o.OrderID = od.OrderID
                 join Products p ON od.ProductID = p.ProductID
                 join Categories ca ON p.CategoryID = ca.CategoryID
where ca.CategoryName = 'Condiments' AND c.Fax IS NOT NULL AND DATEDIFF(YEAR, e.BirthDate, GETDATE()) > 60
GROUP BY e.FirstName, e.LastName, c.CompanyName, c.ContactName, c.Phone, c.Fax

-- 18.จงแสดงข้อมูลว่า วันที่  3 มิถุนายน 2541 พนักงานแต่ละคน ขายสินค้า ได้เป็นยอดเงินเท่าใด พร้อมทั้งแสดงชื่อคนที่ไม่ได้ขายของด้วย
SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, ISNULL(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 0) AS TotalSales
FROM Employees e LEFT join Orders o ON e.EmployeeID = o.EmployeeID AND o.OrderDate = '1998-06-03'
                 LEFT join [Order Details] od ON o.OrderID = od.OrderID
Group By e.FirstName, e.LastName

-- 19.จงแสดงรหัสรายการสั่งซื้อ ชื่อพนักงาน ชื่อบริษัทลูกค้า เบอร์โทร วันที่ลูกค้าต้องการสินค้า เฉพาะรายการที่มีพนักงานชื่อมากาเร็ตเป็นคนรับผิดชอบพร้อมทั้งแสดงยอดเงินรวมที่ลูกค้าต้องชำระด้วย (ทศนิยม 2 ตำแหน่ง)
SELECT o.OrderID, e.FirstName + ' ' + e.LastName AS EmployeeName, c.CompanyName, c.Phone, o.RequiredDate,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalAmount
FROM Orders o join Employees e ON o.EmployeeID = e.EmployeeID
              join Customers c ON o.CustomerID = c.CustomerID
              join [Order Details] od ON o.OrderID = od.OrderID
where e.FirstName = 'Margaret' AND YEAR(o.OrderDate) = 1996
Group By o.OrderID, e.FirstName, e.LastName, c.CompanyName, c.Phone, o.RequiredDate

-- 20.จงแสดงชื่อเต็มพนักงาน อายุงานเป็นปี และเป็นเดือน ยอดขายรวมที่ขายได้ เลือกมาเฉพาะลูกค้าที่อยู่ใน USA, Canada, Mexico และอยู่ในไตรมาศแรกของปี 2541
SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, DATEDIFF(YEAR, e.HireDate, GETDATE()) AS Years,
       DATEDIFF(MONTH, e.HireDate, GETDATE()) AS Months,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Employees e join Orders o ON e.EmployeeID = o.EmployeeID
                 join [Order Details] od ON o.OrderID = od.OrderID
                 join Customers c ON o.CustomerID = c.CustomerID
where o.OrderDate BETWEEN '1998-01-01' AND '1998-03-31' AND c.Country IN ('USA', 'Canada', 'Mexico')
Group By e.FirstName, e.LastName, e.HireDate