import com.realexpayments.hpp.sdk.RealexException;
import com.realexpayments.remote.sdk.RealexClient;
import com.realexpayments.remote.sdk.RealexServerException;
import com.realexpayments.remote.sdk.domain.Card;
import com.realexpayments.remote.sdk.domain.Cvn;
import com.realexpayments.remote.sdk.domain.payment.AutoSettle;
import com.realexpayments.remote.sdk.domain.payment.PaymentRequest;
import com.realexpayments.remote.sdk.domain.payment.PaymentResponse;
import com.realexpayments.remote.sdk.http.HttpConfiguration;

/**
 * Created by Oliver Poole(12022846) on 11/03/2016.
 */
public class PaymentHandler {

    public PaymentHandler() {}

    public String handlePayment(String expDate, long number, String name, String cvn, long purchaseValue, long markup) {

        Card card = new Card()
                .addExpiryDate(expDate)
                .addNumber("" + number)
                .addType(Card.CardType.VISA)
                .addCardHolderName(name)
                .addCvn(cvn)
                .addCvnPresenceIndicator(Cvn.PresenceIndicator.CVN_PRESENT);

        // First request to merchant
        PaymentRequest merchantRequest = new PaymentRequest()
                .addMerchantId("hackathon25")
                .addType(PaymentRequest.PaymentType.AUTH)
                .addAmount(purchaseValue)
                .addCurrency("GBP")
                .addCard(card)
                .addAutoSettle(new AutoSettle().addFlag(AutoSettle.AutoSettleFlag.TRUE))
                .addAccount("Account1");

        // First request to merchant
        PaymentRequest markupRequest = new PaymentRequest()
                .addMerchantId("hackathon25")
                .addType(PaymentRequest.PaymentType.AUTH)
                .addAmount(markup)
                .addCurrency("GBP")
                .addCard(card)
                .addAutoSettle(new AutoSettle().addFlag(AutoSettle.AutoSettleFlag.TRUE))
                .addAccount("Account2");


        HttpConfiguration httpConfiguration = new HttpConfiguration();
        httpConfiguration.setEndpoint("https://epage.sandbox.payandshop.com/epage-remote.cgi");


        RealexClient client = new RealexClient("secret", httpConfiguration);

        try {
            PaymentResponse merchantResponse = client.send(merchantRequest);
            PaymentResponse markupResponse = client.send(markupRequest);

            return "MERCHANT: " + merchantResponse.getMessage() + "MARKUP: " + markupResponse.getMessage();
        }
        catch (RealexServerException e) {
            return e.toString();
        }
        catch (RealexException e) {
            return e.toString();
        }

    }

}
