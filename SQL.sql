--���������� DDL
--��������ҧ�ҹ������
--CREATE DATABASE [6419410031]
--CREATE DATABASE TESTDATA

--�����ź�ҹ������
--DROP DATABASE [6419410031]
--DROP DATABASE ReportServer
--DROP DATABASE ReportServerTempDB

--������ҧ Table


--FOREIGN KEY() REFERENCES
CREATE TABLE Category(
	Cate_ID	CHAR(3) NOT NULL UNIQUE,
	Cate_Name  varchar(30)
	PRIMARY KEY(Cate_ID)
)



CREATE  TABLE  Products( ProductID  char(7)  NOT  NULL  UNIQUE,
  ProductName  varchar(30),
  UnitPrice    Money,
  QTY  Int,
  CategoryID  char(3),
  PRIMARY KEY(ProductID),
  FOREIGN KEY(CategoryID) REFERENCES Category(Cate_ID)
    ON  DELETE  NO ACTION
    ON  UPDATE CASCADE
)



CREATE  TABLE  Products1( ProductID  char(7)  NOT  NULL  UNIQUE,
  ProductName  varchar(30),
  UnitPrice    Money,
  QTY  Int,
  CategoryID  char(3),
  PRIMARY KEY(ProductID)
)

-- ��������� Columns ŧ� Table
ALTER TABLE Products
ADD unit	varchar(15)


--�������� Columns � Table
ALTER TABLE Products
ALTER COLUMN ProductName	varchar(40)


--�����ź Columns � Table
ALTER TABLE Products
DROP COLUMN unit


--Adding a column with a constraint
ALTER TABLE Products ADD ABC VARCHAR(20) NULL
CONSTRAINT exb_unique UNIQUE

ALTER TABLE Products WITH NOCHECK
ADD CONSTRAINT exd_check CHECK (ABC > 1)



--ź Domain
ALTER TABLE Products DROP CONSTRAINT exb_unique
ALTER TABLE Products DROP CONSTRAINT exd_check


--���ҧ INDEX
CREATE INDEX nameIndex ON Products(ProductName);

--ź INDEX
DROP INDEX nameIndex O

--�֧�����ŷ�����
SELECT * FROM study

--�֧�����źҧ column
SELECT Name, Subject, Mark FROM study

--����¹�������ҡ Mark �� ��ṹ ��� Name �� NAME
SELECT Name NAME, Subject, Mark  As '��ṹ' FROM study

SELECT * FROM Study
WHERE Sex = '���' and Mark > 70

SELECT Name, Subject, Mark FROM Study WHERE Mark > 70

-- ��áӨѴ�����ŷ���ӡѹ DISTINCT
SELECT DISTINCT Subject FROM Study
SELECT DISTINCT Name FROM Study

SELECT DISTINCT Subject, Sex FROM Study

-- ���º��º���͹� >, >=, <, <=, <>, =, and , or, not
SELECT * FROM Study
WHERE Mark > 70

SELECT * FROM Study
WHERE Mark >= 70 and Mark <=80

-- ���º��º���͹� IN MEAN SAME OR
SELECT * FROM Study 
WHERE Mark in(88, 60, 80, 73)

SELECT * FROM Study 
WHERE Subject in('������', '��Ե��ʵ��')

-- ���º��º���͹� BETWEEN...AND...
SELECT * FROM Study
WHERE Mark BETWEEN 75 AND 80

-- ���������������
SELECT Study.* FROM Study
SELECT S.* FROM Study AS S
SELECT S.* FROM Study S

-- �Ӷ���ʴ����͹ѡ�֡�� ������¹ ��Ե��ʵ�� ��� ������
SELECT Std.Name FROM Study AS Std
Where Std.Subject in('��Ե��ʵ��','������') AND Std.Subject = '������'

SELECT Std.Name FROM Study AS Std
Where Std.Subject = '��Ե��ʵ��'
AND Name in(SELECT Std.Name FROM Study AS Std
Where Std.Subject = '������')

-- �Ӷ���ʴ����͹ѡ�֡�� �� ������¹ ��Ե��ʵ�� ��ṹ�����ҧ 50-70 ��� �����ѧ��� ��ṹ�����ҧ 50-70
SELECT Name, Sex FROM Study
WHERE Subject = '��Ե��ʵ��' and Mark between 50 and 70 and name in(
SELECT Name FROM Study WHERE Subject = '�����ѧ���' and Mark between 50 and 70)


