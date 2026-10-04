-- Create fresh database
CREATE DATABASE electricity_billing_system;
USE electricity_billing_system;

-- 1. Customers
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Postcode VARCHAR(10) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

-- 2. Tariffs
CREATE TABLE Tariffs (
    TariffID VARCHAR(10) PRIMARY KEY,
    TariffName VARCHAR(50) NOT NULL,
    PricePerUnit DECIMAL(5,2) NOT NULL,
    EffectiveDate DATE NOT NULL
);

-- 3. Meters
CREATE TABLE Meters (
    MeterID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    MeterType VARCHAR(30) NOT NULL,
    InstallationDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 4. Usage — with backticks
CREATE TABLE `Usage` (
    UsageID VARCHAR(10) PRIMARY KEY,
    MeterID VARCHAR(10) NOT NULL,
    TariffID VARCHAR(10) NOT NULL,
    Month VARCHAR(10) NOT NULL,
    UnitsConsumed INT NOT NULL,
    FOREIGN KEY (MeterID) REFERENCES Meters(MeterID),
    FOREIGN KEY (TariffID) REFERENCES Tariffs(TariffID)
);

-- 5. Bills
CREATE TABLE Bills (
    BillID VARCHAR(10) PRIMARY KEY,
    UsageID VARCHAR(10) NOT NULL,
    BillDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    TotalAmount DECIMAL(8,2) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (UsageID) REFERENCES `Usage`(UsageID)
);
INSERT INTO Customers VALUES
('C001', 'Ahmed Ali', '12 Park Road', 'Blackburn', 'BB1 2FG', '07700123456', 'ahmed@email.com'),
('C002', 'Sarah Khan', '45 Oak Street', 'Blackburn', 'BB2 5RT', '07700987654', 'sarah@email.com'),
('C003', 'John Smith', '8 King Avenue', 'Darwen', 'BB3 9PL', '07700456789', 'john@email.com'),
('C004', 'Fatima Begum', '22 Cedar Grove', 'Blackburn', 'BB1 8TY', '07700234567', 'fatima@email.com'),
('C005', 'Ali Raza', '10 High Street', 'Darwen', 'BB3 6XZ', '07700765432', 'ali@email.com');

INSERT INTO Tariffs VALUES
('T001', 'Standard Domestic', 0.18, '2024-01-01'),
('T002', 'Economy 7', 0.14, '2024-01-01'),
('T003', 'Premium', 0.22, '2024-01-01');

INSERT INTO Meters VALUES
('M001', 'C001', 'Digital', '2024-01-15', 'Active'),
('M002', 'C002', 'Digital', '2024-02-20', 'Active'),
('M003', 'C003', 'Analog', '2023-11-10', 'Active'),
('M004', 'C004', 'Digital', '2024-03-05', 'Active'),
('M005', 'C005', 'Smart', '2024-01-28', 'Active');

INSERT INTO `Usage` VALUES
('U001', 'M001', 'T001', '2024-03', 185),
('U002', 'M002', 'T001', '2024-03', 240),
('U003', 'M003', 'T002', '2024-03', 310),
('U004', 'M004', 'T001', '2024-03', 152),
('U005', 'M005', 'T003', '2024-03', 420),
('U006', 'M001', 'T001', '2024-04', 210),
('U007', 'M002', 'T001', '2024-04', 195),
('U008', 'M003', 'T002', '2024-04', 280);

INSERT INTO Bills VALUES
('B001', 'U001', '2024-04-01', '2024-04-15', 33.30, 'Paid'),
('B002', 'U002', '2024-04-01', '2024-04-15', 43.20, 'Paid'),
('B003', 'U003', '2024-04-01', '2024-04-15', 43.40, 'Unpaid'),
('B004', 'U004', '2024-04-01', '2024-04-15', 27.36, 'Paid'),
('B005', 'U005', '2024-04-01', '2024-04-15', 92.40, 'Unpaid');
SHOW TABLES;
Select * from Customers;
Select * from Meters;
Select * from Tariffs;
SELECT * FROM `Usage`;
SELECT * FROM Bills;
SELECT 
  c.CustomerID,
  c.FullName,
  m.MeterID,
  m.MeterType,
  u.Month,
  u.UnitsConsumed,
  t.PricePerUnit,
  (u.UnitsConsumed * t.PricePerUnit) AS CalculatedBill,
  b.TotalAmount,
  b.Status
FROM Customers c
JOIN Meters m ON c.CustomerID = m.CustomerID
JOIN `Usage` u ON m.MeterID = u.MeterID
JOIN Tariffs t ON u.TariffID = t.TariffID
LEFT JOIN Bills b ON u.UsageID = b.UsageID;