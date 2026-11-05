# ILVORA Workforce – Role-based GitHub Pages demo

This package is a **front-end demonstration only**. It is not suitable for real employee, medical, bank, attendance or payroll data.

## Deploy to GitHub Pages
Upload the contents of this folder directly into the repository root (so `index.html` is at the root). The paths are relative and support a GitHub Pages project site such as `https://ilvora2026.github.io/ilvora-workforce/`.

## Demo sign-in accounts
Select the account type on the sign-in screen. The matching user ID is prefilled; enter the demo password:

| Role | User ID | Demo password |
|---|---|---|
| Managing Director | ILV001 | IlvoraMD26! |
| Head Office Admin | HEAD001 | IlvoraHead26! |
| Assistant Head Office Admin | ASST001 | IlvoraAsst26! |
| Branch Admin | BRANCH001 | IlvoraBranch26! |
| Employee | ILV003 | IlvoraEmp26! |

These are public demo credentials embedded in front-end code. Anyone who can inspect the public repository can discover them. They only demonstrate different navigation layouts and are **not security controls**.

## Current demo behaviour
- Removes the public preview-role switcher.
- Requires a demo account sign-in before showing the workspace.
- Shows role-specific navigation for the five demo roles.
- Sign-out returns to the sign-in screen.
- Keeps all actions local/demo-only; it does not create or update real records.

## Production requirements
Before using real data, replace demo sign-in with a server-authenticated identity provider and enforce every permission in a backend API. A static GitHub Pages site cannot securely authenticate users or protect confidential data. Cloudflare Workers + D1 can be added later as planned.
