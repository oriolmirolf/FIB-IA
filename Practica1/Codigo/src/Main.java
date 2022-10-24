import IA.Energia.Centrales;
import IA.Energia.Clientes;
import Centrales.IAEstado;
import Centrales.IAGoalTest;
import Centrales.IAHeuristicFunction;
import Centrales.IAHeuristicFunctionEmpty;
import Centrales.IASuccesorFunction;
import Centrales.IASuccesorFunctionSA;

import aima.search.framework.GraphSearch;
import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.AStarSearch;
import aima.search.informed.HillClimbingSearch;
import aima.search.informed.SimulatedAnnealingSearch;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

public class Main {

    public static void main(String[] args) throws Exception{

        // Algoritmos

        //printSimulatedAnnealing();
        printHillClimbing();

    }

    private static void printSimulatedAnnealing () throws Exception {
        long startTime = System.currentTimeMillis();

        /**
         *  For a problem to be solvable:
         *    count(0,prob) % 2 == count(0,sol) %2
         */
        //Config tablero
        int[] cent = new int[]{5, 10, 25};
        int ncl = 1000;
        double[] propc = new double[]{0.25, 0.30, 0.45};
        double propg = 0.75;
        int seed = 1234;

        //Config Simulated Annealing
        int steps = 300000;   //Número total de iteraciones
        int stiter = 100;  //Iteraciones por cada cambio de temperatura (ha de ser un divisor del anterior)
        int k = 125;       //Parámetro k de la función de aceptación de estados --> Cuanto mayor sea, mas tarda en empezar a decrecer la probabilidad de aceptación
        double lamb = 0.0001; //Parámetro lamda de la función de aceptación de estados --> Cuanto mayor sea, rapido decrece la temperatura

        //--Estado
        IAEstado board = new IAEstado(cent, ncl, propc, propg, seed);

        //--Estado xperimento 5
        //double penalizacion = 10000000000.0; //Penalizacion por cliene garantizado no asignado
        //IAEstado board = new IAEstado(cent, ncl, propc, propg, seed, penalizacion);


        //Ejecutar el algoritmo de solucion inicial
        //board.genSolIniVacia();
        //board.genSolIniOrdenada();
        //board.genSolIniOrdenadaTodos();
        board.genSolIniAsignadosTodos();
        //board.genSolIniAleatoriaTodos();

        // Create the Problem object
        //problema
        Problem p = new Problem(board,
                new IASuccesorFunctionSA(),
                new IAGoalTest(),
                new IAHeuristicFunction());
        //---problema experimento 5
        /*Problem p = new Problem(board,
                new IASuccesorFunctionSA(),
                new IAGoalTest(),
                new IAHeuristicFunctionEmpty());

         */

        // Instantiate the search algorithm
        Search alg = new SimulatedAnnealingSearch(steps, stiter, k, lamb);
        SearchAgent agent = new SearchAgent(p, alg);


        //OUTPUT
        printInstrumentation(agent.getInstrumentation());
        ((IAEstado) alg.getGoalState()).calcBeneficio();

        System.out.println("-----------------------------------");
        System.out.println("Beneficio: " + ((IAEstado) alg.getGoalState()).getBEneficio());
        System.out.println("Numero de asignados: " + ((IAEstado) alg.getGoalState()).getAssig());
        System.out.println("Numero de centrales usadas: " + ((IAEstado) alg.getGoalState()).getUsedCents());
        System.out.println("Centrales garanitzadas no asignadas: " + ((IAEstado) alg.getGoalState()).getGNoAssig());
        System.out.println("-----------------------------------");
    }

    private static void printHillClimbing () throws Exception {

        long startTime = System.currentTimeMillis();

        /**
         *  For a problem to be solvable:
         *    count(0,prob) % 2 == count(0,sol) %2
         */
        //Config tablero
        int [] cent = new int []{5, 10, 25};
        int ncl = 1000 ;
        double[] propc = new double []{0.25, 0.30, 0.45};
        double propg = 0.75;
        int seed = 1234 ;

        IAEstado board = new IAEstado(cent, ncl, propc, propg, seed);

        //Ejecucion del estado inicial
        //board.genSolIniAleatoria(seed);
        //board.genSolIniOrdenada();
        //board.genSolIniOrdenadaTodos();
        board.genSolIniAsignadosTodos();
        //board.genSolIniAleatoriaTodos();

        // Create the Problem object
        Problem p = new  Problem(board,
                new IASuccesorFunction(),
                new IAGoalTest(),
                new IAHeuristicFunction());

        // Instantiate the search algorithm
        Search alg = new HillClimbingSearch();

        // Instantiate the SearchAgent object
        SearchAgent agent = new SearchAgent(p, alg);

        // We print the results of the search
        System.out.println();
        printActions(agent.getActions());
        printInstrumentation(agent.getInstrumentation());

        // You can access also to the goal state using the

        System.out.println(alg.getGoalState());
        // method getGoalState of class Search

        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.println("Completado en: " + estimatedTime + " milisegundos");


        System.out.println("Numero de asignados: " + ((IAEstado) alg.getGoalState()).getAssig());
    }

    private static void printInstrumentation(Properties properties) {
        Iterator keys = properties.keySet().iterator();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }

    }

    private static void printActions(List actions) {
        for (int i = 0; i < actions.size(); i++) {
            String action = (String) actions.get(i);
            System.out.println(action);
        }
    }

}
