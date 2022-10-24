package Centrales;
import java.util.*;

import javax.sql.ConnectionEventListener;

import java.lang.Math;

import IA.Energia.Central;
import IA.Energia.Centrales;
import IA.Energia.Cliente;
import IA.Energia.Clientes;
import IA.Energia.VEnergia;
public class IAEstado {

//Atributos:

    static VEnergia VE;
    static Centrales centList;  //Las centrales!
    static Clientes cliList;    //Y los clientes
    static double penalizacion; //Penalizacion por cliente garantizado no asignado
    private int[] asignacion; //1 posicion por cliente, su valor indica a que central va. -1 == no asignado
    private double[] capacidad; //1 posicion por central, su valor indica la capacidad restante de cada central
    private double beneficio; //Ha de ser double

    private double lostBen; //Ha de ser double



//Metodos:

    //Creadora:

    public IAEstado(IAEstado x) {
        double b = x.getBEneficio();
        double l = x.getLostBen();
        centList = x.centList;
        cliList = x.cliList;
        VE = x.VE;
        penalizacion = getPenalizacion();
        beneficio = b;
        lostBen = l;
        asignacion = x.asignacion.clone();
        capacidad = x.capacidad.clone();
    }

    /*  Explicacion de parametros (sacados de la documentacion):
        cent:    Vector con tres posiciones con el numero de centrales de cada tipo a generar
        ncl:    Numero de clientes
        propc:  Proporcion de los tipos de clientes (vector 3 posiciones, suman 1)
        propg:  Proporcion de clientes con servicio garantizado
        seed:   Semilla del generador de numeros aleatorio (MISMA PARA CLIENTES Y CENTRALES??)
    */
    public IAEstado(int[] cent, int ncl, double[] propc, double propg, int seed) throws Exception{
        penalizacion = 0;
        //Lo ponemos a -1 para indicar que no tienen una central asignada
        asignacion = new int[ncl];
        for (int i = 0; i < ncl; i++) {
            asignacion[i] = -1;
        }

        centList = new Centrales(cent, seed);
        cliList = new Clientes(ncl, propc, propg, seed);

        capacidad = new double[centList.size()];

        for (int i = 0; i < centList.size(); i++) {
            capacidad[i] = centList.get(i).getProduccion();
        }

        beneficio = 0;
        lostBen = 0;

        VE = new VEnergia();
    }

    public IAEstado(int[] cent, int ncl, double[] propc, double propg, int seed, double p) throws Exception{
        penalizacion = p;
        //Lo ponemos a -1 para indicar que no tienen una central asignada
        asignacion = new int[ncl];
        for (int i = 0; i < ncl; i++) {
            asignacion[i] = -1;
        }

        centList = new Centrales(cent, seed);
        cliList = new Clientes(ncl, propc, propg, seed);

        capacidad = new double[centList.size()];

        for (int i = 0; i < centList.size(); i++) {
            capacidad[i] = centList.get(i).getProduccion();
        }

        beneficio = 0;
        lostBen = 0;

        VE = new VEnergia();
    }

    //Se usa la seed para que se reparta de forma determinista con la semilla. Cambiar?
    public void genSolIniAleatoria(int seed) throws Exception {
        Random random = new Random(seed);
        int bound = centList.size()-1;

        //Recorremos todos los clientes
        for (int i = 0; i < asignacion.length; ++i) {

            Cliente cliTemp = cliList.get(i);

            //Solo le damos una asignacion en el caso de que sea garantizado
            if (cliTemp.getContrato() == 0) {

                //Cogemos una central aleatoria fijada por el bound para no salirse del rango
                int cenTempIndex = random.nextInt(bound);

                double consumo = cliTemp.getConsumo();

                //Calculamos perdida por distancia y actualizamos consumo
                double dist = calcDist(cliTemp, centList.get(cenTempIndex));
                double consumoTotal = consumo / (1-VE.getPerdida(dist));

                double cap = capacidad[cenTempIndex];

                /*  Si el cliente cabe en la central:
                    El cliente pasa a tener la central asignada
                    Se le resta a la capacidad de la central el consumo del cliente.

                    PUNTO CLAVE: La "indemnizacion" de la distancia se calcula implicitamente, pues lo añadimos a la central y se computara despues al calcular los costes de producir dicha energia.
                */

                while (cap < consumoTotal) {
                    cenTempIndex = random.nextInt(bound);
                    dist = calcDist(cliTemp, centList.get(cenTempIndex));

                    consumoTotal = consumo / (1-VE.getPerdida(dist));
                    cap = capacidad[cenTempIndex];
                }
                asignacion[i] = cenTempIndex;
                capacidad[cenTempIndex] = cap-consumo;
            }
        }
        calcBeneficio();
    }

