#!/bin/bash

# Name your penguin
read -p "What would you like to name your penguin? " tux_name
if [ -z "$tux_name" ]; then
    tux_name="Tux"
fi

# Penguin and player parameters
hunger=0
max_hunger=5
food=0
money=10
happiness=5
max_happiness=10

# Function to display the penguin
draw_tux() {
    echo "    $tux_name"
    echo "       .--."
    echo "      |o_o |"
    echo "      |:_/ |"
    echo "     //   \\ \\"
    echo "    (|     | )"
    echo "   /'\\_   _/`\\"
    echo "   \\___)=(___/"
}

# Shop function
shop() {
    echo
    echo "=== Shop ==="
    echo "1. Buy food (cost: 3 coins per portion)"
    echo "2. Leave the shop"
    read -p "Choose an option (1/2): " shop_choice

    case $shop_choice in
        1)
            if [ "$money" -ge 3 ]; then
                food=$((food + 1))
                money=$((money - 3))
                echo "You bought some food! You now have $food portions of food."
            else
                echo "You don't have enough money!"
            fi
            ;;
        2)
            echo "You leave the shop."
            ;;
        *)
            echo "Unknown option. Please choose again."
            ;;
    esac
    sleep 2
}

# Activities function
activities() {
    echo
    echo "=== Activities ==="
    echo "1. Take $tux_name for a walk (increases happiness, increases hunger)"
    echo "2. Play a game with $tux_name (increases happiness, decreases money)"
    echo "3. Teach $tux_name tricks (chance to earn money, decreases happiness)"
    echo "4. Return to the menu"
    read -p "Choose an activity (1/2/3/4): " activity_choice

    case $activity_choice in
        1)
            happiness=$((happiness + 2))
            hunger=$((hunger + 1))
            echo "$tux_name: The walk was amazing! :)"
            ;;
        2)
            if [ "$money" -ge 2 ]; then
                happiness=$((happiness + 3))
                money=$((money - 2))
                echo "$tux_name: That game was so much fun! :)"
            else
                echo "You don't have enough money to play."
            fi
            ;;
        3)
            happiness=$((happiness - 1))
            if [ $((RANDOM % 2)) -eq 0 ]; then
                earned=$((RANDOM % 5 + 1))
                money=$((money + earned))
                echo "$tux_name learned a trick and earned $earned coins!"
            else
                echo "$tux_name wasn't in the mood to learn today."
            fi
            ;;
        4)
            echo "Returning to the menu."
            ;;
        *)
            echo "Unknown option. Please choose again."
            ;;
    esac

    if [ "$happiness" -gt "$max_happiness" ]; then
        happiness=$max_happiness
    fi

    sleep 2
}

# Main menu in ASCII format
main_menu() {
    clear
    echo "============================"
    echo "   WELCOME TO YOURPETTUX!"
    echo "============================"
    echo "          .--."
    echo "         |o_o |"
    echo "         |:_/ |"
    echo "        //   \\ \\"
    echo "       (|     | )"
    echo "      /'\\_   _/`\\"
    echo "      \\___)=(___/"
    echo
    echo "Game created by: grzesiowski1223"
    echo
    echo "Press Enter to start the game!"
    read
}

# Run the main menu
main_menu

# Game loop
while true; do
    clear
    draw_tux
    echo
    echo "$tux_name: Hunger level: $hunger/$max_hunger | Happiness: $happiness/$max_happiness"
    echo "Food: $food | Money: $money"

    if [ "$hunger" -ge "$max_hunger" ]; then
        echo
        echo "$tux_name is too hungry and sadly passed away... :("
        break
    fi

    if [ "$happiness" -le 0 ]; then
        echo
        echo "$tux_name is too sad and decided to leave you... :("
        break
    fi

    echo
    echo "What would you like to do?"
    echo "1. Feed $tux_name (requires food)"
    echo "2. Wait (hunger increases, you earn money)"
    echo "3. Shop"
    echo "4. Activities"
    echo "5. Quit the game"
    read -p "Choose an option (1/2/3/4/5): " choice

    case $choice in
        1)
            if [ "$food" -gt 0 ]; then
                hunger=$((hunger - 1))
                if [ "$hunger" -lt 0 ]; then
                    hunger=0
                fi
                food=$((food - 1))
                echo "$tux_name: Thank you for the food! :)"
            else
                echo "You don't have any food! Go to the shop to buy some."
            fi
            ;;
        2)
            hunger=$((hunger + 1))
            money=$((money + 1))
            echo "$tux_name: I'm getting hungrier... :("
            echo "You earned 1 coin for waiting."
            ;;
        3)
            shop
            ;;
        4)
            activities
            ;;
        5)
            echo "Goodbye! $tux_name will miss you!"
            break
            ;;
        *)
            echo "Unknown option. Please choose again."
            ;;
    esac
    sleep 2
done
