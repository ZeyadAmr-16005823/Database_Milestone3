-- =============================================
------------------Ziad's Part-------------------
-- =============================================
-- CEO and Top Management
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth, 
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active, 
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('John', 'Anderson', 'John Anderson', '12345678901234', '1975-03-15', 'USA',
    '+1-555-0001', 'john.anderson@company.com', '123 Executive St, New York, NY',
    'Mary Anderson', '+1-555-0002', 'Spouse',
    'Experienced CEO with 20 years in tech industry', 'Completed', 'Active', 'Active',
    '2015-01-01', 1, 100, 1, 1, NULL, 1);

-- HR Director (will manage HR team)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Sarah', 'Johnson', 'Sarah Johnson', '12345678901235', '1980-06-20', 'USA',
    '+1-555-0010', 'sarah.johnson@company.com', '456 HR Blvd, New York, NY',
    'Mike Johnson', '+1-555-0011', 'Spouse',
    'HR Director with expertise in talent management', 'Completed', 'Active', 'Active',
    '2016-03-15', 1, 100, 2, 4, 1, 1);

-- IT Manager (will manage IT team)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Michael', 'Chen', 'Michael Chen', '12345678901236', '1982-09-10', 'Canada',
    '+1-555-0020', 'michael.chen@company.com', '789 Tech Ave, New York, NY',
    'Lisa Chen', '+1-555-0021', 'Spouse',
    'IT Manager specializing in infrastructure', 'Completed', 'Active', 'Active',
    '2017-05-01', 1, 100, 3, 5, 1, 1);

-- Finance Manager
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('David', 'Miller', 'David Miller', '12345678901237', '1978-11-25', 'USA',
    '+1-555-0030', 'david.miller@company.com', '321 Finance Dr, New York, NY',
    'Emma Miller', '+1-555-0031', 'Spouse',
    'CFO with strong financial planning background', 'Completed', 'Active', 'Active',
    '2016-07-01', 1, 100, 4, 3, 1, 1);

-- HR Specialists (report to HR Director)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Emily', 'Davis', 'Emily Davis', '12345678901238', '1990-04-12', 'USA',
    '+1-555-0040', 'emily.davis@company.com', '111 Park Lane, New York, NY',
    'Robert Davis', '+1-555-0041', 'Father',
    'HR Specialist focusing on recruitment', 'Completed', 'Active', 'Active',
    '2019-01-15', 1, 95, 2, 10, 2, 1),
('James', 'Wilson', 'James Wilson', '12345678901239', '1988-08-30', 'UK',
    '+1-555-0050', 'james.wilson@company.com', '222 Queens St, New York, NY',
    'Anna Wilson', '+1-555-0051', 'Spouse',
    'HR Specialist handling employee relations', 'Completed', 'Active', 'Active',
    '2018-06-01', 1, 90, 2, 10, 2, 1);

-- Payroll Officers (report to Finance Manager)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Lisa', 'Brown', 'Lisa Brown', '12345678901240', '1985-02-18', 'USA',
    '+1-555-0060', 'lisa.brown@company.com', '333 Finance Plaza, New York, NY',
    'Tom Brown', '+1-555-0061', 'Spouse',
    'Payroll Officer with 8 years experience', 'Completed', 'Active', 'Active',
    '2017-09-01', 1, 100, 4, 11, 4, 1),
('Robert', 'Taylor', 'Robert Taylor', '12345678901241', '1992-12-05', 'USA',
    '+1-555-0070', 'robert.taylor@company.com', '444 Money St, New York, NY',
    'Jennifer Taylor', '+1-555-0071', 'Mother',
    'Junior Payroll Officer', 'In Progress', 'Active', 'Active',
    '2020-03-15', 1, 85, 4, 11, 4, 1);

-- System Administrators (report to IT Manager)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Kevin', 'Martinez', 'Kevin Martinez', '12345678901242', '1987-07-22', 'Mexico',
    '+1-555-0080', 'kevin.martinez@company.com', '555 Server Rd, New York, NY',
    'Maria Martinez', '+1-555-0081', 'Spouse',
    'Senior System Administrator', 'Completed', 'Active', 'Active',
    '2018-02-01', 1, 100, 3, 12, 3, 1),
('Amanda', 'Garcia', 'Amanda Garcia', '12345678901243', '1993-05-14', 'Spain',
    '+1-555-0090', 'amanda.garcia@company.com', '666 Network Ave, New York, NY',
    'Carlos Garcia', '+1-555-0091', 'Father',
    'System Administrator', 'Completed', 'Active', 'Active',
    '2019-08-01', 1, 95, 3, 12, 3, 1);

