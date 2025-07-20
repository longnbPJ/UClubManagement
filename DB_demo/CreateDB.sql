USE master;
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'CMA')
BEGIN
    ALTER DATABASE CMA SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CMA;
END
GO

CREATE DATABASE CMA
GO

USE CMA
GO

CREATE TABLE Semester (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    
    -- Ensure end_date is after start_date
    CONSTRAINT check_date_range CHECK (end_date > start_date)
);

-- Create index for faster queries based on date ranges
CREATE INDEX idx_semester_dates ON semester(start_date, end_date);

CREATE TABLE UserRole (
	UserRoleID INT PRIMARY KEY IDENTITY(1,1),
	UserRoleName varchar(10)
)

CREATE TABLE Account (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    Fullname NVARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    UserRoleID int,
	UserImgURL Nvarchar(max),
	UserDescription Nvarchar(max),
	Foreign key (UserRoleID) references UserRole(UserRoleID)
);

Create table StudentInfo (
	StudentID varchar(10) PRIMARY KEY,
	Major varchar(50),
	Course varchar(10),
	AccountID int,
	Foreign key (AccountID) references Account(AccountID)
)

CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    SenderID INT,
    Link Nvarchar(max),
    Title NVARCHAR(255),
    Message NVARCHAR(2000),
    CreatedAt DATETIME DEFAULT GETDATE(),
    DeliveryMethod NVARCHAR(50) NOT NULL DEFAULT 'in-app',
    FOREIGN KEY (SenderID) REFERENCES Account(AccountID) ON DELETE SET NULL
);

CREATE TABLE Receivant (
    NotificationID INT,
    ReceiverID INT,
    IsRead INT DEFAULT 0,
    PRIMARY KEY (NotificationID, ReceiverID),
    FOREIGN KEY (NotificationID) REFERENCES Notification(NotificationID) ON DELETE CASCADE,
    FOREIGN KEY (ReceiverID) REFERENCES Account(AccountID) ON DELETE CASCADE
);

CREATE TABLE Club (
    ClubID INT PRIMARY KEY IDENTITY(1,1),
	Manager INT,
    EstablishDate DATE,
    EstablishBy int,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (EstablishBy) REFERENCES Account(AccountID),
    FOREIGN KEY (Manager) REFERENCES Account(AccountID)
);

CREATE TABLE ClubMember(
    AccountID INT,
    ClubID INT,
	ClubRole varchar(100),
    JoinDate DATETIME DEFAULT GETDATE(),
	ApprovedBy INT,
    PRIMARY KEY (AccountID, ClubID),
    FOREIGN KEY (ApprovedBy) REFERENCES Account(AccountID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    Status NVARCHAR(50), -- Ví dụ: 'Upcoming', 'Ongoing', 'Finished'
	ClubID int,
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);

CREATE TABLE EventParticipant (
    EventID INT,
    AccountID INT,
	EventRole varchar(50),
    Status NVARCHAR(50), -- Ví dụ: 'Participated', 'Not Participated'
    PRIMARY KEY (EventID, AccountID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE Question (
    QuestionID INT PRIMARY KEY IDENTITY(1,1),
    ClubID INT,
    AccountID INT,
    Content NVARCHAR(1000) NOT NULL,
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE Answer (
    AnswerID INT PRIMARY KEY IDENTITY(1,1),
    QuestionID INT,
    AccountID INT,
    Content NVARCHAR(1000) NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE Announcement (
    AnnouncementID INT PRIMARY KEY IDENTITY(1,1),
    ClubID INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CreatedBy INT,
    Title NVARCHAR(200) NOT NULL,
    Content NVARCHAR(1000),
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
    FOREIGN KEY (CreatedBy) REFERENCES Account(AccountID)
);

CREATE TABLE Report (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT,
    ClubID INT,
	SemesterID INT,
	MemberQuantity int,
	MemberChanges int,
    EventSummary NVARCHAR(1000),
    CreatedAt DATETIME DEFAULT GETDATE(),
	ParticipationStats float,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
    FOREIGN KEY (SemesterID) REFERENCES Semester(ID)
);

CREATE TABLE RequestStatus (
	StatusID INT PRIMARY KEY IDENTITY(1,1),
	StatusName varchar(10)
)

CREATE TABLE Request (
    RequestID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT,
    ClubID INT,
    Type NVARCHAR(50), -- Ví dụ: 'Join Club', 'Leave Club'
    StatusID int, -- Ví dụ: 'Pending', 'Approved', 'Rejected'
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
    FOREIGN KEY (StatusID) REFERENCES RequestStatus(StatusID)
);

CREATE TABLE EventInfo (
	EventInfoID INT PRIMARY KEY IDENTITY(1,1),
	EventID INT NULL,
    RequestID INT NULL,
    EventName NVARCHAR(200) NOT NULL,
    EventDate DATE,
    EventLocation NVARCHAR(200),
    EventTime NVARCHAR(100),
    EventDesc NVARCHAR(1000),
    EventImgURL NVARCHAR(max),
	FOREIGN KEY (EventID) REFERENCES Event(EventID) ON DELETE SET NULL,
    FOREIGN KEY (RequestID) REFERENCES Request(RequestID) ON DELETE SET NULL,
    CHECK (EventID IS NOT NULL OR RequestID IS NOT NULL)  -- Bắt buộc phải thuộc ít nhất một
)

CREATE TABLE ClubInfo (
    ClubInfoID INT PRIMARY KEY IDENTITY(1,1),
    ClubID INT NULL,
	RequestID INT NULL,
    ClubName NVARCHAR(1000),
	ClubImgURL NVARCHAR(max),
    ClubDesc NVARCHAR(1000),
    EstablishDate DATE,
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
    FOREIGN KEY (RequestID) REFERENCES Request(RequestID),
    CHECK (ClubID IS NOT NULL OR RequestID IS NOT NULL)  -- Bắt buộc phải thuộc ít nhất một
);

GO
CREATE FUNCTION fn_GetCurrentSemesterID()
RETURNS INT
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @CurrentSemesterID INT = NULL;
    
    -- Find which semester contains the current date
    SELECT @CurrentSemesterID = id
    FROM semester
    WHERE @CurrentDate BETWEEN start_date AND end_date;
    
    -- If no semester is found for the current date, return NULL
    RETURN @CurrentSemesterID;
END;
