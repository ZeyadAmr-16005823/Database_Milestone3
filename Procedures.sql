
-- =============================================
-- SYSTEM ADMINISTRATOR PROCEDURES (10)
-- =============================================
--------Ziad's Part----------------------------
-- 1. ViewEmployeeInfo
CREATE PROCEDURE ViewEmployeeInfo
    @EmployeeID INT
AS
BEGIN
    SELECT * FROM Employee WHERE EmployeeID = @EmployeeID;
END;
GO

-- 2. AddEmployee
CREATE PROCEDURE AddEmployee
    @FullName VARCHAR(200),
    @NationalID VARCHAR(50),
    @DateOfBirth DATE,
    @CountryOfBirth VARCHAR(100),
    @Phone VARCHAR(50),
    @Email VARCHAR(100),
    @Address VARCHAR(255),
    @EmergencyContactName VARCHAR(100),
    @EmergencyContactPhone VARCHAR(50),
    @Relationship VARCHAR(50),
    @Biography VARCHAR(MAX),
    @EmploymentProgress VARCHAR(100),
    @AccountStatus VARCHAR(50),
    @EmploymentStatus VARCHAR(50),
    @HireDate DATE,
    @IsActive BIT,
    @ProfileCompletion INT,
    @DepartmentID INT,
    @PositionID INT,
    @ManagerID INT,
    @ContractID INT,
    @TaxFormID INT,
    @SalaryTypeID INT,
    @PayGrade VARCHAR(50)
AS
BEGIN
    DECLARE @NewEmployeeID INT;
    
    INSERT INTO Employee (
        FullName, NationalID, DateOfBirth, CountryOfBirth, Phone, Email, 
        Address, EmergencyContactName, EmergencyContactPhone, Relationship, 
        Biography, EmploymentProgress, AccountStatus, EmploymentStatus, 
        HireDate, IsActive, ProfileCompletion, DepartmentID, PositionID, 
        ManagerID, ContractID, TaxFormID, SalaryTypeID, PayGrade
    )
    VALUES (
        @FullName, @NationalID, @DateOfBirth, @CountryOfBirth, @Phone, @Email,
        @Address, @EmergencyContactName, @EmergencyContactPhone, @Relationship,
        @Biography, @EmploymentProgress, @AccountStatus, @EmploymentStatus,
        @HireDate, @IsActive, @ProfileCompletion, @DepartmentID, @PositionID,
        @ManagerID, @ContractID, @TaxFormID, @SalaryTypeID, @PayGrade
    );
    
    SET @NewEmployeeID = SCOPE_IDENTITY();
    SELECT 'Employee added successfully' AS Message, @NewEmployeeID AS EmployeeID;
END;
GO

-- 3. UpdateEmployeeInfo
CREATE PROCEDURE UpdateEmployeeInfo
    @EmployeeID INT,
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @Address VARCHAR(150)
AS
BEGIN
    UPDATE Employee
    SET Email = @Email, Phone = @Phone, Address = @Address
    WHERE EmployeeID = @EmployeeID;
    
    SELECT 'Employee information updated successfully' AS Message;
END;
GO

-- 4. AssignRole
CREATE PROCEDURE AssignRole
    @EmployeeID INT,
    @RoleID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Employee_Role WHERE EmployeeID = @EmployeeID AND RoleID = @RoleID)
    BEGIN
        INSERT INTO Employee_Role (EmployeeID, RoleID, AssignedDate)
        VALUES (@EmployeeID, @RoleID, GETDATE());
    END
    
    SELECT 'Role assigned successfully' AS Message;
END;
GO

-- 5. GetDepartmentEmployeeStats
CREATE PROCEDURE GetDepartmentEmployeeStats
AS
BEGIN
    SELECT 
        d.DepartmentName,
        COUNT(e.EmployeeID) AS EmployeeCount
    FROM Department d
    LEFT JOIN Employee e ON d.DepartmentID = e.DepartmentID
    GROUP BY d.DepartmentID, d.DepartmentName
    ORDER BY d.DepartmentName;
END;
GO

-- 6. ReassignManager
CREATE PROCEDURE ReassignManager
    @EmployeeID INT,
    @NewManagerID INT
AS
BEGIN
    UPDATE Employee SET ManagerID = @NewManagerID WHERE EmployeeID = @EmployeeID;
    
    UPDATE EmployeeHierarchy
    SET ManagerID = @NewManagerID,
        Level = (SELECT ISNULL(Level, 0) FROM EmployeeHierarchy WHERE EmployeeID = @NewManagerID) + 1
    WHERE EmployeeID = @EmployeeID;
    
    SELECT 'Manager reassigned successfully' AS Message;
END;
GO

-- 7. ReassignHierarchy
CREATE PROCEDURE ReassignHierarchy
    @EmployeeID INT,
    @NewDepartmentID INT,
    @NewManagerID INT
AS
BEGIN
    UPDATE Employee
    SET DepartmentID = @NewDepartmentID, ManagerID = @NewManagerID
    WHERE EmployeeID = @EmployeeID;
    
    UPDATE EmployeeHierarchy
    SET DepartmentID = @NewDepartmentID,
        ManagerID = @NewManagerID,
        Level = (SELECT ISNULL(Level, 0) FROM EmployeeHierarchy WHERE EmployeeID = @NewManagerID) + 1
    WHERE EmployeeID = @EmployeeID;
    
    SELECT 'Hierarchy reassigned successfully' AS Message;
END;
GO

-- 8. NotifyStructureChange
CREATE PROCEDURE NotifyStructureChange
    @AffectedEmployees VARCHAR(500),
    @Message VARCHAR(200)
AS
BEGIN
    -- Create notification
    DECLARE @NotificationID INT;
    
    INSERT INTO Notification (message_content, timestamp, urgency, read_status, notification_type)
    VALUES (@Message, GETDATE(), 'High', 0, 'Structure Change');
    
    SET @NotificationID = SCOPE_IDENTITY();
    
    -- Parse employee IDs and send notifications
    DECLARE @EmployeeID INT;
    DECLARE @Position INT;
    DECLARE @EmployeeList VARCHAR(500) = @AffectedEmployees + ',';
    
    WHILE CHARINDEX(',', @EmployeeList) > 0
    BEGIN
        SET @Position = CHARINDEX(',', @EmployeeList);
        SET @EmployeeID = CAST(LTRIM(RTRIM(LEFT(@EmployeeList, @Position - 1))) AS INT);
        
        INSERT INTO Employee_Notification (employee_id, notification_id, delivery_status, delivered_at)
        VALUES (@EmployeeID, @NotificationID, 'Pending', GETDATE());
        
        SET @EmployeeList = SUBSTRING(@EmployeeList, @Position + 1, LEN(@EmployeeList));
    END
    
    SELECT 'Notification sent successfully' AS ConfirmationMessage;
END;
GO

