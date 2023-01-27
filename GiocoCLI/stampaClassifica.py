import os
import requests

# Metodo per stampare la classifica
def stampaClassifica():
    
    
    # Pulizia terminale
    os.system('cls' if os.name == 'nt' else 'clear')
    
    # Richiesta classifica
    response = requests.get("http://127.0.0.1:30333/getClassifica")
    classifica = response.json()["classifica"]

    indice = 1
    for giocatore in classifica:
        print(" " + str(indice) + ". "+ giocatore["username"] + ": " + str(giocatore["punteggio"]) + " punti")
        indice = indice + 1

    input("\nPremere invio per tornare al menu")