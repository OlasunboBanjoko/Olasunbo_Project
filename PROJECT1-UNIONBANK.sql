SELECT  B.BORROWERID,
CONCAT(A.BorrowerFirstName, '  ',A.BorrowerMiddleInitial, '  ' , A.BorrowerLastName) AS BorrowerFullName,
STUFF(A.TaxPayerID_SSN, 1,5, '***-**')  AS SSN,YEAR(B.PurchaseDate)AS [YEAR OF PURCHASE],
[PurchaseAmount (IN THOUSAND)]=FORMAT(PURCHASEAMOUNT/1000, 'C0')+'K' 
FROM dbo.Borrower AS A
RIGHT  JOIN dbo.LoanSetupInformation AS B ON A.BORROWERID=B.BORROWERID;

SELECT  A.BORROWERID,
CONCAT(A.BorrowerFirstName, '  ',A.BorrowerMiddleInitial, '  ' , A.BorrowerLastName) AS BorrowerFullName,
STUFF(A.TaxPayerID_SSN,1,5,'***_**')  AS SSN,YEAR(B.PurchaseDate) AS [YEAR OF PURCHASE],
[PurchaseAmount (IN THOUSAND)]=FORMAT(PURCHASEAMOUNT/1000, 'C0')+'K' 
FROM dbo.Borrower AS A
LEFT  JOIN dbo.LoanSetupInformation AS B ON A.BORROWERID=B.BORROWERID;

[Yesterday 10:11 PM] aodulawa2001 (Guest)
    
 SELECT  B.BORROWERID,
CONCAT(A.BorrowerFirstName, '  ',A.BorrowerMiddleInitial, '  ' , A.BorrowerLastName) AS BorrowerFullName,
STUFF(A.TaxPayerID_SSN, 1,5, '***-**')  AS SSN,YEAR(B.PurchaseDate)AS [YEAR OF PURCHASE],
[PurchaseAmount (IN THOUSAND)]=FORMAT(PURCHASEAMOUNT/1000, 'C0')+'K' 
FROM dbo.Borrower AS A
RIGHT  JOIN dbo.LoanSetupInformation AS B ON A.BORROWERID=B.BORROWERID;

 SELECT  A.BORROWERID,
CONCAT(A.BorrowerFirstName, '  ',A.BorrowerMiddleInitial, '  ' , A.BorrowerLastName) AS BorrowerFullName,
STUFF(A.TaxPayerID_SSN,1,5,'***_**')  AS SSN,YEAR(B.PurchaseDate) AS [YEAR OF PURCHASE],
[PurchaseAmount (IN THOUSAND)]=FORMAT(PURCHASEAMOUNT/1000, 'C0')+'K' 
FROM dbo.Borrower AS A
LEFT  JOIN dbo.LoanSetupInformation AS B ON A.BORROWERID=B.BORROWERID;


select  A.CITIZENSHIP,
FORMAT(SUM(PurchaseAmount), 'c0') AS [TOTAL PURCHASEAMOUNT],
FORMAT(avg(B.PurchaseAmount),'c0') as [average purchase amount],
count(B.BorrowerID) as [count of borrowers],
concat(avg(LTV),'%') as [average ltv],
concat(min(LTV),'%') AS [MINIMUM lTV],
concat(MAX(LTV),'%') AS [Maximum ltv]
FROM   LoanSetupInformation AS B
INNER JOIN [dbo].[Borrower] AS A ON A.BorrowerID=B.BorrowerID
GROUP BY A.CITIZENSHIP,B.PurchaseAmount
ORDER BY [PurchaseAmount] DESC