-- 9. ViewOrgHierarchy
CREATE PROCEDURE ViewOrgHierarchy
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.FullName AS EmployeeName,
        m.FullName AS ManagerName,
        d.DepartmentName,
        p.PositionTitle,
        ISNULL(eh.Level, 0) AS HierarchyLevel
    FROM Employee e
    LEFT JOIN Employee m ON e.ManagerID = m.EmployeeID
    LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Position p ON e.PositionID = p.PositionID
    LEFT JOIN EmployeeHierarchy eh ON e.EmployeeID = eh.EmployeeID
    ORDER BY ISNULL(eh.Level, 0), d.DepartmentName, e.FullName;
END;
GO

-- 10. ManageUserAccounts
CREATE PROCEDURE ManageUserAccounts
    @UserID INT,
    @Role VARCHAR(50),
    @Action VARCHAR(20)
AS
BEGIN
    IF @Action = 'CREATE'
    BEGIN
        DECLARE @RoleID INT;
        SELECT @RoleID = RoleID FROM Role WHERE RoleName = @Role;
        
        IF @RoleID IS NOT NULL
        BEGIN
            INSERT INTO Employee_Role (EmployeeID, RoleID, AssignedDate)
            VALUES (@UserID, @RoleID, GETDATE());
        END
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Employee_Role WHERE EmployeeID = @UserID;
    END
    
    SELECT 'User account managed successfully' AS Message;
END;
GO

-- =============================================
-- HR ADMINISTRATOR PROCEDURES (6)
-- =============================================

-- 11. GetTeamByManager
CREATE PROCEDURE GetTeamByManager
    @ManagerID INT
AS
BEGIN
    SELECT EmployeeID, FullName AS EmployeeName
    FROM Employee
    WHERE ManagerID = @ManagerID
    ORDER BY FullName;
END;
GO

-- 12. AssignDepartmentHead
CREATE PROCEDURE AssignDepartmentHead
    @DepartmentID INT,
    @ManagerID INT
AS
BEGIN
    UPDATE Department SET DepartmentHeadID = @ManagerID WHERE DepartmentID = @DepartmentID;
    SELECT 'Department head assigned successfully' AS Message;
END;
GO

-- 13. CreateEmployeeProfile
CREATE PROCEDURE CreateEmployeeProfile
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @RoleID INT,
    @HireDate DATE,
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @NationalID VARCHAR(50),
    @DateOfBirth DATE,
    @CountryOfBirth VARCHAR(100)
AS
BEGIN
    DECLARE @NewEmployeeID INT;
    DECLARE @FullName VARCHAR(200) = @FirstName + ' ' + @LastName;
    
    INSERT INTO Employee (FullName, NationalID, DateOfBirth, CountryOfBirth, Phone, Email, HireDate, DepartmentID, IsActive, ProfileCompletion, AccountStatus)
    VALUES (@FullName, @NationalID, @DateOfBirth, @CountryOfBirth, @Phone, @Email, @HireDate, @DepartmentID, 1, 30, 'Active');
    
    SET @NewEmployeeID = SCOPE_IDENTITY();
    
    INSERT INTO Employee_Role (EmployeeID, RoleID, AssignedDate)
    VALUES (@NewEmployeeID, @RoleID, GETDATE());
    
    INSERT INTO EmployeeHierarchy (EmployeeID, DepartmentID, Level)
    VALUES (@NewEmployeeID, @DepartmentID, 1);
    
    SELECT 'Employee profile created successfully' AS Message, @NewEmployeeID AS EmployeeID;
END;
GO

-- 14. UpdateEmployeeProfile
CREATE PROCEDURE UpdateEmployeeProfile
    @EmployeeID INT,
    @FieldName VARCHAR(50),
    @NewValue VARCHAR(255)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = N'UPDATE Employee SET ' + QUOTENAME(@FieldName) + ' = @Value WHERE EmployeeID = @EmpID';
    EXEC sp_executesql @SQL, N'@Value VARCHAR(255), @EmpID INT', @Value = @NewValue, @EmpID = @EmployeeID;
    
    SELECT 'Employee profile updated successfully' AS Message;
END;
GO

-- 15. SetProfileCompleteness
CREATE PROCEDURE SetProfileCompleteness
    @EmployeeID INT,
    @CompletenessPercentage INT
AS
BEGIN
    UPDATE Employee SET ProfileCompletion = @CompletenessPercentage WHERE EmployeeID = @EmployeeID;
    SELECT 'Profile completeness updated successfully' AS Message, @CompletenessPercentage AS CompletenessPercentage;
END;
GO

-- 16. GenerateProfileReport
CREATE PROCEDURE GenerateProfileReport
    @FilterField VARCHAR(50),
    @FilterValue VARCHAR(100)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = N'SELECT * FROM Employee WHERE ' + QUOTENAME(@FilterField) + ' = @Value';
    EXEC sp_executesql @SQL, N'@Value VARCHAR(100)', @Value = @FilterValue;
END;
GO

-- =============================================
-- LINE MANAGER PROCEDURES (6)
-- =============================================

-- 17. GetTeamStatistics
CREATE PROCEDURE GetTeamStatistics
    @ManagerID INT
AS
BEGIN
    SELECT COUNT(*) AS TeamSize, COUNT(*) AS SpanOfControl
    FROM Employee
    WHERE ManagerID = @ManagerID;
END;
GO

-- 18. ViewTeamProfiles
CREATE PROCEDURE ViewTeamProfiles
    @ManagerID INT
AS
BEGIN
    SELECT e.EmployeeID, e.FullName, e.Email, e.Phone, p.PositionTitle, d.DepartmentName, e.HireDate
    FROM Employee e
    LEFT JOIN Position p ON e.PositionID = p.PositionID
    LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID
    WHERE e.ManagerID = @ManagerID
    ORDER BY e.FullName;
END;
GO

-- 19. GetTeamSummary
CREATE PROCEDURE GetTeamSummary
    @ManagerID INT
AS
BEGIN
    SELECT p.PositionTitle AS Role, COUNT(*) AS EmployeeCount, AVG(DATEDIFF(YEAR, e.HireDate, GETDATE())) AS AverageTenure, d.DepartmentName
    FROM Employee e
    LEFT JOIN Position p ON e.PositionID = p.PositionID
    LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID
    WHERE e.ManagerID = @ManagerID
    GROUP BY p.PositionTitle, d.DepartmentName;
END;
GO

-- 20. FilterTeamProfiles
CREATE PROCEDURE FilterTeamProfiles
    @ManagerID INT,
    @Skill VARCHAR(50),
    @RoleID INT
