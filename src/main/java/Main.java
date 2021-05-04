import f21_02327.IndlaesVaccinationsAftaler;
import f21_02327.VaccinationsAftale;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Main {
    public static void main(String[] args) {

        if(args.length == 0)
        {
            System.out.println("Using default file: vaccinationsaftaler.csv");
            insertDataFile("vaccinationsaftaler.csv");
        }
        else
        {
            for (int i = 0; i < args.length; i++) {
                System.out.println(args[i]);
                insertDataFile(args[i]);
            }
        }
    }

    public static void insertDataFile(String filename)
    {
        // Read the data file
        IndlaesVaccinationsAftaler laeser = new IndlaesVaccinationsAftaler();
        List<VaccinationsAftale> aftaler;

        try {
            aftaler = laeser.indlaesAftaler(filename);
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }

        try
        {
            Connection connection = getConnection();

            // Create and execute Update.
            // --------------------------
            for(VaccinationsAftale aftale : aftaler) {

                //Insert patients
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

                //Date and time formatting
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat simpleTimeFormat = new SimpleDateFormat("HH:mm:ss");

                //Insert appointments
                checkup = connection.prepareStatement("select appointment_id from Appointment where CPR = ? AND address = ? AND appointment_date = ?"); //
                checkup.setLong (1, aftale.getCprnr());
                checkup.setString (2, aftale.getLokation());
                checkup.setDate(3, java.sql.Date.valueOf(simpleDateFormat.format(aftale.getAftaltTidspunkt())));

                rs =  checkup.executeQuery();
                if(!rs.absolute(1))
                {
                    PreparedStatement statement = connection.prepareStatement("insert into Appointment(address, appointment_date, appointment_time, CPR) values(?, ?, ?, ?)");
                    statement.setString(1, aftale.getLokation());
                    statement.setDate(2, java.sql.Date.valueOf(simpleDateFormat.format(aftale.getAftaltTidspunkt())));
                    statement.setTime(3, java.sql.Time.valueOf(simpleTimeFormat.format(aftale.getAftaltTidspunkt())));
                    statement.setLong(4, aftale.getCprnr());

                    statement.execute();
                }
            }

            // Close connection.
            // -----------------
            connection.close();

        }
        catch (java.sql.SQLException e)
        {
            e.printStackTrace();
            return;
        }
    }

    public static Connection getConnection() throws java.sql.SQLException
    {
        // Database connection variables
        // -----------------------------------
        String host = "localhost"; //host is "localhost" or "127.0.0.1"
        String port = "3306"; //port is where to communicate with the RDBM system
        String database = "vaccineDB"; //database containing tables to be queried
        String cp = "utf8"; //Database codepage supporting danish (i.e. æøåÆØÅ)

        // Set username og password.
        // -------------------------
        String username = "JavaUser";		// Username for connection
        String password = "password1";	// Password for username

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?characterEncoding=" + cp;
        // -----------------------------------

        // Return a connection.
        return DriverManager.getConnection(url, username, password);
    }
}