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
