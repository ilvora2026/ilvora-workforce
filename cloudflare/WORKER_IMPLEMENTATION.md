# Cloudflare Worker implementation requirements

This folder is the D1 schema foundation. Before production, implement Worker routes with authenticated sessions and strict server-side authorization:

- POST /auth/invite-employee: branch admin submits basic details; head office approval required.
- POST /auth/approve-employee: MD/head admin approves, issues one-time activation link and employee ID.
- POST /auth/activate: force password reset; password policy minimum 7 characters, at least one non-space character, one uppercase and one number; recommend 12+ characters.
- POST /auth/otp/request and /auth/otp/verify: email + SMS provider integration, rate limits and expiry.
- POST /qr/rotate and POST /attendance/punch: signed short-lived QR, branch-specific geofence, GPS accuracy threshold, selfie upload to private R2, server time, sequence validation and audit log.
- POST /leave/submit and POST /leave/decision: policy routing, required medical certificate, max 8 files, protected storage, approval rules and leave-to-attendance posting in a transaction.
- POST /attendance/correction: branch admin submits reason; head office approval required before mutation.
- POST /payroll/calculate and POST /payroll/approve: approved policy engine, attendance reconciliation, statutory deductions reviewed by accountant, additions, advances and net pay.
- POST /bank-details/propose and POST /bank-details/confirm: encrypted bank fields, single-use employee confirmation link, reject reason and notification.
- POST /transfers/request and POST /transfers/decision: vacancy validation and stable employee ID.
- GET /exports/attendance, /exports/payroll-bank, /exports/accounts and /exports/payslip: permission checks, signed export URLs, audit trail.
- POST /retention/archive: archive and deletion only after legal retention rules and signed-off schedule.

Never return password hashes, OTPs, bank account numbers or private medical documents to unauthorised clients. Do not store or display plaintext passwords, including for the Managing Director. Do not immediately hard-delete employee records on termination; deactivate access and preserve legally required employment, payroll and audit records under an approved retention policy.
