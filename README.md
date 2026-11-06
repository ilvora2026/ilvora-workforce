# ILVORA Workforce — Branch Admin scope demo

Static GitHub Pages UI preview only. Do not use real employee, bank, medical, attendance or payroll information.

## Branch Admin demo
- ID: `BRANCH001`
- Password: `IlvoraBranch26!`
- Assigned branch: **Kottarakara Clinic**

The Branch Admin preview is scoped to Kottarakara Clinic and includes:
- Branch-only employee list and employee onboarding request
- Request employee removal (deactivation request, not hard deletion)
- Employee password-reset request
- Branch deduction request for Head Office approval
- Branch-only attendance register and correction submission to Head Office
- Branch duty roster
- Local CL / ML / EL / NPML review up to 5 days; longer requests are routed to Head Office with notes
- Head Office decision list with green approved, orange pending and red rejected status
- Branch-only printable/downloadable attendance and roster reports

The supplied ILVORA seal is included at `assets/ilvora-official-seal.png` for the future PDF payslip template.

## Other demo logins
- Managing Director: `ILV001` / `IlvoraMD26!`
- Head Office Admin: `HEAD001` / `IlvoraHead26!`
- Assistant Admin: `ASST001` / `IlvoraAsst26!`
- Employee: `ILV003` / `IlvoraEmp26!`

## Important production notes
This is a front-end prototype. Branch scope is a demonstration filter, not a security boundary. GitHub Pages cannot securely enforce roles or protect API/data. The production backend must enforce branch_id on every query and mutation, verify role permissions server-side, and audit approvals.

Employee deletion should normally be deactivation with retention of statutory, payroll and audit records. Medical and leave attachments should be retained or securely purged under a documented legal/HR retention schedule; printing alone is not sufficient authority for immediate deletion. Browser download cleanup can clear temporary local data but cannot erase a user's downloaded copy.

A future PDF payslip should place the supplied ILVORA seal in the footer with authorised issuer details; do not imply a digital signature unless one is implemented.

## Head Office stage: records, retention and employee exit
Managing Director and Head Office Admin demo accounts have three additional sections:
- **Records & retention:** five-year medical/leave attachment policy subject to legal review; category-specific retention, advance notice, legal holds and deletion queue.
- **Physical records register:** print, verify and file status with file/cabinet references.
- **Employee exit & archive:** approval checklist, access revocation and archival without erasing statutory history.

These are illustrative UI workflows only. Production requires backend permissions, immutable audit events, secure storage, scheduled jobs and legally reviewed retention schedules.

## New trial features in this stage
- Separate `common-device.html` attendance terminal page (device demo ID `KOT-TAB-01`; illustrative only).
- Common device flow: select employee in the assigned branch, generate demo OTP, front-camera photo, GPS permission and submit demo attendance.
- Rotating QR token simulation with 30-second expiry display. Production must use signed, one-time, server-validated tokens.
- Employee resignation request screen; production approval will calculate days remaining to approved last working day and notify Branch Admin five days before exit.
- Head Office common-device inventory and branch assignment; MD-only signature profile screen for two Managing Directors.
- Branch creation form includes category (Hospital, Clinic, Pharmacy, Investigation laboratory) and bed count for hospitals/clinics.
- Mobile layout hardening and overflow controls.
- Payroll/attendance/roster report downloads and monthly reminders are represented as demo workflows; scheduled notifications require backend integration.

## Attendance timing policy
- Clock-in accepted as on-time from 5 minutes before to 15 minutes after scheduled roster start.
- Any clock-out before scheduled end is marked early checkout, including one second early.
- Clock-out at scheduled end through 15 minutes after is on-time.
- Do not silently rewrite actual punch times. Preserve actual time and separately calculate flags/adjustment display.
- Employee mobile attendance uses rotating QR + automatic face photo + GPS; common device supports face-photo + employee OTP, biometric reader integration, or rotating QR, depending on branch device configuration.
- Attendance photo deletion target: within 2 days after attendance is marked, subject to any legal hold, complaint or audit preservation. Monthly attendance reports retain a verification tick and verification timestamp, not the photo.

