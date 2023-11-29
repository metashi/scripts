#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Skrypt wymaga uprawnien (sudo). Uruchom go ponownie z sudo."
    exit 1
fi

# Sprawdzenie, czy narzędzie Lynis jest zainstalowane
if ! command -v lynis &> /dev/null; then
    echo "Narzedzie Lynis nie jest zainstalowane. Instaluje."
    sudo dnf install -y lynis
fi

# Wykonanie skanowania i zapisanie wynikow do pliku
lynis audit system --report-file report.txt --log-file lynis_rep.log 

echo "Skanowanie zakonczone pomyslnie."



