-- Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’.
-- Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę

-- select on_loan, isbn from copy
-- select out_date from loanhist
-- wrong

-- Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
-- select member.lastname , member_no
-- from member
-- where lastname = "Graff" left outer join sales s  
-- on b.buyer_id = s.buyer_id

-- select isbn from reservation
-- join member on member_no = member_no
-- where firstname = "Stephen"
-- wrong

--=====================================================================


--Dla każdego dorosłego czytelnika podaj liczbę jego dzieci.

--Dla każdego dorosłego czytelnika podaj liczbę jego dzieci urodzonych przed 1998r