    private double calcConsumo(Cliente a, double dist, int cen_i) {
        double consumo = a.getConsumo();
        double perdida = VE.getPerdida(dist);
        if (perdida != 0.0) consumo /= (1-perdida);

        return consumo;
    }

    public void genSolIniOrdenada() throws Exception{
        for (int i=0; i<asignacion.length; ++i) {
            double dist = -1;
            int cen = -1;
            double consFinal = -1;
            Cliente cliAux = cliList.get(i);
            if (cliAux.getContrato() == 0) { // 0 => Cliente garantizado
                for (int j=1; j<capacidad.length; ++j) {
                    double aux = calcDist(cliAux, centList.get(j));
                    double consumo = calcConsumo(cliAux, aux, j);
                    if ((aux < dist || dist == -1) && consumo <= capacidad[j]) {
                        dist = aux;
                        cen = j;
                        consFinal = consumo;
                    }
                }
                asignacion[i] = cen;
                capacidad[cen] -= consFinal;
            }
        }
        calcBeneficio();
    }

    public void genSolIniOrdenadaTodos() throws Exception{
        for (int i=0; i<asignacion.length; ++i) {
            double dist = -1;
            int cen = -1;
            double consFinal = -1;
            Cliente cliAux = cliList.get(i);
            if (cliAux.getContrato() == 0) { // 0 => Cliente garantizado
                for (int j=0; j<capacidad.length; ++j) {
                    double aux = calcDist(cliAux, centList.get(j));
                    double consumo = calcConsumo(cliAux, aux, j);
                    if ((aux < dist || dist == -1) && consumo <= capacidad[j]) {
                        dist = aux;
                        cen = j;
                        consFinal = consumo;
                    }
                }
                asignacion[i] = cen;
                capacidad[cen] -= consFinal;
            }

        }
        for (int i=0; i<asignacion.length; ++i) {
            Cliente cliAux = cliList.get(i);
            if (asignacion[i] == -1) {
                boolean posible = false;
                int cen = -1;
                double consumo = cliAux.getConsumo();
                double consumoTotal = consumo;

                for (int j=0; j<capacidad.length && !posible; ++j) {
                    double dist = calcDist(cliAux, centList.get(j));

                    consumoTotal = consumo / (1-VE.getPerdida(dist));
                    if (capacidad[j] >= consumoTotal) {
                        posible = true;
                        cen = j;
                    }
                }
                if (posible) {
                    asignacion[i] = cen;
                    capacidad[cen] -= consumoTotal;
                }
            }
        }
        calcBeneficio();
    }

    public void genSolIniAsignadosTodos() throws Exception{
        for (int i=0; i<asignacion.length; ++i) {
            int cen = -1;
            double consFinal = -1;
            Cliente cliAux = cliList.get(i);
            double consumo = cliAux.getConsumo();
            double consumoTotal = -1;
            if (cliAux.getContrato() == 0) { // 0 => Cliente garantizado
                boolean posible = false;
                for (int j=0; j<capacidad.length && !posible; ++j) {
                    double dist = calcDist(cliAux, centList.get(j));
                    consumoTotal = consumo / (1 - VE.getPerdida(dist));
                    if (consumoTotal <= capacidad[j]) {
                        posible = true;
                        cen = j;
                        consFinal = consumo;
                    }
                }
                asignacion[i] = cen;
                capacidad[cen] -= consFinal;
            }

        }
        for (int i=0; i<asignacion.length; ++i) {
            Cliente cliAux = cliList.get(i);
            if (asignacion[i] == -1) {
                boolean posible = false;
                int cen = -1;
                double consumo = cliAux.getConsumo();
                double consumoTotal = -1;

                for (int j=0; j<capacidad.length && !posible; ++j) {
                    double dist = calcDist(cliAux, centList.get(j));

                    consumoTotal = consumo / (1-VE.getPerdida(dist));
                    if (capacidad[j] >= consumoTotal) {
                        posible = true;
                        cen = j;
                    }
                }
                if (posible) {
                    asignacion[i] = cen;
                    capacidad[cen] -= consumoTotal;
                }
            }
        }
        calcBeneficio();
    }