AS
BEGIN
    SELECT DISTINCT e.EmployeeID, e.FullName, p.PositionTitle, d.DepartmentName
    FROM Employee e
    LEFT JOIN Position p ON e.PositionID = p.PositionID
    LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Employee_Skill es ON e.EmployeeID = es.EmployeeID
    LEFT JOIN Skill s ON es.SkillID = s.SkillID
    LEFT JOIN Employee_Role er ON e.EmployeeID = er.EmployeeID
    WHERE e.ManagerID = @ManagerID
        AND (@Skill IS NULL OR s.SkillName = @Skill)
        AND (@RoleID IS NULL OR er.RoleID = @RoleID)
    ORDER BY e.FullName;
END;
GO

-- 21. ViewTeamCertifications
CREATE PROCEDURE ViewTeamCertifications
    @ManagerID INT
AS
BEGIN
    SELECT e.EmployeeID, e.FullName, s.SkillName, v.VerificationName, v.IssuedDate, v.ExpiryDate
    FROM Employee e
    LEFT JOIN Employee_Skill es ON e.EmployeeID = es.EmployeeID
    LEFT JOIN Skill s ON es.SkillID = s.SkillID
    LEFT JOIN Employee_Verification ev ON e.EmployeeID = ev.EmployeeID
    LEFT JOIN Verification v ON ev.VerificationID = v.VerificationID
    WHERE e.ManagerID = @ManagerID
    ORDER BY e.FullName, s.SkillName;
END;
GO

-- 22. AddManagerNotes
CREATE PROCEDURE AddManagerNotes
    @EmployeeID INT,
    @ManagerID INT,
    @Note VARCHAR(500)
AS
BEGIN
    INSERT INTO ManagerNotes (EmployeeID, ManagerID, Note, NoteDate)
    VALUES (@EmployeeID, @ManagerID, @Note, GETDATE());
    
    SELECT 'Manager note added successfully' AS Message;
END;
GO

-- =============================================
-- EMPLOYEE PROCEDURES (6)
-- =============================================

-- 23. ViewEmployeeProfile
CREATE PROCEDURE ViewEmployeeProfile
    @EmployeeID INT
AS
BEGIN
    SELECT e.*, p.PositionTitle, d.DepartmentName, m.FullName AS ManagerName
    FROM Employee e
    LEFT JOIN Position p ON e.PositionID = p.PositionID
    LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Employee m ON e.ManagerID = m.EmployeeID
    WHERE e.EmployeeID = @EmployeeID;
END;
GO

-- 24. UpdateContactInformation
CREATE PROCEDURE UpdateContactInformation
    @EmployeeID INT,
    @RequestType VARCHAR(50),
    @NewValue VARCHAR(100)
AS
BEGIN
    IF @RequestType = 'Phone'
        UPDATE Employee SET Phone = @NewValue WHERE EmployeeID = @EmployeeID;
    ELSE IF @RequestType = 'Address'
        UPDATE Employee SET Address = @NewValue WHERE EmployeeID = @EmployeeID;
    ELSE IF @RequestType = 'Email'
        UPDATE Employee SET Email = @NewValue WHERE EmployeeID = @EmployeeID;
    
    SELECT 'Contact information updated successfully' AS Message;
END;
GO

-- 25. ViewEmploymentTimeline
CREATE PROCEDURE ViewEmploymentTimeline
    @EmployeeID INT
AS
BEGIN
    SELECT 'Hired' AS EventType, e.HireDate AS EventDate, 'Hired as ' + ISNULL(p.PositionTitle, 'Employee') AS Description
    FROM Employee e
    LEFT JOIN Position p ON e.PositionID = p.PositionID
    WHERE e.EmployeeID = @EmployeeID
    ORDER BY EventDate;
END;
GO

-- 26. UpdateEmergencyContact
CREATE PROCEDURE UpdateEmergencyContact
    @EmployeeID INT,
    @ContactName VARCHAR(100),
    @Relation VARCHAR(50),
    @Phone VARCHAR(20)
AS
BEGIN
    UPDATE Employee
    SET EmergencyContactName = @ContactName, Relationship = @Relation, EmergencyContactPhone = @Phone
    WHERE EmployeeID = @EmployeeID;
    
    SELECT 'Emergency contact updated successfully' AS Message;
END;
GO

-- 27. RequestHRDocument
CREATE PROCEDURE RequestHRDocument
    @EmployeeID INT,
    @DocumentType VARCHAR(50)
AS
BEGIN
    INSERT INTO Notification (EmployeeID, Message, NotificationDate, IsRead)
    VALUES (@EmployeeID, 'HR Document Request: ' + @DocumentType, GETDATE(), 0);
    
    SELECT 'HR document request submitted successfully' AS Message;
END;
GO

-- 28. NotifyProfileUpdate
CREATE PROCEDURE NotifyProfileUpdate
    @EmployeeID INT,
    @NotificationType VARCHAR(50)
AS
BEGIN
    INSERT INTO Notification (EmployeeID, Message, NotificationDate, IsRead)
    VALUES (@EmployeeID, 'Profile Update: ' + @NotificationType, GETDATE(), 0);
    
    SELECT 'Notification sent successfully' AS Message;
END;
GO

-- =============================================
-- HELPER FUNCTIONS (2)
-- =============================================

-- Function 1: GetHierarchyLevel
CREATE FUNCTION dbo.GetHierarchyLevel(@EmployeeID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Level INT = 0;
    DECLARE @ManagerID INT;
    
    SELECT @ManagerID = ManagerID FROM Employee WHERE EmployeeID = @EmployeeID;
    
    WHILE @ManagerID IS NOT NULL
    BEGIN
        SET @Level = @Level + 1;
        SELECT @ManagerID = ManagerID FROM Employee WHERE EmployeeID = @ManagerID;
        
        IF @Level > 100 BREAK; -- Safety limit
    END
    
    RETURN @Level;
END;
GO

-- Function 2: EmployeeExists
CREATE FUNCTION dbo.EmployeeExists(@EmployeeID INT)
RETURNS BIT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employee WHERE EmployeeID = @EmployeeID)
        RETURN 1;
    RETURN 0;
END;
GO
---------ZIAD END------------------------------







-- =============================================
-- Tarek - Payroll, Salary Types & Policies
-- Stored Procedures Script (CORRECTED VERSION)
-- =============================================

-- =============================================

-- =============================================

-- 1. Generate Payroll
GO
CREATE PROCEDURE GeneratePayroll
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        p.payroll_id,
        p.employee_id,
        e.full_name,
        p.period_start,
        p.period_end,
        p.base_amount,
        p.adjustments,
        p.taxes,
        p.contributions,
        p.net_salary,
        p.payment_date
    FROM Payroll p
    INNER JOIN Employee e ON p.employee_id = e.employee_id
    WHERE p.period_start >= @StartDate AND p.period_end <= @EndDate
    ORDER BY p.employee_id, p.period_start;
END;
GO

-- 2. Adjust Payroll Item
GO
CREATE PROCEDURE AdjustPayrollItem
    @PayrollID INT,
    @Type VARCHAR(50),
    @Amount DECIMAL(10,2),
    @duration INT,
    @timezone VARCHAR(20)