-- Software Developers (report to IT Manager)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Daniel', 'Lee', 'Daniel Lee', '12345678901244', '1991-03-08', 'South Korea',
    '+1-555-0100', 'daniel.lee@company.com', '777 Code St, New York, NY',
    'Susan Lee', '+1-555-0101', 'Mother',
    'Senior Software Engineer', 'Completed', 'Active', 'Active',
    '2018-11-01', 1, 100, 3, 7, 3, 1),
('Jessica', 'White', 'Jessica White', '12345678901245', '1994-09-19', 'USA',
    '+1-555-0110', 'jessica.white@company.com', '888 Dev Blvd, New York, NY',
    'Paul White', '+1-555-0111', 'Father',
    'Software Engineer', 'Completed', 'Active', 'Active',
    '2020-01-15', 1, 90, 3, 6, 3, 1),
('Christopher', 'Harris', 'Christopher Harris', '12345678901246', '1995-11-30', 'USA',
    '+1-555-0120', 'chris.harris@company.com', '999 Programming Ln, New York, NY',
    'Nancy Harris', '+1-555-0121', 'Mother',
    'Junior Developer', 'In Progress', 'Active', 'Active',
    '2021-06-01', 1, 75, 3, 8, 3, 1);

-- Team Leads (report to IT Manager)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Patricia', 'Clark', 'Patricia Clark', '12345678901247', '1986-01-25', 'USA',
    '+1-555-0130', 'patricia.clark@company.com', '101 Leader Dr, New York, NY',
    'Mark Clark', '+1-555-0131', 'Spouse',
    'Team Lead for Backend Development', 'Completed', 'Active', 'Active',
    '2017-04-01', 1, 100, 3, 13, 3, 1),
('Thomas', 'Lewis', 'Thomas Lewis', '12345678901248', '1989-06-17', 'USA',
    '+1-555-0140', 'thomas.lewis@company.com', '202 Management St, New York, NY',
    'Karen Lewis', '+1-555-0141', 'Spouse',
    'Team Lead for Frontend Development', 'Completed', 'Active', 'Active',
    '2018-08-15', 1, 100, 3, 13, 3, 1);

-- Accountants (report to Finance Manager)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Michelle', 'Robinson', 'Michelle Robinson', '12345678901249', '1990-10-03', 'USA',
    '+1-555-0150', 'michelle.robinson@company.com', '303 Accounting Way, New York, NY',
    'Steven Robinson', '+1-555-0151', 'Spouse',
    'Senior Accountant', 'Completed', 'Active', 'Active',
    '2019-02-01', 1, 95, 4, 9, 4, 1);

-- Interns (various departments)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Sophia', 'Walker', 'Sophia Walker', '12345678901250', '1999-04-20', 'USA',
    '+1-555-0160', 'sophia.walker@company.com', '404 Intern Ave, New York, NY',
    'Helen Walker', '+1-555-0161', 'Mother',
    'IT Intern learning software development', 'In Progress', 'Active', 'Active',
    '2023-09-01', 1, 60, 3, 15, 11, 1),
('Andrew', 'Hall', 'Andrew Hall', '12345678901251', '2000-07-12', 'USA',
    '+1-555-0170', 'andrew.hall@company.com', '505 Student Rd, New York, NY',
    'Brian Hall', '+1-555-0171', 'Father',
    'HR Intern supporting recruitment', 'In Progress', 'Active', 'Active',
    '2023-09-01', 1, 55, 2, 15, 2, 1);

-- Inactive/Past Employees (for testing scenarios)
INSERT INTO Employee (first_name, last_name, full_name, national_id, date_of_birth, country_of_birth,
    phone, email, address, emergency_contact_name, emergency_contact_phone, relationship,
    biography, employment_progress, account_status, employment_status, hire_date, is_active,
    profile_completion, department_id, position_id, manager_id, salary_type_id) VALUES
('Richard', 'Young', 'Richard Young', '12345678901252', '1985-12-08', 'USA',
    '+1-555-0180', 'richard.young@company.com', '606 Former St, New York, NY',
    'Linda Young', '+1-555-0181', 'Spouse',
    'Former employee', 'Completed', 'Inactive', 'Terminated',
    '2019-01-01', 0, 100, 3, 6, 3, 1);

