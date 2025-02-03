#!/bin/bash

# Definición de colores ANSI brillantes
YELLOW='\033[1;33m'    # Amarillo brillante
GREEN='\033[1;32m'     # Verde brillante
NC='\033[0m'           # Reset (sin color)

echo "${YELLOW}Construyendo página web...${NC}"
mkdocs build

echo "${YELLOW}Actualizando el contenido del servidor web...${NC}"
sudo rm -r /var/www/sudoheroes/doc/
sudo cp -r /home/ubuntu/sudoheroes/site/ /var/www/sudoheroes/doc
echo "${GREEN}Contenido actualizado!${NC}"

echo "${YELLOW}Recargando nginx...${NC}"
sudo /etc/init.d/nginx reload

echo "${GREEN}La página web se ha actualizado correctamente!${NC}"

