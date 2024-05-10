create database buyYourBooks;
use buyYourBooks;

Create table Book (
Bookid varchar(10) primary key, Bookname varchar(20), Category varchar(20));
Insert into Book values ('B101', 'Science Revolution', 'Journal'); 
Insert into Book values ('B102', 'Brain Teasers', 'Aptitude'); 
Insert into Book values ('B103', 'India Today', 'Magazine'); 
Insert into Book values ('B104', 'Tech World', 'Journal');
Insert into Book values ('B105', 'Bizz world', 'Magazine'); 
Insert into Book values ('B106', 'The Quests', 'Aptitude');

create table customer(
custid varchar(10) primary key,
custname varchar(20));
Insert into customer values('C101', 'Jack'); 
Insert into customer values('C102', 'Anne'); 
Insert into customer values('C103', 'Jane'); 
Insert into customer values('C104', 'Maria');

create table purchase(
purchaseid varchar(10) primary key,
custid varchar(10) references customer(custid),
bookid varchar(10) references book(bookid),
purchasedate date );
Insert into purchase values ('P201','C101', 'B102','2019-12-12');
Insert into purchase values ('P202','C102','B103','2019-11-25');
Insert into purchase values ('P203','C103', 'B104','2019-12-12');
Insert into purchase values ('P204','C104', 'B105','2019-11-25');
Insert into purchase values ('P205','C101', 'B101','2019-12-11');
Insert into purchase values ('P206','C101', 'B106','2019-12-12');
select * from book;
select * from customer;
select * from purchase;

select custid, count(distinct purchasedate) AS num_of_books
from purchase
group by custid
having count(distinct purchasedate) > 1;

select p.custid, b.Bookname
from purchase p
join customer c on p.custid = c.custid
join Book b on p.Bookid = b.Bookid
where b.Category in (
    select b1.Category
    from Book b1
    join purchase p1 on b1.Bookid = p1.Bookid
    group by b1.Category
    having count(distinct p1.custid) > 1 and count(distinct p1.purchasedate) > 1
)
order by p.custid;



select c.custname, b.Bookname
from customer c
join purchase p on c.custid = p.custid
join Book b on p.Bookid = b.Bookid
where p.purchasedate = (
    select purchasedate
    from purchase
    where custid = (
        select custid
        from customer
        where custname = 'Anne'
    )
)
and c.custname != 'Anne';

drop database buyYourBooks;
