/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
const showToast = (msg) => {
    Toastify({
        text: msg,
        className: "card border border-1 rounded-3 shadow-sm fw-bold p-5",
        duration: 4000,
        gravity: "bottom",
        position: "right",
        style: {
            background: "white",
            color: "black"
        }
    }).showToast();
};
