/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
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

public class Feedback {
    private ProductVariantSize pvs;
    private Account account;
    private String content;
    private int ratedStar;
    private boolean status;
    private String image;
    private Date createDate;
    private Date updateDate;
}