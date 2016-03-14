/**
 * Created by Oliver Poole(12022846) on 12/03/2016.
 */
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import com.google.gson.Gson;

public class NotificationController {

    public NotificationController() {}

    public String sendNotification(Transaction transaction) {

        String oneSignalAPIKey = "54c5705b-3438-4020-880c-7ef08258d709";

        HttpURLConnection connection = null;
        try {
            //Create connection
            URL url = new URL("https://onesignal.com/api/v1/notifications");
            connection = (HttpURLConnection)url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Basic ZWUzY2Y1NmItOWViYi00OTgxLTkxOGEtOWIyODA5MDZjZDY4");

            connection.setUseCaches(false);
            connection.setDoOutput(true);

            HashMap<String, String> transactionMap = transaction.toHashMap();
            transactionMap.put("en", "");

            Gson gson = new Gson();

            HashMap<String, String> contentMap = new HashMap<>();
            contentMap.put("en", "This is a cool notification");

            HashMap<String, Object> map = new HashMap<>();
            map.put("app_id", oneSignalAPIKey);
            map.put("isIos", "" + true);
            map.put("contents", contentMap);
            map.put("data", transactionMap);

            map.put("included_segments", new String[]{"All"});

            String urlParameters = gson.toJson(map);


            //Send request
            DataOutputStream wr = new DataOutputStream (
                    connection.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.close();

            //Get Response
            InputStream is = connection.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(is));
            StringBuilder response = new StringBuilder(); // or StringBuffer if not Java 5+
            String line;
            while((line = rd.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            rd.close();
            return response.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }

    }
}

