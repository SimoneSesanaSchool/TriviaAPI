import json
import random
from fastapi import FastAPI


app = FastAPI()
numeroDomanda = 0
with open("File/Domande.txt", "r") as f:

    # Lettura delle domande dal file json
    dati = json.load(f)



# METODI PER IL GIOCO
##########################################################################################
# Metodo che restituisce una domanda casuale e le relative risposte
@app.get('/getDomanda')
async def getDomanda(domandeGiaUscite: str):
    
    array = domandeGiaUscite.split(",")
    domandeEstratte = list(map(int, array))
    print(domandeEstratte)

    # Estrazione di una domanda casuale dal file
    numeroDomanda = random.randint(0, len(dati["domande"])-1)
    
    # Si controlla che la domanda non sia già uscita
    while numeroDomanda in domandeEstratte:
        numeroDomanda = random.randint(0, len(dati["domande"])-1)


    # Estrazione dei dati dal file json
    domandaEstratta = dati["domande"][numeroDomanda]
    risposta1 = dati["domande"][numeroDomanda]["risposte"][0]["risposta"]
    risposta2 = dati["domande"][numeroDomanda]["risposte"][1]["risposta"]
    risposta3 = dati["domande"][numeroDomanda]["risposte"][2]["risposta"]
    risposta4 = dati["domande"][numeroDomanda]["risposte"][3]["risposta"]

    # Vengono ritornate la domanda e le relative risposte. Viene
    # inoltre ritornato il numero della domanda, che servirà poi
    # per verificare la correttezza della risposta inviata
    return {
        "domanda": domandaEstratta["domanda"],
        "risposta1": risposta1,
        "risposta2": risposta2,
        "risposta3": risposta3,
        "risposta4": risposta4,
        "numeroDomanda": numeroDomanda
    }


# Metodo che riceve in ingresso il numero della domanda e della risposta
# data dall'utente e ritorna se la risposta è corretta o meno
@app.get('/verificaRisposta')
async def verificaRisposta(numeroDomanda: int, numeroRisposta: int):

    numeroRisposta = numeroRisposta - 1

    i = 0
    while i < 4:
        if(dati["domande"][numeroDomanda]["risposte"][i]["corretta"] == True):
            if i == numeroRisposta:
                return {"corretta": "si"}
        i = i + 1

    return {
        "corretta": "no"
    }

##########################################################################################



# METODI CLASSIFICA
##########################################################################################
# Metodo che inserisce il punteggio del giocatore con il relativo
# username all'interno della classifica
@app.get('/aggiornaClassifica')
async def aggiornaPunteggio(username: str, punteggio: int):
    
    datiGiocatore = {
        "username": username,
        "punteggio": punteggio
    }

    with open("File/PunteggiGiocatori.txt", "r") as p:

        # Lettura dei punteggi
        punteggi = json.load(p)

        classifica = punteggi["classifica"]

        # Se il giocatore è gia presente nella classifica viene eliminato
        # in modo che poi possa essere reinserito correttamente
        for giocatore in classifica:
            if giocatore["username"] == datiGiocatore["username"]:
                classifica.remove(giocatore)    

        # Il giocatore viene aggiunto alla classifica
        posizione = 0
        for giocatore in classifica:
            if giocatore["punteggio"] < datiGiocatore["punteggio"]:
                classifica.insert(posizione, datiGiocatore)
                break

            posizione = posizione + 1

        # Se il giocatore non è stato ancora aggiunto viene aggiunto alla fine
        if posizione == len(classifica):
            classifica.append(datiGiocatore)

        f.close()

    # Le modifiche vengono apportate al file
    with open("File/PunteggiGiocatori.txt", "w") as p:

        punteggi["classifica"] = classifica
        p.write(json.dumps(punteggi))

    return {
        "classifica": classifica
    }


# Metodo per reimpostare la classifica
@app.get('/reimpostaClassifica')
async def reimpostaClassifica():

    # Viene aggiornato il file contenente la classifica
    with open("File/PunteggiGiocatori.txt", "w") as c:
        c.write('{"classifica": []}')

    return {
        "classifica": []
    }


# Metodo che ritorna la classifica
@app.get('/getClassifica')
async def getClassifica():

    with open("File/PunteggiGiocatori.txt", "r") as p:

        # Lettura dei punteggi
        punteggi = json.load(p)

        return {
            "classifica": punteggi["classifica"]
        }

##########################################################################################