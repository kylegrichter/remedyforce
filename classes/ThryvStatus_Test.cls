@isTest (SeeAllData = true)
public class ThryvStatus_Test {
    public static testmethod void ThryvStatus_Test() {
        ThryvStatus controller = new ThryvStatus();
        controller.getcurrentCount();
        controller.getpastCount();
        controller.getupcomingCount();
        controller.getcurrent();
        controller.getpast();
        controller.getupcoming();
    }
}