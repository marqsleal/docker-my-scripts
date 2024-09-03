#!/bin/bash

# Antes de roda este script, certifique-se de settar a permissão dele com:
# chmod +x docker_cleanup.sh

# Parar todos os containers em execução:
CONTAINERS=$(docker ps -q)
if [ -n "$CONTAINERS" ]; then
  docker stop $CONTAINERS
else
  echo "Nenhum container em execução para parar."
fi

# Remover todos os containers:
CONTAINERS=$(docker ps -a -q)
if [ -n "$CONTAINERS" ]; then
  docker rm $CONTAINERS
else
  echo "Nenhum container para remover."
fi

# Remover todas as imagens
IMAGES=$(docker images -q)
if [ -n "$IMAGES" ]; then
  docker rmi $IMAGES
else
  echo "Nenhuma imagem para remover."
fi

# Remover todos os volumes ociosos:
docker volume prune -f

# Remover todos as redes ociosas:
docker network prune -f