-- =============================================
-- 2. INSERT ROLES
-- =============================================
INSERT INTO Role (role_name, purpose) VALUES
('System Administrator', 'Full system access and configuration'),
('HR Administrator', 'HR operations and employee management'),
('Payroll Officer', 'Payroll processing and salary management'),
('Line Manager', 'Team management and approval authority'),
('Employee', 'Standard employee access'),
('Executive', 'Executive level access and decision making'),
('Payroll Specialist', 'Advanced payroll configuration');

-- =============================================
-- 3. INSERT ROLE PERMISSIONS
-- =============================================
-- System Administrator Permissions
INSERT INTO RolePermission (role_id, permission_name, allowed_action) VALUES
(1, 'Manage Users', 'Create, Read, Update, Delete'),
(1, 'Manage Roles', 'Create, Read, Update, Delete'),
(1, 'Manage Hierarchy', 'Create, Read, Update, Delete'),
(1, 'Manage Shifts', 'Create, Read, Update, Delete'),
(1, 'Manage Attendance', 'Create, Read, Update, Delete'),
(1, 'View All Data', 'Read'),
(1, 'System Configuration', 'Create, Update');

-- HR Administrator Permissions
INSERT INTO RolePermission (role_id, permission_name, allowed_action) VALUES
(2, 'Manage Employees', 'Create, Read, Update'),
(2, 'Manage Contracts', 'Create, Read, Update'),
(2, 'Approve Leave', 'Approve, Reject'),
(2, 'Manage Leave Policies', 'Create, Read, Update'),
(2, 'View Payroll Summary', 'Read'),
(2, 'Manage Missions', 'Create, Read, Update'),
(2, 'Manage Profiles', 'Create, Read, Update');

-- Payroll Officer Permissions
INSERT INTO RolePermission (role_id, permission_name, allowed_action) VALUES
(3, 'Generate Payroll', 'Create, Read'),
(3, 'Adjust Payroll', 'Update'),
(3, 'View Payroll History', 'Read'),
(3, 'Manage Allowances', 'Create, Read, Update'),
(3, 'Sync Attendance to Payroll', 'Execute'),
(3, 'Configure Pay Grades', 'Create, Read, Update');

-- Line Manager Permissions
INSERT INTO RolePermission (role_id, permission_name, allowed_action) VALUES
(4, 'View Team', 'Read'),
(4, 'Approve Leave', 'Approve, Reject'),
(4, 'Manage Team Shifts', 'Create, Read, Update'),
(4, 'View Team Attendance', 'Read'),
(4, 'Approve Time Requests', 'Approve, Reject'),
(4, 'Add Manager Notes', 'Create, Read');

-- Employee Permissions
INSERT INTO RolePermission (role_id, permission_name, allowed_action) VALUES
(5, 'View Own Profile', 'Read'),
(5, 'Update Own Contact', 'Update'),
(5, 'Submit Leave Request', 'Create'),
(5, 'View Own Payroll', 'Read'),
(5, 'Record Attendance', 'Create'),
(5, 'View Own Shifts', 'Read');

-- Executive Permissions
INSERT INTO RolePermission (role_id, permission_name, allowed_action) VALUES
(6, 'View All Reports', 'Read'),
(6, 'Approve Major Decisions', 'Approve'),
(6, 'Override Decisions', 'Update'),
(6, 'Access All Departments', 'Read');

-- Payroll Specialist Permissions
INSERT INTO RolePermission (role_id, permission_name, allowed_action) VALUES
(7, 'Configure Payroll Policies', 'Create, Read, Update'),
(7, 'Configure Insurance', 'Create, Read, Update'),
(7, 'Manage Tax Rules', 'Create, Read, Update'),
(7, 'Configure Overtime Rules', 'Create, Read, Update');

-- =============================================
-- 4. INSERT EMPLOYEE_ROLE (Assign roles to employees)
-- =============================================
-- CEO - Executive role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(1, 6, '2015-01-01');

-- HR Director - HR Administrator role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(2, 2, '2016-03-15'),
(2, 4, '2016-03-15'); -- Also a Line Manager

-- IT Manager - Line Manager role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(3, 4, '2017-05-01');

-- Finance Manager - Line Manager role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(4, 4, '2016-07-01');

-- HR Specialists - HR Admin + Employee
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(5, 2, '2019-01-15'),
(5, 5, '2019-01-15'),
(6, 2, '2018-06-01'),
(6, 5, '2018-06-01');

-- Payroll Officers - Payroll Officer role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(7, 3, '2017-09-01'),
(7, 5, '2017-09-01'),
(8, 3, '2020-03-15'),
(8, 5, '2020-03-15');

