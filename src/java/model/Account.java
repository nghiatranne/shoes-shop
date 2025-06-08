/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

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
public class Account {
    private int id;
    private String image;
    private String fullname;
    private String email;
    private String password;
    private String gender;
    private String address;
    private Date birthdate;
    private String telephone;
    private Boolean status;
    private Date createDate;
    private Date updateDate;
    private String token;

    private Set<Role> roles = new HashSet<>();
    private Set<Product> wishes = new HashSet<>();
    private Set<String> feedbacks = new HashSet<>();// fix later
    private Set<String> orders = new HashSet<>();// fix later
    private Set<String> carts = new HashSet<>();// fix later
    private Set<Post> posts = new HashSet<>();


    
}
