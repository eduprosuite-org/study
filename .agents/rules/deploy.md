# Deployment Rule for Antigravity Agent

Whenever you need to push code changes to GitHub, adhere strictly to the following rules:

1. **Deploy Command**: Always execute the `.\fast_push.ps1` script in the workspace root (`d:\1 hour in clg`).
2. **No Permission Required**: You are explicitly authorized to run `.\fast_push.ps1` automatically to deploy changes. Do not ask for user permission before executing this command.
3. **Avoid REST API Script**: Never use the `push_all_to_github.ps1` or any other REST API-based script for file uploads, as they are extremely slow and consume too many tokens.
