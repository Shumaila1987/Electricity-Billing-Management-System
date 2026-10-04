# Electricity Billing Management System

I built this project to design and implement a complete database system for managing electricity customers, meters, usage records, tariffs, and bills.

---

## How I Built This Project

### Step 1 — Prepared the Data in Excel
I created all the source data myself in Excel. I made separate sheets for each part:
- **Customers** — unique ID, full name, address, city, postcode, phone number, email
- **Tariffs** — tariff ID, name, price per unit, effective start date
- **Meters** — meter ID, which customer it belongs to, meter type, installation date, active status
- **Usage** — usage record ID, meter ID, which tariff applies, month, units consumed
- **Bills** — bill ID, which usage record it comes from, bill date, due date, total amount, payment status

I checked every entry carefully and made sure IDs matched across all sheets so everything would connect correctly.

### Step 2 — Created the Database in MySQL Workbench
I opened MySQL Workbench and wrote SQL code to set up the database and all five tables:
- `Customers` — main customer information
- `Tariffs` — different pricing plans
- `Meters` — physical meters linked to customers
- `Usage` — monthly consumption readings linked to meters and tariffs
- `Bills` — generated invoices based on usage

I defined proper data types — `VARCHAR` for IDs and names, `INT` for numbers, `DECIMAL` for money values, `DATE` for dates — and set primary keys for every table.

### Step 3 — Connected the Tables with Relationships
I added foreign keys so tables connect properly:
- One customer can have **many** meters
- One meter can have **many** usage readings
- One tariff can apply to **many** usage readings
- One usage record creates **one** bill

This means data stays consistent — I cannot add a meter for a customer that does not exist, and every bill traces back to real usage.

### Step 4 — Inserted All the Data
I ran `INSERT` statements to load all the Excel information into the MySQL tables. I entered:
- 5 customers from Blackburn and Darwen area
- 3 different electricity tariffs
- 5 meters (digital, analog, smart)
- 8 monthly usage records
- 5 issued bills showing paid and unpaid status

### Step 5 — Tested with JOIN Queries
I wrote a SQL query to join all five tables together:
```sql
SELECT 
    c.CustomerID,
    c.FullName,
    m.MeterID,
    m.MeterType,
    u.Month,
    u.UnitsConsumed,
    t.PricePerUnit,
    b.TotalAmount,
    b.Status
FROM Customers c
JOIN Meters m ON c.CustomerID = m.CustomerID
JOIN `Usage` u ON m.MeterID = u.MeterID
JOIN Tariffs t ON u.TariffID = t.TariffID
LEFT JOIN Bills b ON u.UsageID = b.UsageID;
```
The query returned 8 rows showing full customer details, meter info, consumption, pricing, and bill status — everything connected and working correctly.
Step 6 — Created the ER Diagram 
I used Reverse Engineer in MySQL Workbench to automatically pull in my database structure. It generated the full Entity Relationship Diagram showing:

https://github.com/Shumaila1987/Electricity-Billing-Management-System/blob/main/ER_Diagram.png

 
- All 5 tables with every column and data type
​
- Solid lines showing one-to-many relationships
​
- How customers → meters → usage → bills connect
​
- How tariffs link to usage for pricing
 
I exported the diagram as an image file to include here.
Entity Relationship Diagram
Tools I Used
 
- Microsoft Excel — data preparation
​
- MySQL Workbench 8.0 — database design, queries, and diagram
 
What I Learned
 
- How to plan and structure a relational database from scratch
​
- How to set up primary keys and foreign keys
​
- How to write multi-table JOIN queries to get complete information
​
- How to troubleshoot connection and access issues
​
- How to generate and read an ER diagram
 
 
 
Built by Shumaila
