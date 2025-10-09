#!/bin/bash

PURPLE='\e[0;35m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${PURPLE} ████████╗██╗   ██╗██╗  ██╗ ██████╗  ██████╗  ██████╗ ████████╗ ██████╗██╗  ██╗██╗"
echo -e "${PURPLE} ╚══██╔══╝██║   ██║╚██╗██╔╝██╔═══██╗██╔════╝ ██╔═══██╗╚══██╔══╝██╔════╝██║  ██║██║"
echo -e "${PURPLE}   ██║   ██║   ██║ ╚███╔╝ ██║   ██║██║  ███╗██║   ██║   ██║   ██║     ███████║██║"
echo -e "${PURPLE}   ██║   ██║   ██║ ██╔██╗ ██║   ██║██║   ██║██║   ██║   ██║   ██║     ██╔══██║██║"
echo -e "${PURPLE}   ██║   ╚██████╔╝██╔╝ ██╗╚██████╔╝╚██████╔╝╚██████╔╝   ██║   ╚██████╗██║  ██║██║"
echo -e "${PURPLE}   ╚═╝    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝    ╚═════╝╚═╝  ╚═╝╚═╝${NC}"
echo ""
echo "Installation script:"
echo ""
sleep 1

read -r -p "Do you want to install Tuxogotchi to /usr/local/bin directory? [y/N] " response

case "$response" in
    [yY][eE][sS]|[yY])
        echo -e "${GREEN}Downloading Script...${NC}"
        echo ""
        sleep 1

        TMP_FILE=$(mktemp /tmp/tuxogotchi.XXXX.sh)
        curl -s -o "$TMP_FILE" https://raw.githubusercontent.com/grzesiowski1223/TerminalPetTux/main/tuxogotchi.sh
        echo -e "${GREEN}Download complete!${NC}"
        echo ""
        sleep 1

        echo -e "${GREEN}Copying script to /usr/local/bin...${NC}"
        echo ""
        sleep 1

        # Symulacja postępu instalacji
        for i in {0..100..10}; do
            echo -ne "[${PURPLE}$(printf "%0.s#" $(seq 1 $((i/2))))${NC}$(printf "%0.s-" $(seq 1 $((50-i/2))))] $i% \r"
            sleep 0.2
        done
        sudo mv "$TMP_FILE" /usr/local/bin/tuxogotchi
        echo -e "\n${GREEN}Script copied successfully!${NC}"
        echo ""
        sleep 1

        echo -e "${GREEN}Making command executable...${NC}"
        echo ""
        sleep 1
        sudo chmod +x /usr/local/bin/tuxogotchi

        # Symulacja postępu chmod
        for i in {0..100..20}; do
            echo -ne "[${PURPLE}$(printf "%0.s#" $(seq 1 $((i/2))))${NC}$(printf "%0.s-" $(seq 1 $((50-i/2))))] $i% \r"
            sleep 0.2
        done
        echo -e "\n${GREEN}Command is now executable!${NC}"
        echo ""
        sleep 1

        echo -e "Done! Now you can use the command ${PURPLE}tuxogotchi${NC}."
        echo ""
        sleep 1
        ;;
    *)
        echo "Exiting..."
        exit 0
        ;;
esac