AS
BEGIN
    DECLARE @EmployeeID INT;
    
    IF NOT EXISTS (SELECT 1 FROM Payroll WHERE payroll_id = @PayrollID)
    BEGIN
        SELECT 'Invalid Payroll ID' AS Message;
        RETURN;
    END
    
    SELECT @EmployeeID = employee_id FROM Payroll WHERE payroll_id = @PayrollID;
    
    BEGIN TRANSACTION;

    IF @Type = 'Allowance'
    BEGIN
        UPDATE Payroll
        SET adjustments = adjustments + @Amount
        WHERE payroll_id = @PayrollID;
    END
    ELSE IF @Type = 'Deduction'
    BEGIN
        UPDATE Payroll
        SET adjustments = adjustments - @Amount
        WHERE payroll_id = @PayrollID;
    END
    
    -- Insert the allowance/deduction with duration and timezone
    INSERT INTO AllowanceDeduction (payroll_id, employee_id, type, amount, currency, duration, timezone)
    VALUES (@PayrollID, @EmployeeID, @Type, @Amount, 'EGP', CAST(@duration AS VARCHAR(20)), @timezone);
    
    INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
    VALUES (@PayrollID, 1, GETDATE(), 'Adjustment: ' + @Type + ' of ' + CAST(@Amount AS VARCHAR(20)) + ' for ' + CAST(@duration AS VARCHAR(20)) + ' mins');
    
    COMMIT TRANSACTION;
    
    SELECT 'Payroll item adjusted successfully' AS Message;
END;
GO

-- 3. Calculate Net Salary
GO
CREATE PROCEDURE CalculateNetSalary
    @PayrollID INT,
    @NetSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @NetSalary = net_salary
    FROM Payroll
    WHERE payroll_id = @PayrollID;
    
    IF @NetSalary IS NULL
        SET @NetSalary = 0;
END;
GO

-- 4. Apply Payroll Policy
GO
CREATE PROCEDURE ApplyPayrollPolicy
    @PolicyID INT,
    @PayrollID INT,
    @type VARCHAR(20),
    @description VARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Payroll WHERE payroll_id = @PayrollID)
    BEGIN
        SELECT 'Invalid Payroll ID' AS Message;
        RETURN;
    END
    
    IF NOT EXISTS (SELECT 1 FROM PayrollPolicy WHERE policy_id = @PolicyID)
    BEGIN
        SELECT 'Invalid Policy ID' AS Message;
        RETURN;
    END
    
    IF NOT EXISTS (SELECT 1 FROM PayrollPolicy_ID WHERE payroll_id = @PayrollID AND policy_id = @PolicyID)
    BEGIN
        INSERT INTO PayrollPolicy_ID (payroll_id, policy_id)
        VALUES (@PayrollID, @PolicyID);
        
        INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
        VALUES (@PayrollID, 1, GETDATE(), 'Policy Applied: ' + CAST(@PolicyID AS VARCHAR(10)) + ', Type: ' + @type + ', Desc: ' + @description);
        
        SELECT 'Policy applied successfully' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Policy already applied to this payroll' AS Message;
    END
END;
GO

-- 5. Get Monthly Payroll Summary
GO
CREATE PROCEDURE GetMonthlyPayrollSummary
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT 
        SUM(base_amount) AS TotalBaseSalary,
        SUM(adjustments) AS TotalAdjustments,
        SUM(taxes) AS TotalTaxes,
        SUM(contributions) AS TotalContributions,
        SUM(net_salary) AS TotalNetSalary,
        COUNT(*) AS EmployeeCount
    FROM Payroll
    WHERE MONTH(period_start) = @Month AND YEAR(period_start) = @Year;
END;
GO

-- 6. Add Allowance Deduction
GO
CREATE PROCEDURE AddAllowanceDeduction
    @PayrollID INT,
    @Type VARCHAR(50),
    @Amount DECIMAL(10,2)
AS
BEGIN
    DECLARE @EmployeeID INT;
    
    IF NOT EXISTS (SELECT 1 FROM Payroll WHERE payroll_id = @PayrollID)
    BEGIN
        SELECT 'Invalid Payroll ID' AS Message;
        RETURN;
    END
    
    SELECT @EmployeeID = employee_id FROM Payroll WHERE payroll_id = @PayrollID;
    
    BEGIN TRANSACTION;
    
    INSERT INTO AllowanceDeduction (payroll_id, employee_id, type, amount, currency)
    VALUES (@PayrollID, @EmployeeID, @Type, @Amount, 'EGP');
    
    IF @Type = 'Allowance'
    BEGIN
        UPDATE Payroll SET adjustments = adjustments + @Amount WHERE payroll_id = @PayrollID;
    END
    ELSE
    BEGIN
        UPDATE Payroll SET adjustments = adjustments - @Amount WHERE payroll_id = @PayrollID;
    END
    
    INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
    VALUES (@PayrollID, 1, GETDATE(), 'Added ' + @Type + ': ' + CAST(@Amount AS VARCHAR(20)));
    
    COMMIT TRANSACTION;
    
    SELECT 'Allowance/Deduction added successfully' AS Message;
END;
GO

-- 7. Get Employee Payroll History
GO
CREATE PROCEDURE GetEmployeePayrollHistory
    @EmployeeID INT
AS
BEGIN
    SELECT 
        payroll_id,
        period_start,
        period_end,
        base_amount,
        adjustments,
        taxes,
        contributions,
        net_salary,
        payment_date
    FROM Payroll
    WHERE employee_id = @EmployeeID
    ORDER BY period_start DESC;
END;
GO

-- 8. Get Bonus Eligible Employees
GO
CREATE PROCEDURE GetBonusEligibleEmployees
    @Eligibility_criteria NVARCHAR(200)
AS
BEGIN
    -- Return employees based on eligibility criteria in bonus policy
    SELECT DISTINCT
        e.employee_id,
        e.full_name,
        e.department_id,
        e.hire_date,
        DATEDIFF(YEAR, e.hire_date, GETDATE()) AS YearsOfService,
        p.base_amount
    FROM Employee e
    LEFT JOIN Payroll p ON e.employee_id = p.employee_id
    INNER JOIN BonusPolicy bp ON bp.eligibility_criteria LIKE '%' + @Eligibility_criteria + '%'
    WHERE DATEDIFF(YEAR, e.hire_date, GETDATE()) >= 1
    ORDER BY e.employee_id;
END;
GO

-- 9. Update Salary Type
GO
CREATE PROCEDURE UpdateSalaryType
    @EmployeeID INT,
    @SalaryTypeID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Employee WHERE employee_id = @EmployeeID)
    BEGIN
        SELECT 'Invalid Employee ID' AS Message;
        RETURN;
    END
    
    IF NOT EXISTS (SELECT 1 FROM SalaryType WHERE salary_type_id = @SalaryTypeID)
    BEGIN
        SELECT 'Invalid Salary Type ID' AS Message;
        RETURN;
    END
    
    UPDATE Employee
    SET salary_type_id = @SalaryTypeID
    WHERE employee_id = @EmployeeID;
    
    SELECT 'Salary type updated successfully' AS Message;