    public void genSolIniAleatoriaTodos() throws Exception{

        Random random = new Random();
        int bound = centList.size()-1;

        int n = asignacion.length;
        int i = random.nextInt(bound);
        int c = 0;


        while (c < n) {
            int cen = -1;
            double consFinal = -1;
            Cliente cliAux = cliList.get(i);
            double consumo = cliAux.getConsumo();
            double consumoTotal = -1;
            if (cliAux.getContrato() == 0) { // 0 => Cliente garantizado
                boolean posible = false;
                for (int j=0; j<capacidad.length && !posible; ++j) {
                    double dist = calcDist(cliAux, centList.get(j));
                    consumoTotal = consumo / (1 - VE.getPerdida(dist));
                    if (consumoTotal <= capacidad[j]) {
                        posible = true;
                        cen = j;
                        consFinal = consumo;
                    }
                }
                asignacion[i] = cen;
                capacidad[cen] -= consFinal;
            }
            i++;
            c++;
            if (i >= n) i = 0;
        }

        i = random.nextInt(bound);
        c = 0;
        while (c < n) {
            Cliente cliAux = cliList.get(i);
            if (asignacion[i] == -1) {
                boolean posible = false;
                int cen = -1;
                double consumo = cliAux.getConsumo();
                double consumoTotal = -1;

                for (int j=0; j<capacidad.length && !posible; ++j) {
                    double dist = calcDist(cliAux, centList.get(j));

                    consumoTotal = consumo / (1-VE.getPerdida(dist));
                    if (capacidad[j] >= consumoTotal) {
                        posible = true;
                        cen = j;
                    }
                }
                if (posible) {
                    asignacion[i] = cen;
                    capacidad[cen] -= consumoTotal;
                }
            }
            i++;
            c++;
            if (i >= n) i = 0;
        }
        calcBeneficio();
    }


    /*  Calcula el beneficio del estado actual
        Primero iteramos sobre los clientes para calcular ganancias (o perdidas, si no son abastecidos)
        Y luego iteramos sobre las centrales para ver cuanto nos ha costado la energia producida
    */
    public void calcBeneficio() throws Exception{
        //Reseteamos beneficio por si acaso
        beneficio = 0;

        //Recorremos todos los clientes
        for (int i = 0; i < asignacion.length; ++i) {

            Cliente cliTemp = cliList.get(i);
            int tipo = cliTemp.getTipo(); //Tipo = G, MG, XG
            int contrato = cliTemp.getContrato();   //Contrato = prioridad
            double consumo = cliTemp.getConsumo();

            //Si no está asignado la indemnización siempre son 50e * MW, pero lo pongo asi para "usar las consultoras dadas"
            if (asignacion[i] == -1){
                beneficio -= VE.getTarifaClientePenalizacion(tipo)*consumo;
            }
            //Si está asignado:
            else {
                if (contrato == 0) // 0 => Garantizado
                    beneficio += consumo*VE.getTarifaClienteGarantizada(tipo);
                else
                    beneficio += consumo*VE.getTarifaClienteNoGarantizada(tipo);

            }
        }

        //Calculo perdidas por central
        for (int i = 0; i < capacidad.length; ++i) {
            Central cenTemp = centList.get(i);
            int tipo = cenTemp.getTipo();   //Tipo = A, B, C

            //Si la central está apagada, es decir, produccion total = restante por asiganar
            if (cenTemp.getProduccion() == capacidad[i]) {
                beneficio -= VE.getCosteParada(tipo);
            }
            //En cambio, si está en marcha, pagamos toda la electricidad que pueda generar
            else {
                beneficio -= (VE.getCosteMarcha(tipo) + VE.getCosteProduccionMW(tipo)*cenTemp.getProduccion());
            }
        }
        lostBen = calcLostBen();
    }


