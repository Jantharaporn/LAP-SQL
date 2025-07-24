--ตัวอย่าง Query แบบ "คอลัมน์คำนวณชั่วคราว"
--มูลค่าสินค้าคงเหลือต่อรายการ
Select ProductID, ProductName, 
                 UnitPrice, UnitsInStock, 
                 UnitPrice * UnitsInStock AS StockValue   --AS คือ Alias Name
from Products

--ต้องสั่งซิเแสินค้าเพิ่มหรือยัง
Select ProductID as รหัส, ProductName as สินค้า,
      UnitsInStock + UnitSOnOrder as จำนวนคงเหลือทั้งหมด,
      ReorderLevel as จุดสั่งซื้อ
from Products 
where (UnitsInStock + UnitsOnOrder) < ReorderLevel

--ภาษีมูลค่าเพิ่ม 7%
Select ProductID, ProductName,
       UnitPrice, ROUND(UnitPrice * 0.07, 2) AS Vat7
from Products

--ชื่อนามสกุลพนักงาน
Select employeeID, TitleOfCourtesy+FirstName+space(1)+LastName as [Employee Name]
from Employees
หรือ
Select employeeID, TitleOfCourtesy+FirstName+'' +LastName as [Employee Name]
from Employees

--ต้องการทราบราคาในแต่ละรายการขายสินค้า [order details]
Select orderID, ProductID, UnitPrice, Quantity, Discount, 
       (UnitPrice*Quantity) as TotalPrice,
       (UnitPrice*Quantity) * (1-Discount) as NetPrice
from [Order Details]

--ราคาจริง = ราคาเต็ม - ส่วนลด
--ราคาเต็ม = ราคา * จำนวน
--ส่วนลด = ราคเต็ม * ลด
--ราคาจริง = (ราคา * จำนวน) - (ราคา * จำนวน * ลด)
--ราคาจริง = ราคา * จำนวน * (1 - ลด)

Select (42.40 * 35) - (42.40*35*0.15)

--ต้องการทราบอายุ และอายุงานของพนักงานทุกคน จนถึงปัจจุบัน
Select employeeID, FirstName, BirthDate, Datediff(YEAR,BirthDate,getdate()) Age,
       HireDate, DATEDIFF(YEAR,HireDate,GETDATE()) YearInOffice
from Employees

Select getdate()


--Aggregate Function หรือ Group Function (Sum, Count, Min, Max Avg, ...)
--คำสั่ง COUNT
--แสดงข้อมูลจำนวนชนิดสินค้าที่มีเก็บไว้ต่ำกว่า 15 ชิ้น
Select COUNT(*) AS จำนวนสินค้า, COUNT(ProductID), COUNT(productName), COUNT(UnitPrice)
from Products
where UnitsInStock < 15

--จำนวนลูกค้าที่อยู่ในประเทศ USA ได้เท่าไหร่
Select COUNT(*) from Customers
where Country = 'USA'
--จำนวนพนักงานที่อยู่ใน London
Select COUNT(*) from Employees
where City = 'London'

--จำนวนใบสั่งซื้อที่ออกในปี 1997
Select COUNT(*) from Orders where Year(OrderDate) = 1997
--จำนวนครั้งที่ขายสินค้ารหัส 1
Select COUNT(*) from [Order Details] where ProductID = 1

--function Sum
--จำนวนสินค้าที่ขายได้ทั้งหมด
Select sum(quantity)
from [Order Details]
where ProductID = 2

--มูลค่าสินค้าในคลังทั้งหมด
Select sum(UnitPrice * UnitsInStock)
from Products

--จำนวนสินค้ารหัสประเภท 8 ที่สั่งซื้อแล้ว
Select sum(UnitsOnOrder)
from Products
where CategoryID = 8

--ราคาสินค้ารหัส 1 ที่ขายได้ราคาสูงสุดและต่ำสุด
Select max(UnitPrice), min(UnitPrice)
from [Order Details]
where ProductID = 71

--function AVG
--ราคาสินค้าเฉลี่ยทั้งหมดที่เคยขายได้ เฉพาะสินค้ารหัส 5
Select AVG(UnitPrice), min(UnitPrice), max(UnitPrice)
from [Order Details]
where ProductID = 5

-----------------------------------------------------------------------
--การจัดกลุ่มข้อมูล โดยใช้ GROUP BY
--แสดงชื่อประเทศ และจำนวนลูกค้าที่อยู่ในประเทศ จากตารางลูกค้า
Select Country, count(*) as [Num of Country]
from Customers
GROUP BY Country

--รหัสประเภทสินค้า ราคาเฉลี่ยของสินค้าประเภทเดียวกัน
Select categoryID, AVG(UnitPrice), min(UnitPrice), max(UnitPrice)
from Products
GROUP BY categoryID

--รายการสินค้าในใบสั่งซื้อทุกใบ [order details]
--เฉพาะในใบสั่งซื้อที่มีสินค้ามากกว่า 3 ชนิด
Select orderID, count(*)
from [Order Details]
GROUP BY orderID
Having count(*)>3

--ประเทศปลายทาง และจำนวนในใบสั่งซื้อที่ส่งสินค้าไปถึงปลายทาง
Select ShipCountry, count(*)
from orders 
GROUP BY ShipCountry

--เงื่อนไขในการจัดกลุ่ม โดยใช้ HAVING
--ต้องการเฉาะที่มีจำนวนใบสั่งซื้อ ตั้งแต่ 100 ขึ้นไป
Select ShipCountry, count(*) as numOfOrders
from Orders
GROUP BY ShipCountry
Having count(*)>=100

---ข้อมูลรหัสใบสั่งซื้อ ยอดเงินรวมในใบสั่งซื้อนั้น แสดงเฉพาะในใบสั่งซื้อที่มียอดเงินน้อยกว่า 100 [Order details]
Select orderID, sum(UnitPrice*Quantity*(1-Discount))
from [Order Details]
GROUP BY OrderID
Having sum(UnitPrice*Quantity*(1-Discount)) < 100

--ประเทศใดที่มีจำนวนใบสั่งซื้อที่สั่งสินค้าไปปลายทางต่ำกว่า 20 รายการ ในปี 1997
Select shipCountry, count(*) AS numOfOrders
from Orders 
where Year(OrderDate) = 1997
GROUP BY shipCountry
Having count(*)<20
order by count(*) desc

--ใบสั่งซื้อใดมียอดขายสูงที่สุด แสดงรหัสใบสั่งซื้อและยอดขาย
Select top 1 orderID, sum(UnitPrice*Quantity*(1-Discount)) as total
from [Order Details]
GROUP BY OrderID
order by total desc

--ใบสั่งซื้อใดมียอดขายต่ำที่สุด 5 อันดับ แสดงรหัสใบสั่งซื้อและยอดขาย
Select top 5 orderID, sum(UnitPrice*Quantity*(1-Discount)) as total
from [Order Details]
GROUP BY OrderID
order by total asc