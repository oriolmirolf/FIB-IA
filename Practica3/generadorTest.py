import os
import sys
import random


def conex(g, expectedSize):
	visited = set()
	visited.add(0)

	toVisit = set()
	toVisit.update([x for x in g[0]])
	
	while len(toVisit) > 0:
		elm = toVisit.pop()
		visited.add(elm)
		toVisit.update([x for x in g[elm] if x not in visited])



	return (len(visited) == expectedSize)

def nuevaPeticion(nPersonal, nAsentamientos, nSuministros, nAlmacenes, extension):
	tipo = random.randrange(2)
	if tipo == 0:
		rec = random.randrange(nPersonal)
		nuevaPeticionPersonal(rec, nAsentamientos, extension)
	else:
		rec = random.randrange(nSuministros)
		nuevaPeticionSuministro(rec, nAlmacenes, extension)

def nuevaPeticionPersonal(rec, nAsentamientos, extension):
	ase = random.randrange(nAsentamientos)
	prio = random.randrange(3) + 1
	file.write("		(peticion p"+str(rec)+" a"+str(ase)+")")
	if extension >= 4:
		file.write(" (= (prioridad p"+str(rec)+" a"+str(ase)+") "+str(prio)+")")
	file.write(os.linesep)

def nuevaPeticionSuministro(rec, nAlmacenes, extension):
	ase = random.randrange(nAlmacenes)
	prio = random.randrange(3) + 1
	file.write("		(peticion s"+str(rec)+" al"+str(ase)+")")
	if extension >= 4:
		file.write(" (= (prioridad s"+str(rec)+" al"+str(ase)+") "+str(prio)+")")
	file.write(os.linesep)


if len(sys.argv) == 1:
	print("Generar todo aleatorio?")
	print("-- 1: Si")
	print("-- 0: No")
	if int(input("?")) == 1:
		print("Indique la extensión:")
		print("-- 0: Nivel básico")
		print("-- 1: Extensión 1")
		print("-- 2: Extensión 2")
		print("-- 3: Extensión 2 (Priorizar combistible)")
		print("-- 4: Extensión 3")
		print("-- 5: Extensión 3 (Priorizar combustible y prioridad)")
		extension = int(input("?"))
		nRovers = random.randrange(7) + 2
		nPeticiones = random.randrange(15) + 5
		nPersonal = random.randrange(10) + 5
		nSuministros = random.randrange(10) + 5
		nAsentamientos = random.randrange(5) +5
		nAlmacenes = random.randrange(5) +5
	else:
		if len(sys.argv) > 1:
			extension = int(sys.argv[1])
		else:
			print("Indique la extensión:")
			print("-- 0: Nivel básico")
			print("-- 1: Extensión 1")
			print("-- 2: Extensión 2")
			print("-- 3: Extensión 2 (Priorizar combistible)")
			print("-- 4: Extensión 3")
			print("-- 5: Extensión 3 (Priorizar combustible y prioridad)")
			extension = int(input())

		if len(sys.argv) > 2:
			nRovers = int(sys.argv[2])
		else:
			print("Indique la cantidad de rovers:")
			nRovers = int(input())

		if len(sys.argv) > 3:
			nPeticiones = int(sys.argv[3])
		else:
			print("Indique la cantidad de peticiones:")
			nPeticiones = int(input())

		if len(sys.argv) > 4:
			nPersonal = int(sys.argv[4])
		else:
			print("Indique la cantidad de personal:")
			nPersonal = int(input())

		if len(sys.argv) > 5:
			nSuministros = int(sys.argv[5])
		else:
			print("Indique la cantidad de suministros:")
			nSuministros = int(input())

		if len(sys.argv) > 6:
			nAsentamientos = int(sys.argv[6])
		else:
			print("Indique la cantidad de asentamientos:")
			nAsentamientos = int(input())

		if len(sys.argv) > 7:
			nAlmacenes = int(sys.argv[7])
		else:
			print("Indique la cantidad de almacenes:")
			nAlmacenes = int(input())
else:
	if len(sys.argv) > 1:
		extension = int(sys.argv[1])
	else:
		print("Indique la extensión:")
		print("-- 0: Nivel básico")
		print("-- 1: Extensión 1")
		print("-- 2: Extensión 2")
		print("-- 3: Extensión 2 (Priorizar combistible)")
		print("-- 4: Extensión 3")
		print("-- 5: Extensión 3 (Priorizar combustible y prioridad)")
		extension = int(input())

	if len(sys.argv) > 2:
		nRovers = int(sys.argv[2])
	else:
		print("Indique la cantidad de rovers:")
		nRovers = int(input())

	if len(sys.argv) > 3:
		nPeticiones = int(sys.argv[3])
	else:
		print("Indique la cantidad de peticiones:")
		nPeticiones = int(input())

	if len(sys.argv) > 4:
		nPersonal = int(sys.argv[4])
	else:
		print("Indique la cantidad de personal:")
		nPersonal = int(input())

	if len(sys.argv) > 5:
		nSuministros = int(sys.argv[5])
	else:
		print("Indique la cantidad de suministros:")
		nSuministros = int(input())

	if len(sys.argv) > 6:
		nAsentamientos = int(sys.argv[6])
	else:
		print("Indique la cantidad de asentamientos:")
		nAsentamientos = int(input())

	if len(sys.argv) > 7:
		nAlmacenes = int(sys.argv[7])
	else:
		print("Indique la cantidad de almacenes:")
		nAlmacenes = int(input())