-- System Administrators - System Admin role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(9, 1, '2018-02-01'),
(9, 5, '2018-02-01'),
(10, 1, '2019-08-01'),
(10, 5, '2019-08-01');

-- Developers - Employee role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(11, 5, '2018-11-01'),
(12, 5, '2020-01-15'),
(13, 5, '2021-06-01');

-- Team Leads - Line Manager + Employee
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(14, 4, '2017-04-01'),
(14, 5, '2017-04-01'),
(15, 4, '2018-08-15'),
(15, 5, '2018-08-15');

-- Accountant - Employee role
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(16, 5, '2019-02-01');

-- Interns - Employee role only
INSERT INTO Employee_Role (employee_id, role_id, assigned_date) VALUES
(17, 5, '2023-09-01'),
(18, 5, '2023-09-01');

-- =============================================
-- 5. INSERT HR ADMINISTRATORS
-- =============================================
INSERT INTO HRAdministrator (employee_id, approval_level, record_access_scope, document_validation_rights) VALUES
(2, 'Chief', 'All Departments', 'Full Validation Rights'),
(5, 'Senior', 'HR Department', 'Standard Validation'),
(6, 'Junior', 'HR Department', 'Basic Validation');

-- =============================================
-- 6. INSERT SYSTEM ADMINISTRATORS
-- =============================================
INSERT INTO SystemAdministrator (employee_id, system_privilege_level, configurable_fields, audit_visibility_scope) VALUES
(9, 'Super', 'All System Fields', 'Full Audit Access'),
(10, 'Senior', 'Standard System Fields', 'Department Level Audit');

-- =============================================
-- 7. INSERT PAYROLL SPECIALISTS
-- =============================================
INSERT INTO PayrollSpecialist (employee_id, assigned_region, processing_frequency, last_processed_period) VALUES
(7, 'North America', 'Monthly', '2024-10-31'),
(8, 'North America', 'Monthly', '2024-10-31');

-- =============================================
-- 8. INSERT LINE MANAGERS
-- =============================================
INSERT INTO LineManager (employee_id, team_size, supervised_departments, approval_limit) VALUES
(2, 3, 'Human Resources', 50000.00),
(3, 8, 'Information Technology', 75000.00),
(4, 3, 'Finance', 100000.00),
(14, 4, 'IT - Backend Team', 25000.00),
(15, 3, 'IT - Frontend Team', 25000.00);

-- =============================================
-- 9. INSERT EMPLOYEE HIERARCHY
-- =============================================
-- CEO at top (no manager)
INSERT INTO EmployeeHierarchy (employee_id, manager_id, hierarchy_level) VALUES
(1, NULL, 1);

-- Department Heads report to CEO
INSERT INTO EmployeeHierarchy (employee_id, manager_id, hierarchy_level) VALUES
(2, 1, 2), -- HR Director
(3, 1, 2), -- IT Manager
(4, 1, 2); -- Finance Manager

-- HR Team reports to HR Director
INSERT INTO EmployeeHierarchy (employee_id, manager_id, hierarchy_level) VALUES
(5, 2, 3), -- HR Specialist
(6, 2, 3), -- HR Specialist
(18, 2, 3); -- HR Intern

-- Finance Team reports to Finance Manager
INSERT INTO EmployeeHierarchy (employee_id, manager_id, hierarchy_level) VALUES
(7, 4, 3), -- Payroll Officer
(8, 4, 3), -- Payroll Officer
(16, 4, 3); -- Accountant

-- IT Team - Team Leads report to IT Manager
INSERT INTO EmployeeHierarchy (employee_id, manager_id, hierarchy_level) VALUES
(9, 3, 3),  -- System Admin
(10, 3, 3), -- System Admin
(14, 3, 3), -- Team Lead
(15, 3, 3); -- Team Lead

-- Developers report to Team Leads
INSERT INTO EmployeeHierarchy (employee_id, manager_id, hierarchy_level) VALUES
(11, 14, 4), -- Senior Dev to Backend Lead
(12, 14, 4), -- Developer to Backend Lead
(13, 15, 4), -- Junior Dev to Frontend Lead
(17, 15, 4); -- IT Intern to Frontend Lead