-- ���º��º���͹� LIKE ����¡Ѻ��ҡѺ
SELECT * FROM Book
WHERE Book_Name LIKE 'DATA%' --��鹵鹵�ͧ�� Data

SELECT * FROM Book
WHERE Book_Name LIKE '%s' --��鹵����á��� ��ŧ���µ�ͧ�� s

SELECT * FROM Book
WHERE Book_Name LIKE '%V%' --������ v ����㹢�����

SELECT * FROM Book
WHERE Book_Name LIKE '___a%' --��ҹ˹�����ʹ� 3 ����á ��Ƿ�� 4 ��ͧ�� a ��ҹ��ѧ�����á���

-- ��èѴ���§������ (ORDER BY)
SELECT * FROM Study ORDER BY Mark ASC --�Ѵ���§�ҡ���� � �ҡ
SELECT * FROM Study ORDER BY Mark DESC --�ѧ���§�ҡ�ҡ � ����
SELECT * FROM Study ORDER BY Mark DESC, Sex asc
SELECT * FROM Study ORDER BY 4 DESC, 2 asc

/*����觷ҧ��Ե��ʵ��
MAX �Ҥ���٧�ش
MIN �Ҥ�ҵ���ش
AVG �Ҥ�������
SUM �Ҽ����
COUNT �Ѻ�ӹǹ
*/

SELECT * FROM Employee
SELECT COUNT(*) AS COUNTEM FROM Employee
SELECT MAX(Salary) AS MAXSALARY FROM Employee
SELECT MIN(Salary) AS MINSALARY FROM Employee
SELECT AVG(Salary) AS AVGSALARY FROM Employee
SELECT SUM(Salary) AS SUMSALARY FROM Employee

SELECT
	COUNT(*) AS COUNTEM,
	MAX(Salary) AS MAXSALARY,
	MIN(Salary) AS MINSALARY,
	AVG(Salary) AS AVGSALARY,
	SUM(Salary) AS SUMSALARY
FROM
	Employee

SELECT Subject, COUNT(*) AS '�ӹǹ' FROM Study
GROUP BY Subject

SELECT 
	Subject,
	COUNT(*) AS CountSub,
	MAX(Mark) AS MaxMark,
	MIN(Mark) AS MinMark,
	AVG(Mark) AS AverageMark
FROM
	Study
GROUP BY Subject
ORDER BY MaxMark DESC, AverageMark asc /*Or use MAX(Mark)*/

SELECT 
	Subject,
	Sex,
	COUNT(*) AS CountSub,
	MAX(Mark) AS MaxMark,
	MIN(Mark) AS MinMark,
	AVG(Mark) AS AverageMark
FROM
	Study
WHERE Sex = '���'
GROUP BY Sex, Subject
--HAVING Sex = '���' ��óշ���ա��������ä�Ե��ʵ��
ORDER BY Subject,Sex, CountSub DESC, MaxMark DESC, MinMark DESC

SELECT * FROM Study

--��Ե��ʵ�� +, -, *, /
SELECT Name, Surname, Salary FROM Employee As Emp

SELECT Name, Surname, Salary, Salary+(Salary*0.05) AS Up5 FROM Employee As Emp

SELECT *, ROUND(Mark*100.0/150,2) AS Percenof150 FROM Study


--������ͧ�§���ҧ (joining table)
--���ҧ������׺�鹢�����
SELECT * FROM Book
SELECT * FROM Publisher
SELECT * FROM Categor

SELECT * FROM Book, Publisher

SELECT Bk.Book_Name, Pub.Publisher_ID FROM Book AS Bk, Publisher AS Pub

--2 Table like where
SELECT Bk.Book_ID, Bk.Book_Name, Pub.Publisher_Name, Bk.[Printed Year], Bk.Price, Bk.Quantity
FROM Book AS Bk, Publisher AS Pub
WHERE BK.Publisher_ID = Pub.Publisher_ID

