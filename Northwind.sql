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

--==================================================================
-- Begining of 2-0
--==================================================================
-- TOP --

-- COUNT  liczba wierszy --
-- COUNT (*) same --
-- MIN  wartość minimalna --
-- MAX wartość maksymalna --
-- SUM suma --
-- AVG wartosć średnia --
-- GROUP BY --
-- GROUP BU CUBE --
-- -||- SETS --

-- HAVING --
-- ROLLUP --


--==================================================================
-- End of 2-0
--==================================================================

--==================================================================
-- Begining of 3-0
--==================================================================

-- JOIN --

-- Napisz polecenie zwracające nazwy produktów i firmy je dostarczające
-- tak aby produkty bez dostawców i dostawcy bez produktów nie pojawiali się
select p.ProductName, s.CompanyName
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID

-- OUTER JOIN --

--Napisz polecenie zwracające wszystkich klientów z datami zamówień\
select c.CompanyName, c.CustomerID, o.OrderDate
from Customers as c
left outer join Orders as o
on o.CustomerID = c.CustomerID 

-- Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których
-- aktualnie nie  ma w magazynie
select s.CompanyName, s.Phone, p.ProductID
from Suppliers as s
join Products as p
on p.SupplierID = s.SupplierID
where p.UnitsInStock = 0

-- Dla każdego klienta podaj liczbę złożonych przez niego zamówień. Zbiór wynikowy
-- powinien zawierać nazwę klienta, oraz liczbę zamówień
select c.CompanyName, c.CustomerID, count(o.OrderID) as Orders
from Customers as c
join Orders as o
on o.CustomerID = c.CustomerID
join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName, c.CustomerID
order by count(o.OrderID) desc

-- Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, 
-- dla każdego produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
use Northwind

select distinct p.UnitPrice, o.ShipAddress, p.ProductName
from Products as p
inner join [Order Details] as od 
on od.UnitPrice = p.UnitPrice and od.UnitPrice >= 20 and p.UnitPrice <= 30 and p.CategoryID = '6'
join Orders as o
on o.OrderID = od.OrderID
inner join Categories as c
on c.CategoryID = p.CategoryID
-- IDK

-- Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
select p.ProductName, p.UnitPrice, c.CategoryName
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID and CategoryName = 'Confections'



-- Dla każdego klienta podaj liczbę złożonych przez niego zamówień w marcu 1997r
select c.CompanyName, count(o.OrderID) as num
from Customers as c
left join Orders as o
on o.CustomerID = c.CustomerID and year(o.OrderDate) = 1997 and month(o.OrderDate) = 3
group by c.CompanyName, c.CustomerID
order by count(o.OrderID) desc


-- Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty  z kategorii ‘Confections’
select c.CompanyName, c.Phone
from Customers c
join Orders o
on o.CustomerID = c.CustomerID 
join [Order Details] od
on od.OrderID = o.OrderID 
join Products p
on p.ProductID = od.ProductID
join Categories k
on k.CategoryName = p.CategoryID and k.CategoryName = 'Confections'
group by k.CategoryID, c.CompanyName, c.Phone

-- Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty  z kategorii ‘Confections’

select distinct c.CompanyName, c.Phone
from Customers as c
join Orders as o 
on c.CustomerID = o.CustomerID
join [Order Details] as od 
on o.OrderID = od.OrderID
join Products as p 
on od.ProductID = p.ProductID
join Categories as ca 
on p.CategoryID = ca.CategoryID
where ca.CategoryName ='Confections'

--select distinct c.CompanyName, c.Phone
--from Customers as c
--where c.CustomersID not in{
--    select distinct o.CustomerID
--    from Orders o
--    inner join [Order Details] od 
--    on od.OrderID = o.OrderID
--    inner join Products p 
--    on p.ProductID = od.ProductID
--    inner join Categories cat 
--    on cat.CategoryID = p.CategoryID
--    where cat.CategoryName = 'Confesions'    
--}



-- Union suma zbiorow
select  firstname + ' ' + lastname as name,city, postalcode  
from employees  
union  
select companyname, city, postalcode 
from customers

select 'a'
union all 
select 'a'

-- Intersect cesc wspolna 

-- państwa z których mamy zarówno klientów jak i dostawców
select country from customers  
intersect  
select country from suppliers

-- Except roznica
select customerid from orders where year(orderdate) = 1997  
except  
select customerid from orders where year(orderdate) = 1996
--==================================================================
-- End of 3-0
--==================================================================


--==================================================================
-- Begining of 3-1
--==================================================================

-- додому до хати

--==================================================================
-- End of 3-1
--==================================================================

--==================================================================
-- Begining of 4-0
--==================================================================

-- W  miejscu w którym możemy użyć nazwy tabeli, możemy użyć podzapytania
select t.orderid, t.customerid  
 from (select orderid, customerid  
         from orders) as t

-- Zwraca tylko 1 linieke
select productname, unitprice  
     , (select avg(unitprice) from products) as average 
     , UnitPrice - (select avg(unitprice) from products) as diff
from products
where UnitPrice > (select avg(unitprice) from products)


select productname, UnitPrice, CategoryID
    ,(select avg(UnitPrice)
    from products as p_in
    where p_in.CategoryID = p_in.CategoryID) as average
    , UnitPrice - (select avg(UnitPrice)
    from products as p_in
    where p_in.CategoryID = p_in.CategoryID) as diff
from Products p_out
where UnitPrice > (select avg(UnitPrice)
)



-- перевірка за допомоги except




--==================================================================
-- End of 4-0
--==================================================================


--========================================================================================================================
-- IDK what's down there, just let it be
--========================================================================================================================


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