-- =============================================
-- 10. INSERT MANAGER NOTES
-- =============================================
INSERT INTO ManagerNotes (employee_id, manager_id, note_content, created_at) VALUES
(5, 2, 'Excellent performance in Q3 recruitment drive. Hired 5 quality candidates.', '2024-10-15 10:30:00'),
(6, 2, 'Good handling of employee conflict resolution case. Shows strong mediation skills.', '2024-09-20 14:15:00'),
(11, 14, 'Outstanding code quality. Completed backend refactoring 2 weeks ahead of schedule.', '2024-10-01 09:00:00'),
(12, 14, 'Needs improvement in code documentation. Discussed best practices.', '2024-09-15 16:45:00'),
(13, 15, 'Showing good progress. Completed first major feature independently.', '2024-10-20 11:20:00'),
(17, 15, 'Eager learner. Completed training modules ahead of schedule.', '2024-10-10 13:30:00'),
(7, 4, 'Processed October payroll accurately with zero errors. Excellent attention to detail.', '2024-11-01 10:00:00'),
(16, 4, 'Completed Q3 financial reporting efficiently. Ready for more responsibility.', '2024-10-05 15:00:00');

-- =============================================
-- 11. INSERT APPROVAL WORKFLOWS
-- =============================================
-- Leave Approval Workflow
INSERT INTO ApprovalWorkflow (workflow_type, threshold_amount, approver_role, created_by, status) VALUES
('Leave', NULL, 'Line Manager', 2, 'Active'),
('Leave - Extended', NULL, 'HR Administrator', 2, 'Active'),
('Leave - Special', NULL, 'Executive', 2, 'Active');

-- Payroll Approval Workflow
INSERT INTO ApprovalWorkflow (workflow_type, threshold_amount, approver_role, created_by, status) VALUES
('Payroll Adjustment', 5000.00, 'Payroll Officer', 7, 'Active'),
('Payroll Adjustment - Major', 20000.00, 'Line Manager', 7, 'Active'),
('Payroll Configuration', NULL, 'Executive', 7, 'Active');

-- Time Correction Workflow
INSERT INTO ApprovalWorkflow (workflow_type, threshold_amount, approver_role, created_by, status) VALUES
('Time Correction', NULL, 'Line Manager', 9, 'Active'),
('Attendance Override', NULL, 'HR Administrator', 9, 'Active');

-- Expense Reimbursement Workflow
INSERT INTO ApprovalWorkflow (workflow_type, threshold_amount, approver_role, created_by, status) VALUES
('Expense - Standard', 1000.00, 'Line Manager', 2, 'Active'),
('Expense - Major', 5000.00, 'Executive', 2, 'Active');

-- Policy Change Workflow
INSERT INTO ApprovalWorkflow (workflow_type, threshold_amount, approver_role, created_by, status) VALUES
('Policy Update', NULL, 'HR Administrator', 2, 'Active'),
('Major Policy Change', NULL, 'Executive', 2, 'Active');

-- =============================================
-- 12. INSERT APPROVAL WORKFLOW STEPS
-- =============================================
-- Leave Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(1, 1, 4, 'Review and Approve/Reject Leave Request'), -- Line Manager
(1, 2, 2, 'Final Approval if > 10 days'); -- HR Administrator

-- Extended Leave Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(2, 1, 4, 'Initial Review'), -- Line Manager
(2, 2, 2, 'HR Review and Approval'), -- HR Administrator
(2, 3, 6, 'Executive Approval if > 30 days'); -- Executive

-- Payroll Adjustment Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(4, 1, 3, 'Review Adjustment'), -- Payroll Officer
(4, 2, 4, 'Manager Approval'); -- Line Manager

-- Major Payroll Adjustment Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(5, 1, 3, 'Initial Review'), -- Payroll Officer
(5, 2, 4, 'Manager Review'), -- Line Manager
(5, 3, 6, 'Executive Approval'); -- Executive

-- Time Correction Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(7, 1, 4, 'Review and Approve Time Correction'); -- Line Manager

-- Expense Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(9, 1, 4, 'Review and Approve Expense'); -- Line Manager (Standard Expense)

-- Major Expense Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(10, 1, 4, 'Initial Review'), -- Line Manager
(10, 2, 6, 'Executive Approval'); -- Executive (Major Expense)

-- Policy Update Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(11, 1, 2, 'HR Review and Approval'); -- HR Administrator

-- Major Policy Change Workflow Steps
INSERT INTO ApprovalWorkflowStep (workflow_id, step_number, role_id, action_required) VALUES
(12, 1, 2, 'HR Review'), -- HR Administrator
(12, 2, 6, 'Executive Approval'); -- Executive

-- =============================================
----------------Ziad END-------------------------------------------------------------------
-- =============================================



