import random

# Funzione per generare un numero casuale diverso dal numero passato
def generaNumeroCasuale(numero, numeroMassimo):

    x = random.randint(0, numeroMassimo) 
    
    while x == numero:
        x = random.randint(0, numeroMassimo)
    
    return x