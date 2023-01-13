import json

with open("File/PunteggiGiocatori.txt", "r") as f:
  
    sigma = {
        "username": "bruuh",
        "punteggio": 10
    }

    # Lettura dei punteggi
    punteggi = json.load(f)

    classifica = punteggi["classifica"]
    print(classifica)

    posizione = 0
    for giocatore in classifica:
        if giocatore["punteggio"] < sigma["punteggio"]:
            classifica.insert(posizione, sigma)
            break

        posizione = posizione + 1

    if posizione == len(classifica):
        classifica.append(sigma)

    print(posizione)
    print(classifica)

    f.close()

with open("File/PunteggiGiocatori.txt", "w") as f:

    punteggi["classifica"] = classifica
    f.write(json.dumps(punteggi))