    /*  Calcula el beneficio perdido del estado actual
    Iteramos sobre los clientes para calcular las perdidas que hay por distancias entre ellos y sus centrales
    */
    public double calcLostBen() throws Exception{
        double tmp = 0;
        for (int i = 0; i < cliList.size(); ++i) {

            Cliente cli = cliList.get(i);

            int icentral = asignacion[i];
            double consumo = cli.getConsumo();

            if (icentral != -1) {
                Central cent = centList.get(icentral);
                double consumoT = consumo / (1-VE.getPerdida(calcDist(cli, cent)));
                int tipoCentral = cent.getTipo();
                tmp += (consumoT-consumo)*VE.getCosteProduccionMW(tipoCentral);
            }
        }
        return tmp;
    }

    //Devuelve la distancia entre un cliente y una central.
    //Pasar por direccion? (Eficiencia)
    public double calcDist(Cliente cl, Central ce) {
        return Math.sqrt(
                Math.pow(cl.getCoordX() - ce.getCoordX(), 2) +
                        Math.pow(cl.getCoordY() - ce.getCoordY(), 2)
        );
    }

    public boolean isCenEmpty(int ice){
        return (capacidad[ice] == centList.get(ice).getProduccion());
    }



    //------ Operadores ----------------------


    public Boolean removeCentral(int icl) throws Exception{

        //Comprobacion
        if (asignacion[icl] == -1 || cliList.get(icl).getContrato() == 0) return false;


        int iOldCentral = asignacion[icl];          //Indice central antigua
        Central oldCentral = centList.get(iOldCentral); //Central antigua
        Cliente cl = cliList.get(icl);                  //Cliente

        double disOldCentral = calcDist(cl, oldCentral);    //Distancia cliente - oldCentral

        double consumo = cl.getConsumo();                   //Consumo base del cliente
        double consumoT = consumo/(1-VE.getPerdida(disOldCentral));

        capacidad[iOldCentral] += consumoT;

        asignacion[icl] = -1;

        //-----------calcular beneficio

        int tipoCE = oldCentral.getTipo();

        if (isCenEmpty(iOldCentral)) {
            beneficio += VE.getCosteMarcha(tipoCE) + oldCentral.getProduccion()*VE.getCosteProduccionMW(tipoCE);
            beneficio -= VE.getCosteParada(tipoCE);
        }

        //Le hemos de pagar la indemnizacion y nos deja de pagar la energia
        beneficio -= consumo*VE.getTarifaClientePenalizacion(cl.getTipo());
        beneficio -= consumo*VE.getTarifaClienteNoGarantizada(cl.getTipo());

        return true;
    }


