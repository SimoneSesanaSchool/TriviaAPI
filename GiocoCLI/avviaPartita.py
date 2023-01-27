import os
import requests

# Metodo per giocare
def avviaPartita():

    # Struttura contenente i dati del giocatore
    datiGiocatore = {
        "username": "",
        "punteggio": 0,
        "ultimaDomandaEstratta": -1
    }
       
    datiGiocatore["username"] = input("Inserire username: ")
    
    # Stampa domande finche l'utente non inserisce una risposta errata
    while True:
        
        response = requests.get("http://127.0.0.1:30333/getDomanda?domandeGiaUscite=-1")
   
        domandaEstratta = datiGiocatore["ultimaDomandaEstratta"]
        while domandaEstratta == response.json()["numeroDomanda"]:
            response = requests.get("http://127.0.0.1:30333/getDomanda?domandeGiaUscite=-1")


        datiGiocatore["ultimaDomandaEstratta"] = response.json()["numeroDomanda"]


        # Stampa domanda
        print(response.json()["domanda"])

        # Stampa opzioni possibili
        print(" 1. " + response.json()["risposta1"])
        print(" 2. " + response.json()["risposta2"])
        print(" 3. " + response.json()["risposta3"])
        print(" 4. " + response.json()["risposta4"])

        risposta = input("Inserire numero risposta: ")

        # Verifica correttezza della risposta
        questionResponse = requests.get("http://127.0.0.1:30333/verificaRisposta?numeroDomanda=" + str(response.json()["numeroDomanda"]) +"&numeroRisposta= " + str(risposta) + "")
        
        if questionResponse.json()["corretta"] == "si":
            
            # Incremento punteggio giocatore
            datiGiocatore["punteggio"] = datiGiocatore["punteggio"] + 1
            
            # Stampa punteggio
            print("Risposta corretta. Punteggio: " + str(datiGiocatore["punteggio"]))

            input("Premere invio per continuare")

            # Pulizia terminale
            os.system('cls' if os.name == 'nt' else 'clear')
  
        else:

            # Stampa punteggio
            print("Risposta errata. Hai perso.\nIl tuo punteggio: " + str(datiGiocatore["punteggio"]))
            input("Premere invio per continuare")

            # Viene aggiornata la classifica
            requests.get("http://localhost:30333/aggiornaClassifica?username="+datiGiocatore["username"]+"&punteggio="+str(datiGiocatore["punteggio"])+"")


            # Pulizia terminale
            os.system('cls' if os.name == 'nt' else 'clear')

            break

