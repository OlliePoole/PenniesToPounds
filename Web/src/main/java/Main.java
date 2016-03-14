import com.google.gson.Gson;
import ratpack.exec.Promise;

import ratpack.form.Form;
import ratpack.http.TypedData;
import ratpack.server.RatpackServer;
import ratpack.groovy.template.TextTemplateModule;
import ratpack.guice.Guice;
import ratpack.server.RatpackServer;
import ratpack.server.BaseDir;
import static ratpack.groovy.Groovy.groovyTemplate;
import static ratpack.groovy.Groovy.ratpack;
import ratpack.error.ServerErrorHandler;



import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;
import java.sql.*;
import com.heroku.sdk.jdbc.DatabaseUrl;

public class Main {
    public static void main(String... args) throws Exception {
        RatpackServer.start(b -> {
                    b
                            .serverConfig(s -> s
                                    .baseDir(BaseDir.find())
                                    .env()
                            )
                            .registry(
                                    Guice.registry(s -> s
                                            .module(TextTemplateModule.class, conf ->
                                                    conf.setStaticallyCompile(true)
                                            )
                                    )
                            )
                            .handlers(c -> {
                                c
                                        .post("makePayment", ctx -> {
                                            System.out.println("test");
                                            ctx.parse(Form.class).then((
                                                    s -> {
                                                        long originalValue = Long.parseLong(s.get("original-value"));
                                                        long markup = Long.parseLong(s.get("markup"));
                                                        long cardNumber = Long.parseLong(s.get("card-number"));
                                                        String cardName = s.get("card-name");
                                                        String cardExpiry = s.get("card-expiry");
                                                        String cardSvn = s.get("card-svn");


                                                        PaymentHandler handler = new PaymentHandler();
                                                        ctx.render(handler.handlePayment(cardExpiry, cardNumber, cardName, cardSvn, originalValue, markup));

                                                        Transaction transaction = new Transaction(1.24, 0.76, "Nimbus 2000", "10:45", 51.532620, -0.122509);

                                                        NotificationController controller = new NotificationController();
                                                        controller.sendNotification(transaction);
                                                    }
                                            ));



                                        })
                                        .files(f -> f.dir("public"));
                            });
                }
        );
    }
}
