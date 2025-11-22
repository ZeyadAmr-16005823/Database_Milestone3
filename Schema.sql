-- =============================================
------------------Ziad's Part-------------------
-- =============================================

-- Table: Position (Referenced by Employee)
CREATE TABLE Position (
    position_id INT PRIMARY KEY IDENTITY(1,1),
    position_title VARCHAR(100) NOT NULL,
    responsibilities VARCHAR(500),
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive'))
);

-- Table: Department (Referenced by Employee)
CREATE TABLE Department (
    department_id INT PRIMARY KEY IDENTITY(1,1),
    department_name VARCHAR(100) NOT NULL,
    purpose VARCHAR(200),
    department_head_id INT NULL,
    FOREIGN KEY (department_head_id) REFERENCES Employee(employee_id)
);

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




---------- Omar Zaher -----------
-- ================================
-- LEAVE MODULE
-- ================================
CREATE TABLE LeaveType (
    leave_id INT PRIMARY KEY,
    leave_type VARCHAR(50),
    leave_description TEXT
);

CREATE TABLE VacationLeave (
    leave_id INT PRIMARY KEY,
    carry_over_days INT,
    approving_manager INT,
    FOREIGN KEY (leave_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE SickLeave (
    leave_id INT PRIMARY KEY,
    medical_cert_required BOOLEAN,
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
    official_recognition BOOLEAN,
    regional_scope VARCHAR(100),
    FOREIGN KEY (leave_id) REFERENCES LeaveType(leave_id)
);

CREATE TABLE LeavePolicy (
    policy_id INT PRIMARY KEY,
    name VARCHAR(100),
    purpose TEXT,
    eligibility_rules TEXT,
    notice_period INT,
    special_leave_type INT,
    reset_on_new_year BOOLEAN,
    FOREIGN KEY (special_leave_type) REFERENCES LeaveType(leave_id)
);

CREATE TABLE LeaveRequest (
    request_id INT PRIMARY KEY,
    employee_id INT,
    leave_id INT,
    justification TEXT,
    duration INT,
    approval_timing TIMESTAMP,
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
    uploaded_at TIMESTAMP,
    FOREIGN KEY (leave_request_id) REFERENCES LeaveRequest(request_id)
);

-- ================================
-- ATTENDANCE MODULE
-- ================================

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    shift_id INT,
    entry_time TIMESTAMP,
    exit_time TIMESTAMP,
    duration INT,
    login_method VARCHAR(50),
    logout_method VARCHAR(50),
    exception_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (shift_id) REFERENCES ShiftSchedule(shift_id),
    FOREIGN KEY (exception_id) REFERENCES Exception(exception_id)
);

CREATE TABLE AttendanceLog (
    attendance_log_id INT PRIMARY KEY,
    attendance_id INT,
    actor VARCHAR(100),
    timestamp TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (attendance_id) REFERENCES Attendance(attendance_id)
);

CREATE TABLE AttendanceCorrectionRequest (
    request_id INT PRIMARY KEY,
    employee_id INT,
    date DATE,
    correction_type VARCHAR(50),
    reason TEXT,
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

CREATE TABLE Exception (
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
    FOREIGN KEY (exception_id) REFERENCES Exception(exception_id)
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
    currency VARCHAR(50),
    FOREIGN KEY (currency) REFERENCES Currency(CurrencyName)
);

CREATE TABLE HourlySalaryType (
    salary_type_id INT PRIMARY KEY,
    hourly_rate DECIMAL(10,2),
    max_monthly_hours INT,
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

CREATE TABLE MonthlySalaryType (
    salary_type_id INT PRIMARY KEY,
    tax_rule TEXT,
    contribution_scheme TEXT,
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

CREATE TABLE ContractSalaryType (
    salary_type_id INT PRIMARY KEY,
    contract_value DECIMAL(10,2),
    installment_details TEXT,
    FOREIGN KEY (salary_type_id) REFERENCES SalaryType(salary_type_id)
);

CREATE TABLE AllowanceDeduction (
    ad_id INT PRIMARY KEY,
    payroll_id INT,
    employee_id INT,
    type VARCHAR(50),
    amount DECIMAL(10,2),
    currency VARCHAR(50),
    duration VARCHAR(50),
    timezone VARCHAR(50),
    FOREIGN KEY (payroll_id) REFERENCES Payroll(payroll_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (currency) REFERENCES Currency(CurrencyName)
);

CREATE TABLE PayrollPolicy (
    policy_id INT PRIMARY KEY,
    effective_date DATE,
    type VARCHAR(50),
    description TEXT
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
    eligibility_criteria TEXT,
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
    change_date TIMESTAMP,
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
    form_content TEXT
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
    message_content TEXT,
    timestamp TIMESTAMP,
    urgency VARCHAR(50),
    read_status BOOLEAN,
    notification_type VARCHAR(50)
);

CREATE TABLE Employee_Notification (
    employee_id INT,
    notification_id INT,
    delivery_status VARCHAR(50),
    delivered_at TIMESTAMP,
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