END;
GO

-- 10. Get Payroll By Department
GO
CREATE PROCEDURE GetPayrollByDepartment
    @DepartmentID INT,
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT 
        e.department_id,
        d.department_name,
        COUNT(DISTINCT e.employee_id) AS EmployeeCount,
        SUM(p.base_amount) AS TotalBaseSalary,
        SUM(p.net_salary) AS TotalNetSalary
    FROM Payroll p
    INNER JOIN Employee e ON p.employee_id = e.employee_id
    INNER JOIN Department d ON e.department_id = d.department_id
    WHERE e.department_id = @DepartmentID
    AND MONTH(p.period_start) = @Month
    AND YEAR(p.period_start) = @Year
    GROUP BY e.department_id, d.department_name;
END;
GO

-- 11. Validate Attendance Before Payroll
GO
CREATE PROCEDURE ValidateAttendanceBeforePayroll
    @PayrollPeriodID INT
AS
BEGIN
    DECLARE @StartDate DATE, @EndDate DATE, @PayrollID INT;
    
    SELECT @PayrollID = payroll_id, @StartDate = start_date, @EndDate = end_date
    FROM PayrollPeriod
    WHERE payroll_period_id = @PayrollPeriodID;
    
    IF @PayrollID IS NULL
    BEGIN
        SELECT 'Invalid Payroll Period ID' AS Message;
        RETURN;
    END
    
    -- Find employees with missing punches in the payroll period
    SELECT 
        e.employee_id,
        e.full_name,
        COUNT(*) AS UnresolvedPunches
    FROM Employee e
    INNER JOIN Attendance a ON e.employee_id = a.employee_id
    WHERE (a.entry_time IS NULL OR a.exit_time IS NULL)
    AND a.attendance_id IN (
        SELECT attendance_id 
        FROM Attendance 
        WHERE employee_id = e.employee_id
        AND (
            (entry_time IS NOT NULL AND CAST(entry_time AS DATE) BETWEEN @StartDate AND @EndDate)
            OR
            (exit_time IS NOT NULL AND CAST(exit_time AS DATE) BETWEEN @StartDate AND @EndDate)
        )
    )
    GROUP BY e.employee_id, e.full_name
    HAVING COUNT(*) > 0;
END;
GO

-- 12. Sync Attendance To Payroll
GO
CREATE PROCEDURE SyncAttendanceToPayroll
    @SyncDate DATE
AS
BEGIN
    DECLARE @PayrollID INT;
    
    SELECT TOP 1 @PayrollID = payroll_id
    FROM Payroll
    WHERE period_start <= @SyncDate AND period_end >= @SyncDate
    ORDER BY payroll_id DESC;
    
    IF @PayrollID IS NOT NULL
    BEGIN
        INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
        VALUES (@PayrollID, 1, GETDATE(), 'Attendance synced for: ' + CONVERT(VARCHAR, @SyncDate));
    END
    
    SELECT 'Attendance synced successfully' AS Message;
END;
GO

-- 13. Sync Approved Permissions To Payroll
GO
CREATE PROCEDURE SyncApprovedPermissionsToPayroll
    @PayrollPeriodID INT
AS
BEGIN
    DECLARE @PayrollID INT, @StartDate DATE, @EndDate DATE;
    
    SELECT @PayrollID = payroll_id, @StartDate = start_date, @EndDate = end_date
    FROM PayrollPeriod
    WHERE payroll_period_id = @PayrollPeriodID;
    
    IF @PayrollID IS NULL
    BEGIN
        SELECT 'Invalid Payroll Period ID' AS Message;
        RETURN;
    END
    
    BEGIN TRANSACTION;
    
    -- Sync approved permission requests for ALL employees in this payroll period
    -- Updates payroll adjustments based on approved attendance corrections
    UPDATE p
    SET p.adjustments = p.adjustments + 
        (SELECT ISNULL(COUNT(*), 0) * 50.00
         FROM AttendanceCorrectionRequest acr
         WHERE acr.employee_id = p.employee_id
         AND acr.status = 'Approved'
         AND acr.date BETWEEN @StartDate AND @EndDate)
    FROM Payroll p
    WHERE p.payroll_id = @PayrollID
    AND EXISTS (
        SELECT 1 
        FROM AttendanceCorrectionRequest acr
        WHERE acr.employee_id = p.employee_id
        AND acr.status = 'Approved'
        AND acr.date BETWEEN @StartDate AND @EndDate
    );
    
    -- Log the sync operation
    INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
    VALUES (@PayrollID, 1, GETDATE(), 'Approved permissions synced for period ' + CAST(@PayrollPeriodID AS VARCHAR(10)));
    
    COMMIT TRANSACTION;
    
    SELECT 'Approved permissions synced to payroll successfully' AS Message;
END;
GO

-- 14. Configure Pay Grades
GO
CREATE PROCEDURE ConfigurePayGrades
    @GradeName VARCHAR(50),
    @MinSalary DECIMAL(10,2),
    @MaxSalary DECIMAL(10,2)
AS
BEGIN
    IF @MinSalary >= @MaxSalary
    BEGIN
        SELECT 'Minimum salary must be less than maximum salary' AS Message;
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM PayGrade WHERE grade_name = @GradeName)
    BEGIN
        SELECT 'Pay grade with this name already exists' AS Message;
        RETURN;
    END
    
    INSERT INTO PayGrade (grade_name, min_salary, max_salary)
    VALUES (@GradeName, @MinSalary, @MaxSalary);
    
    SELECT 'Pay grade configured successfully' AS Message;
END;
GO

-- 15. Configure Shift Allowances
GO
CREATE PROCEDURE ConfigureShiftAllowances
    @ShiftType VARCHAR(50),
    @AllowanceName VARCHAR(50),
    @Amount DECIMAL(10,2)
AS
BEGIN
    IF @Amount <= 0
    BEGIN
        SELECT 'Allowance amount must be positive' AS Message;
        RETURN;
    END
    
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (GETDATE(), 'Shift Allowance', 'Shift: ' + @ShiftType + ', Allowance: ' + @AllowanceName + ', Amount: ' + CAST(@Amount AS VARCHAR));
    
    SELECT 'Shift allowance configured successfully' AS Message;
END;
GO

-- 16. Enable Multi Currency Payroll
GO
CREATE PROCEDURE EnableMultiCurrencyPayroll
    @CurrencyCode VARCHAR(10),
    @ExchangeRate DECIMAL(10,4)