- =============================================
-- Tarek - Payroll, Salary Types & Policies
-- Data Insertion Script
-- =============================================

-- Insert Currency Data
INSERT INTO Currency (CurrencyCode, CurrencyName, ExchangeRate, CreatedDate, LastUpdated)
VALUES 
('USD', 'US Dollar', 1.0000, GETDATE(), GETDATE()),
('EUR', 'Euro', 0.9200, GETDATE(), GETDATE()),
('GBP', 'British Pound', 0.8000, GETDATE(), GETDATE()),
('EGP', 'Egyptian Pound', 30.9000, GETDATE(), GETDATE()),
('SAR', 'Saudi Riyal', 3.7500, GETDATE(), GETDATE());

-- Insert Salary Types
INSERT INTO SalaryType (type, payment_frequency, currency)
VALUES 
('Hourly', 'Weekly', 'EGP'),
('Monthly', 'Monthly', 'EGP'),
('Contract', 'Milestone', 'USD'),
('Monthly', 'Monthly', 'USD'),
('Hourly', 'Bi-Weekly', 'USD'),
('Monthly', 'Monthly', 'SAR');

-- Insert Hourly Salary Types
INSERT INTO HourlySalaryType (salary_type_id, hourly_rate, max_monthly_hours)
VALUES 
(1, 50.00, 180),
(5, 75.00, 160);

-- Insert Monthly Salary Types
INSERT INTO MonthlySalaryType (salary_type_id, tax_rule, contribution_scheme)
VALUES 
(2, 'Progressive 10-25%', 'Social Insurance 11%'),
(4, 'Flat 15%', 'Social Insurance 11%'),
(6, 'Progressive 5-20%', 'Social Insurance 9%');

-- Insert Contract Salary Types
INSERT INTO ContractSalaryType (salary_type_id, contract_value, installment_details)
VALUES 
(3, 120000.00, 'Quarterly payments based on milestones');

-- Insert Pay Grades
INSERT INTO PayGrade (grade_name, min_salary, max_salary)
VALUES 
('Entry Level', 3000.00, 6000.00),
('Junior', 6000.00, 10000.00),
('Mid Level', 10000.00, 18000.00),
('Senior', 18000.00, 30000.00),
('Executive', 30000.00, 60000.00),
('C-Level', 60000.00, 120000.00);

-- Insert Tax Forms
INSERT INTO TaxForm (jurisdiction, validity_period, form_content)
VALUES 
('Egypt', '2025', 'Egyptian tax form for residents - progressive tax rates 10-25%'),
('Egypt', '2025', 'Egyptian tax form for non-residents - flat tax rate 20%'),
('International', '2025', 'W-8BEN form for foreign contractors'),
('Saudi Arabia', '2025', 'KSA tax form - Zakat and income tax'),
('UAE', '2025', 'UAE tax form - Corporate tax 9%');

-- Insert Payroll Policies
INSERT INTO PayrollPolicy (effective_date, type, description)
VALUES 
('2025-01-01', 'Overtime', 'Standard overtime calculation with weekday and weekend multipliers'),
('2025-01-01', 'Lateness', 'Grace period and deduction rules for late arrival'),
('2025-01-01', 'Bonus', 'Annual and performance-based bonus policy'),
('2025-01-01', 'Deduction', 'Standard deduction policy for absences and violations'),
('2025-03-01', 'Overtime', 'Updated overtime policy with higher rates for critical projects'),
('2025-01-01', 'Insurance', 'Social insurance contribution brackets'),
('2025-01-01', 'Tax', 'Progressive tax calculation policy');

-- Insert Overtime Policies
INSERT INTO OvertimePolicy (policy_id, weekday_rate_multiplier, weekend_rate_multiplier, max_hours_per_month)
VALUES 
(1, 1.25, 1.50, 50),
(5, 1.50, 2.00, 60);

-- Insert Lateness Policies
INSERT INTO LatenessPolicy (policy_id, grace_period_mins, deduction_rate)
VALUES 
(2, 10, 2.50),
(4, 15, 3.00);

-- Insert Bonus Policies
INSERT INTO BonusPolicy (policy_id, bonus_type, eligibility_criteria)
VALUES 
(3, 'Annual Performance', 'Completed 1 year with performance rating above 3.5/5');

-- Insert Deduction Policies
INSERT INTO DeductionPolicy (policy_id, deduction_reason, calculation_mode)
VALUES 
(4, 'Absence', 'Full day salary deduction');

