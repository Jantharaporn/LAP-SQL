--Sub Query
--ต้องการข้อมูลคนที่มีตำแหน่งเดียวกับ Nancy
-------1.หาตำแหน่งของ Nancy ก่อน
Select title from Employees
where FirstName = 'Nancy'

-------2.หาข้อมูลคนที่มีตำแหน่งเดียวกับ Nancy 
Select * from Employees 
where Title = (Select title from Employees where FirstName = 'Nancy')

-------3.ต้องการชื่อนามสกุลพนักงานที่มีอายุมากที่สุด
Select FirstName, LastName from Employees
where BirthDate = (Select min(BirthDate) from Employees)

-------4.ต้องการชื่อสินค้าที่มีราคามากกว่าสินค้าชื่อ Ikura
Select ProductName from Products
where UnitPrice > (Select UnitPrice from Products
                   where ProductName = 'Ikura')

-------5.ต้องการชื่อบริษัทลูกค้าที่อยู่เมืองเดียวกับบริษัทชื่อ Around the Horn
Select CompanyName from Customers
Where City = (Select City from Products
              where CompanyName = 'Around the Horn')

-------6.ต้องการชื่อนามสกุลพนักงงานที่เข้างานคนมากที่สุด
Select FirstName, LastName from Employees
where HireDate = (Select MAX(HireDate) from Employees)

-------7.ข้อมูลใบสั่งซื้อที่ถูกส่งไปประเทสที่ไม่มีผู้ผลิตสินค้าตั้งอยู่
Select * from Orders
where ShipCountry not in (Select distinct country from Suppliers)

--การใส่ตัวเลขลำดับ
--ต้องการข้อมูลสินค้าที่มีราคาน้อยกว่า 50$
Select ROW_NUMBER() OVER (order by unitprice) AS RowNum,
productName , UnitPrice
from Products
where UnitPrice < 50

--คำสั่ง DML (Insert Upadate Delete)
Select * from Shippers

----------------คำสั่ง Insert เพิ่มข้อมูล
--ตารางมี PK เป็น AutoIncrement (AutoNumber)
Insert into Shippers
VALUES('บริษัทขนมหาศาลจำกัด','087-98765432')

Insert into Shippers(CompanyName)
VALUES('บริษัทขนมหาศาลจำกัด')


Select * from Customers
--ตารางที่มี PK เป็น char, nChar
Insert into customers(CustomerID,CompanyName)
VALUES('A0001','บริษัทซื้อเยอะจำกัด')

Select * from Employees
--จงเพิ่มข้อมูลพนักงาน 1 คน (ใส่ข้อมูลเท่าที่มี)
Insert into Employees(FirstName,LastName)
VALUES('Phaseeda','Jantharaporn')


--จงเพิ่มสินค้า ปลาแดกบอง ราคา 1.5$ จำนวน 12
Insert into Products(ProductName,UnitPrice,UnitsInStock)
VALUES('ปลาแดกบอง',1.5,12)

Select * from Products

-------------------คำสั่ง Update ปรับปรุงข้อมูล
---ปรับปรุงเบอร์โทรศัพท์ของบริษัทขนส่ง รหัส 6
Update Shippers
set Phone = '085-111111111'
where ShipperID = 5

Select * from Shippers

--ปรับปรุงจำนวนสินค้าคงเหลือสินค้ารหัส 1 เพิ่มจำนวนเข้าไป 100 ชิ้น
Update Products
SET UnitsInStock = UnitsInStock+100
where ProductID = 1

Select * from Products

--ปรับปรุง เมือง และประเทศลูกค้า รหัส A0001 ให้เป็น อุดรธานี, Thailand
Update Customers
set City = 'อุดรธานี', Country = 'Thailad'
where CustomerID = 'A0001'

Select * from Customers

-----------------คำสั่ง Delete ลบข้อมูล
--ลบบริษัทขนส่งสินค้า รหัส 6
Delete from Shippers
where ShipperID = 6

Select * from Orders


Select * from Employees
--ต้องการข้อมูล รหัสและชื่อพนักงาน และรหัสและชื่อหัวหน้าพนักงาน
Select emp.EmployeeID, emp.FirstName ชื่อพนักงาน,
       boss.EmployeeID, boss.FirstName ชื่อหัวหน้า
from Employees emp left outer join Employees boss
on emp.ReportsTo = boss.EmployeeID