    /*Mueve un cliente, asignado o no asignado, a una central
        pre:
            icl = indice del cliente
            inewCentral = indice de la nueva central

        post:
            Se asigna al cliente icl la central inewCentral
            Se actualiza la capacidad de todas las centrales afectadas
            Se actualiza el beneficio del estado
    */
    public Boolean move(int icl, int inewCentral) throws Exception{

        Cliente cl = cliList.get(icl);
        int tipoCl = cl.getTipo();
        double consumo = cl.getConsumo();

        Central newCentral = centList.get(inewCentral); //Nueva central
        double disNewCentral = calcDist(cl, newCentral);    //Distancia cliente - newCentral
        double consumoNuevo = consumo/(1-VE.getPerdida(disNewCentral));


        //Comprobacion de si es posible el move
        if (capacidad[inewCentral] < consumoNuevo) return false;


        int iOldCentral = asignacion[icl];          //Indice central antigua, si -1 no estaba asignado

        /*  TRATAMIENTO POR CASOS SOBRE DONDE ERA CLIENTE:
            - No asignado
            - Asignado
        */

        //Si no esta asignado
        if (iOldCentral == -1) {
            beneficio += consumo*VE.getTarifaClientePenalizacion(tipoCl);
            beneficio += consumo*VE.getTarifaClienteNoGarantizada(tipoCl);
        }
        if (iOldCentral == -1) {
            beneficio += consumo*VE.getTarifaClientePenalizacion(tipoCl);
            if (cl.getContrato() == 0) // 0 => Garantizado
                beneficio += consumo*VE.getTarifaClienteGarantizada(tipoCl);
            else
                beneficio += consumo*VE.getTarifaClienteNoGarantizada(tipoCl);
        }


        //Si esta asignado
        else {

            Central oldCentral = centList.get(iOldCentral); //Central antigua
            double disOldCentral = calcDist(cl, oldCentral);    //Distancia cliente - oldCentral

            int tipoOldCe = oldCentral.getTipo();

            double consumoTotal = consumo/(1-VE.getPerdida(disOldCentral));

            lostBen -= (consumoTotal-consumo)*VE.getCosteProduccionMW(tipoOldCe);

            //Y añadimos esa capacidad
            capacidad[iOldCentral] += +consumoTotal;

            //Si la hemos vaciado...
            if (isCenEmpty(iOldCentral)){
                beneficio -= VE.getCosteParada(tipoOldCe);
                beneficio += VE.getCosteMarcha(tipoOldCe) + oldCentral.getProduccion()*VE.getCosteProduccionMW(tipoOldCe);
            }
        }

        //AQUI YA CONJUNTO

        int tipoNCe = newCentral.getTipo();

        //Si estaba vacia la ponemos en marcha
        if (isCenEmpty(inewCentral)) {
            beneficio += VE.getCosteParada(tipoNCe);
            beneficio -= (VE.getCosteMarcha(tipoNCe) + newCentral.getProduccion()*VE.getCosteProduccionMW(tipoNCe));
        }

        //Realizamos la asignacion
        asignacion[icl] = inewCentral;

        //Restamos capacidad a la central
        capacidad[inewCentral] -= consumoNuevo;

        lostBen += (consumoNuevo-consumo) * VE.getCosteProduccionMW(tipoNCe);

        return true;
    }

