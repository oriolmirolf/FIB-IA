package Centrales;

import IA.Energia.TestEnergia;
import aima.search.framework.HeuristicFunction;

import java.util.logging.Level;
import java.util.logging.Logger;

public class IAHeuristicFunction implements HeuristicFunction {

    public double getHeuristicValue(Object n){
        double h = 0.0;
        try {
            h = -((IAEstado) n).getHeuristic5();
        }
        catch (Exception var22) {
            Logger.getLogger(TestEnergia.class.getName()).log(Level.SEVERE, (String)null, var22);
        }
        return h;
    }
}