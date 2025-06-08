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

/**
 *
 * @author hoaht
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Role {
    private int id;
    private String role_name;
    private Date createDate;
    private Date updateDate;
}
