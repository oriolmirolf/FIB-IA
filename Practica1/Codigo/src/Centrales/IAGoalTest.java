package Centrales;

import aima.search.framework.GoalTest;

/**
 * Created by bejar on 17/01/17.
 */
public class IAGoalTest implements GoalTest {

    public boolean isGoalState(Object state){

        return((IAEstado) state).is_goal();
    }
}
