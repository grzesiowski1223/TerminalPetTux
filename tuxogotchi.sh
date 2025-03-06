#!/bin/bash

# Inicjalizacja zmiennych
hunger=0
happiness=10
energy=10
mood=10
alive=1
points=0  # Punkty do wydania w sklepie
inventory=()  # Ekwipunek

# Funkcja do wyświetlania ASCII Tuxa z odpowiednią buzią
show_tux() {
    if [ $mood -ge 8 ]; then
        echo "       .--."
        echo "      |o_o |"
        echo "      |:_/ |"
        echo "     //   \ \\"
        echo "    (| ^_^ | )"
        echo "   /'\_   _/'\`\\"
        echo "   \___)=(___/"
    elif [ $mood -ge 4 ]; then
        echo "       .--."
        echo "      |o_o |"
        echo "      |:_/ |"
        echo "     //   \ \\"
        echo "    (| •_• | )"
        echo "   /'\_   _/'\`\\"
        echo "   \___)=(___/"
    else
        echo "       .--."
        echo "      |o_o |"
        echo "      |:_/ |"
        echo "     //   \ \\"
        echo "    (| T_T | )"
        echo "   /'\_   _/'\`\\"
        echo "   \___)=(___/"
    fi
    echo ""
}

# Funkcja do wyświetlania stanu Tuxa
status() {
    clear  # Czyści ekran, aby uniknąć bałaganu
    show_tux
    echo "Stan Tuxa:"
    echo "Głód: $hunger"
    echo "Szczęście: $happiness"
    echo "Energia: $energy"
    echo "Samopoczucie: $mood"
    echo "Punkty: $points"
    echo "Ekwipunek: ${inventory[@]}"
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
    mood=$((mood + 1))
    points=$((points + 1))  # Zdobywasz punkty
    if [ $mood -gt 10 ]; then
        mood=10
    fi
    status  # Wyświetl Tuxa po akcji
}

# Funkcja do zabawy z Tuxem
play() {
    echo "Bawisz się z Tuxem. Tux jest szczęśliwy!"
    happiness=$((happiness + 2))
    energy=$((energy - 1))
    hunger=$((hunger + 1))
    mood=$((mood + 2))
    points=$((points + 2))  # Zdobywasz punkty
    if [ $mood -gt 10 ]; then
        mood=10
    fi
    status  # Wyświetl Tuxa po akcji
}

# Funkcja do usypiania Tuxa
sleep() {
    echo "Tux idzie spać. Chrap chrap..."
    energy=$((energy + 3))
    hunger=$((hunger + 1))
    happiness=$((happiness - 1))
    mood=$((mood - 1))
    points=$((points + 1))  # Zdobywasz punkty
    if [ $mood -lt 0 ]; then
        mood=0
    fi
    status  # Wyświetl Tuxa po akcji
}

# Funkcja do sprawdzania, czy Tux żyje
check_alive() {
    if [ $hunger -ge 10 ] || [ $happiness -le 0 ] || [ $energy -le 0 ]; then
        alive=0
        echo "Niestety, Tux umarł. :("
        show_tux
        exit 1
    fi
}

# Funkcja do wyświetlania sklepu
shop() {
    echo "Witaj w sklepie!"
    echo "Masz $points punktów."
    echo "Co chcesz kupić?"
    echo "1. Super jedzenie (koszt: 5 punktów) – zmniejsza głód o 5"
    echo "2. Super zabawka (koszt: 7 punktów) – zwiększa szczęście o 5"
    echo "3. Energizer (koszt: 6 punktów) – zwiększa energię o 5"
    echo "4. Wyjdź z sklepu"
    read -p "Wybierz opcję (1-4): " choice

    case $choice in
        1)
            if [ $points -ge 5 ]; then
                points=$((points - 5))
                inventory+=("Super jedzenie")
                echo "Kupiłeś Super jedzenie!"
            else
                echo "Nie masz wystarczająco punktów!"
            fi
            ;;
        2)
            if [ $points -ge 7 ]; then
                points=$((points - 7))
                inventory+=("Super zabawka")
                echo "Kupiłeś Super zabawkę!"
            else
                echo "Nie masz wystarczająco punktów!"
            fi
            ;;
        3)
            if [ $points -ge 6 ]; then
                points=$((points - 6))
                inventory+=("Energizer")
                echo "Kupiłeś Energizer!"
            else
                echo "Nie masz wystarczająco punktów!"
            fi
            ;;
        4)
            echo "Wychodzisz ze sklepu."
            ;;
        *)
            echo "Nieprawidłowy wybór."
            ;;
    esac
    status  # Wyświetl Tuxa po akcji
}

# Funkcja do używania przedmiotów z ekwipunku
use_item() {
    echo "Twój ekwipunek: ${inventory[@]}"
    read -p "Który przedmiot chcesz użyć? (wpisz nazwę lub 'anuluj'): " item
    case $item in
        "Super jedzenie")
            hunger=$((hunger - 5))
            if [ $hunger -lt 0 ]; then
                hunger=0
            fi
            inventory=("${inventory[@]/Super jedzenie}")
            echo "Użyto Super jedzenia. Głód Tuxa zmniejszył się o 5!"
            ;;
        "Super zabawka")
            happiness=$((happiness + 5))
            inventory=("${inventory[@]/Super zabawka}")
            echo "Użyto Super zabawki. Szczęście Tuxa wzrosło o 5!"
            ;;
        "Energizer")
            energy=$((energy + 5))
            inventory=("${inventory[@]/Energizer}")
            echo "Użyto Energizera. Energia Tuxa wzrosła o 5!"
            ;;
        "anuluj")
            echo "Anulowano."
            ;;
        *)
            echo "Nie masz takiego przedmiotu w ekwipunku."
            ;;
    esac
    status  # Wyświetl Tuxa po akcji
}

# Główna pętla gry
while [ $alive -eq 1 ]; do
    status  # Wyświetl Tuxa na początku każdego cyklu
    echo "Co chcesz zrobić?"
    echo "1. Nakarm Tuxa"
    echo "2. Baw się z Tuxem"
    echo "3. Uśpij Tuxa"
    echo "4. Odwiedź sklep"
    echo "5. Użyj przedmiotu z ekwipunku"
    echo "6. Wyjdź z gry"
    read -p "Wybierz opcję (1-6): " choice

    case $choice in
        1) feed ;;
        2) play ;;
        3) sleep ;;
        4) shop ;;
        5) use_item ;;
        6) echo "Do widzenia!"; exit 0 ;;
        *) echo "Nieprawidłowy wybór. Spróbuj ponownie." ;;
    esac

    check_alive
done