    /*  Devuelve true si se han podido cambiar, es decir:
        En todos los casos menos si;
            - Uno es garantizado y el otro no asignado
            - Ambos son no asignados
            - No caben los consumos pertinentes
    */
    public Boolean swap(int ic1, int ic2) throws Exception{

        Cliente c1 = cliList.get(ic1);
        Cliente c2 = cliList.get(ic2);

        int contrato1 = c1.getContrato();
        int contrato2 = c2.getContrato();

        int tipo1 = c1.getTipo();
        int tipo2 = c2.getTipo();

        double consumo1 = c1.getConsumo();
        double consumo2 = c2.getConsumo();


        //CASO SWAP 1 (NO ASIGNADO) Y 2 (SI ASIGNADO)
        if (asignacion[ic1] == -1) {

            if (asignacion[ic2] == -1) return false;

            int icentral2 = asignacion[ic2];
            Central central2 = centList.get(icentral2);

            double d1 = calcDist(c1, central2);
            double d2 = calcDist(c2, central2);

            double consumo1Total = consumo1/(1-VE.getPerdida(d1));
            double consumo2Total = consumo2/(1-VE.getPerdida(d2));

            if ((capacidad[icentral2] + consumo2Total) < consumo1Total) return false;

            //Todo comprobado, hacemos la chicha

            //1. Dejamos de pagar la indemnizacion de c1 pero pagamos la de c2
            beneficio += consumo1*VE.getTarifaClientePenalizacion(tipo1);
            beneficio -= consumo2*VE.getTarifaClientePenalizacion(tipo2);

            //2. Dejamos de cobrar del 2 pero cobramos del 1
            if (contrato1 == 0)
                beneficio += consumo1*VE.getTarifaClienteGarantizada(tipo1);
            else
                beneficio += consumo1*VE.getTarifaClienteNoGarantizada(tipo1);


            if (contrato1 == 0)
                beneficio -= consumo2*VE.getTarifaClienteGarantizada(tipo2);
            else
                beneficio -= consumo2*VE.getTarifaClienteNoGarantizada(tipo2);

            //3. Realizamos las asignaciones
            asignacion[ic1] = icentral2;
            asignacion[ic2] = -1;

            //4. Actualizamos la capacidad
            capacidad[icentral2] += (consumo2Total - consumo1Total);

            lostBen -= (consumo2Total-consumo2)*VE.getCosteProduccionMW(central2.getTipo());

            lostBen += (consumo1Total-consumo1)*VE.getCosteProduccionMW(central2.getTipo());

            return true;
        }

        //CASO SWAP 2 (NO ASIGNADO) Y 1 (SI ASIGNADO)
        if (asignacion[ic2] == -1) {

            if (asignacion[ic1] == -1) return false;

            int icentral1 = asignacion[ic1];
            Central central1 = centList.get(icentral1);

            double d1 = calcDist(c1, central1);
            double d2 = calcDist(c2, central1);

            double consumo1Total = consumo1/(1-VE.getPerdida(d1));
            double consumo2Total = consumo2/(1-VE.getPerdida(d2));

            if (capacidad[icentral1] + consumo1Total < consumo2Total) return false;

            //Todo comprobado, hacemos la chicha

            //1. Dejamos de pagar la indemnizacion de c2 pero pagamos la de c1
            beneficio -= consumo1*VE.getTarifaClientePenalizacion(tipo1);
            beneficio += consumo2*VE.getTarifaClientePenalizacion(tipo2);

            //2. Dejamos de cobrar del 1 pero cobramos del 2
            if (contrato1 == 0)
                beneficio -= consumo1*VE.getTarifaClienteGarantizada(tipo1);
            else
                beneficio -= consumo1*VE.getTarifaClienteNoGarantizada(tipo1);


            if (contrato1 == 0)
                beneficio += consumo2*VE.getTarifaClienteGarantizada(tipo2);
            else
                beneficio += consumo2*VE.getTarifaClienteNoGarantizada(tipo2);

            //3. Realizamos las asignaciones
            asignacion[ic1] = -1;
            asignacion[ic2] = icentral1;

            //4. Actualizamos la capacidad
            capacidad[icentral1] += (consumo1Total - consumo2Total);

            lostBen -= (consumo1Total-consumo1)*VE.getCosteProduccionMW(central1.getTipo());

            lostBen += (consumo2Total-consumo2)*VE.getCosteProduccionMW(central1.getTipo());

            return true;

        }

        //AQUI ESTAMOS EN EL CASO DE AMBOS SON ASIGNADOS

        int icentral1 = asignacion[ic1];
        int icentral2 = asignacion[ic2];

        Central central1 = centList.get(icentral1);
        Central central2 = centList.get(icentral2);

        int tipocentral1 = central1.getTipo();
        int tipocentral2 = central2.getTipo();

        double d1A = calcDist(c1, central1);
        double d1N = calcDist(c1, central2);

        double d2A = calcDist(c2, central2);
        double d2N = calcDist(c2, central1);


        double c1A = consumo1/(1-VE.getPerdida(d1A));
        double c1N = consumo1/(1-VE.getPerdida(d1N));

        double c2A = consumo2/(1-VE.getPerdida(d2A));
        double c2N = consumo2/(1-VE.getPerdida(d2N));

        //Comprobamos si caben
        if (capacidad[icentral1] < c2N || capacidad[icentral2] < c1N) return false;

        //Actualizamos asignaciones
        asignacion[ic1] = icentral2;
        asignacion[ic2] = icentral1;

        //Actualizamos capacidades
        capacidad[icentral1] += (c1A - c2N);
        capacidad[icentral2] += (c2A - c1N);

        lostBen -= (c1A - consumo1) * VE.getCosteProduccionMW(tipocentral1);
        lostBen -= (c2A - consumo2) * VE.getCosteProduccionMW(tipocentral2);

        lostBen += (c1N - consumo1) * VE.getCosteProduccionMW(tipocentral2);

        lostBen += (c2N - consumo2) * VE.getCosteProduccionMW(tipocentral1);

        return true;
    }