AS
BEGIN
    IF @ExchangeRate <= 0
    BEGIN
        SELECT 'Exchange rate must be positive' AS Message;
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM Currency WHERE CurrencyCode = @CurrencyCode)
    BEGIN
        UPDATE Currency
        SET ExchangeRate = @ExchangeRate,
            LastUpdated = GETDATE()
        WHERE CurrencyCode = @CurrencyCode;
        
        SELECT 'Currency exchange rate updated successfully' AS Message;
    END
    ELSE
    BEGIN
        INSERT INTO Currency (CurrencyCode, CurrencyName, ExchangeRate, CreatedDate, LastUpdated)
        VALUES (@CurrencyCode, @CurrencyCode, @ExchangeRate, GETDATE(), GETDATE());
        
        SELECT 'Multi-currency payroll enabled successfully' AS Message;
    END
END;
GO

-- 17. Manage Tax Rules
GO
CREATE PROCEDURE ManageTaxRules
    @TaxRuleName VARCHAR(50),
    @CountryCode VARCHAR(10),
    @Rate DECIMAL(5,2),
    @Exemption DECIMAL(10,2)
AS
BEGIN
    IF @Rate < 0 OR @Rate > 100
    BEGIN
        SELECT 'Tax rate must be between 0 and 100' AS Message;
        RETURN;
    END
    
    IF @Exemption < 0
    BEGIN
        SELECT 'Tax exemption cannot be negative' AS Message;
        RETURN;
    END
    
    -- Store tax rule as a structured record in TaxForm
    -- Using consistent format for parsing and application
    DECLARE @FormContent NVARCHAR(500);
    SET @FormContent = 'TAX_RULE|' + @TaxRuleName + '|RATE:' + CAST(@Rate AS VARCHAR(10)) + '|EXEMPTION:' + CAST(@Exemption AS VARCHAR(20));
    
    INSERT INTO TaxForm (jurisdiction, validity_period, form_content)
    VALUES (
        @CountryCode, 
        CAST(YEAR(GETDATE()) AS VARCHAR(4)), 
        @FormContent
    );
    
    SELECT 'Tax rule managed successfully' AS Message;
END;
GO

-- 18. Approve Payroll Config Changes
GO
CREATE PROCEDURE ApprovePayrollConfigChanges
    @ConfigID INT,
    @ApproverID INT,
    @Status VARCHAR(20)
AS
BEGIN
    DECLARE @PayrollID INT;
    
    SELECT TOP 1 @PayrollID = payroll_id
    FROM Payroll
    ORDER BY payroll_id DESC;
    
    IF @PayrollID IS NOT NULL
    BEGIN
        INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
        VALUES (@PayrollID, @ApproverID, GETDATE(), 'Config Change: ID ' + CAST(@ConfigID AS VARCHAR) + ', Status: ' + @Status);
    END
    
    SELECT 'Payroll configuration change approved successfully' AS Message;
END;
GO

-- 19. Configure Signing Bonus
GO
CREATE PROCEDURE ConfigureSigningBonus
    @EmployeeID INT,
    @BonusAmount DECIMAL(10,2),
    @EffectiveDate DATE
AS
BEGIN
    DECLARE @PayrollID INT;
    
    IF NOT EXISTS (SELECT 1 FROM Employee WHERE employee_id = @EmployeeID)
    BEGIN
        SELECT 'Invalid Employee ID' AS Message;
        RETURN;
    END
    
    IF @BonusAmount <= 0
    BEGIN
        SELECT 'Bonus amount must be positive' AS Message;
        RETURN;
    END
    
    SELECT TOP 1 @PayrollID = payroll_id
    FROM Payroll
    WHERE employee_id = @EmployeeID
    AND period_start <= @EffectiveDate AND period_end >= @EffectiveDate
    ORDER BY period_start DESC;
    
    IF @PayrollID IS NOT NULL
    BEGIN
        BEGIN TRANSACTION;
        
        UPDATE Payroll
        SET adjustments = adjustments + @BonusAmount
        WHERE payroll_id = @PayrollID;
        
        INSERT INTO AllowanceDeduction (payroll_id, employee_id, type, amount, currency)
        VALUES (@PayrollID, @EmployeeID, 'Signing Bonus', @BonusAmount, 'EGP');
        
        INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
        VALUES (@PayrollID, 1, GETDATE(), 'Signing Bonus Added: ' + CAST(@BonusAmount AS VARCHAR(20)));
        
        COMMIT TRANSACTION;
        
        SELECT 'Signing bonus configured successfully' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'No payroll record found for the specified date' AS Message;
    END
END;
GO

-- 20. Configure Termination Benefits
GO
CREATE PROCEDURE ConfigureTerminationBenefits
    @EmployeeID INT,
    @CompensationAmount DECIMAL(10,2),
    @EffectiveDate DATE,
    @Reason VARCHAR(50)
AS
BEGIN
    DECLARE @PayrollID INT;
    
    IF NOT EXISTS (SELECT 1 FROM Employee WHERE employee_id = @EmployeeID)
    BEGIN
        SELECT 'Invalid Employee ID' AS Message;
        RETURN;
    END
    
    IF @CompensationAmount <= 0
    BEGIN
        SELECT 'Compensation amount must be positive' AS Message;
        RETURN;
    END
    
    SELECT TOP 1 @PayrollID = payroll_id
    FROM Payroll
    WHERE employee_id = @EmployeeID
    AND period_start <= @EffectiveDate AND period_end >= @EffectiveDate
    ORDER BY period_start DESC;
    
    IF @PayrollID IS NOT NULL
    BEGIN
        BEGIN TRANSACTION;
        
        INSERT INTO AllowanceDeduction (payroll_id, employee_id, type, amount, currency)
        VALUES (@PayrollID, @EmployeeID, 'Termination - ' + @Reason, @CompensationAmount, 'EGP');
        
        UPDATE Payroll
        SET adjustments = adjustments + @CompensationAmount
        WHERE payroll_id = @PayrollID;
        
        INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
        VALUES (@PayrollID, 1, GETDATE(), 'Termination Benefits: ' + CAST(@CompensationAmount AS VARCHAR(20)) + ' - ' + @Reason);
        
        COMMIT TRANSACTION;
        
        SELECT 'Termination benefits configured successfully' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'No payroll record found for the specified date' AS Message;
    END
END;
GO

-- 21. Configure Insurance Brackets
GO
CREATE PROCEDURE ConfigureInsuranceBrackets
    @InsuranceType VARCHAR(50),
    @MinSalary DECIMAL(10,2),
    @MaxSalary DECIMAL(10,2),
    @EmployeeContribution DECIMAL(5,2),
    @EmployerContribution DECIMAL(5,2)
