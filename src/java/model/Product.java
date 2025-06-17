/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**

 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Product {

    private int id;
    private String title;
    private String image;
    private String description;
    private Date createDate;
    private Date updateDate;
    private boolean status;
    private Brand brand;

    private Set<Category> categories = new HashSet<>();
    private List<ProductVariant> productvariants = new ArrayList<>();

}
