package by.zemich.videohosting.dao.entities;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.UuidGenerator;

import java.util.*;

@Entity
@Getter
@Setter
@ToString(exclude = {"subscriptions"})
public class User {
    @Setter(AccessLevel.NONE)
    @Id
    @UuidGenerator(style = UuidGenerator.Style.TIME)
    private UUID id;
    private String username;
    private String name;
    private String email;

    @Setter(AccessLevel.NONE)
    @OrderBy("name DESC")
    @ManyToMany(
            cascade = {CascadeType.MERGE, CascadeType.PERSIST}
    )
    @JoinTable(
            name = "user_channel",
            joinColumns = @JoinColumn(name = "user_id",  referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "channel_id")
    )
    private Set<Channel> subscriptions = new HashSet<>();

    public void subscribe(Channel channel) {
        subscriptions.add(channel);
        channel.addSubscriber(this);
    }

    public void unsubscribe(Channel channel) {
        subscriptions.remove(channel);
        channel.removeSubscriber(this);
    }

}
