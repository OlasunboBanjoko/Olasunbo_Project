--CREATE A DATABASE AND NAME IT UNION BANK

CREATE DATABASE UNIONBANK;

CREATE SCHEMA BORROWER

CREATE TABLE BORROWER.BORROWER (
BorrowerID int not null,
BorrowerFirstName varchar (255) not null,
BorrowerMiddleInitial char (1) not null,
BorrowerLastName varchar (255) not null,
DOB Datetime not null,
Gender char (1) null,
TaxPayerID_SSN varchar (9) not null,
PhoneNumber varchar (10) not null,
Email varchar (255) not null,
Citizenship varchar (255) null,
Beneficiaryname varchar (255) null,
IsUscitizen bit null,
CreateDate datetime not null);

create table BORROWER.BORROWERADDRESS (
AddressID int not null,
BorrowerID int not null,
StreetAddress varchar (255) not null,
ZIP varchar (5) not null,
CreateDate Datetime not null);


CREATE TABLE CALENDAR (
CalendarDate datetime null);

create table [State] (
StateID char (2) not null,
StateName varchar (255) not null,
CreateDate datetime not null);

create table US_Zipcodes (
IsSurrogateKey int not null,
ZIP varchar (5) not null,
Latitude float null,
Longitude float null,
City varchar (255) null,
State_id char (2) null,
[Population] int null,
Density decimal (18,0) null,
county_fips varchar (10) null,
county_name varchar (255) null,
county_names_all varchar (255) null,
county_fips_all varchar (50) null,
timezone varchar (255) null,
CreateDate datetime not null);

create schema LOAN 

CREATE table LOAN.LOANSETUPINFORMATION (
IsSurrogateKey int not null,
LoanNumber varchar (10) not null,
PurchaseAmount numeric (18,2) not null,
PurchaseDate datetime not null,
LoanTerm int not null,
BorrowerID int not null,
UnderwriterID int not null,
ProductID char (2) not null,
InterestRate decimal (3,2) not null,
PaymentFrequency int not null,
AppraisalValue numeric (18,2) not null,
CreateDate datetime not null,
LTV decimal (4,2) not null,
FirstInterestPaymentDate datetime null,
MaturityDate datetime not null);

create table LOAN.LOANPERIODIC (
Issurrogatekey INT NOT NULL,
Loannumber varchar (10) not null,
Cycledate datetime not null,
Extramonthlypayment numeric (18,2) not null,
Unpaidprincipalbalance numeric (18,2) not null,
Beginningschedulebalance numeric (18,2) not null,
Paidinstallment numeric (18,2) not null,
Interestportion numeric (18,2) not null,
Principalportion numeric (18,2) not null,
EndScheduledbalance numeric (18,2) not null,
Actualendschedulebalance numeric (18,2) not null,
Totalinterestaccrued numeric (18,2) not null,
Totalprincipalaccrued numeric (18,2) not null,
DEFAULTPENALTY numeric (18,2) not null,
Delinquencycode int identity (10,10) not null, --increament by 0, added code identity, requirement given was 10,0
Createdate datetime not null);
drop table LOAN.LOANPERIODIC

create table LOAN.LU_DELINQUENCY (
DelinquencyCode int not null,
Delinquency varchar (255) not null);

create table LOAN.LU_PAYMENTFREQUENCY (
PaymentFrequency int not null,
PaymentIsMadeEvery int not null,
PaymentFrequency_Description varchar (255) not null)

create table LOAN.UNDERWRITER (
UnderwriterID int not null,
UnderwriterFirstName varchar (255) null,
UnderwriterMiddleInitial char (1) null,
UnderwriterLastName varchar (255) not null,
PhoneNumber varchar (14) null,
Email varchar (255) not null,
CreateDate datetime not null)


alter table BORROWER.BORROWER
add constraint pk_borrower_borrowerid primary key (BorrowerID);

alter table BORROWER.BORROWERADDRESS
add constraint pk_borroweraddress_addressid_borrowerid primary key (AddressID,BorrowerID);

alter table LOAN.LOANPERIODIC
add constraint pk_loanperiodic_loannumber_cycledate primary key (Loannumber,Cycledate);

alter table LOAN.LOANSETUPINFORMATION
add constraint pk_loansetupinformation_loannumber primary key (LoanNumber);

alter table LOAN.LU_DELINQUENCY
add constraint pk_loanludelinquency_delinquencycode primary key (DelinquencyCode);

