# ILVORA Workforce Management — PWA design and implementation starter

## What is included
- Responsive desktop web dashboard with separate tabs (not one long scrolling page).
- Mobile layout with bottom navigation and a non-overlapping three-dot menu.
- Role-preview switch for Managing Director, Head Admin, Assistant Admin, Branch Admin and Employee.
- Attendance terminal screen concept.
- Uploaded ILVORA logo, generated app icons, and uploaded muted looping video background.
- PWA manifest and service worker.
- Cloudflare D1 starter schema and detailed Worker API/security implementation requirements.

## Important status
This package is a **UI prototype and backend foundation**, not a production-ready HR/payroll/attendance service. The dashboard uses illustrative sample records and demo interactions. It does not authenticate real users, send OTPs, scan/verify signed QR tokens, persist attendance, process payroll, send email/SMS, or upload documents. Do not use it to make real payroll or employment decisions until the Cloudflare Worker backend, authorization, integrations, policy rules and testing are completed.

## Preview
Serve this folder over localhost or HTTPS. PWA, camera and GPS features require a secure context. For example, use a local static web server. Open `index.html` via a file:// URL only for a limited visual preview.

## Cloudflare deployment plan
1. Create a Cloudflare account.
2. Create a D1 database and apply `cloudflare/schema.sql`.
3. Create a private R2 bucket for selfies and medical attachments.
4. Implement Worker endpoints described in `cloudflare/WORKER_IMPLEMENTATION.md`.
5. Configure OTP delivery through verified SMS and email providers.
6. Deploy the frontend to Cloudflare Pages.
7. Add `attendance.ilvorahealthcare.com` as a custom domain and create the DNS record at GoDaddy as instructed by Cloudflare. Do not alter the main website or Zoho MX/TXT records.
8. Test each role with separate accounts and verify every permission on the server, not only in the interface.

## Business rules requiring signed-off policy before production
- Payroll period "10th to 10th" and 10-day holdback: define exact start/end inclusivity and treatment of joiners/leavers.
- Monthly attendance period: 1st through last calendar day.
- Payment release: 10th or preceding banking working day if holiday.
- Paid medical leave: max 5 days per financial year, certificate mandatory; validate legal/employment policy.
- Branch Admin approval limits and Head Office escalation thresholds.
- TDS, PF, insurance and tax calculations must be approved by the accountant and applicable law.
- Retention: the requested auto-delete dates conflict with statutory payroll/employment record retention. Use archive/retention rules approved by legal/accounting advisers; never delete records needed for audit, disputes or statutory compliance.
- Termination/resignation: deactivate access immediately, but preserve legally required payroll, attendance and audit records. Do not automatically erase all employee records.
- Passwords: secure hashes only; no one, including MD, can view an existing password. Use reset flows.
- Sensitive data: bank details and medical certificates require encryption/restricted access and documented retention.

## Design
Navy / teal / champagne-gold palette. Video background is muted, looping and responsive. Mobile menu is a separate overlay/drawer; three-dot control remains fixed in the top bar.
