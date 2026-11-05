PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS branches (
 id TEXT PRIMARY KEY, name TEXT NOT NULL UNIQUE, address TEXT, maps_url TEXT,
 latitude REAL NOT NULL, longitude REAL NOT NULL,
 geofence_radius_m INTEGER NOT NULL CHECK(geofence_radius_m BETWEEN 10 AND 2000),
 is_active INTEGER NOT NULL DEFAULT 1, created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS employees (
 id TEXT PRIMARY KEY, employee_code TEXT NOT NULL UNIQUE, full_name TEXT NOT NULL,
 address TEXT, department TEXT, position TEXT, mobile TEXT NOT NULL, email TEXT NOT NULL,
 branch_id TEXT NOT NULL REFERENCES branches(id), photo_key TEXT,
 employment_status TEXT NOT NULL DEFAULT 'pending',
 joined_on TEXT, resigned_on TEXT, terminated_on TEXT,
 created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS accounts (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL UNIQUE REFERENCES employees(id),
 username TEXT UNIQUE, password_hash TEXT NOT NULL, must_reset_password INTEGER NOT NULL DEFAULT 1,
 role TEXT NOT NULL CHECK(role IN ('managing_director','head_admin','head_assistant','branch_admin','employee')),
 branch_scope TEXT, mfa_enabled INTEGER NOT NULL DEFAULT 1, is_active INTEGER NOT NULL DEFAULT 1,
 created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS attendance (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id),
 branch_id TEXT NOT NULL REFERENCES branches(id), event_type TEXT NOT NULL CHECK(event_type IN ('IN','OUT')),
 event_at TEXT NOT NULL, latitude REAL NOT NULL, longitude REAL NOT NULL, gps_accuracy_m REAL NOT NULL,
 distance_m REAL NOT NULL, qr_token_id TEXT NOT NULL, selfie_key TEXT NOT NULL,
 verification_status TEXT NOT NULL CHECK(verification_status IN ('verified','approved_correction')),
 source TEXT NOT NULL DEFAULT 'pwa', created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS attendance_employee_date ON attendance(employee_id,event_at);
CREATE TABLE IF NOT EXISTS qr_tokens (
 id TEXT PRIMARY KEY, branch_id TEXT NOT NULL REFERENCES branches(id), token_hash TEXT NOT NULL UNIQUE,
 expires_at TEXT NOT NULL, consumed_at TEXT, created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS shifts (
 id TEXT PRIMARY KEY, branch_id TEXT NOT NULL REFERENCES branches(id), name TEXT NOT NULL,
 start_time TEXT NOT NULL, end_time TEXT NOT NULL, crosses_midnight INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS roster (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id),
 shift_id TEXT REFERENCES shifts(id), duty_date TEXT NOT NULL, day_type TEXT NOT NULL DEFAULT 'duty',
 created_by TEXT NOT NULL, created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS leave_requests (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id), leave_type TEXT NOT NULL,
 from_date TEXT NOT NULL, to_date TEXT NOT NULL, reason TEXT NOT NULL, days REAL NOT NULL,
 medical_document_keys TEXT, status TEXT NOT NULL DEFAULT 'pending',
 submitted_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, reviewed_by TEXT, reviewed_at TEXT, reviewer_reason TEXT
);
CREATE TABLE IF NOT EXISTS salary_components (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id), effective_from TEXT NOT NULL,
 gross_monthly REAL NOT NULL, tds_percent REAL DEFAULT 0, pf_percent REAL DEFAULT 0,
 insurance_percent REAL DEFAULT 0, paid_medical_allowance REAL DEFAULT 0, created_by TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS payroll_runs (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id),
 period_start TEXT NOT NULL, period_end TEXT NOT NULL, gross REAL NOT NULL,
 paid_off_days REAL DEFAULT 0, unpaid_days REAL DEFAULT 0, additions_json TEXT NOT NULL,
 deductions_json TEXT NOT NULL, advance_recovery REAL DEFAULT 0, net_pay REAL NOT NULL,
 bank_snapshot_json TEXT, status TEXT NOT NULL DEFAULT 'draft', approved_by TEXT, approved_at TEXT
);
CREATE TABLE IF NOT EXISTS bank_change_requests (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id),
 account_name TEXT NOT NULL, account_number_encrypted TEXT NOT NULL, ifsc TEXT NOT NULL,
 status TEXT NOT NULL DEFAULT 'pending_employee_confirmation', confirmation_token_hash TEXT,
 employee_decision_reason TEXT, created_by TEXT NOT NULL, created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS advance_requests (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id), amount REAL NOT NULL,
 reason TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'pending', requested_at TEXT DEFAULT CURRENT_TIMESTAMP,
 reviewed_by TEXT, reviewed_at TEXT, paid_at TEXT
);
CREATE TABLE IF NOT EXISTS transfer_requests (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id),
 from_branch TEXT NOT NULL REFERENCES branches(id), to_branch TEXT NOT NULL REFERENCES branches(id),
 reason TEXT NOT NULL, vacancy_confirmed INTEGER NOT NULL DEFAULT 0,
 status TEXT NOT NULL DEFAULT 'pending', reviewed_by TEXT, reviewed_at TEXT
);
CREATE TABLE IF NOT EXISTS approval_requests (
 id TEXT PRIMARY KEY, request_type TEXT NOT NULL, entity_id TEXT NOT NULL,
 submitted_by TEXT NOT NULL, assigned_scope TEXT, status TEXT NOT NULL DEFAULT 'pending',
 decision_by TEXT, decision_at TEXT, reason TEXT
);
CREATE TABLE IF NOT EXISTS audit_log (
 id TEXT PRIMARY KEY, actor_account_id TEXT, action TEXT NOT NULL, entity_type TEXT NOT NULL,
 entity_id TEXT, before_json TEXT, after_json TEXT, created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS financial_year_summaries (
 id TEXT PRIMARY KEY, employee_id TEXT NOT NULL REFERENCES employees(id),
 fy_start TEXT NOT NULL, fy_end TEXT NOT NULL, summary_json TEXT NOT NULL,
 generated_at TEXT DEFAULT CURRENT_TIMESTAMP, downloaded_at TEXT, archived_by TEXT
);
