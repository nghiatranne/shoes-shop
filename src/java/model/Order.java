/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import constants.OrderStatus;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author hoaht
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Order {
    private String order_id;
    private Date updateDate;
    private Date createDate;
    private OrderStatus status;
    private String note;
    private String fullName;
    private String email;
    private String receiveAddress;
    private String tel;
    
    private Account account;
    private PaymentMethod paymentMethod;
    
    private Set<OrderDetail> orderDetails = new HashSet<>();
    
    private boolean isPaid;
}