AS
BEGIN
    IF @MinSalary >= @MaxSalary
    BEGIN
        SELECT 'Minimum salary must be less than maximum salary' AS Message;
        RETURN;
    END
    
    IF @EmployeeContribution < 0 OR @EmployerContribution < 0
    BEGIN
        SELECT 'Contribution percentages must be non-negative' AS Message;
        RETURN;
    END
    
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (
        GETDATE(),
        'Insurance',
        'Type: ' + @InsuranceType + 
        ', Range: ' + CAST(@MinSalary AS VARCHAR) + '-' + CAST(@MaxSalary AS VARCHAR) +
        ', Employee: ' + CAST(@EmployeeContribution AS VARCHAR) + '%' +
        ', Employer: ' + CAST(@EmployerContribution AS VARCHAR) + '%'
    );
    
    SELECT 'Insurance bracket configured successfully' AS Message;
END;
GO

-- 22. Update Insurance Brackets
GO
CREATE PROCEDURE UpdateInsuranceBrackets
    @BracketID INT,
    @MinSalary DECIMAL(10,2),
    @MaxSalary DECIMAL(10,2),
    @EmployeeContribution DECIMAL(5,2),
    @EmployerContribution DECIMAL(5,2)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM PayrollPolicy WHERE policy_id = @BracketID)
    BEGIN
        SELECT 'Invalid Bracket ID' AS Message;
        RETURN;
    END
    
    IF @MinSalary >= @MaxSalary
    BEGIN
        SELECT 'Minimum salary must be less than maximum salary' AS Message;
        RETURN;
    END
    
    UPDATE PayrollPolicy
    SET description = 
        'Range: ' + CAST(@MinSalary AS VARCHAR) + '-' + CAST(@MaxSalary AS VARCHAR) +
        ', Employee: ' + CAST(@EmployeeContribution AS VARCHAR) + '%' +
        ', Employer: ' + CAST(@EmployerContribution AS VARCHAR) + '%',
        effective_date = GETDATE()
    WHERE policy_id = @BracketID;
    
    SELECT 'Insurance bracket updated successfully' AS Message;
END;
GO

-- 23. Configure Payroll Policies
GO
CREATE PROCEDURE ConfigurePayrollPolicies
    @PolicyType VARCHAR(50),
    @PolicyDetails NVARCHAR(MAX),
    @effectivedate DATE
AS
BEGIN
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (@effectivedate, @PolicyType, @PolicyDetails);
    
    SELECT 'Payroll policy configured successfully' AS Message;
END;
GO

-- 24. Define Pay Grades
GO
CREATE PROCEDURE DefinePayGrades
    @GradeName VARCHAR(50),
    @MinSalary DECIMAL(10,2),
    @MaxSalary DECIMAL(10,2),
    @CreatedBy INT
AS
BEGIN
    IF @MinSalary >= @MaxSalary
    BEGIN
        SELECT 'Minimum salary must be less than maximum salary' AS Message;
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM PayGrade WHERE grade_name = @GradeName)
    BEGIN
        SELECT 'Pay grade with this name already exists' AS Message;
        RETURN;
    END
    
    INSERT INTO PayGrade (grade_name, min_salary, max_salary)
    VALUES (@GradeName, @MinSalary, @MaxSalary);
    
    SELECT 'Pay grade defined successfully' AS Message;
END;
GO

-- 25. Configure Escalation Workflow
GO
CREATE PROCEDURE ConfigureEscalationWorkflow
    @ThresholdAmount DECIMAL(10,2),
    @ApproverRole VARCHAR(50),
    @CreatedBy INT
AS
BEGIN
    IF @ThresholdAmount <= 0
    BEGIN
        SELECT 'Threshold amount must be positive' AS Message;
        RETURN;
    END
    
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (
        GETDATE(),
        'Escalation',
        'Threshold: ' + CAST(@ThresholdAmount AS VARCHAR) + ', Approver: ' + @ApproverRole
    );
    
    SELECT 'Escalation workflow configured successfully' AS Message;
END;
GO

-- 26. Define Pay Type
GO
CREATE PROCEDURE DefinePayType
    @EmployeeID INT,
    @PayType VARCHAR(50),
    @EffectiveDate DATE
AS
BEGIN
    DECLARE @SalaryTypeID INT;
    
    IF NOT EXISTS (SELECT 1 FROM Employee WHERE employee_id = @EmployeeID)
    BEGIN
        SELECT 'Invalid Employee ID' AS Message;
        RETURN;
    END
    
    SELECT @SalaryTypeID = salary_type_id
    FROM SalaryType
    WHERE type = @PayType;
    
    IF @SalaryTypeID IS NOT NULL
    BEGIN
        UPDATE Employee
        SET salary_type_id = @SalaryTypeID
        WHERE employee_id = @EmployeeID;
        
        SELECT 'Pay type defined successfully' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Invalid pay type specified' AS Message;
    END
END;
GO

-- 27. Configure Overtime Rules
GO
CREATE PROCEDURE ConfigureOvertimeRules
    @DayType VARCHAR(20),
    @Multiplier DECIMAL(3,2),
    @hourspermonth INT
AS
BEGIN
    IF @Multiplier <= 0
    BEGIN
        SELECT 'Multiplier must be positive' AS Message;
        RETURN;
    END
    
    IF @hourspermonth <= 0
    BEGIN
        SELECT 'Hours per month must be positive' AS Message;
        RETURN;
    END
    
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (GETDATE(), 'Overtime', 'DayType: ' + @DayType + ', Multiplier: ' + CAST(@Multiplier AS VARCHAR) + ', Max Hours: ' + CAST(@hourspermonth AS VARCHAR));
    
    DECLARE @PolicyID INT = SCOPE_IDENTITY();
    
    INSERT INTO OvertimePolicy (policy_id, weekday_rate_multiplier, weekend_rate_multiplier, max_hours_per_month)
    VALUES (@PolicyID, @Multiplier, @Multiplier * 1.2, @hourspermonth);
    
    SELECT 'Overtime rules configured successfully' AS Message;
END;
GO

-- 28. Configure Shift Allowance
GO
CREATE PROCEDURE ConfigureShiftAllowance
    @ShiftType VARCHAR(20),
    @AllowanceAmount DECIMAL(10,2),
    @CreatedBy INT
AS
BEGIN
    IF @AllowanceAmount <= 0
    BEGIN
        SELECT 'Allowance amount must be positive' AS Message;
        RETURN;
    END
    
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (
        GETDATE(),
        'Shift Allowance',
        'Shift: ' + @ShiftType + ', Amount: ' + CAST(@AllowanceAmount AS VARCHAR)
    );
    
    SELECT 'Shift allowance configured successfully' AS Message;
END;
GO

-- 29. Configure Multi Currency
GO
CREATE PROCEDURE ConfigureMultiCurrency
    @CurrencyCode VARCHAR(10),
    @ExchangeRate DECIMAL(10,4),
    @EffectiveDate DATE
