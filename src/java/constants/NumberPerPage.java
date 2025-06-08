/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constants;

/**
 *
 * @author hoaht
 */
public enum NumberPerPage {
    SIZE(12);

    private final int value;

    NumberPerPage(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}


