use library

-- Napisz polecenie select  za pomocą którego uzyskasz identyfikator/numer tytułu oraz
-- tytuł książki
--==================================================================
-- Begining of 3-0
--==================================================================

-- Union suma zbiorow

select lastname
from member m join adult a on m.member_no = a.member_no
where state = 'AZ'
union all
select lastname
from member m join adult a on m.member_no = a.member_no
where state = 'CA'


-- Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają  więcej niż dwoje dzieci zapisanych do biblioteki
select m.member_no, lastname, firstname
from member m 
join adult a 
on m.member_no = a.member_no
join juvenile j 
on a.member_no = j.adult_member_no
where state = 'AZ'
group by m.member_no, lastname, firstname
having count(*) >2


-- Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają  więcej niż dwoje dzieci zapisanych do biblioteki 
-- oraz takich którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci zapisanych do biblioteki

select m.member_no, lastname, firstname
from member m 
join adult a 
on m.member_no = a.member_no
join juvenile j 
on a.member_no = j.adult_member_no
where state = 'AZ'
group by m.member_no, lastname, firstname
having count(*) >2 
union 
select m.member_no, lastname, firstname
from member m 
join adult a 
on m.member_no = a.member_no
join juvenile j 
on a.member_no = j.adult_member_no
where state = 'CA'
group by m.member_no, lastname, firstname
having count(*) >3


select m.member_no, lastname, firstname
from member m 
join adult a 
on m.member_no = a.member_no
join juvenile j 
on a.member_no = j.adult_member_no
where state = 'AZ'


-- without union
select m.member_no, lastname, firstname
from member m 
join adult a 
on m.member_no = a.member_no
join juvenile j 
on a.member_no = j.adult_member_no
group by m.member_no, lastname, firstname
having (count(*) >2 and max(state) = 'AZ') or (count(*) >3 and max(state) = 'CA')

select m.member_no, lastname, firstname
from member m 
join adult a 
on m.member_no = a.member_no
join juvenile j 
on a.member_no = j.adult_member_no
group by m.member_no, lastname, firstname, [state]
having (count(*) >2 and max(state) = 'AZ')



--==================================================================
-- End of 3-0
--==================================================================