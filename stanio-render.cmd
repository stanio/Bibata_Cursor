@echo off
rem # Usual options include: --standard-sizes --windows-cursors
stanio-misc\gradlew -p stanio-misc -q bibata:run --args="render ..\.. %*"
