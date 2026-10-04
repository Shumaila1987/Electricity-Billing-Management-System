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