alter table LOAN.LU_PAYMENTFREQUENCY
add constraint pk_loanlupaymentfrequency_paymentfrequency primary key (PaymentFrequency);

alter table dbo.State
add constraint pk_state_stateid primary key (StateID);

alter table LOAN.UNDERWRITER
add constraint pk_loanunderwriter_underwriterid primary key (UnderwriterID);

alter table dbo.US_Zipcodes
add constraint pk_uszipcodes_zip primary key (Zip);

alter table BORROWER.BORROWER
add constraint chk_borrower_dob check (DOB<dateadd(year,-18,getdate()))

alter table BORROWER.BORROWER
add constraint chk_borrower_email check (email like '%@%')

alter table BORROWER.BORROWER
add constraint chk_borrower_phonenumber check (len(PhoneNumber)=10)

alter table BORROWER.BORROWER
add constraint chk_borrower_ssn check (len(TaxPayerID_SSN)=9) 

alter table BORROWER.BORROWER
add constraint df_borrower_createdate default (getdate()) for CreateDate;

alter table BORROWER.BORROWERADDRESS
add constraint df_borroweraddress_createdate default (getdate()) for CreateDate;

alter table BORROWER.BORROWERADDRESS
add constraint fk_borroweraddress_borrowerid foreign key (BorrowerID) references Borrower.Borrower (BorrowerID)

alter table BORROWER.BORROWERADDRESS
add constraint fk_borroweraddress_zip foreign key (ZIP) references US_ZipCodes (ZIP) 

alter table LOAN.LOANPERIODIC
add constraint chk_loanperiodic_interestportion_principalportion check (interestportion+Principalportion=Paidinstallment)
 
alter table LOAN.LOANPERIODIC
add constraint df_loanperiodic_createdate default (getdate()) for Createdate

alter table LOAN.LOANPERIODIC
add constraint df_loanperiodic_extramonthlypayment default (0) for Extramonthlypayment 

alter table LOAN.LOANPERIODIC
add constraint fk_loanperiodic_loannumber foreign key (Loannumber) references loan.LoanSetUpInformation (LoanNumber) 

alter table LOAN.LOANPERIODIC
add constraint fk_loanperiodic_delinquencycode foreign key (DelinquencyCode) references loan.lu_delinquency (Delinquencycode)

alter table LOAN.LOANSETUPINFORMATION
add constraint chk_loansetupinformation_loanterm check (loanterm in(35,30,15,10))

alter table LOAN.LOANSETUPINFORMATION
add constraint chk_loansetupinformation_loanterm check (loanterm =35 or loanterm =30 or loanterm=15 or loanterm=10)

alter table LOAN.LOANSETUPINFORMATION
add constraint chk_loansetupinformation_interestrate check (Interestrate between 0.01 and 0.03);

alter table LOAN.LOANSETUPINFORMATION
Add constraint df_loansetupinformation_createdate default (Getdate ()) for CreateDate

alter table LOAN.LOANSETUPINFORMATION
add constraint fk_loansetupinformation_borrowerid foreign key (BorrowerID) references Borrower.Borrower (BorrowerID) 

Alter Table LOAN.LOANSETUPINFORMATION
Add Constraint fk_loansetupinformation_Paymentfrequency foreign Key (PaymentFrequency) References LOAN.LU_PAYMENTFREQUENCY (PaymentFrequency)

Alter Table LOAN.LOANSETUPINFORMATION
Add Constraint fk_loansetupinformation_Underwriterid foreign Key (UnderwriterID) References LOAN.UNDERWRITER (UnderwriterID)

Alter Table DBO.[STATE]
Add Constraint df_State_Createdate default (Getdate()) for CreateDate

Alter Table DBO.[STATE]
Add Constraint Uc_State_StateName Unique (StateName)

Alter Table LOAN.UNDERWRITER
add constraint chk_underwriter_email check (Email like '%@%')                              "

alter table LOAN.UNDERWRITER
add constraint df_underwriter_createdate default (getdate ()) for CreateDate

alter table DBO.US_Zipcodes
add constraint df_us_zipcodes_createdate default (getdate ()) for CreateDate

ALTER TABLE DBO.US_ZIPCODES
ADD CONSTRAINT FK_US_ZIPCODES_STATEID FOREIGN KEY (STATE_ID) REFERENCES LOAN.UNDERWRITER (UNDERWRITERID);
--ERROR Column 'LOAN.UNDERWRITER.UnderwriterID' is not the same data type as referencing column 'US_ZIPCODES.STATE_ID' in foreign key 'FK_US_ZIPCODES_STATEID'