import f21_02327.IndlaesVaccinationsAftaler;
import f21_02327.VaccinationsAftale;
import java.io.IOException;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        IndlaesVaccinationsAftaler laeser = new IndlaesVaccinationsAftaler();
        try {
            List<VaccinationsAftale> aftaler = laeser.indlaesAftaler(args[0]);
            for(VaccinationsAftale aftale : aftaler) {
                System.out.println(aftale);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
