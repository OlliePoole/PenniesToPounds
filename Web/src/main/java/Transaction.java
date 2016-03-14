import java.util.HashMap;

/**
 * Created by Oliver Poole(12022846) on 11/03/2016.
 */
public class Transaction {

    private double totalValue;
    private double amountSaved;

    private String venue;
    private String time;

    private double lat;
    private double lon;

    public Transaction(double totalValue, double amountSaved, String venue, String time, double lat, double lon) {

        this.totalValue = totalValue;
        this.amountSaved = amountSaved;
        this.venue = venue;
        this.time = time;
        this.lat = lat;
        this.lon = lon;

    }

    public HashMap<String, String> toHashMap() {

        HashMap<String, String> map = new HashMap<>();
        map.put("total-value", "" + this.totalValue);
        map.put("amount-saved", "" + this.amountSaved);
        map.put("venue", this.venue);
        map.put("time", this.time);
        map.put("latitude", "" + this.lat);
        map.put("longitude", "" + this.lon);

        return map;
    }

}
