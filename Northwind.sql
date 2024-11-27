use Northwind
--==================================================================
-- Begining of 1-0 select
--==================================================================

-- select */distinct
-- from {table}
--where <condition>

-- ZADANIA

-- Wybierz nazwy i adresy wszystkich klientów:
select CompanyName, Address 
from Customers

-- Wybierz nazwiska i numery telefonów pracowników
select LastName, HomePhone
from Employees

-- Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
select CompanyName, City
from Customers
where City = 'London'

-- Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w
-- Hiszpanii
select CompanyName, Country
from Customers
where country = 'France' or country = 'Spain'

-- Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
select ProductName, UnitPrice
from Products
where UnitPrice >= '20.00' and UnitPrice <= '30.00'

--  Wybierz nazwy i ceny produktów z kategorii 'Meat/Poultry'
select ProductName, UnitPrice
from Products
where CategoryID = '6'


-- LIKE --

-- LIKE  ‘BR%' napisy zaczynające się od BR
-- LIKE  'Br%' napisy zaczynające się od Br
-- LIKE  ‘%een' napisy kończące się na een
-- LIKE  '%en%' napisy mające w środku en
-- LIKE  '_en' pierwsza litera dowolna a następnie en
-- LIKE  '[CK]%' pierwsza litera C lub K
-- LIKE  '[S-V]%' pierwsza litera S do V
-- LIKE  'M[^c]%' pierwsza litera M druga litera różna od c

--  Szukamy informacji o produktach sprzedawanych w butelkach (‘bottleʼ)
select ProductName, QuantityPerUnit
from Products
where QuantityPerUnit like '%bottle%'

-- Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na
-- literę z zakresu od B do L
select Title, LastName, FirstName
from Employees
where LastName like '[B-L]%'

-- OPERATORY --

--Wybierz zamówienia złożone w latach: 1997 do 1998
select OrderID, OrderDate
from Orders
where OrderDate between '01.01.1997' and '01.01.1998'

-- ORDER BY --

select CompanyName, Country
from Customers
order by Country



























--==================================================================
-- End of 1-0 select
--==================================================================

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
