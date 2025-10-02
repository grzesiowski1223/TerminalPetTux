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
echo "Instalation script:"
echo ""
sleep 1
read -r -p "Do you want to install Tuxogotchi to /bin directory? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        echo -e "${GREEN}Installing Script...${NC}"
        echo ""
            sleep 1

        curl -o tuxogotchi.sh https://raw.githubusercontent.com/grzesiowski1223/TerminalPetTux/main/tuxogotchi.sh
        echo ""
            sleep 1

        echo -e "${GREEN}Preparing script for installation...${NC}"
        echo ""
            sleep 1

        mv -v ~/tuxogotchi.sh ~/tuxogotchi
        echo ""
            sleep 1

        echo -e "${GREEN}Copying files to /bin directory...${NC}"
        echo ""
            sleep 1

        sudo mv -v ~/tuxogotchi /bin
        echo ""
            sleep 1

        echo -e "${GREEN}Making command executable...${NC}"
        echo ""
            sleep 1

        chmod -v +x /bin/tuxogotchi
        echo ""
            sleep 1

        echo -e "Done now u can use Command ${PURPLE}tuxogotchi${NC}."
            sleep 1
        ;;
    *)

        echo "Exiting..."
        exit
        ;;
esac
