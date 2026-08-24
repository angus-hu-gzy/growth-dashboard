@echo off
rem ============================================
rem  Growth-Dashboard Auto Push Script
rem  Double-click to upload changes to GitHub
rem ============================================
cd /d C:\Users\angus\WorkBuddy\2026-08-20-23-27-48

echo.
echo [1/3] Staging all changes...
git add -A

echo [2/3] Creating commit...
git commit -m "update %date% %time%" >nul 2>&1 || echo       (no changes to commit - that is fine)

echo [3/3] Pushing to GitHub...
git push

echo.
echo ============================================
echo   DONE - check the result above
echo   if it says "main -> main" it worked!
echo ============================================
echo.
pause
