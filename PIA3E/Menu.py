#Modulos
from encriptar import generate_key, generate_iv,encrypt_file #Encriptar
from generador import generar_contrasena #Generador
from AbuseIPDB import buscar_datos #Data Abuse
import os 
from sh import buscar_shodan #Shodan
from DecBin import decimal_binario, texto_binario #Binario
def limpiar_pantalla():
    os.system('cls' if os.name=='nt' else 'clear')
#Menu
while True:
    print("=====MENU=====")
    print("1)API SHODAN") #Yo
    print("2)API-DATA ABUSE")#Uriel 
    print("3)Generador de contraseñas") #Yo
    print("4)Encriptar Archivo") #Yo
    print("5)Codificador de binario") #Angel
    print("6)SALIR")
    print("7)Limpiar pantalla")
    opcion=int(input("Ingresa una opcion:\n"))
    if opcion == 1:
        print("SHODAN")
        api_key=input("Ingresa tu api key aqui: \n")
        xd=buscar_shodan(api_key)

    elif opcion == 2:
        print("Data Abuse")
        api_key=input("INgresa la apikey de data abuse aqui:\n")
        ip_address=input("Ingresa la direccion ip:\n")
        buscar_datos(api_key,ip_address)
        
    elif opcion == 3:
        print("Generar contraseñas")
        contrasena_generada= generar_contrasena()
        print(f"La contraseña generada es: {contrasena_generada}")

    elif opcion == 4:
        print("Encriptar archivos")
        file_path = input("Ingresa la ruta del archivo que deseas encriptar:\n")
        key = generate_key()  
        iv = generate_iv()
        encrypt_file(file_path, key, iv)
        with open("clave.key", "wb") as key_file:
            key_file.write(key)
        print("Clave guardada en clave.key")

    elif opcion == 5:
        print("Codificador de binario")
        entrada=input("Ingresa el texto a convertir (Nuemros/texto):\n")
        if entrada.lstrip('-').isdigit():
            numero_decimal=int(entrada)
            binario=decimal_binario(numero_decimal)
            print(f"El numero {numero_decimal} en binario es: {binario}")
        else:
            binario=texto_binario(entrada)
            print(f"El texto '{entrada}' en binario es: {binario}")

    elif opcion == 6:
        exit()
    elif opcion == 7:
        limpiar_pantalla()
    else:
        print("Ingresa una opcion valida!!")