--3 Table like where
SELECT Bk.Book_ID, Bk.Book_Name, Pub.Publisher_Name, Bk.[Printed Year], Bk.Price, Bk.Quantity, Cat.Cat_Name
FROM Book AS Bk, Publisher AS Pub, Categor AS Cat
WHERE BK.Publisher_ID = Pub.Publisher_ID
	AND Bk.Cat_ID = Cat.Cat_ID AND Bk.Price > 600

SELECT Cat.Cat_Name, COUNT(Bk.Book_ID)
FROM Book AS Bk, Publisher AS Pub, Categor AS Cat
WHERE BK.Publisher_ID = Pub.Publisher_ID
	AND Bk.Cat_ID = Cat.Cat_ID
GROUP BY Cat.Cat_Name

--2 table like Join
SELECT Bk.Book_ID, Bk.Book_Name, Pub.Publisher_Name, Bk.[Printed Year], Bk.Price, Bk.Quantity
FROM Book AS Bk JOIN Publisher AS Pub ON(Bk.Publisher_ID = Pub.Publisher_ID)
WHERE Bk.Price > 500

--2 Table like INNER JOIN
SELECT Bk.Book_ID, Bk.Book_Name, Pub.Publisher_Name, Bk.[Printed Year], Bk.Price, Bk.Quantity
FROM Book AS Bk INNER JOIN Publisher AS Pub ON(Bk.Publisher_ID = Pub.Publisher_ID)

--2 Table like LEFT JOIN RIGHT JOIN
SELECT Bk.Book_ID, Bk.Book_Name, Pub.Publisher_Name, Bk.[Printed Year], Bk.Price, Bk.Quantity
FROM Book AS Bk RIGHT OUTER JOIN Publisher AS Pub ON(Bk.Publisher_ID = Pub.Publisher_ID)

SELECT Bk.Book_ID, Bk.Book_Name, Pub.Publisher_Name, Bk.[Printed Year], Bk.Price, Bk.Quantity
FROM Book AS Bk RIGHT OUTER JOIN Publisher AS Pub ON(Bk.Publisher_ID = Pub.Publisher_ID)
WHERE Bk.Book_Name IS NULL

SELECT Bk.Book_ID, Bk.Book_Name, Pub.Publisher_Name, Bk.[Printed Year], Bk.Price, Bk.Quantity
FROM Book AS Bk LEFT OUTER JOIN Publisher AS Pub ON(Bk.Publisher_ID = Pub.Publisher_ID)

--�ͺ ����ʴ������� ����Ἱ� ����Ἱ� �����Ҥ ���բ���������ʴ�੾�� North American ��� South America �Ѵ���§��� Region �������ҡ
SELECT * FROM Department --ID Name Region_ID
SELECT * FROM Region --ID Region

SELECT 
	Dept.ID AS DeptmentID, 
	Dept.Name AS DeptmentName, 
	Re.Region AS DeptmentRegion
FROM Department AS Dept INNER JOIN Region AS Re ON(Dept.Region_ID = Re.ID)
WHERE Re.Region = 'North America' AND Region IN(SELECT Re.Region FROM Region AS Re WHERE Re.Region = 'South America')
ORDER BY Re.Region ASC

SELECT 
	Dept.ID AS DeptmentID, 
	Dept.Name AS DeptmentName, 
	Re.Region AS DeptmentRegion
FROM Department AS Dept INNER JOIN Region AS Re ON(Dept.Region_ID = Re.ID)
WHERE Re.Region IN('North America', 'South America')
ORDER BY Re.Region ASC

SELECT Std.Name FROM Study AS Std
Where Std.Subject = '��Ե��ʵ��'
AND Name in(SELECT Std.Name FROM Study AS Std
Where Std.Subject = '������')

SELECT b.Book_ID, b.Book_Name, p.Publisher_Name, [Printed Year], c.Cat_Name, Price, Quantity 
FROM Book AS b INNER JOIN Publisher AS p on(b.Publisher_ID = p.Publisher_ID) 
FULL JOIN Categor AS c on(c.Cat_ID = b.Cat_ID)

SELECT b.Book_ID, b.Book_Name, p.Publisher_Name, [Printed Year], c.Cat_Name, Price, Quantity 
FROM Book AS b FULL JOIN Publisher AS p on(b.Publisher_ID = p.Publisher_ID) 
FULL JOIN Categor AS c on(c.Cat_ID = b.Cat_ID)