    //Per fer cerca local
    public boolean is_goal(){
        return false;
    }


    //Heuristica beneficio - lostBen que calcula el lostBen iterativamente (no usada)
    public double getHeuristic() throws Exception{

        int lostBen = 0;
        for (int i = 0; i < cliList.size(); ++i) {

            int icentral = asignacion[i];

            if (icentral != -1) {
                double consumo = cliList.get(i).getConsumo();
                double consumoT = consumo / (1-VE.getPerdida(calcDist(cliList.get(i), centList.get(icentral))));

                int tipoCentral = centList.get(icentral).getTipo();

                lostBen += (consumoT-consumo)*VE.getCosteProduccionMW(tipoCentral);
            }
        }

        return beneficio - lostBen;
    }

    //Heurística beneficio - entropia (calcula la entropia iterando dos veces por las centrales)
    public double getHeuristic2() throws Exception{

        int m = centList.size();

        double[] perc = new double[m+1];

        for (int i = 0; i < m; ++i) {
            perc[i] = capacidad[i] /centList.get(i).getProduccion();
        }

        double entropy = 0.0;

        for (int i = 1; i <= m; ++i) {
            double p = perc[i] / m;
            if (perc[i] > 0)
                entropy -= p * Math.log(p) / Math.log(2);
        }
        return beneficio - entropy;
    }

    //Heurística beneficio + goodBen, descartada por malos resultados, calcula iterativamente el goodBen por cada cliente
    public double getHeuristic3() throws Exception{

        int goodBen = 0;

        for (int i = 0; i < cliList.size(); ++i) {

            int icentral = asignacion[i];

            if (icentral != -1) {
                double consumo = cliList.get(i).getConsumo();
                int tipoCentral = centList.get(icentral).getTipo();
                goodBen += consumo*VE.getCosteProduccionMW(tipoCentral);
            }
        }

        return beneficio + goodBen;
    }

    //heuristica beneficio - lostBen usando los parámetros de la clase, heuristica definitiva
    public double getHeuristic5() throws Exception{
        return beneficio - lostBen;
    }

    //-----GETTERS

    public Centrales getCentList() {
        return centList;
    }

    public int getCentral(int i) {
        return asignacion[i];
    }

    public int getNClientes() {
        return asignacion.length;
    }

    public int getNCentrales() {
        return capacidad.length;
    }

    public double getBEneficio() {
        return beneficio;
    }

    public double getLostBen() {
        return lostBen;
    }

    public int[] getAsignacion() {
        return asignacion;
    }

    public double[] getCapacidad() {
        return capacidad;
    }

    public double getCapCen(int i) {
        return capacidad[i];
    }

    public double getPenalizacion() {
        return penalizacion;
    }

    public void genSolIniVacia() throws Exception {
        calcBeneficio();
    }


    //funcion usada para debugar el beneficio durante la fase de experimentacion
    public double debugBeneficio() throws Exception{
        //Reseteamos beneficio por si acaso
        double temp = 0;

        //Recorremos todos los clientes
        for (int i = 0; i < asignacion.length; ++i) {

            Cliente cliTemp = cliList.get(i);
            int tipo = cliTemp.getTipo(); //Tipo = G, MG, XG
            int contrato = cliTemp.getContrato();   //Contrato = prioridad
            double consumo = cliTemp.getConsumo();

            //Si no está asignado la indemnización siempre son 50e * MW, pero lo pongo asi para "usar las consultoras dadas"
            if (asignacion[i] == -1){
                temp -= consumo*VE.getTarifaClientePenalizacion(tipo);
            }
            //Si está asignado:
            else {
                if (contrato == 0) // 0 => Garantizado
                    temp += consumo*VE.getTarifaClienteGarantizada(tipo);
                else
                    temp += consumo*VE.getTarifaClienteNoGarantizada(tipo);
            }
        }

        //Calculo perdidas por central
        for (int i = 0; i < capacidad.length; ++i) {
            Central cenTemp = centList.get(i);
            int tipo = cenTemp.getTipo();   //Tipo = A, B, C

            //Si la central está apagada, es decir, produccion total = restante por asiganar
            if (cenTemp.getProduccion() == capacidad[i]) {
                temp -= VE.getCosteParada(tipo);
            }
            //En cambio, si está en marcha, pagamos toda la electricidad que pueda generar
            else {
                temp -= (VE.getCosteMarcha(tipo) + VE.getCosteProduccionMW(tipo)*cenTemp.getProduccion());
            }
        }
        return temp;
    }

