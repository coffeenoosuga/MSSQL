use Northwind
-- Ogranicznie zbioru wynikow;)

select top 5 with ties orderid, productid, quantity
from [order details]
order by quantity desc

-- Fun agregujace (count, count(*), min, max, sum, avg)

-- count
select * from employees

select count (*)
from employees

select count (reportsto)
from employees

-- sum
select sum(quantity)
from [order details]
where productid = 7


-- 2 podaj max cene produktu ponizej 20.
select max (UnitPrice)
from Products
where (UnitPrice < 20)

-- 4. Cena powyrzejj sredniej
select UnitPrice from Products where UnitPrice > (select AVG(UnitPrice) from Products)

-- 5. Suma zamowienia  numerze 10250
select round(sum(UnitPrice*Quantity*(1-Discount)),3)
from [Order Details]
where OrderID = 10250

select cast(0.1 as float) + cast(0.1 as float) + cast(0.1 as float) - cast(0.3 as float)

-- Group up
select * from orderhist

select productid ,sum(quantity) as total_quantity
from orderhist
group by productid

select productid, sum(quantity) as total_quantity
from [order details]
where productid between 10 and 20
group by productid
order by productid

-- 3. Liczba zamowien dostarczanych przez poszczegolnych spedytorow
select * from Shippers
select *  from [Order details]


-- Group by z Having
select productid, sum(quantity) as total_quantity
from orderhist
group by productid
having sum(quantity)>=30


--------------------------------------------------------------------------------

-- Zamowienia dla ktorych liczba pozycij jest >5

select OrderId, count(*) as new
from [Order Details]
group by OrderID
having count(*) >5

-- Wyświetl  klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień 
-- (wyniki posortuj malejąco wyłącznej kwoty za dostarczenie zamówień dla każdego z klientów)

select CustomerID, sum(Freight) as "new"
from Orders
where year(Orderdate) = 1998
group by CustomerID
having count(*) > 8
order by sum(Freight) desc



select count(*) as "New"
from Orders
where year(OrderDate) = 1998 and CustomerID='SAVEA'

-- Dla kazdego zamowienia wartosc od < do >(top 10)
select top 10 OrderID, count(*), sum(UnitPrice*Quantity*(1-Discount)) as new
from [Order Details]
group by OrderID
order by new desc 

-- Nr Zamowienia, wartosc, where liczba jednostek zamowienia > 250

-- select OrderID, count(*), sum(UnitPrice*Quantity*(1-Discount)) as new, sum(Quantity) as new2
-- from [Order Details]
-- group by OrderID
-- order by new desc 
-- having sum(quantity) < 250

-- productId < 3

select ProductID, sum(Quantity) as new
from [Order Details]
group by ProductID
having ProductID < 3


-- dla kazdego przewoznika (nazwa) i iczba zamowienw 1997
select CompanyName from Shippers


-- Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień w lutym 1997r dla kazdego

select COUNT(OrderID),FirstName,LastName,Employees.EmployeeID
from Employees
left join orders
    on Employees.EmployeeID=orders.EmployeeID
     and YEAR(orderdate) = 1997 and month (orderdate) = 2
group by FirstName, LastName, Employees.EmployeeID
--zrobic w domu
