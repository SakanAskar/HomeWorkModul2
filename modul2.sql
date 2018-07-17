--1.	Написать хранимую процедуру, уменьшающую на 10% стоимость книг, изданных ранее 1998 года (1998 год не включается в условие). 
create procedure MinusPercentEarlierDate @Percent int, @Date int
as
Declare @Bookscnt int, @cnt_ int = 1, @BookPrice money = 0
select @Bookscnt = COUNT(b.N) from books b
while (@Bookscnt != @cnt_)
begin
	Set @BookPrice = 0
	select @BookPrice = b.Price from books b where YEAR(b.Date) < @Date and b.N = @cnt_ 
	if (@BookPrice != 0)
	begin
		Declare @MinusPerc money = @BookPrice
		Set @MinusPerc = (@MinusPerc / 100) * @Percent
		Set @BookPrice = @BookPrice -  @MinusPerc
		select b.Name, b.Date, @BookPrice BookPrice from books b where b.N = @cnt_ and YEAR(b.Date) < @Date
		--union all
	end
	Set	@cnt_ = @cnt_ + 1
end

Execute MinusPercentEarlierDate 10,1998

--2.	Написать хранимую процедуру, вставляющую 5 новых строк в таблицу «Издательства».
create procedure FiveNewStrtoPress 
as 
insert press (name) values ('---')
insert press (name) values ('---')
insert press (name) values ('---')
insert press (name) values ('---')
insert press (name) values ('---')

Execute FiveNewStrtoPress
select * from press p where p.name = '---'

--3.	Написать хранимую процедуру, подсчитывающую факториал числа. (5! = 1*2*3*4*5 = 120) (0! = 1) (факториала отрицательного числа не существует).
drop procedure FactorialofNum

create procedure FactorialofNum @num int
as 
Declare @Val int = 1, @cnt int = 1
if(@num>0)
begin 
	while(@cnt!=@num + 1)
	begin
		set @Val = @Val * @cnt
		set @cnt = @cnt + 1
	end
	raiserror('Factorial of %d: %d',0,1,@num,@val)
end
else
raiserror('num <= 0',0,1)

Execute FactorialofNum 5