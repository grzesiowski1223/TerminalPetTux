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
    echo "Tux's Status:"
    echo "Hunger: $hunger"
    echo "Happiness: $happiness"
    echo "Energy: $energy"
    echo "Mood: $mood"
    echo "Money: $money"
    echo "Inventory: ${inventory[@]}"
    echo ""
}

feed() {
    echo "You feed Tux. Yum yum!"
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
    echo "You play with Tux. Tux is happy!"
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
    echo "Tux goes to sleep. Zzz..."
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
        echo "Unfortunately, Tux has died. :("
        show_tux
        exit 1
    fi
}

shop() {
    echo "Welcome to the shop!"
    echo "You have $money money."
    echo "What would you like to buy?"
    echo "1. Super Food (cost: 5) – reduces hunger by 5"
    echo "2. Super Toy (cost: 7) – increases happiness by 5"
    echo "3. Energizer (cost: 6) – increases energy by 5"
    echo "4. Exit the shop"
    read -p "Choose an option (1-4): " choice

    case $choice in
        1)
            if [ $money -ge 5 ]; then
                money=$((money - 5))
                inventory+=("Super Food")
                echo "You bought Super Food!"
            else
                echo "You don't have enough money!"
            fi
            ;;
        2)
            if [ $money -ge 7 ]; then
                money=$((money - 7))
                inventory+=("Super Toy")
                echo "You bought a Super Toy!"
            else
                echo "You don't have enough money!"
            fi
            ;;
        3)
            if [ $money -ge 6 ]; then
                money=$((money - 6))
                inventory+=("Energizer")
                echo "You bought an Energizer!"
            else
                echo "You don't have enough money!"
            fi
            ;;
        4)
            echo "You exit the shop."
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
    status
}

use_item() {
    echo "Your inventory: ${inventory[@]}"
    read -p "Which item would you like to use? (type the name or 'cancel'): " item
    case $item in
        "Super Food")
            hunger=$((hunger - 5))
            if [ $hunger -lt 0 ]; then
                hunger=0
            fi
            inventory=("${inventory[@]/Super Food}")
            echo "You used Super Food. Tux's hunger decreased by 5!"
            ;;
        "Super Toy")
            happiness=$((happiness + 5))
            inventory=("${inventory[@]/Super Toy}")
            echo "You used a Super Toy. Tux's happiness increased by 5!"
            ;;
        "Energizer")
            energy=$((energy + 5))
            inventory=("${inventory[@]/Energizer}")
            echo "You used an Energizer. Tux's energy increased by 5!"
            ;;
        "cancel")
            echo "Cancelled."
            ;;
        *)
            echo "You don't have this item in your inventory."
            ;;
    esac
    status
}

while [ $alive -eq 1 ]; do
    status
    echo "What would you like to do?"
    echo "1. Feed Tux"
    echo "2. Play with Tux"
    echo "3. Put Tux to sleep"
    echo "4. Visit the shop"
    echo "5. Use an item from the inventory"
    echo "6. Exit the game"
    read -p "Choose an option (1-6): " choice

    case $choice in
        1) feed ;;
        2) play ;;
        3) sleep ;;
        4) shop ;;
        5) use_item ;;
        6) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid choice. Try again." ;;
    esac

    check_alive
done
