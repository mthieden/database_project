import f21_02327.IndlaesVaccinationsAftaler;
import f21_02327.VaccinationsAftale;
import java.io.IOException;
import java.sql.*;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        // Database connection variables
        // -----------------------------------
        String host = "localhost"; //host is "localhost" or "127.0.0.1"
        String port = "3306"; //port is where to communicate with the RDBM system
        String database = "vaccineDB"; //database containing tables to be queried
        String cp = "utf8"; //Database codepage supporting danish (i.e. æøåÆØÅ)

        // Set username og password.
        // -------------------------
        String username = "root";		// Username for connection
        String password = "hunter2";	// Password for username

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?characterEncoding=" + cp;
        // -----------------------------------


        // Read the data file
        IndlaesVaccinationsAftaler laeser = new IndlaesVaccinationsAftaler();
        List<VaccinationsAftale> aftaler;

        try {
            aftaler = laeser.indlaesAftaler("vaccinationsaftaler.csv"); //args[0]
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }

        //database connection
        try
        {
            // Get a connection.
            // -----------------
            Connection connection = DriverManager.getConnection(url, username, password);

            // Create and execute Update.
            // --------------------------
            for(VaccinationsAftale aftale : aftaler) {
                PreparedStatement checkup = connection.prepareStatement("select CPR from Patient where CPR = ?");
                checkup.setLong (1, aftale.getCprnr());
                ResultSet rs =  checkup.executeQuery();

                if(!rs.absolute(1))
                {
                    PreparedStatement statement = connection.prepareStatement("insert into Patient values(?, ?, ?)");
                    statement.setLong(1, aftale.getCprnr());
                    statement.setString(2, aftale.getNavn());
                    statement.setString(3, aftale.getLokation());
                    statement.execute();
                }
            }

            // Close connection.
            // -----------------
            connection.close();

        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
/*

*/

    }
}