AS
BEGIN
    IF @ExchangeRate <= 0
    BEGIN
        SELECT 'Exchange rate must be positive' AS Message;
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM Currency WHERE CurrencyCode = @CurrencyCode)
    BEGIN
        UPDATE Currency
        SET ExchangeRate = @ExchangeRate,
            LastUpdated = @EffectiveDate
        WHERE CurrencyCode = @CurrencyCode;
        
        SELECT 'Currency exchange rate updated successfully' AS Message;
    END
    ELSE
    BEGIN
        INSERT INTO Currency (CurrencyCode, CurrencyName, ExchangeRate, CreatedDate, LastUpdated)
        VALUES (@CurrencyCode, @CurrencyCode, @ExchangeRate, @EffectiveDate, @EffectiveDate);
        
        SELECT 'Multi-currency configured successfully' AS Message;
    END
END;
GO

-- 30. Configure Signing Bonus Policy
GO
CREATE PROCEDURE ConfigureSigningBonusPolicy
    @BonusType VARCHAR(50),
    @Amount DECIMAL(10,2),
    @EligibilityCriteria NVARCHAR(MAX)
AS
BEGIN
    IF @Amount <= 0
    BEGIN
        SELECT 'Bonus amount must be positive' AS Message;
        RETURN;
    END
    
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (GETDATE(), 'Signing Bonus', @EligibilityCriteria);
    
    DECLARE @PolicyID INT = SCOPE_IDENTITY();
    
    INSERT INTO BonusPolicy (policy_id, bonus_type, eligibility_criteria)
    VALUES (@PolicyID, @BonusType, @EligibilityCriteria);
    
    SELECT 'Signing bonus policy configured successfully' AS Message;
END;
GO

-- 31. Configure Insurance Brackets By Name (with BracketName parameter)
-- Note: This has same name as procedure 21 in requirements, renamed to avoid SQL conflict
GO
CREATE PROCEDURE ConfigureInsuranceBracketsByName
    @BracketName VARCHAR(50),
    @MinSalary DECIMAL(10,2),
    @MaxSalary DECIMAL(10,2),
    @EmployeeContribution DECIMAL(5,2),
    @EmployerContribution DECIMAL(5,2)
AS
BEGIN
    IF @MinSalary >= @MaxSalary
    BEGIN
        SELECT 'Minimum salary must be less than maximum salary' AS Message;
        RETURN;
    END
    
    IF @EmployeeContribution < 0 OR @EmployerContribution < 0
    BEGIN
        SELECT 'Contribution percentages must be non-negative' AS Message;
        RETURN;
    END
    
    INSERT INTO PayrollPolicy (effective_date, type, description)
    VALUES (
        GETDATE(),
        'Insurance',
        'Bracket: ' + @BracketName + 
        ', Range: ' + CAST(@MinSalary AS VARCHAR) + '-' + CAST(@MaxSalary AS VARCHAR) +
        ', Employee: ' + CAST(@EmployeeContribution AS VARCHAR) + '%' +
        ', Employer: ' + CAST(@EmployerContribution AS VARCHAR) + '%'
    );
    
    SELECT 'Insurance bracket configured successfully' AS Message;
END;
GO

-- 32. Generate Tax Statement
GO
CREATE PROCEDURE GenerateTaxStatement
    @EmployeeID INT,
    @TaxYear INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Employee WHERE employee_id = @EmployeeID)
    BEGIN
        SELECT 'Invalid Employee ID' AS Message;
        RETURN;
    END
    
    SELECT 
        e.employee_id,
        e.full_name,
        @TaxYear AS TaxYear,
        ISNULL(SUM(p.base_amount), 0) AS TotalIncome,
        ISNULL(SUM(p.taxes), 0) AS TotalTaxesPaid,
        ISNULL(SUM(p.contributions), 0) AS TotalContributions,
        ISNULL(SUM(p.net_salary), 0) AS TotalNetIncome
    FROM Employee e
    LEFT JOIN Payroll p ON e.employee_id = p.employee_id AND YEAR(p.period_start) = @TaxYear
    WHERE e.employee_id = @EmployeeID
    GROUP BY e.employee_id, e.full_name;
END;
GO

-- 33. Approve Payroll Configuration
GO
CREATE PROCEDURE ApprovePayrollConfiguration
    @ConfigID INT,
    @ApprovedBy INT
AS
BEGIN
    DECLARE @PayrollID INT;
    
    SELECT TOP 1 @PayrollID = payroll_id
    FROM Payroll
    ORDER BY payroll_id DESC;
    
    IF @PayrollID IS NOT NULL
    BEGIN
        INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
        VALUES (@PayrollID, @ApprovedBy, GETDATE(), 'Configuration Approved: ID ' + CAST(@ConfigID AS VARCHAR));
    END
    
    SELECT 'Payroll configuration approved successfully' AS Message;
END;
GO

-- 34. Modify Past Payroll
GO
CREATE PROCEDURE ModifyPastPayroll
    @PayrollRunID INT,
    @EmployeeID INT,
    @FieldName VARCHAR(50),
    @NewValue DECIMAL(10,2),
    @ModifiedBy INT
AS
BEGIN
    DECLARE @OldValue DECIMAL(10,2);
    
    IF NOT EXISTS (SELECT 1 FROM Payroll WHERE payroll_id = @PayrollRunID)
    BEGIN
        SELECT 'Invalid Payroll ID' AS Message;
        RETURN;
    END
    
    BEGIN TRANSACTION;
    
    IF @FieldName = 'base_amount'
    BEGIN
        SELECT @OldValue = base_amount FROM Payroll WHERE payroll_id = @PayrollRunID;
        UPDATE Payroll SET base_amount = @NewValue WHERE payroll_id = @PayrollRunID;
    END
    ELSE IF @FieldName = 'adjustments'
    BEGIN
        SELECT @OldValue = adjustments FROM Payroll WHERE payroll_id = @PayrollRunID;
        UPDATE Payroll SET adjustments = @NewValue WHERE payroll_id = @PayrollRunID;
    END
    ELSE IF @FieldName = 'taxes'
    BEGIN
        SELECT @OldValue = taxes FROM Payroll WHERE payroll_id = @PayrollRunID;
        UPDATE Payroll SET taxes = @NewValue WHERE payroll_id = @PayrollRunID;
    END
    ELSE IF @FieldName = 'contributions'
    BEGIN
        SELECT @OldValue = contributions FROM Payroll WHERE payroll_id = @PayrollRunID;
        UPDATE Payroll SET contributions = @NewValue WHERE payroll_id = @PayrollRunID;
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'Invalid field name' AS Message;
        RETURN;
    END
    
    INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
    VALUES (@PayrollRunID, @ModifiedBy, GETDATE(), 'Modified ' + @FieldName + ' from ' + CAST(@OldValue AS VARCHAR(20)) + ' to ' + CAST(@NewValue AS VARCHAR(20)));
    
    COMMIT TRANSACTION;
    
    SELECT 'Past payroll modified successfully' AS Message;
END;
GO

-- =============================================

-- =============================================

--------------------------Tarek End---------------------------
