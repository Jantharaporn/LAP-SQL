--1. ต้องการรหัสพนักงาน คำนำหน้า ชื่อ นามสกุล ของพนักงานที่อยู่ในประเทศ USA
Select EmployeeID, TitleofCourtesy, FirstName, LastName 
from Employees 
where Country = 'usa'

--2. ต้องการข้อมูลสินค้าที่มีรหัสประเภท 1,2,4,8 และมีราคา ช่วง 100$-200$
Select * from Products where CategoryID in (1,2,3,4) and UnitPrice BETWEEN 100 and 200

--3. ต้องการประเทศ เมือง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร ของลูกค้าทั้งหมด ที่อยู่ในภาค WA และ WY
Select Country, City, CompanyName, ContactName, Phone
from Customers
where Region = 'WA' or Region = 'WY'

--4. ข้อมูลของสินค้ารหัสประเภทที่ 1 ราคาไม่เกิน 20 หรือสินค้ารหัสประเภทที่ 8 ราคาตั้งแต่ 150 ขึ้นไป
Select * from Products
where (CategoryID = 1 and UnitPrice<=20) or (CategoryID = 8 and UnitPrice>=150)

--5. ชื่อบริษัทลูกค้า ที่อยู่ใน ประเทศ USA ที่ไม่มีหมายเลข FAX  เรียงตามลำดับชื่อบริษัท 
Select CompanyName from Customers where fax is NULL order by CompanyName

--6. ต้องการข้อมูลลูกค้าที่ชื่อบริษัททมีคำว่า Com
Select * from Customers where CompanyName like '%com%'


---------------------------------------------------------------------