## Production limitations
The common-device page simulates OTP generation locally, camera capture, geolocation permission and QR token display. It does not send SMS OTP, perform biometric/face identity matching, validate geofences, persist attendance or create cryptographically secure QR tokens. Static GitHub Pages cannot protect device credentials or branch data. Cloudflare/backend integration is required for real authentication, role enforcement, audit, scheduled notifications, report generation, image deletion and payroll.

## Common Attendance Device login update
The main sign-in dropdown now includes **Common Attendance Device**. Selecting it and entering the device demo credentials redirects to the separate `common-device.html` terminal, which has its own device sign-in gate. Demo credentials: `KOT-TAB-01` / `Device26!`. The terminal page is separate from employee and administrator workspaces.
Security note: GitHub Pages is static hosting. The credentials in this demo are visible in client-side code and are not secure. Production must validate device identity server-side, store only password hashes, bind each device to one branch, issue revocable tokens and enforce terminal-only permissions on every API request.

## Employee portal access-control correction (v0.5)
- Added dedicated employee-only pages: My workspace, My duty roster, My attendance, My payslip, Apply for leave, My application status, Salary advance, Mark attendance and Resignation.
- Employee workspace no longer falls back to the generic administrator dashboard when an employee signs in.
- Employee navigation is restricted to employee-specific tabs. A render-time role guard redirects any unauthorised tab request back to the employee workspace.
- Employee views show only the signed-in employee's information in the intended production design. The sample values in this static demo remain illustrative and must be replaced with authenticated per-user backend records.
- Admin dashboard pages remain available only to their authorised admin roles in the role access matrix.

# Consolidated role separation rebuild – v0.6
## Role boundaries in this trial
- Managing Director: organisation-wide oversight, all branch records, administrator controls, signature profiles, retention, employee exit and device management.
- Head Office Admin: organisation-wide operations and approvals, branch and employee management, payroll and reports. No MD-only signature or highest-level admin controls.
- Assistant Head Office Admin: Head Office operational modules as configured; no MD-only controls.
- Branch Admin: one assigned branch only. The demo Branch Admin is assigned to Kottarakara Clinic. The branch dashboard, employee list, attendance register, roster and leave examples are branch-scoped. No branch directory, cross-branch transfer listing, payroll administration or common-device credential management.
- Employee: personal roster, personal attendance, own payslip, leave application, application status, salary advance, attendance marking and resignation only.
- Common device: separate terminal page, not an administrator or employee workspace.
## Branch Admin request functions added
- Employee onboarding request, employee removal/deactivation request, password reset request, monthly salary deduction request and bank/emergency details submission after employee approval.
- Head Office decision inbox displays branch-submitted request statuses.
- Leave authority note: branch-level decisions up to five days; longer leave and paid health leave are forwarded to Head Office with recommendation and notes.
- Branch report download requirements and notification before the 18th are specified.
## Critical limitation
This is still a static GitHub Pages trial using sample data and demo credentials. Client-side role filtering is for demonstration only and is not a security boundary. Production must enforce tenant/branch scope and user permissions in the API/database, authenticate each request, and audit every action. Demo buttons may show local confirmation but do not create persistent approvals, payroll entries, SMS, OTP, secure camera evidence or report jobs.

## v0.7 demo update (5 Nov 2026)
- Added a profile menu with My Profile and Sign out.
- Added Forgot password entry on the sign-in screen. The demo illustrates registered phone/email recovery, but does not send OTP/SMS/email; production needs a secure authentication backend and verified contact delivery.
- Added a month calendar for Branch Admin duty assignment. Select an employee, choose a date, and set shift type/start/end times in one-hour increments. Supports overnight time ranges and paid-off days. Assignments are in-memory demo data only and are not persisted.
- The interactive calendar is restricted in the interface to Branch Admin; Head Office roster page remains a read-only overview.

This remains a static demonstration. Do not use it for real authentication, password recovery, roster publication or payroll until server-side authentication, authorisation, persistence, audit logging and OTP delivery are implemented and tested.
