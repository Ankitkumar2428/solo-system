@echo off
title Solo Leveling System - GitHub Pages Deployer
color 0B

echo.
echo  ================================================================
echo   SYSTEM : Solo Leveling - One-Click GitHub Pages Deployer
echo  ================================================================
echo.
echo  This will deploy your app to GitHub Pages for FREE.
echo  You need a GitHub account. Create one at https://github.com
echo.
echo  ----------------------------------------------------------------

set /p GITHUB_USER=  Enter your GitHub username: 

echo.
echo  Creating GitHub repository "solo-system"...
echo  Your browser will open to authorize. Sign in with GitHub.
echo.

REM Install GitHub CLI if not present
where gh >nul 2>&1
if %errorlevel% neq 0 (
  echo  Installing GitHub CLI...
  winget install --id GitHub.cli -e --accept-source-agreements --accept-package-agreements
  echo.
)

echo  Logging in to GitHub...
gh auth login --web --git-protocol https

echo.
echo  Creating repository on GitHub...
gh repo create solo-system --public --description "My Solo Leveling Life RPG System" --source=. --remote=origin --push

echo.
echo  Enabling GitHub Pages...
gh api repos/%GITHUB_USER%/solo-system/pages --method POST --field source[branch]=main --field source[path]=/

echo.
echo  ================================================================
echo.
echo  DONE! Your app will be live in ~2 minutes at:
echo.
echo   https://%GITHUB_USER%.github.io/solo-system
echo.
echo  Install on your phone:
echo   iPhone  : Open link in Safari, Share, Add to Home Screen
echo   Android : Open in Chrome, tap menu, Install App
echo.
echo  ================================================================
pause
