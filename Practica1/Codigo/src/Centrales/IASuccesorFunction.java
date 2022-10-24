package Centrales;

import IA.Energia.TestEnergia;
import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Random;

/**
 * Created by bejar on 17/01/17
 */


/**
 * Created by bejar on 17/01/17
 */
public class IASuccesorFunction implements SuccessorFunction {

    public List getSuccessors(Object state)  {
        ArrayList retval = new ArrayList();
        IAEstado board = (IAEstado) state;
        IAEstado newBoard = null;

        //REMOVE
        for (int i=0; i<board.getNClientes(); ++i) {

            for (int j=0; j<board.getNCentrales(); ++j) {
                newBoard = new IAEstado(board);
                try {
                    //MOVE
                    if (newBoard.move(i, j)) {
                        retval.add(new Successor(new String("El cliente " + i + " se mueve a la central " + j + "; beneficio = " + newBoard.getBEneficio()),newBoard));
                    }
                }
                catch (Exception var22) {
                    Logger.getLogger(TestEnergia.class.getName()).log(Level.SEVERE, (String)null, var22);
                }
            }
            for (int j=i+1; j<board.getNClientes(); ++j) {
                newBoard = new IAEstado(board);
                try {
                    //SWAP
                    if (newBoard.swap(i, j)) {
                        retval.add(new Successor(new String(
                                "Se han cambiado de centrales los clientes " + i + " y " + j + "; beneficio = " + newBoard.getBEneficio()),newBoard));
                    }
                }
                catch (Exception var22) {
                    Logger.getLogger(TestEnergia.class.getName()).log(Level.SEVERE, (String)null, var22);
                }
            }
        }
        return retval;
    }
}