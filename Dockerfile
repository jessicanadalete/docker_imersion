# Etapa 1: Definir a imagem base
# O seu readme.md recomenda Python 3.10. Usar uma imagem 'slim' é uma boa prática
# pois ela é menor que a imagem padrão, mas possui mais compatibilidade que a 'alpine'.
FROM python:3.10-slim

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiamos primeiro o requirements.txt para aproveitar o cache de camadas do Docker.
# Se este arquivo não mudar, o Docker não precisará reinstalar as dependências em builds futuros.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# O argumento --no-cache-dir desabilita o cache do pip, o que ajuda a manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação
COPY . .

# Etapa 6: Expor a porta em que a aplicação irá rodar (padrão é 8000 para FastAPI)
EXPOSE 8000

# Etapa 7: Definir o comando para iniciar a aplicação
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
# O uvicorn é o servidor ASGI que o FastAPI utiliza.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000","--reload"]