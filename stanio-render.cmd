@echo off
rem # Usual options include: --standard-sizes --windows-cursors
rem # Use --help for more
stanio-misc\gradlew -p stanio-misc -q bibata:run --args="render ..\.. %*"