    //devuelve si todos los clientes garantizados tienen centrales asignadas
    public boolean allAssig() {
        int n = cliList.size();
        for (int i = 0; i < n; ++i) {
            if (asignacion[i] == -1
                    && cliList.get(i).getContrato() == 0
            ) return false;
        }
        return true;
    }

    //devuelve el numero de clientes asignados
    public int getAssig() {
        int n = cliList.size();
        int c = 0;
        for (int i = 0; i < n; ++i) {
            if (asignacion[i] != -1) c++;
        }
        return c;
    }

    //devuelve la suma de capacidad libre entre las centrales
    public double getWastedCap() {
        int m = centList.size();
        double waste = 0.0;
        for (int i = 0; i < m; ++i) {
            if (centList.get(i).getProduccion() != capacidad[i])
                waste += capacidad[i];
        }
        return waste;
    }

    //devuelve el numero de centrales vacias
    public int getEmptyCents() {
        int m = centList.size();
        int c = 0;
        for (int i = 0; i < m; ++i)
            if (isCenEmpty(i)) ++c;

        return c;
    }

    //devuelve si el estado es correcto
    public boolean isCorrectSolution() {

        double sumaNec = 0.0;

        //Primero compruebo que todos los asignados tengan suministro
        int n = cliList.size();
        for (int i = 0; i < n; ++i) {

            Cliente cl = cliList.get(i);

            if (cl.getContrato() == 0 && asignacion[i] == -1)
                return false;

            if (asignacion[i] != -1)
                sumaNec = cl.getConsumo() * VE.getPerdida(calcDist(cl, centList.get(asignacion[i])));
        }

        double sumaProd = 0.0;

        //Luego que el suministro sea valido
        int m = centList.size();
        for (int i = 0; i < m; ++i) {
            if (capacidad[i] < 0 || capacidad[i] > centList.get(i).getProduccion())
                return false;
            sumaProd += centList.get(i).getProduccion();
        }


        return sumaNec <= sumaProd;
    }

    //devuelve el numero de centrales que tienen por lo menos un cliente asignado
    public int getUsedCents() {
        int m = centList.size();
        int c = 0;
        for (int i = 0; i < m; ++i)
            if (!isCenEmpty(i)) ++c;

        return c;
    }

    public double getHeuristicEmpty() throws Exception{
        calcBeneficio();
        double lostBen = 0;
        for (int i = 0; i < cliList.size(); ++i) {

            int icentral = asignacion[i];

            if (icentral != -1) {
                double consumo = cliList.get(i).getConsumo();
                double consumoT = consumo / (1.0-VE.getPerdida(calcDist(cliList.get(i), centList.get(icentral))));

                int tipoCentral = centList.get(icentral).getTipo();

                lostBen += (consumoT-consumo)*VE.getCosteProduccionMW(tipoCentral);
            }
        }

        double ben =  beneficio - Math.pow(lostBen, 2);
        double pen = getGNoAssig() *  penalizacion;
        return ben - pen;
    }

    //devuelve el numero de clientes garantizados no asignados
    public int getGNoAssig() {
        int c = 0;
        for (int i = 0; i < cliList.size(); ++i) {
            if (asignacion[i] == -1 && cliList.get(i).getContrato() == 0)
                ++c;
        }
        return c;
    }



}