a = [] #asentamientos
al = [] #almacenes

#Abrir/Crear el archivo
file = open("./archivo_prueba.txt", "w")

#InInicio del test
file.write("(define (problem nombre)" + os.linesep)

if extension != 0:
	ex = extension
	if (ex >= 3): ex -= 1
	if (ex > 3): ex -= 1
	file.write("	(:domain desplazamientos-ext"+str(ex)+")" + os.linesep)
else:
	file.write("	(:domain desplazamientos-basico)" + os.linesep)

#Declaramos los objectos
file.write("	(:objects" + os.linesep)
	#Personas
personalString = "";
for i in range(0, nPersonal):
	personalString += ' p'+str(i)
file.write("		" + personalString + " - persona" + os.linesep)

	#suministro
suministroString = "";
for i in range(0, nSuministros):
	suministroString += ' s'+str(i)
file.write("		" + suministroString + " - suministro" + os.linesep)

	#asentamiento
asentamientoString = "";
for i in range(0, nAsentamientos):
	asentamientoString += ' a'+str(i)
	a.append('a'+str(i))
file.write("		" + asentamientoString + " - asentamiento" + os.linesep)

	#almacen
almacenString = "";
for i in range(0, nAlmacenes):
	almacenString += ' al'+str(i)
	a.append('al'+str(i))
file.write("		" + almacenString + " - almacen" + os.linesep)

	#rover
roverString = "";
for i in range(0, nRovers):
	roverString += ' r'+str(i)
file.write("		" + roverString + " - rover" + os.linesep)

file.write("	)" + os.linesep)



#--------------------- Crear el grafo de todas las bases
totalBases = nAlmacenes + nAsentamientos
grafo = []
for i in range (0, totalBases):
	grafo.append(set())

numTrue = 0
while numTrue < totalBases - 1:
	f = random.randrange(totalBases)
	t = random.randrange(totalBases)

	if f != t and t not in grafo[f] and f not in grafo[t]:
		grafo[f].add(t)
		grafo[t].add(f)
		numTrue += 1

while (not conex(grafo, totalBases)):
	f = random.randrange(totalBases)
	t = random.randrange(totalBases)

	while f != t and t not in grafo[f] and f not in grafo[t]:
		grafo[f].add(t)
		grafo[t].add(f)




#Inicializar los objetos
file.write("	(:init" + os.linesep)
# --------------------- adyacente
n = 0
for x in grafo:
	for m in x:

		str0 = "a"
		a0 = n
		if a0 >= nAsentamientos:
			str0 += "l"
			a0 -= nAsentamientos

		str1 = "a"
		a1 = m
		if m >= nAsentamientos:
			str1 += "l"
			a1 -= nAsentamientos

		file.write("		(basesAdyacentes " + str0 + str(a0) + " " + str1 + str(a1) + ")" + os.linesep)
	n += 1

# --------------------- posicionRecurso
for i in range(0, nPersonal):
	pos = random.randrange(nAsentamientos)
	file.write("		(posicionRecurso p"+ str(i) +" a"+ str(pos) +")" + os.linesep)

for i in range(0, nSuministros):
	pos = random.randrange(nAlmacenes)
	file.write("		(posicionRecurso s"+ str(i) +" al"+ str(pos) +")" + os.linesep)



for i in range(0, nPersonal):
	nuevaPeticionPersonal(i, nAsentamientos, extension)

for i in range(0, nSuministros):
	nuevaPeticionSuministro(i, nAlmacenes, extension)


for p in range(0, nPeticiones):
	nuevaPeticion(nPersonal, nAsentamientos, nSuministros, nAlmacenes, extension)




#posicionRover
sumaCombustible = 0
for i in range(0, nRovers):
	pos = random.randrange(totalBases)
	strBase = "a"
	if pos >= nAsentamientos:
		strBase += "l"
		pos -= nAsentamientos
	file.write("		(posicionRover r"+ str(i) +" "+ strBase + str(pos) +")")

	if extension >= 1:
		file.write(" (= (numPersonas r"+str(i)+") 0)")

	if extension >= 2:
		c = random.randrange(totalBases*2+1) 
		sumaCombustible += c
		file.write(" (= (combustible r"+str(i)+") "+str(c)+")")
	file.write(os.linesep)

if extension >= 2:
	file.write(" (= (sumaCombustible) "+str(sumaCombustible)+")" +os.linesep)


if (extension >= 4):
	file.write(" (= (sumaPrioridad) 0)" + os.linesep)


file.write("	)" + os.linesep)
file.write("	(:goal (forall (?r - recurso) (entregado ?r)))" + os.linesep)

if extension == 3:
	file.write("	(:metric maximize  (sumaCombustible))" + os.linesep)

if extension == 4:
	file.write("	(:metric maximize  (sumaPrioridad))" + os.linesep)

if extension == 5:
	file.write("	(:metric maximize (+ (* 10 (sumaPrioridad)) (* 8 (sumaCombustible))))" + os.linesep)
file.write(")" + os.linesep)
file.close()