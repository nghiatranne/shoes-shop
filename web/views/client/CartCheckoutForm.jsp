<%-- 
    Document   : ListBook
    Created on : Mar 2, 2024, 3:27:57 AM
    Author     : hoaht
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>

            <jsp:include page="layout/navigation.jsp"/>

            <section class="pt-5 pb-9">
                <div class="container-small cart">
                    <h2 class="mb-5">Shipping Info</h2>
                    <div class="mb-3">
                        <c:if test="${error_quantity}">
                            <span class="badge badge-phoenix fs--2 badge-phoenix-warning">
                                <span class="badge-label">The quantity in stock is not enough!</span>
                                <span class="ms-1" data-feather="alert-octagon" style="height:12.8px;width:12.8px;"></span>
                            </span>
                        </c:if>
                    </div>
                    <div class="row">
                        <div class="col-lg-7 mb-4 mb-lg-0">
                            <div class="card mb-2 rounded-0">
                                <div class="xBNaac"></div>
                                <div class="pt-3 pb-2">
                                    <div class="d-flex justify-content-between mb-3 px-3">
                                        <div class="d-flex align-items-end">
                                            <span class="text-warning" data-feather="map-pin" style="height: 35px; width: 35px;"></span>
                                            <h3 class="text-warning">Shipping Address</h3>
                                        </div>

                                        <button class="btn btn-phoenix-primary px-8 px-sm-11" type="button" data-bs-toggle="modal" data-bs-target="#verticallyCentered">CHANGE ADDRESS</button>
                                    </div>
                                    <div class="border rounded-2 mx-2 d-flex flex-column gap-1 p-3">
                                        <label class="form-label fs-0 text-1000 ps-0 text-none">Full name: ${address.fullName}</label>
                                        <label class="form-label fs-0 text-1000 ps-0 text-none">Telephone: ${address.tel}</label>
                                        <label class="form-label fs-0 text-1000 ps-0 text-none">Address: ${address.address}</label>
                                    </div>
                                </div>

                                <div class="">

                                </div>
                            </div>
                            <form id="informationForm" method="post" action="infor/save">
                                <div class="d-flex flex-column gap-2 mb-2">
                                    <c:forEach items="${paymentMethods}" var="p">
                                        <label class="d-flex align-items-center border p-2 rounded-2">
                                            <label for="inlineRadio1" class="me-2 ms-0">
                                                <img style="width: 50px;" class="mr-1" src="${p.imageLink}" alt="">
                                            </label>
                                            <label class="form-check-label fs-0 w-100" for="${p.method}">${p.note}</label>
                                            <div>
                                                <input class="form-check-input" id="${p.method}" type="radio" name="paymentMethod" value="${p.method}" ${p.method == 'COD' ? 'checked' : ''}/>
                                            </div>
                                        </label>
                                    </c:forEach>
                                </div>
                                <div class="row g-4">
                                    <div class="d-flex justify-content-between gap-2">
                                        <div class="">
                                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-phoenix-primary px-8 px-sm-11">
                                                CHANGE ORDER
                                            </a>
                                        </div>
                                        <div class="">
                                            <button class="btn btn-phoenix-primary px-8 px-sm-11" type="submit">PLACE ORDER</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="col-lg-5">
                            <div class="card mt-3 mt-lg-0 rounded-0">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <h3 class="mb-0">Summary</h3>
                                    </div>
                                    <div class="border-dashed border-bottom mt-4">
                                        <div id="list_book_category">
                                            <div class="row align-items-center mb-2 g-3">
                                                <div class="col-8 col-md-7 col-lg-8">
                                                    <div class="d-flex align-items-center">
                                                        <h6 class="fw-semi-bold text-1000 lh-base">The New Naturals </h6>
                                                    </div>
                                                </div>
                                                <div class="col-2 col-md-3 col-lg-2">
                                                    <h6 class="fs--2 mb-0">x1</h6>
                                                </div>
                                                <div class="col-2 ps-0">
                                                    <h5 class="mb-0 fw-semi-bold text-end text-lg-start">$398</h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="border-dashed border-bottom mt-4">
                                        <div class="d-flex justify-content-between mb-2">
                                            <h5 class="text-900 fw-semi-bold">Items subtotal: </h5>
                                            <h5 id="sub_total" class="text-900 fw-semi-bold"></h5>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between border-dashed-y pt-3">
                                        <h4 class="mb-0">Total :</h4>
                                        <h4 id="total" class="mb-0"></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </body>

    <div class="modal fade" id="verticallyCentered" tabindex="-1" data-bs-backdrop="static" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="d-flex flex-column gap-2">
                        <form class="m-0 p-0" action="${pageContext.request.contextPath}/choose-address" method="post">
                            <div id="address-table" class="d-flex flex-column gap-2 mb-2">
                                <c:forEach items="${addresses}" var="ad">
                                    <label class="d-flex align-items-center border p-2 rounded-2">
                                        <label class="form-check-label fs-0 w-100" for="${ad.id}">
                                            Full Name: ${ad.fullName} <br>
                                            Telephone: ${ad.tel} <br>
                                            Address: ${ad.address}
                                        </label>
                                        <div>
                                            <input class="form-check-input" id="${ad.id}" type="radio" name="idAddressChoose" value="${ad.id}" ${ad.choosen == true ? 'checked' : ''} />
                                        </div>
                                    </label>
                                </c:forEach>
                            </div>

                            <div class="d-flex gap-2">
                                <button class="btn btn-phoenix-secondary w-50" type="button" data-bs-dismiss="modal">Cancel</button>
                                <button class="btn btn-phoenix-primary w-50" type="button" data-bs-toggle="modal" data-bs-target="#createAddressModal">Create address</button>
                                <button class="btn btn-phoenix-primary w-50" type="submit">Choose</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="createAddressModal" tabindex="-1" data-bs-backdrop="static" aria-labelledby="createAddressModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="verticallyCenteredModalLabel">Create address</h5>
                    <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs--1"></span></button>
                </div>
                <div class="modal-body">
                    <div class="mb-2">
                        <label class="form-label" for="name">Full name </label>
                        <input class="form-control" name="name" id="name" placeholder="Name" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label" for="address">Address </label>
                        <input class="form-control" name="address" id="address" placeholder="Address" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label" for="tel">Telephone </label>
                        <input class="form-control" name="tel" id="tel" placeholder="Telephone" />
                    </div>
                    <div class="mb-2">
                        <input class="form-check-input me-1" id="isDefault" type="checkbox" name="isDefault"/>
                        <label class="form-check-label" for="isDefault">Set as default information</label>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-phoenix-primary me-1 mb-1 w-50" type="submit" id="btnCreateAddress">Create</button>
                        <button class="btn btn-phoenix-secondary me-1 mb-1 w-50" type="button" data-bs-toggle="modal" data-bs-target="#verticallyCentered" onclick="loadAddresses()">Choose address</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="import-js.jsp"/>

    <script>
        $(document).ready(function () {
            // Attach a submit event handler to the form or button click event
            $('#btnCreateAddress').on('click', function (e) {
                e.preventDefault();  // Prevent default form submission

                // Send the POST request to the server endpoint
                $.ajax({
                    url: '${pageContext.request.contextPath}/api/address/add', // The URL of the API endpoint on your server
                    type: 'POST',
                    contentType: "application/x-www-form-urlencoded",
                    data: {
                        address: $('#address').val(),
                        name: $('#name').val(),
                        telephone: $('#tel').val(),
                        isDefault: $('#isDefault').is(':checked')
                    },
                    success: function (data) {
                        showToast("Add new address successfull");

                        $('#address').val('');
                        $('#name').val('');
                        $('#tel').val('');
                        $('#isDefault').prop('checked', false);

                        if (data.address.choosen) {
                            window.location.reload();
                        }
                    },
                    error: function (xhr, status, error) {

                    }
                });
            });
        });
    </script>

    <script>
        function loadAddresses() {
            fetch('http://localhost:8080/BookShopping/api/addresses')
                    .then(res => res.json())
                    .then(data => {
                        var addressTable = document.getElementById('address-table');
                        addressTable.innerHTML = ''; // Clear previous contents

                        data.forEach(function (ad) {
                            // Determine if the input should be checked
                            var isChecked = ad.choosen ? 'checked' : '';

                            var addressHTML = '<label class="d-flex align-items-center border p-2 rounded-2">' +
                                    '<label class="form-check-label fs-0 w-100" for="' + ad.id + '">' +
                                    'Fullname: ' + ad.fullName + '<br>' +
                                    'Telephone: ' + ad.tel + '<br>' +
                                    'Address: ' + ad.address +
                                    '</label>' +
                                    '<div>' +
                                    // Apply the isChecked variable to the input element
                                    '<input class="form-check-input" id="' + ad.id + '" type="radio" name="idAddressChoose" value="' + ad.id + '" ' + isChecked + ' />' +
                                    '</div>' +
                                    '</label>';

                            addressTable.innerHTML += addressHTML; // Append new address entry
                        });
                    })
                    .catch(function (error) {
                        console.error('Error loading addresses:', error);
                        addressTable.innerHTML += '<p>Error loading addresses.</p>';
                    });
        }
    </script>

    <script>
        const isBook_cart_keys = (book_isbn) => {
            const book_cart_keys = JSON.parse(localStorage.getItem('book_cart_key')) || [];
            let quantity;
            book_cart_keys.forEach((item) => {
                if (item.book_isbn === book_isbn) {
                    quantity = item.quantity;
                }
            });
            return quantity;
        };

        const formatCurrency = (amount) => {
            return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
        };

        const loadData = () => {
            let carts = [];

            fetch('http://localhost:8080/BookShopping/api/books')
                    .then(res => res.json())
                    .then(data => {
                        data.forEach((el) => {
                            let quantity = isBook_cart_keys(el.isbn);

                            if (quantity) {
                                carts.push({
                                    book_isbn: el.isbn,
                                    image: el.image,
                                    title: el.title,
                                    author: el.authors[0].fullName,
                                    language: el.language,
                                    price: el.price,
                                    quantity: quantity
                                });
                            }
                        });

                        $('#list_book_category').empty();
                        $('#list_book_quantity').empty();
                        let total = 0;
                        carts.forEach((item) => {
                            total += item.price * item.quantity;
                            total = parseFloat(total.toFixed(2));
                            let newRow = '<div class="row align-items-center mb-2 g-3">' +
                                    '<div class="col-8 col-md-7 col-lg-7">' +
                                    '<div class="d-flex align-items-center">' +
                                    '<h6 class="fw-semi-bold text-1000 lh-base">' + item.title + '</h6>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="col-2 col-md-3 col-lg-2">' +
                                    '<h6 class="fs--2 mb-0">x' + item.quantity + '</h6>' +
                                    '</div>' +
                                    '<div class="col-3 ps-0">' +
                                    '<h5 class="mb-0 fw-semi-bold text-end text-lg-end pe-2">$' + formatCurrency(parseFloat(item.price * item.quantity)) + '</h5>' +
                                    '</div>' +
                                    '</div>';
                            let key_books = '<input type="text" name="book_isbn" value="' + item.book_isbn + '" />' +
                                    '<input type="text" name="quantity" value="' + item.quantity + '" />';
                            $('#list_book_quantity').append(key_books);
                            $('#list_book_category').append(newRow);
                        });

                        $('#sub_total').empty().append(formatCurrency(total));
                        $('#total').empty().append(formatCurrency(total));
                    })
                    .catch(error => {
                        console.log(error);
                    });
        };

        loadData();

        $("#informationForm").validate({
            errorPlacement: function (label, element) {
                label.addClass('invalid-feedback');
                label.insertAfter(element);
            },
            wrapper: 'div',
            rules: {
                fullName: {
                    required: true,
                    maxlength: 30
                },
                phone: {
                    required: true,
                    maxlength: 10
                },
                address_sender: {
                    required: true
                },
                address_receiver: {
                    required: true
                }
            },
            messages: {
                fullName: {
                    required: "Full name is cannot empty!",
                    maxlength: "Full name must be less than 30 characters!"
                },
                phone: {
                    required: "Telephone number is cannot empty!",
                    maxlength: "Telephone number must be 10 characters!"
                },
                address_sender: {
                    required: "Address sender is cannot empty!"
                },
                address_receiver: {
                    required: "Address receiver is cannot empty!"
                }
            }
        });
    </script>
</html>
