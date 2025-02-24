#!/bin/bash

# Inicjalizacja zmiennych
hunger=0
happiness=10
energy=10
alive=1

# Funkcja do wyświetlania stanu Tuxa
status() {
    echo "Stan Tuxa:"
    echo "Głód: $hunger"
    echo "Szczęście: $happiness"
    echo "Energia: $energy"
    echo ""
}

# Funkcja do karmienia Tuxa
feed() {
    echo "Karmisz Tuxa. Mniam mniam!"
    hunger=$((hunger - 2))
    if [ $hunger -lt 0 ]; then
        hunger=0
    fi
    energy=$((energy + 1))
    happiness=$((happiness + 1))
}

# Funkcja do zabawy z Tuxem
play() {
    echo "Bawisz się z Tuxem. Tux jest szczęśliwy!"
    happiness=$((happiness + 2))
    energy=$((energy - 1))
    hunger=$((hunger + 1))
}

# Funkcja do usypiania Tuxa
sleep() {
    echo "Tux idzie spać. Chrap chrap..."
    energy=$((energy + 3))
    hunger=$((hunger + 1))
    happiness=$((happiness - 1))
}

# Funkcja do sprawdzania, czy Tux żyje
check_alive() {
    if [ $hunger -ge 10 ] || [ $happiness -le 0 ] || [ $energy -le 0 ]; then
        alive=0
        echo "Niestety, Tux umarł. :("
        exit 1
    fi
}

# Główna pętla gry
while [ $alive -eq 1 ]; do
    status
    echo "Co chcesz zrobić?"
    echo "1. Nakarm Tuxa"
    echo "2. Baw się z Tuxem"
    echo "3. Uśpij Tuxa"
    echo "4. Wyjdź z gry"
    read -p "Wybierz opcję (1-4): " choice

    case $choice in
        1) feed ;;
        2) play ;;
        3) sleep ;;
        4) echo "Do widzenia!"; exit 0 ;;
        *) echo "Nieprawidłowy wybór. Spróbuj ponownie." ;;
    esac

    check_alive
done