--Union ��ͧ�͵�Ժ����ҡѹ �������ǡѹ
SELECT b.Book_ID, b.Book_Name, p.Publisher_Name, [Printed Year], c.Cat_Name, Price, Quantity 
FROM Book AS b INNER JOIN Publisher AS p on(b.Publisher_ID = p.Publisher_ID) 
RIGHT JOIN Categor AS c on(c.Cat_ID = b.Cat_ID) UNION
SELECT b.Book_ID, b.Book_Name, p.Publisher_Name, [Printed Year], c.Cat_Name, Price, Quantity 
FROM Book AS b INNER JOIN Publisher AS p on(b.Publisher_ID = p.Publisher_ID) 
LEFT OUTER JOIN Categor AS c on(c.Cat_ID = b.Cat_ID)

SELECT * FROM Book

SELECT BK.Book_ID, BK.Book_Name, BK.Price FROM Book AS BK
WHERE BK.Price>800 UNION
SELECT BK.Book_ID, BK.Book_Name, BK.Price FROM Book AS BK
WHERE BK.Price<900

--intersection
SELECT BK.Book_ID, BK.Book_Name, BK.Price FROM Book AS BK
WHERE BK.Price>800 INTERSECT
SELECT BK.Book_ID, BK.Book_Name, BK.Price FROM Book AS BK
WHERE BK.Price<900

SELECT * FROM Book
SELECT * FROM Publisher
SELECT * FROM Categor

SELECT B.Book_ID, B.Book_Name, b.[Printed Year], B.Price, B.Quantity,
	P.Publisher_ID, P.Publisher_Name, P.City,
	C.Cat_ID, C.Cat_Name
FROM Book AS B INNER JOIN Publisher AS P ON(B.Publisher_ID=p.Publisher_ID)
INNER JOIN Categor AS C ON(C.Cat_ID=b.Cat_ID)


--create view
CREATE VIEW ShowBookView
AS SELECT B.Book_ID, B.Book_Name, b.[Printed Year], B.Price, B.Quantity,
	P.Publisher_ID, P.Publisher_Name, P.City,
	C.Cat_ID, C.Cat_Name
FROM Book AS B INNER JOIN Publisher AS P ON(B.Publisher_ID=p.Publisher_ID)
INNER JOIN Categor AS C ON(C.Cat_ID=b.Cat_ID)

SELECT * FROM ShowBookView

SELECT * FROM Book

CREATE VIEW	BookView AS
SELECT * FROM Book

SELECT Book_ID, Book_Name FROM BookView

DROP VIEW BookView

SELECT * FROM TestView1

SELECT * FROM View_1

SELECT        dbo.Employee.ID AS Expr2, dbo.Employee.Name AS Expr3, dbo.Employee.Surname AS Expr4, dbo.Employee.Start_Date AS Expr5, dbo.Employee.Title AS Expr6, dbo.Employee.Dept_ID AS Expr7, dbo.Employee.Salary AS Expr8,
                          dbo.Department.Name AS Expr1, dbo.Department.Region_ID, dbo.Employee.ID, dbo.Employee.Name, dbo.Employee.Surname, dbo.Employee.Start_Date, dbo.Employee.Title, dbo.Employee.Dept_ID, dbo.Employee.Salary
FROM            dbo.Employee INNER JOIN
                         dbo.Department ON dbo.Employee.Dept_ID = dbo.Department.ID

SELECT * FROM Publisher

INSERT INTO Publisher VALUES('Pub10', 'Southeast Asia University', 'Bangkok')

INSERT INTO Publisher(Publisher_ID, Publisher_Name) VALUES('Pub11', 'U.S. Air Forc')

SELECT * FROM Publisher
WHERE Publisher_ID = 'Pub11'

UPDATE Publisher
SET City = 'California', 
WHERE Publisher_ID = 'Pub11'

--test ��������Ҥ�˹ѧ��͢�鹨ҡ����ա 5% ੾��˹ѧ��ͷ���Ҥ��ҡ���� 800
SELECT * FROM Book
WHERE Price > 800

UPDATE Book
SET Price = Price*1.05
WHERE Price > 800