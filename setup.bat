@echo off
REM BudgetBuddy Flutter App Setup Script for Windows

echo Setting up BudgetBuddy Flutter App...
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Flutter is not installed. Please install Flutter first:
    echo    https://docs.flutter.dev/get-started/install
    exit /b 1
)

echo Flutter found
flutter --version
echo.

REM Check Flutter doctor
echo Running Flutter doctor...
flutter doctor
echo.

REM Install dependencies
echo Installing dependencies...
flutter pub get
echo Dependencies installed
echo.

REM Check if .env file exists
if not exist ".env" (
    echo .env file not found. Copying from .env.example...
    copy .env.example .env
    echo .env file created. Please update it with your configuration.
    echo.
) else (
    echo .env file found
    echo.
)

REM Generate code (build_runner)
echo Generating code with build_runner...
echo This may take a few minutes...
flutter pub run build_runner build --delete-conflicting-outputs
echo Code generation completed
echo.

REM Clean and get dependencies again
echo Cleaning project...
flutter clean
flutter pub get
echo Project cleaned and dependencies reinstalled
echo.

echo Setup completed successfully!
echo.
echo Next steps:
echo    1. Update .env file with your backend configuration
echo    2. For REST API: Set BACKEND_TYPE=rest and API_BASE_URL
echo    3. For Firebase: Set BACKEND_TYPE=firebase and Firebase config
echo    4. Run: flutter run
echo.
echo Documentation:
echo    - README.md - General documentation
echo    - ARCHITECTURE.md - Architecture details
echo    - BACKEND_INTEGRATION.md - Backend integration guide
echo.
echo Happy coding!

pause
