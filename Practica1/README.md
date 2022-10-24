# PRÁCTICA 1 DE INTELIGENCIA ARTIFICIAL: BÚSQUEDA LOCAL


## MIEMBROS DEL GRUPO:
- Miró López-Feliu, Oriol
- Cruz Rodríguez, Unai
- Rivera monsergas, Nico


## CONTENIDO DE LA CARPETA:
-Documentacion.pdf: Documentación de la práctica, que contiene la descripción del proyecto, y explicación de todos los parámetros y experimentos realizados

-TablaExperimentos.pdf: Excel que contiene los datos que hemos extraído de los experimentos, donde se pueden apreciar también los gráficos realizados.

-Carpeta Practica1Centrales: Carpeta que contiene todos los códigos siguientes:
	-Main: programa principal que controla la ejecución de todo el proyecto
	-IAEstado: Clase estado que guarda los valores de cada solución inicial, parcial y final
	-IAHeuristicFunction: Clase que contiene la llamada a la función heurística del algoritmo Hill Climbing
	-IAHeuristicFunctionEmpty: Variación de la anterior clase que aplicamos para el experimento 5
	-IASuccesorFunction: Función que contiene la creación de estados sucesores a partir de los operadores para el algoritmo Hill Climbing
	-IASuccesorFunctionSA: Función que contiene la creación de estados sucesores a partir de los operadores para el algoritmo Simulated Annealing


## CÓMO REALIZAR LOS EXPERIMENTOS:
-Para cambiar la solución inicial, solo hace falta descomentar la solución inicial deseada y comentar la que esté seleccionada previamente (lineas 63-67 y 118-122 del Main.java).
-Para ejecutar el algoritmo Hill Climbing o el Simulated Annealing hay que descomentar el que se desee en el void main del Main.java (lineas 29-30).
