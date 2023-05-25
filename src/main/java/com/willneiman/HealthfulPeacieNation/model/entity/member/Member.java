package com.willneiman.HealthfulPeacieNation.model.entity.member;

import com.willneiman.HealthfulPeacieNation.model.entity.MemberQuestion;
import com.willneiman.HealthfulPeacieNation.model.entity.order.Order;
import com.willneiman.HealthfulPeacieNation.model.entity.Reservation;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@ToString
@EntityListeners(AuditingEntityListener.class)
public class Member {

    @Id @GeneratedValue
    @Column(name = "member_id")
    private Long id;

    private String username;
    private String password;
    private String name;
    private String phoneNumber;
    private String email;
    @CreatedDate
    private LocalDateTime registrationDate;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<Order> orders;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<Reservation> reservations;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<MemberQuestion> memberQuestions;

}
