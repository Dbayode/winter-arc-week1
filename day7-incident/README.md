# Day 07 — Git/GitHub & Production Challenge

## Mission
Use a feature branch, add a health check, open and merge a pull request, and document a deliberately introduced incident.

## Git workflow

```bash
git status
git switch -c feature/add-healthcheck
# Add/test healthcheck.sh, then:
git add day7-incident/healthcheck.sh
git commit -m 'feat: add HTTP health check'
git push -u origin feature/add-healthcheck
```

Open a GitHub pull request to `main`; review changes, merge it, and pull `main` locally. Record the **actual** PR URL in `incident-notes.md`.

## Health-check test

```bash
bash day7-incident/healthcheck.sh http://127.0.0.1:8080/
```

The script exits nonzero when the endpoint is unavailable or does not return a 2xx status.

## Incident exercise
In a disposable lab, stop the backend or introduce a reversible misconfiguration. Observe the symptom, collect evidence, diagnose, restore service, and verify recovery. Complete `incident-notes.md` with actual timestamps and commands.

## Deliverables
- Repository URL
- Merged pull request URL
- Completed incident report using **find → debug → fix → verify**
