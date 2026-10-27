# Deploy to GitHub Pages - PowerShell version
param([string]$username = "")

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "  SYSTEM : Solo Leveling - GitHub Pages Deployer" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

# Get username if not provided
if (-not $username) {
    $username = Read-Host "  Enter your GitHub username"
}

Write-Host ""
Write-Host "  Step 1: Setting up git remote..." -ForegroundColor Yellow
git remote remove origin 2>$null
git remote add origin "https://github.com/$username/solo-system.git"

Write-Host "  Step 2: Pushing to GitHub..." -ForegroundColor Yellow
Write-Host ""
Write-Host "  IMPORTANT: GitHub will ask for your password." -ForegroundColor Red
Write-Host "  Use a Personal Access Token (NOT your password):" -ForegroundColor Red
Write-Host "  - Go to: https://github.com/settings/tokens/new" -ForegroundColor White
Write-Host "  - Note: 'Solo System Deploy'" -ForegroundColor White
Write-Host "  - Check: 'repo' scope" -ForegroundColor White
Write-Host "  - Click 'Generate token' and paste it as the password" -ForegroundColor White
Write-Host ""

# First create the repo via GitHub API
Write-Host "  Creating repo on GitHub (browser will open)..." -ForegroundColor Yellow
Start-Process "https://github.com/new?name=solo-system&description=My+Solo+Leveling+Life+RPG&public=1"

Write-Host ""
Write-Host "  1. In the browser tab that just opened:" -ForegroundColor Green
Write-Host "     - Make sure name is 'solo-system'" -ForegroundColor White
Write-Host "     - Keep it Public" -ForegroundColor White
Write-Host "     - DO NOT check 'Add README'" -ForegroundColor White
Write-Host "     - Click 'Create repository'" -ForegroundColor White
Write-Host ""
Read-Host "  Press Enter AFTER you created the repo on GitHub"

Write-Host ""
Write-Host "  Pushing your code..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "  Step 3: Enabling GitHub Pages..." -ForegroundColor Yellow
    Start-Process "https://github.com/$username/solo-system/settings/pages"
    Write-Host ""
    Write-Host "  In the browser tab that just opened:" -ForegroundColor Green
    Write-Host "  - Under 'Branch', select 'main' then '/ (root)'" -ForegroundColor White
    Write-Host "  - Click Save" -ForegroundColor White
    Write-Host ""
    Read-Host "  Press Enter after saving Pages settings"

    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  YOUR APP IS DEPLOYING!" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Live URL (ready in ~2 min):" -ForegroundColor White
    Write-Host "  https://$username.github.io/solo-system" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  INSTALL ON YOUR DEVICES:" -ForegroundColor Yellow
    Write-Host "  iPhone  : Safari -> Share -> Add to Home Screen" -ForegroundColor White
    Write-Host "  Android : Chrome -> Menu -> Install App" -ForegroundColor White
    Write-Host "  PC/Mac  : Chrome address bar -> Install icon" -ForegroundColor White
    Write-Host ""
    Start-Process "https://$username.github.io/solo-system"
    Write-Host "================================================================" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "  Push failed. Make sure you:" -ForegroundColor Red
    Write-Host "  1. Created the repo on GitHub (it must exist)" -ForegroundColor White
    Write-Host "  2. Used a Personal Access Token as password" -ForegroundColor White
    Write-Host "  3. Token has 'repo' scope" -ForegroundColor White
    Write-Host ""
    Write-Host "  Token creation: https://github.com/settings/tokens/new" -ForegroundColor Cyan
}
Write-Host ""
pause