-- NOTE: The following insertions assume that Employee table has been populated
-- with at least 10 employees (employee_id 1-10) by another team member

-- Sample Payroll Records for employees 1-10
INSERT INTO Payroll (employee_id, taxes, period_start, period_end, base_amount, adjustments, contributions, actual_pay, payment_date)
VALUES 
-- January 2025 Payroll
(1, 1500.00, '2025-01-01', '2025-01-31', 15000.00, 500.00, 1650.00, 13850.00, '2025-02-05'),
(2, 800.00, '2025-01-01', '2025-01-31', 8000.00, 300.00, 880.00, 7420.00, '2025-02-05'),
(3, 2250.00, '2025-01-01', '2025-01-31', 22500.00, 1000.00, 2475.00, 21025.00, '2025-02-05'),
(4, 600.00, '2025-01-01', '2025-01-31', 6000.00, 200.00, 660.00, 5540.00, '2025-02-05'),
(5, 1200.00, '2025-01-01', '2025-01-31', 12000.00, 400.00, 1320.00, 10880.00, '2025-02-05'),
(6, 1800.00, '2025-01-01', '2025-01-31', 18000.00, 600.00, 1980.00, 16620.00, '2025-02-05'),
(7, 450.00, '2025-01-01', '2025-01-31', 4500.00, 150.00, 495.00, 4155.00, '2025-02-05'),
(8, 3000.00, '2025-01-01', '2025-01-31', 30000.00, 1200.00, 3300.00, 27900.00, '2025-02-05'),
(9, 900.00, '2025-01-01', '2025-01-31', 9000.00, 350.00, 990.00, 8360.00, '2025-02-05'),
(10, 1050.00, '2025-01-01', '2025-01-31', 10500.00, 450.00, 1155.00, 9795.00, '2025-02-05'),

-- February 2025 Payroll
(1, 1500.00, '2025-02-01', '2025-02-28', 15000.00, 700.00, 1650.00, 14050.00, '2025-03-05'),
(2, 800.00, '2025-02-01', '2025-02-28', 8000.00, 300.00, 880.00, 7420.00, '2025-03-05'),
(3, 2250.00, '2025-02-01', '2025-02-28', 22500.00, 1500.00, 2475.00, 21525.00, '2025-03-05'),
(4, 600.00, '2025-02-01', '2025-02-28', 6000.00, 250.00, 660.00, 5590.00, '2025-03-05'),
(5, 1200.00, '2025-02-01', '2025-02-28', 12000.00, 500.00, 1320.00, 11180.00, '2025-03-05'),

-- March 2025 Payroll
(1, 1500.00, '2025-03-01', '2025-03-31', 15000.00, 500.00, 1650.00, 13850.00, '2025-04-05'),
(2, 800.00, '2025-03-01', '2025-03-31', 8000.00, 400.00, 880.00, 7520.00, '2025-04-05'),
(3, 2250.00, '2025-03-01', '2025-03-31', 22500.00, 2000.00, 2475.00, 22025.00, '2025-04-05');

-- Insert Allowances and Deductions for the payroll records
INSERT INTO AllowanceDeduction (payroll_id, employee_id, type, amount, currency, duration, timezone)
VALUES 
-- January allowances
(1, 1, 'Allowance', 500.00, 'EGP', 'Monthly', 'EET'),
(2, 2, 'Allowance', 300.00, 'EGP', 'Monthly', 'EET'),
(3, 3, 'Allowance', 1000.00, 'EGP', 'Monthly', 'EET'),
(4, 4, 'Allowance', 200.00, 'EGP', 'Monthly', 'EET'),
(5, 5, 'Allowance', 400.00, 'EGP', 'Monthly', 'EET'),
(6, 6, 'Allowance', 600.00, 'EGP', 'Monthly', 'EET'),
(7, 7, 'Allowance', 150.00, 'EGP', 'Monthly', 'EET'),
(8, 8, 'Allowance', 1200.00, 'EGP', 'Monthly', 'EET'),
(9, 9, 'Allowance', 350.00, 'EGP', 'Monthly', 'EET'),
(10, 10, 'Allowance', 450.00, 'EGP', 'Monthly', 'EET'),

-- Some deductions
(3, 3, 'Deduction', 200.00, 'EGP', 'One-time', 'EET'),
(8, 8, 'Deduction', 300.00, 'EGP', 'One-time', 'EET'),

