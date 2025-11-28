-- =============================================
------------------Ziad's Part-------------------
-- =============================================

-- Table: Employee
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    national_id VARCHAR(20),
    date_of_birth DATE,
    country_of_birth VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(150),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    relationship VARCHAR(50),
    biography VARCHAR(MAX),
    profile_image VARCHAR(255),
    employment_progress VARCHAR(50),
    account_status VARCHAR(20) DEFAULT 'Active',
    employment_status VARCHAR(20) DEFAULT 'Active',
    hire_date DATE NOT NULL,
    is_active BIT DEFAULT 1,
    profile_completion INT DEFAULT 0 CHECK (profile_completion BETWEEN 0 AND 100),
    department_id INT,
    position_id INT,
    manager_id INT,
    contract_id INT,
    tax_form_id INT,
    salary_type_id INT,
    pay_grade INT,
    FOREIGN KEY (position_id) REFERENCES Position(position_id),
    FOREIGN KEY (pay_grade) REFERENCES PayGrade(pay_grade_id),
    FOREIGN KEY (tax_form_id) REFERENCES TaxForm(tax_form_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id),
    FOREIGN KEY (contract_id) REFERENCES Contract(contract_id)
);

-- Table: HRAdministrator
CREATE TABLE HRAdministrator (
    employee_id INT PRIMARY KEY,
    approval_level VARCHAR(20) DEFAULT 'Junior' CHECK (approval_level IN ('Junior', 'Senior', 'Chief')),
    record_access_scope VARCHAR(50),
    document_validation_rights VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Table: SystemAdministrator
CREATE TABLE SystemAdministrator (
    employee_id INT PRIMARY KEY,
    system_privilege_level VARCHAR(20) DEFAULT 'Standard' CHECK (system_privilege_level IN ('Standard', 'Senior', 'Super')),
    configurable_fields VARCHAR(MAX),
    audit_visibility_scope VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Table: PayrollSpecialist
CREATE TABLE PayrollSpecialist (
    employee_id INT PRIMARY KEY,
    assigned_region VARCHAR(50),
    processing_frequency VARCHAR(20),
    last_processed_period DATE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Table: LineManager
CREATE TABLE LineManager (
    employee_id INT PRIMARY KEY,
    team_size INT DEFAULT 0,
    supervised_departments VARCHAR(100),
    approval_limit DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Table: Role
CREATE TABLE Role (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name VARCHAR(50) UNIQUE NOT NULL,
    purpose VARCHAR(200)
);

-- Table: RolePermission
CREATE TABLE RolePermission (
    role_id INT NOT NULL,
    permission_name VARCHAR(100) NOT NULL,
    allowed_action VARCHAR(100),
    PRIMARY KEY (role_id, permission_name),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

-- Table: Employee_Role
CREATE TABLE Employee_Role (
    employee_id INT NOT NULL,
    role_id INT NOT NULL,
    assigned_date DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (employee_id, role_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

-- Table: EmployeeHierarchy
CREATE TABLE EmployeeHierarchy (
    employee_id INT NOT NULL,
    manager_id INT,
    hierarchy_level INT DEFAULT 1,
    PRIMARY KEY (employee_id, manager_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id)
);

-- Table: ManagerNotes
CREATE TABLE ManagerNotes (
    note_id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT NOT NULL,
    manager_id INT NOT NULL,
    note_content VARCHAR(500) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id)
);

-- Table: ApprovalWorkflow
CREATE TABLE ApprovalWorkflow (
    workflow_id INT PRIMARY KEY IDENTITY(1,1),
    workflow_type VARCHAR(50) NOT NULL,
    threshold_amount DECIMAL(10,2),
    approver_role VARCHAR(50),
    created_by INT,
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Draft')),
    FOREIGN KEY (created_by) REFERENCES Employee(employee_id)
);

-- Table: ApprovalWorkflowStep
CREATE TABLE ApprovalWorkflowStep (
    workflow_id INT NOT NULL,
    step_number INT NOT NULL,
    role_id INT NOT NULL,
    action_required VARCHAR(100),
    PRIMARY KEY (workflow_id, step_number),
    FOREIGN KEY (workflow_id) REFERENCES ApprovalWorkflow(workflow_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

-- Create indexes for performance optimization
CREATE INDEX IX_Employee_Department ON Employee(department_id);
CREATE INDEX IX_Employee_Manager ON Employee(manager_id);
CREATE INDEX IX_Employee_Position ON Employee(position_id);
CREATE INDEX IX_Employee_Email ON Employee(email);
CREATE INDEX IX_Employee_IsActive ON Employee(is_active);
CREATE INDEX IX_EmployeeRole_Employee ON Employee_Role(employee_id);
CREATE INDEX IX_EmployeeRole_Role ON Employee_Role(role_id);
CREATE INDEX IX_EmployeeHierarchy_Employee ON EmployeeHierarchy(employee_id);
CREATE INDEX IX_EmployeeHierarchy_Manager ON EmployeeHierarchy(manager_id);
CREATE INDEX IX_ManagerNotes_Employee ON ManagerNotes(employee_id);
CREATE INDEX IX_ManagerNotes_Manager ON ManagerNotes(manager_id);
CREATE INDEX IX_ApprovalWorkflowStep_Workflow ON ApprovalWorkflowStep(workflow_id);
CREATE INDEX IX_ApprovalWorkflowStep_Role ON ApprovalWorkflowStep(role_id);
-------------Ziad END---------------------------------------------------------------------------------------------------




---------------Youssef-------------------------
-- =============================================
-- 1. Department Table
-- =============================================
CREATE TABLE Department (
    department_id INT PRIMARY KEY IDENTITY(1,1),
    department_name VARCHAR(100) NOT NULL UNIQUE,
    purpose VARCHAR(500),
    department_head_id INT NULL,
    CONSTRAINT FK_Department_Head FOREIGN KEY (department_head_id) 
        REFERENCES Employee(employee_id)
);

-- =============================================
-- 2. Position Table
-- =============================================
CREATE TABLE Position (
    position_id INT PRIMARY KEY IDENTITY(1,1),
    position_title VARCHAR(100) NOT NULL,
    responsibilities VARCHAR(1000),
    status VARCHAR(20) CHECK (status IN ('Active', 'Inactive', 'Draft')) DEFAULT 'Active'
);

-- =============================================
-- 3. Skill Table
-- =============================================
CREATE TABLE Skill (
    skill_id INT PRIMARY KEY IDENTITY(1,1),
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500)
);

-- =============================================
-- 4. Employee_Skill Table (Many-to-Many)
-- =============================================
CREATE TABLE Employee_Skill (
    employee_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level VARCHAR(20) CHECK (proficiency_level IN ('Beginner', 'Intermediate', 'Advanced', 'Expert')),
    PRIMARY KEY (employee_id, skill_id),
    CONSTRAINT FK_EmployeeSkill_Employee FOREIGN KEY (employee_id) 
        REFERENCES Employee(employee_id) ON DELETE CASCADE,
    CONSTRAINT FK_EmployeeSkill_Skill FOREIGN KEY (skill_id) 
        REFERENCES Skill(skill_id)
);

-- =============================================
-- 5. Verification Table
-- =============================================
CREATE TABLE Verification (
    verification_id INT PRIMARY KEY IDENTITY(1,1),
    verification_type VARCHAR(50) NOT NULL,
    issuer VARCHAR(150),
    issue_date DATE,
    expiry_period INT -- in days
);

-- =============================================
-- 6. Employee_Verification Table (Many-to-Many)
-- =============================================
CREATE TABLE Employee_Verification (
    employee_id INT NOT NULL,
    verification_id INT NOT NULL,
    PRIMARY KEY (employee_id, verification_id),
    CONSTRAINT FK_EmployeeVerification_Employee FOREIGN KEY (employee_id) 
        REFERENCES Employee(employee_id) ON DELETE CASCADE,
    CONSTRAINT FK_EmployeeVerification_Verification FOREIGN KEY (verification_id) 
        REFERENCES Verification(verification_id)
);

-- =============================================
-- 7. Notification Table
-- =============================================
CREATE TABLE Notification (
    notification_id INT PRIMARY KEY IDENTITY(1,1),
    message_content VARCHAR(1000) NOT NULL,
    timestamp DATETIME DEFAULT GETDATE(),
    urgency VARCHAR(20) CHECK (urgency IN ('Low', 'Medium', 'High', 'Urgent')) DEFAULT 'Medium',
    read_status BIT DEFAULT 0,
    notification_type VARCHAR(50) NOT NULL
);

-- =============================================
-- 8. Employee_Notification Table (Many-to-Many)
-- =============================================
CREATE TABLE Employee_Notification (
    employee_id INT NOT NULL,
    notification_id INT NOT NULL,
    delivery_status VARCHAR(20) CHECK (delivery_status IN ('Pending', 'Delivered', 'Failed')) DEFAULT 'Pending',
    delivered_at DATETIME,
    PRIMARY KEY (employee_id, notification_id),
    CONSTRAINT FK_EmployeeNotification_Employee FOREIGN KEY (employee_id) 
        REFERENCES Employee(employee_id) ON DELETE CASCADE,
    CONSTRAINT FK_EmployeeNotification_Notification FOREIGN KEY (notification_id) 
        REFERENCES Notification(notification_id) ON DELETE CASCADE
);

-- =============================================
-- Create Indexes for Performance
-- =============================================

-- Department Indexes
CREATE INDEX IX_Department_Head ON Department(department_head_id);
CREATE INDEX IX_Department_Name ON Department(department_name);

-- Position Indexes
CREATE INDEX IX_Position_Title ON Position(position_title);
CREATE INDEX IX_Position_Status ON Position(status);

-- Skill Indexes
CREATE INDEX IX_Skill_Name ON Skill(skill_name);

-- Employee_Skill Indexes
CREATE INDEX IX_EmployeeSkill_Employee ON Employee_Skill(employee_id);
CREATE INDEX IX_EmployeeSkill_Skill ON Employee_Skill(skill_id);
CREATE INDEX IX_EmployeeSkill_Proficiency ON Employee_Skill(proficiency_level);

-- Verification Indexes
CREATE INDEX IX_Verification_Type ON Verification(verification_type);
CREATE INDEX IX_Verification_IssueDate ON Verification(issue_date);

-- Employee_Verification Indexes
CREATE INDEX IX_EmployeeVerification_Employee ON Employee_Verification(employee_id);
CREATE INDEX IX_EmployeeVerification_Verification ON Employee_Verification(verification_id);

-- Notification Indexes
CREATE INDEX IX_Notification_Type ON Notification(notification_type);
CREATE INDEX IX_Notification_Urgency ON Notification(urgency);
CREATE INDEX IX_Notification_Timestamp ON Notification(timestamp);
CREATE INDEX IX_Notification_ReadStatus ON Notification(read_status);

-- Employee_Notification Indexes
CREATE INDEX IX_EmployeeNotification_Employee ON Employee_Notification(employee_id);
CREATE INDEX IX_EmployeeNotification_Notification ON Employee_Notification(notification_id);
CREATE INDEX IX_EmployeeNotification_DeliveryStatus ON Employee_Notification(delivery_status);
-------------- End of Yousef's---------------------------


---------- Omar Zaher -----------
-- ================================
-- LEAVE MODULE
-- ================================

CREATE TABLE LeaveType (
    leave_id INT PRIMARY KEY,
    leave_type VARCHAR(50),
    leave_description VARCHAR(MAX)
);

CREATE TABLE VacationLeave (
    leave_id INT PRIMARY KEY,
    carry_over_days INT,
    approving_manager INT,
    FOREIGN KEY (leave_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE SickLeave (
    leave_id INT PRIMARY KEY,
    medical_cert_required BIT,
    physician_id INT,
    FOREIGN KEY (leave_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE ProbationLeave (
    leave_id INT PRIMARY KEY,
    eligibility_start_date DATE,
    probation_period INT,
    FOREIGN KEY (leave_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE HolidayLeave (
    leave_id INT PRIMARY KEY,
    holiday_name VARCHAR(100),
    official_recognition BIT,
    regional_scope VARCHAR(100),
    FOREIGN KEY (leave_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE LeavePolicy (
    policy_id INT PRIMARY KEY,
    name VARCHAR(100),
    purpose VARCHAR(MAX),
    eligibility_rules VARCHAR(MAX),
    notice_period INT,
    special_leave_type INT,
    reset_on_new_year BIT,
    FOREIGN KEY (special_leave_type) REFERENCES LeaveType(leave_id)
);

CREATE TABLE LeaveRequest (
    request_id INT PRIMARY KEY,
    employee_id INT,
    leave_id INT,
    justification VARCHAR(MAX),
    duration INT,
    approval_timing DATETIME2,
    status VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (leave_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE LeaveEntitlement (
    employee_id INT,
    leave_type_id INT,
    entitlement INT,
    PRIMARY KEY(employee_id, leave_type_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (leave_type_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE LeaveDocument (
    document_id INT PRIMARY KEY,
    leave_request_id INT,
    file_path VARCHAR(255),
    uploaded_at DATETIME2,
    FOREIGN KEY (leave_request_id) REFERENCES LeaveRequest(request_id)
);

-- ================================
-- ATTENDANCE MODULE
-- ================================

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    shift_id INT,
    entry_time DATETIME2,
    exit_time DATETIME2,
    duration INT,
    login_method VARCHAR(50),
    logout_method VARCHAR(50),
    exception_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (shift_id) REFERENCES ShiftSchedule(shift_id),
    FOREIGN KEY (exception_id) REFERENCES [Exception](exception_id)
);

CREATE TABLE AttendanceLog (
    attendance_log_id INT PRIMARY KEY,
    attendance_id INT,
    actor VARCHAR(100),
    [timestamp] DATETIME2,
    reason VARCHAR(MAX),
    FOREIGN KEY (attendance_id) REFERENCES Attendance(attendance_id)
);

CREATE TABLE AttendanceCorrectionRequest (
    request_id INT PRIMARY KEY,
    employee_id INT,
    date DATE,
    correction_type VARCHAR(50),
    reason VARCHAR(MAX),
    status VARCHAR(50),
    recorded_by INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (recorded_by) REFERENCES Employee(employee_id)
);

-- ================================
-- SHIFT MODULE
-- ================================

CREATE TABLE ShiftSchedule (
    shift_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    start_time TIME,
    end_time TIME,
    break_duration INT,
    shift_date DATE,
    status VARCHAR(50)
);

CREATE TABLE ShiftAssignment (
    assignment_id INT PRIMARY KEY,
    employee_id INT,
    shift_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (shift_id) REFERENCES ShiftSchedule(shift_id)
);

-- ================================
-- EXCEPTION MODULE
-- ================================

CREATE TABLE [Exception] (
    exception_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    date DATE,
    status VARCHAR(50)
);

CREATE TABLE Employee_Exception (
    employee_id INT,
    exception_id INT,
    PRIMARY KEY(employee_id, exception_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (exception_id) REFERENCES [Exception](exception_id)
);

-- ================================
-- PAYROLL MODULE
-- ================================

CREATE TABLE Payroll (
    payroll_id INT PRIMARY KEY,
    employee_id INT,
    taxes DECIMAL(10,2),
    period_start DATE,
    period_end DATE,
    base_amount DECIMAL(10,2),
    adjustments DECIMAL(10,2),
    contributions DECIMAL(10,2),
    actual_pay DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Currency (
    CurrencyCode VARCHAR(10) PRIMARY KEY,
    CurrencyName VARCHAR(50),
    ExchangeRate DECIMAL(10,4),
    CreatedDate DATE,
    LastUpdated DATE
);

CREATE TABLE SalaryType (
    salary_type_id INT PRIMARY KEY,
    type VARCHAR(50),
    payment_frequency VARCHAR(50),
    currency VARCHAR(10),
    FOREIGN KEY (currency) REFERENCES Currency(CurrencyCode)
);

CREATE TABLE HourlySalaryType (
    salary_type_id INT PRIMARY KEY,
    hourly_rate DECIMAL(10,2),
    max_monthly_hours INT,
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

CREATE TABLE MonthlySalaryType (
    salary_type_id INT PRIMARY KEY,
    tax_rule VARCHAR(MAX),
    contribution_scheme VARCHAR(MAX),
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

CREATE TABLE ContractSalaryType (
    salary_type_id INT PRIMARY KEY,
    contract_value DECIMAL(10,2),
    installment_details VARCHAR(MAX),
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

CREATE TABLE AllowanceDeduction (
    ad_id INT PRIMARY KEY,
    payroll_id INT,
    employee_id INT,
    type VARCHAR(50),
    amount DECIMAL(10,2),
    currency VARCHAR(10),
    duration VARCHAR(50),
    timezone VARCHAR(50),
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (currency) REFERENCES Currency(CurrencyCode)
);

CREATE TABLE PayrollPolicy (
    policy_id INT PRIMARY KEY,
    effective_date DATE,
    type VARCHAR(50),
    description VARCHAR(MAX)
);

CREATE TABLE OvertimePolicy (
    policy_id INT PRIMARY KEY,
    weekday_rate_multiplier DECIMAL(5,2),
    weekend_rate_multiplier DECIMAL(5,2),
    max_hours_per_month INT,
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

CREATE TABLE LatenessPolicy (
    policy_id INT PRIMARY KEY,
    grace_period_mins INT,
    deduction_rate DECIMAL(5,2),
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

CREATE TABLE BonusPolicy (
    policy_id INT PRIMARY KEY,
    bonus_type VARCHAR(50),
    eligibility_criteria VARCHAR(MAX),
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

CREATE TABLE DeductionPolicy (
    policy_id INT PRIMARY KEY,
    deduction_reason VARCHAR(100),
    calculation_mode VARCHAR(50),
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

CREATE TABLE PayrollPolicy_ID (
    payroll_id INT,
    policy_id INT,
    PRIMARY KEY(payroll_id, policy_id),
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id),
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

CREATE TABLE Payroll_Log (
    payroll_log_id INT PRIMARY KEY,
    payroll_id INT,
    actor VARCHAR(100),
    change_date DATETIME2,
    modification_type VARCHAR(50),
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id)
);

-- ================================
-- MISC MODULE
-- ================================

CREATE TABLE TaxForm (
    tax_form_id INT PRIMARY KEY,
    jurisdiction VARCHAR(100),
    validity_period VARCHAR(100),
    form_content VARCHAR(MAX)
);

CREATE TABLE PayGrade (
    pay_grade_id INT PRIMARY KEY,
    grade_name VARCHAR(50),
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
);

CREATE TABLE PayrollPeriod (
    payroll_period_id INT PRIMARY KEY,
    payroll_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id)
);

CREATE TABLE Notification (
    notification_id INT PRIMARY KEY,
    message_content VARCHAR(MAX),
    [timestamp] DATETIME2,
    urgency VARCHAR(50),
    read_status BIT,
    notification_type VARCHAR(50)
);

CREATE TABLE Employee_Notification (
    employee_id INT,
    notification_id INT,
    delivery_status VARCHAR(50),
    delivered_at DATETIME2,
    PRIMARY KEY(employee_id, notification_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (notification_id) REFERENCES Notification(notification_id)
);

CREATE TABLE EmployeeHierarchy (
    employee_id INT,
    manager_id INT,
    hierarchy_level INT,
    PRIMARY KEY(employee_id, manager_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Device (
    device_id INT PRIMARY KEY,
    device_type VARCHAR(50),
    terminal_id VARCHAR(50),
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);
--------- Omar Zaher End -------------



- =============================================
-- Tarek - Payroll, Salary Types & Policies
-- Tables Creation Script
-- =============================================

-- Currency Table
CREATE TABLE Currency (
    CurrencyCode VARCHAR(10) PRIMARY KEY,
    CurrencyName VARCHAR(50) NOT NULL,
    ExchangeRate DECIMAL(10,4) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME DEFAULT GETDATE()
);

-- Salary Type Table
CREATE TABLE SalaryType (
    salary_type_id INT PRIMARY KEY IDENTITY(1,1),
    type VARCHAR(50) NOT NULL,
    payment_frequency VARCHAR(50),
    currency VARCHAR(10),
    FOREIGN KEY (currency) REFERENCES Currency(CurrencyCode)
);

-- Hourly Salary Type
CREATE TABLE HourlySalaryType (
    salary_type_id INT PRIMARY KEY,
    hourly_rate DECIMAL(10,2) NOT NULL,
    max_monthly_hours INT,
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

-- Monthly Salary Type
CREATE TABLE MonthlySalaryType (
    salary_type_id INT PRIMARY KEY,
    tax_rule VARCHAR(200),
    contribution_scheme VARCHAR(200),
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

-- Contract Salary Type
CREATE TABLE ContractSalaryType (
    salary_type_id INT PRIMARY KEY,
    contract_value DECIMAL(10,2) NOT NULL,
    installment_details VARCHAR(500),
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

-- Pay Grade Table
CREATE TABLE PayGrade (
    pay_grade_id INT PRIMARY KEY IDENTITY(1,1),
    grade_name VARCHAR(50) NOT NULL UNIQUE,
    min_salary DECIMAL(10,2) NOT NULL,
    max_salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_PayGrade_MinMax CHECK (min_salary < max_salary)
);

-- Payroll Table
CREATE TABLE Payroll (
    payroll_id INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT NOT NULL,
    taxes DECIMAL(10,2) DEFAULT 0,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    base_amount DECIMAL(10,2) NOT NULL,
    adjustments DECIMAL(10,2) DEFAULT 0,
    contributions DECIMAL(10,2) DEFAULT 0,
    actual_pay DECIMAL(10,2),
    net_salary AS (base_amount + adjustments - taxes - contributions),
    payment_date DATE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Allowance Deduction Table
CREATE TABLE AllowanceDeduction (
    ad_id INT PRIMARY KEY IDENTITY(1,1),
    payroll_id INT NOT NULL,
    employee_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10),
    duration VARCHAR(50),
    timezone VARCHAR(50),
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (currency) REFERENCES Currency(CurrencyCode)
);

-- Payroll Policy Table
CREATE TABLE PayrollPolicy (
    policy_id INT PRIMARY KEY IDENTITY(1,1),
    effective_date DATE NOT NULL,
    type VARCHAR(50) NOT NULL,
    description NVARCHAR(MAX)
);

-- Overtime Policy Table
CREATE TABLE OvertimePolicy (
    policy_id INT PRIMARY KEY,
    weekday_rate_multiplier DECIMAL(3,2) NOT NULL,
    weekend_rate_multiplier DECIMAL(3,2) NOT NULL,
    max_hours_per_month INT,
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

-- Lateness Policy Table
CREATE TABLE LatenessPolicy (
    policy_id INT PRIMARY KEY,
    grace_period_mins INT NOT NULL,
    deduction_rate DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

-- Bonus Policy Table
CREATE TABLE BonusPolicy (
    policy_id INT PRIMARY KEY,
    bonus_type VARCHAR(50) NOT NULL,
    eligibility_criteria NVARCHAR(MAX),
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

-- Deduction Policy Table
CREATE TABLE DeductionPolicy (
    policy_id INT PRIMARY KEY,
    deduction_reason VARCHAR(100) NOT NULL,
    calculation_mode VARCHAR(50) NOT NULL,
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

-- Payroll Policy ID Junction Table
CREATE TABLE PayrollPolicy_ID (
    payroll_id INT NOT NULL,
    policy_id INT NOT NULL,
    PRIMARY KEY (payroll_id, policy_id),
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id),
    FOREIGN KEY (policy_id) REFERENCES PayrollPolicy(policy_id)
);

-- Payroll Log Table
CREATE TABLE Payroll_Log (
    payroll_log_id INT PRIMARY KEY IDENTITY(1,1),
    payroll_id INT NOT NULL,
    actor INT NOT NULL,
    change_date DATETIME DEFAULT GETDATE(),
    modification_type VARCHAR(100) NOT NULL,
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id)
);

-- Tax Form Table
CREATE TABLE TaxForm (
    tax_form_id INT PRIMARY KEY IDENTITY(1,1),
    jurisdiction VARCHAR(100) NOT NULL,
    validity_period VARCHAR(100),
    form_content NVARCHAR(MAX)
);

-- Payroll Period Table
CREATE TABLE PayrollPeriod (
    payroll_period_id INT PRIMARY KEY IDENTITY(1,1),
    payroll_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Open',
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id),
    CONSTRAINT CHK_PayrollPeriod_Dates CHECK (start_date < end_date)
);
-------------------------------Tarek End--------------------------------------
