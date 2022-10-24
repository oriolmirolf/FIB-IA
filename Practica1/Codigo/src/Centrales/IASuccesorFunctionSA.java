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
public class IASuccesorFunctionSA implements SuccessorFunction {

    public List getSuccessors(Object state)  {
        ArrayList retval = new ArrayList();
        IAEstado board = (IAEstado) state;
        IAEstado newBoard = null;

        int seed = 0;
        Random rand = new Random();

        int n = board.getNClientes();
        int m = board.getNCentrales();

        double probMoveOld = (n-1.)/(2.*m+n+1.);
        double probSwapOld = 2.*m/(2.*m+n-1.);
        double total = n*m + n*(n-1.0)/2.0;
        double probMove = (n*m)/(total);          //0.0741
        double probSwap = (n*(n-1.0)/2.0)/(total);    //0.9258


        if (rand.nextDouble(probMove + probSwap) > probMove) {  //do swap
            int i = rand.nextInt(n);
            int j = rand.nextInt(n);
            newBoard = new IAEstado(board);
            try {
                int count = 0;
                while (i == j || !newBoard.swap(i,j)) {
                    if (count > 2*n*n) {
                        i = rand.nextInt(n);
                        j = rand.nextInt(m);
                        while(!newBoard.move(i,j)) {
                            i = rand.nextInt(n);
                            j = rand.nextInt(m);
                        }
                        retval.add(new Successor(new String("El cliente " + i + " se mueve a la central " + j + "; beneficio = " + newBoard.getBEneficio()),newBoard));
                        return retval;
                    }
                    else {
                        i = rand.nextInt(n);
                        j = rand.nextInt(n);
                        count++;
                    }
                }
                retval.add(new Successor(new String("Se han cambiado de centrales los clientes " + i + " y " + j + "; beneficio = " + newBoard.getBEneficio()),newBoard));
            }
            catch (Exception var22) {
                Logger.getLogger(TestEnergia.class.getName()).log(Level.SEVERE, (String)null, var22);
            }
        }
        else {
            int i = rand.nextInt(n);
            int j = rand.nextInt(m);
            newBoard = new IAEstado(board);
            try {
                int count = 0;
                while(!newBoard.move(i,j)) {
                    if (count > n*n*n) {
                        i = rand.nextInt(n);
                        j = rand.nextInt(n);
                        while (i == j || !newBoard.swap(i,j)) {
                            i = rand.nextInt(n);
                            j = rand.nextInt(n);

                        }
                        retval.add(new Successor(new String("Se han cambiado de centrales los clientes " + i + " y " + j + "; beneficio = " + newBoard.getBEneficio()),newBoard));
                        return retval;
                    }
                    i = rand.nextInt(n);
                    j = rand.nextInt(m);
                    count++;
                }
                retval.add(new Successor(new String("El cliente " + i + " se mueve a la central " + j + "; beneficio = " + newBoard.getBEneficio()),newBoard));
            }
            catch (Exception var22) {
                Logger.getLogger(TestEnergia.class.getName()).log(Level.SEVERE, (String)null, var22);
            }
        }
        return retval;
    }
}