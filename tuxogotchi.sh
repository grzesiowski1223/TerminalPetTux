#!/bin/bash

# Kolory
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
RESET="\033[0m"

# Parametry Tuxa
tux_name="Tux"
happiness=5
hunger=0
money=10
food=3

# Funkcja do rysowania Tuxa
draw_tux() {
    if [ "$happiness" -ge 7 ]; then
        face="^_^"
    elif [ "$happiness" -ge 4 ]; then
        face="-_-"
    else
        face="T_T"
    fi

    echo -e "${CYAN}    $tux_name${RESET}"
    echo -e "${YELLOW}       .--.${RESET}"
    echo -e "${YELLOW}      |$face|${RESET}"
    echo -e "${YELLOW}      |:_/ |${RESET}"
    echo -e "${YELLOW}     //   \\\\\${RESET}"
    echo -e "${YELLOW}    (|     | )${RESET}"
    echo -e "${YELLOW}   /'\\_   _/`\\${RESET}"
    echo -e "${YELLOW}   \\___)=(___/${RESET}"
}

# Funkcja karmienia
feed_tux() {
    if [ "$food" -gt 0 ]; then
        food=$((food - 1))
        hunger=$((hunger - 2))
        happiness=$((happiness + 1))
        [ "$hunger" -lt 0 ] && hunger=0
        echo -e "${GREEN}You fed $tux_name!${RESET}"
    else
        echo -e "${RED}You have no food left!${RESET}"
    fi
}

# Funkcja zabawy
play_with_tux() {
    echo -e "${CYAN}Choose an activity:${RESET}"
    echo -e "1. Walk"
    echo -e "2. Dance"
    echo -e "3. Read a book"
    read -p "Your choice: " activity_choice

    case $activity_choice in
        1)
            echo -e "${GREEN}$tux_name enjoyed a walk!${RESET}"
            happiness=$((happiness + 2))
            hunger=$((hunger + 1))
            ;;
        2)
            echo -e "${GREEN}$tux_name danced happily!${RESET}"
            happiness=$((happiness + 3))
            hunger=$((hunger + 2))
            ;;
        3)
            echo -e "${GREEN}$tux_name enjoyed a quiet reading session.${RESET}"
            happiness=$((happiness + 1))
            hunger=$((hunger + 1))
            ;;
        *)
            echo -e "${RED}Invalid choice!${RESET}"
            ;;
    esac
}

# Funkcja sklepu
shop() {
    echo -e "${YELLOW}=== Shop ===${RESET}"
    echo -e "1. Buy food (cost: 3 coins per portion)"
    echo -e "2. Leave the shop"
    read -p "Choose an option (1/2): " shop_choice

    case $shop_choice in
        1)
            if [ "$money" -ge 3 ]; then
                food=$((food + 1))
                money=$((money - 3))
                echo -e "${GREEN}You bought some food! You now have $food portions of food.${RESET}"
            else
                echo -e "${RED}You don't have enough money!${RESET}"
            fi
            ;;
        2)
            echo -e "${CYAN}You leave the shop.${RESET}"
            ;;
        *)
            echo -e "${RED}Unknown option. Please choose again.${RESET}"
            ;;
    esac
    sleep 2
}

# Główna pętla gry
while true; do
    echo
    draw_tux
    echo -e "${BLUE}Happiness: $happiness  Hunger: $hunger  Food: $food  Money: $money${RESET}"
    echo -e "${YELLOW}What would you like to do?${RESET}"
    echo -e "1. Feed $tux_name"
    echo -e "2. Wait"
    echo -e "3. Play"
    echo -e "4. Go to the shop"
    echo -e "5. Quit"
    read -p "Your choice: " choice

    case $choice in
        1)
            feed_tux
            ;;
        2)
            hunger=$((hunger + 1))
            earned=$((RANDOM % 3 + 1))
            money=$((money + earned))
            echo -e "${CYAN}$tux_name is waiting... You earned $earned coins.${RESET}"
            ;;
        3)
            play_with_tux
            ;;
        4)
            shop
            ;;
        5)
            echo -e "${GREEN}Goodbye!${RESET}"
            break
            ;;
        *)
            echo -e "${RED}Invalid choice!${RESET}"
            ;;
    esac

    if [ "$hunger" -ge 10 ]; then
        echo -e "${RED}$tux_name has starved! Game over.${RESET}"
        break
    fi

    if [ "$happiness" -le 0 ]; then
        echo -e "${RED}$tux_name is too unhappy to continue. Game over.${RESET}"
        break
    fi
done
