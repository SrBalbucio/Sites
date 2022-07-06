package balbucio.bot;

import discord4j.core.DiscordClient;
import discord4j.core.GatewayDiscordClient;
import discord4j.core.event.domain.lifecycle.ReadyEvent;
import discord4j.core.event.domain.message.MessageCreateEvent;
import discord4j.core.object.entity.Message;
import discord4j.core.object.entity.User;
import reactor.core.publisher.Mono;
import reactor.netty.udp.UdpServer;

public class Main {

    private static User botUser = null;

    public static void main(String[] args) {
        console("Iniciando...");
        DiscordClient client = DiscordClient.create("");

        Mono<Void> login = client.withGateway((GatewayDiscordClient gateway) -> {
            // ReadyEvent example
            Mono<Void> printOnLogin = gateway.on(ReadyEvent.class, event ->
                            Mono.fromRunnable(() -> {
                                final User self = event.getSelf();
                                System.out.printf("Logged in as %s#%s%n", self.getUsername(), self.getDiscriminator());
                            }))
                    .then();

            // MessageCreateEvent example
            Mono<Void> handlePingCommand = gateway.on(MessageCreateEvent.class, event -> {
                Message message = event.getMessage();

                if (message.getContent().equalsIgnoreCase("!ping")) {
                    return message.getChannel().flatMap(channel -> channel.createMessage("pong!"));
                }

                return Mono.empty();
            }).then();

            // combine them!
            return printOnLogin.and(handlePingCommand);
        });

    }

    private static void console(String message){
        System.out.print("\n"+message);
    }
}
