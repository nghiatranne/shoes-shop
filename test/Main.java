
import util.PasswordHasher;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author hoaht
 */
public class Main {
    public static void main(String[] args) {
        String hashedPassword = PasswordHasher.hashPassword("123");
        System.out.println(hashedPassword);
    }
}
