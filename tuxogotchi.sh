#!/bin/bash

hunger=0
happiness=10
energy=10
mood=10
alive=1
money=0
inventory=()

show_tux() {
    if [ $mood -ge 8 ]; then
        echo "       .--."
        echo "      |^_^ |"
        echo "      |:_/ |"
        echo "     //   \ \\"
        echo "    (|     | )"
        echo "   /'\_   _/'\`\\"
        echo "   \___)=(___/"
    elif [ $mood -ge 4 ]; then
        echo "       .--."
        echo "      |•_• |"
        echo "      |:_/ |"
        echo "     //   \ \\"
        echo "    (|     | )"
        echo "   /'\_   _/'\`\\"
        echo "   \___)=(___/"
    else
        echo "       .--."
        echo "      |T_T |"
        echo "      |:_/ |"
        echo "     //   \ \\"
        echo "    (|     | )"
        echo "   /'\_   _/'\`\\"
        echo "   \___)=(___/"
    fi
    echo ""
}

status() {
    clear
    show_tux
    echo "Stan Tuxa:"
    echo "Głód: $hunger"
    echo "Szczęście: $happiness"
    echo "Energia: $energy"
    echo "Samopoczucie: $mood"
    echo "Pieniądze: $money"
    echo "Ekwipunek: ${inventory[@]}"
    echo ""
}

feed() {
    echo "Karmisz Tuxa. Mniam mniam!"
    hunger=$((hunger - 2))
    if [ $hunger -lt 0 ]; then
        hunger=0
    fi
    energy=$((energy + 1))
    happiness=$((happiness + 1))
    mood=$((mood + 1))
    money=$((money + 1))
    if [ $mood -gt 10 ]; then
        mood=10
    fi
    status
}

play() {
    echo "Bawisz się z Tuxem. Tux jest szczęśliwy!"
    happiness=$((happiness + 2))
    energy=$((energy - 1))
    hunger=$((hunger + 1))
    mood=$((mood + 2))
    money=$((money + 2))
    if [ $mood -gt 10 ]; then
        mood=10
    fi
    status
}

sleep() {
    echo "Tux idzie spać. Chrap chrap..."
    energy=$((energy + 3))
    hunger=$((hunger + 1))
    happiness=$((happiness - 1))
    mood=$((mood - 1))
    money=$((money + 1))
    if [ $mood -lt 0 ]; then
        mood=0
    fi
    status
}

check_alive() {
    if [ $hunger -ge 10 ] || [ $happiness -le 0 ] || [ $energy -le 0 ]; then
        alive=0
        echo "Niestety, Tux umarł. :("
        show_tux
        exit 1
    fi
}

shop() {
    echo "Witaj w sklepie!"
    echo "Masz $money pieniędzy."
    echo "Co chcesz kupić?"
    echo "1. Super jedzenie (koszt: 5) – zmniejsza głód o 5"
    echo "2. Super zabawka (koszt: 7) – zwiększa szczęście o 5"
    echo "3. Energizer (koszt: 6) – zwiększa energię o 5"
    echo "4. Wyjdź z sklepu"
    read -p "Wybierz opcję (1-4): " choice

    case $choice in
        1)
            if [ $money -ge 5 ]; then
                money=$((money - 5))
                inventory+=("Super jedzenie")
                echo "Kupiłeś Super jedzenie!"
            else
                echo "Nie masz wystarczająco pieniędzy!"
            fi
            ;;
        2)
            if [ $money -ge 7 ]; then
                money=$((money - 7))
                inventory+=("Super zabawka")
                echo "Kupiłeś Super zabawkę!"
            else
                echo "Nie masz wystarczająco pieniędzy!"
            fi
            ;;
        3)
            if [ $money -ge 6 ]; then
                money=$((money - 6))
                inventory+=("Energizer")
                echo "Kupiłeś Energizer!"
            else
                echo "Nie masz wystarczająco pieniędzy!"
            fi
            ;;
        4)
            echo "Wychodzisz ze sklepu."
            ;;
        *)
            echo "Nieprawidłowy wybór."
            ;;
    esac
    status
}

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
    status
}

while [ $alive -eq 1 ]; do
    status
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
