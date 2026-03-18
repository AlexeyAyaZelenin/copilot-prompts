# Null Safety

## Use This Reference When

- Guarding browser globals, DOM APIs, or query results
- Handling nullable headers or response metadata
- Converting display callbacks to handle unknown values safely

## Core Rules

- Do: guard `window`, DOM APIs, and query results before use
- Before: `recruiterDisplay(employee: Recruiter): string { return employee.fullName.trim(); }`
- After: `recruiterDisplay = (employee: unknown): string => { if (!this.isRecruiterDisplayValue(employee)) { return ''; } return employee.fullName.trim(); }`

- Do not: rely on unsafe non-null chains for uncertain values
- Before: `const fileName = response.headers.get('file-name').replace(/\"/g, '');`
- After: `const fileName = response.headers.get('file-name')?.replace(/\"/g, '') ?? 'leases.csv';`
