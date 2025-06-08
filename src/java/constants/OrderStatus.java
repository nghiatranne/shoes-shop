/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constants;

/**
 *
 * @author phamh
 */
public enum OrderStatus {
    SUBMITTED, CONFIRMED, PACKAGING, SHIPPING, SHIPPED, COMPLETED, CANCELED, REJECTED;

    public static OrderStatus intToStatus(int value) {
        switch (value) {
            case 0: {
                return SUBMITTED;
            }
            case 1: {
                return CONFIRMED;
            }
            case 2: {
                return PACKAGING;
            }
            case 3:{
                return SHIPPING;
            }
            case 4: {
                return SHIPPED;
            }
            case 5: {
                return COMPLETED;
            }
            case -1: {
                return CANCELED;
            }
            case -2: {
                return REJECTED;
            }
            default:
                throw new AssertionError();
        }
    }

    public static int statusToInt(OrderStatus orderStatus) {
        switch (orderStatus) {
            case SUBMITTED: {
                return 0;
            }
            case CONFIRMED: {
                return 1;
            }
            case PACKAGING: {
                return 2;
            }
            case SHIPPING: {
                return 3;
            }
            case SHIPPED: {
                return 4;
            }
            case COMPLETED: {
                return 5;
            }
            case CANCELED: {
                return -1;
            }
            case REJECTED: {
                return -2;
            }
            default:
                throw new AssertionError();
        }
    }
    
    public static boolean isOrderStatus(String key) {
        OrderStatus[] values = OrderStatus.values();
        for (OrderStatus v : values) {
            if (key.equalsIgnoreCase(v.name())) return true;
        }
        return false;
    }
}