-- February allowances
(11, 1, 'Allowance', 700.00, 'EGP', 'Monthly', 'EET'),
(12, 2, 'Allowance', 300.00, 'EGP', 'Monthly', 'EET'),
(13, 3, 'Allowance', 1500.00, 'EGP', 'Monthly', 'EET'),
(14, 4, 'Allowance', 250.00, 'EGP', 'Monthly', 'EET'),
(15, 5, 'Allowance', 500.00, 'EGP', 'Monthly', 'EET'),

-- March allowances
(16, 1, 'Allowance', 500.00, 'EGP', 'Monthly', 'EET'),
(17, 2, 'Allowance', 400.00, 'EGP', 'Monthly', 'EET'),
(18, 3, 'Allowance', 2000.00, 'EGP', 'Monthly', 'EET');

-- Link Payroll to Policies
INSERT INTO PayrollPolicy_ID (payroll_id, policy_id)
VALUES 
-- January payrolls with policies
(1, 1), (1, 2), (1, 6),
(2, 1), (2, 2),
(3, 1), (3, 3), (3, 6),
(4, 2), (4, 4),
(5, 1), (5, 2),
(6, 1), (6, 6),
(7, 2), (7, 4),
(8, 1), (8, 3), (8, 6),
(9, 1), (9, 2),
(10, 1), (10, 2),

-- February payrolls
(11, 1), (11, 2),
(12, 1), (12, 2),
(13, 1), (13, 3),
(14, 2), (14, 4),
(15, 1), (15, 2),

-- March payrolls
(16, 5), (16, 2),
(17, 5), (17, 2),
(18, 5), (18, 3);

-- Insert Payroll Logs
INSERT INTO Payroll_Log (payroll_id, actor, change_date, modification_type)
VALUES 
(1, 1, '2025-01-31 09:00:00', 'Payroll Generated'),
(1, 1, '2025-01-31 09:15:00', 'Added Transportation Allowance'),
(2, 1, '2025-01-31 09:00:00', 'Payroll Generated'),
(3, 1, '2025-01-31 09:00:00', 'Payroll Generated'),
(3, 1, '2025-01-31 09:20:00', 'Added Performance Bonus'),
(4, 1, '2025-01-31 09:00:00', 'Payroll Generated'),
(5, 1, '2025-01-31 09:00:00', 'Payroll Generated'),
(8, 1, '2025-01-31 09:00:00', 'Payroll Generated'),
(8, 1, '2025-01-31 09:30:00', 'Deduction Applied - Uniform'),
(11, 1, '2025-02-28 09:00:00', 'Payroll Generated'),
(11, 1, '2025-02-28 09:25:00', 'Added Overtime Payment'),
(13, 1, '2025-02-28 09:00:00', 'Payroll Generated'),
(13, 1, '2025-02-28 09:35:00', 'Added Project Completion Bonus'),
(16, 1, '2025-03-31 09:00:00', 'Payroll Generated'),
(17, 1, '2025-03-31 09:00:00', 'Payroll Generated'),
(18, 1, '2025-03-31 09:00:00', 'Payroll Generated'),
(18, 1, '2025-03-31 09:40:00', 'Added Annual Bonus');

-- Insert Payroll Periods
INSERT INTO PayrollPeriod (payroll_id, start_date, end_date, status)
VALUES 
-- January periods
(1, '2025-01-01', '2025-01-31', 'Closed'),
(2, '2025-01-01', '2025-01-31', 'Closed'),
(3, '2025-01-01', '2025-01-31', 'Closed'),
(4, '2025-01-01', '2025-01-31', 'Closed'),
(5, '2025-01-01', '2025-01-31', 'Closed'),
(6, '2025-01-01', '2025-01-31', 'Closed'),
(7, '2025-01-01', '2025-01-31', 'Closed'),
(8, '2025-01-01', '2025-01-31', 'Closed'),
(9, '2025-01-01', '2025-01-31', 'Closed'),
(10, '2025-01-01', '2025-01-31', 'Closed'),

-- February periods
(11, '2025-02-01', '2025-02-28', 'Closed'),
(12, '2025-02-01', '2025-02-28', 'Closed'),
(13, '2025-02-01', '2025-02-28', 'Closed'),
(14, '2025-02-01', '2025-02-28', 'Closed'),
(15, '2025-02-01', '2025-02-28', 'Closed'),

-- March periods
(16, '2025-03-01', '2025-03-31', 'Open'),
(17, '2025-03-01', '2025-03-31', 'Open'),
(18, '2025-03-01', '2025-03-31', 'Open');

-------------------------Tarek End ---------------------------------------
