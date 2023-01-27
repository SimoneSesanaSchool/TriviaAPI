import avviaPartita
import stampaClassifica

# Menu
while True:
    
    # Scelta opzioni
    print("Benvenuto su TriviaBro")
    print(" 0. Nuova partita")
    print(" 1. Stampa classifica")
    print(" 2. Esci")

    scelta = input("Inserisci scelta: ")

    if scelta == "0":
        avviaPartita.avviaPartita()
    elif scelta == "1":
        stampaClassifica.stampaClassifica()
    elif scelta == "2":
        break
    else:
        pass