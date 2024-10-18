<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderSummary.aspx.cs" Inherits="Comp_peri_ecomm.OrderSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <style>
        .container {
            max-width: 960px;
        }

        .lh-condensed {
            line-height: 1.25;
        }
        /* Added style to align the state dropdown to the right */
        /* Added Flexbox layout to align the state dropdown to the right */
        

        /* Adjusting the width of the fields */
        .eight.wide.field,
        .four.wide.field {
            width: 48%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        // No changes in JavaScript as it remains static
        (function () {
            'use strict'

            window.addEventListener('load', function () {
                var forms = document.getElementsByClassName('needs-validation') < a href = "OrderSummary.aspx" > OrderSummary.aspx</a>

                    Array.prototype.filter.call(forms, function (form) {
                        form.addEventListener('submit', function (event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault()
                                event.stopPropagation()
                            }
                            form.classList.add('was-validated')
                        }, false)
                    })
            }, false)
        }())
    </script>
    <script>
        function validateForm() {
            var isValid = true;

            // Validate first name
            var firstName = document.getElementById("<%= firstName.ClientID %>").value;
            if (firstName.trim() === "") {
                document.getElementById("<%= firstName.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= firstName.ClientID %>").classList.remove("is-invalid");
            }

            // Validate last name
            var lastName = document.getElementById("<%= lastName.ClientID %>").value;
            if (lastName.trim() === "") {
                document.getElementById("<%= lastName.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= lastName.ClientID %>").classList.remove("is-invalid");
            }

            // Validate phone number
            var phone = document.getElementById("<%= phone.ClientID %>").value;
            if (phone.trim() === "") {
                document.getElementById("<%= phone.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= phone.ClientID %>").classList.remove("is-invalid");
            }

            // Validate email
            var email = document.getElementById("<%= email.ClientID %>").value;
            if (email.trim() === "" || !isValidEmail(email)) {
                document.getElementById("<%= email.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= email.ClientID %>").classList.remove("is-invalid");
            }

            // Validate address1
            var address1 = document.getElementById("<%= address1.ClientID %>").value;
            if (address1.trim() === "") {
                document.getElementById("<%= address1.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= address1.ClientID %>").classList.remove("is-invalid");
            }

            // Validate state
            var state = document.getElementById("<%= State.ClientID %>").value;
            if (state === "") {
                document.getElementById("<%= State.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= State.ClientID %>").classList.remove("is-invalid");
            }

            // Validate city
            var city = document.getElementById("<%= City.ClientID %>").value;
            if (city === "") {
                document.getElementById("<%= City.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= City.ClientID %>").classList.remove("is-invalid");
            }

            // Validate zip code
            var zip = document.getElementById("<%= zip.ClientID %>").value;
            if (zip.trim() === "") {
                document.getElementById("<%= zip.ClientID %>").classList.add("is-invalid");
                isValid = false;
            } else {
                document.getElementById("<%= zip.ClientID %>").classList.remove("is-invalid");
            }

            // Validate payment method
            var paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
            if (!paymentMethod) {
                // No payment method selected
                isValid = false;
                document.getElementById("btnContinue").disabled = true; // Disable the button
            } else {
                // Check the selected payment method
                if (paymentMethod.id === "Cash") {
                    // If "Cash on Delivery" is selected, enable the button and return true
                    document.getElementById("btnContinue").disabled = false;
                    return true;
                } else {
                    // If "Credit card" is selected, perform additional credit card validation
                    // Here you can add specific credit card validation logic if needed
                    // For now, just enable the button and return true
                    document.getElementById("btnContinue").disabled = false;
                    return true;
                }
            }

            return isValid;
        }


        // Function to validate email format
        function isValidEmail(email) {
            // Regular expression for email validation
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
    </script>
    <div class="container-sm">
        <div class="row">
            <div class="col-md-7">
                <h4 class="mb-3">Billing address</h4>
                <div class="ui form needs-validation" novalidate="">
                    <div class="two fields">
                        <div class="field">
                            <label>First name</label>
                            <asp:TextBox ID="firstName" CssClass="form-control" runat="server" Text=""></asp:TextBox>
                            <div class="invalid-feedback">Valid first name is required.</div>
                        </div>
                        <div class="field">
                            <label>Last name</label>
                            <asp:TextBox ID="lastName" CssClass="form-control" runat="server" Text=""></asp:TextBox>
                            <div class="invalid-feedback">Valid last name is required.</div>
                        </div>
                    </div>
                    <div class="field">
                        <label>Phone</label>
                        <asp:TextBox ID="phone" CssClass="form-control" runat="server" placeholder="Enter your phone number" Text=""></asp:TextBox>
                        <div class="invalid-feedback">Please enter your phone number.</div>
                    </div>
                    <div class="field">
                        <label>Email</label>
                        <asp:TextBox ID="email" CssClass="form-control" runat="server" placeholder="you@example.com" Text=""></asp:TextBox>
                        <div class="invalid-feedback">Please enter a valid email address.</div>
                    </div>
                    <div class="field">
                        <label>Address1</label>
                        <asp:TextBox ID="address1" CssClass="form-control" runat="server" placeholder="1234 Main St" Text=""></asp:TextBox>
                        <div class="invalid-feedback">Please enter your shipping address.</div>
                    </div>
                    <div class="field">
                        <label>Address 2 <span class="text-muted">(Optional)</span></label>
                        <asp:TextBox ID="address2" CssClass="form-control" runat="server" placeholder="Apartment or suite" Text=""></asp:TextBox>
                    </div>
                    <div class="fields">
                         <div class="eight wide field state-dropdown">
                    <label>State</label>
                    <asp:DropDownList ID="State" CssClass="ui fluid dropdown" runat="server" required="">
                        <asp:ListItem Value="">Choose...</asp:ListItem>
                        <asp:ListItem>Maharashtra</asp:ListItem>
                    </asp:DropDownList>
                    <div class="invalid-feedback">Please select a valid country.</div>
                </div>
                        <div class="four wide field">
                            <label>City</label>
                            <asp:DropDownList ID="City" CssClass="ui fluid dropdown" runat="server" required="">
                                <asp:ListItem Value="">Choose...</asp:ListItem>
                                <asp:ListItem>Kalyan</asp:ListItem>
                            </asp:DropDownList>
                            <div class="invalid-feedback">Please provide a valid state.</div>
                        </div>
                        <div class="four wide field">
                            <label>Zip</label>
                            <asp:TextBox ID="zip" CssClass="form-control" runat="server" placeholder="" Text=""></asp:TextBox>
                            <div class="invalid-feedback">Zip code required.</div>
                        </div>
                    </div>
                   <%-- <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="Checkbox1" runat="server">
                        <label class="custom-control-label" for="save-info">Save this information for next time</label>
                    </div>--%>
                    <hr class="mb-4">
                    <h4 class="mb-3">Payment</h4>
                    <div class="d-block my-3">
                        <div class="custom-control custom-radio">
                            <input id="Cash" name="paymentMethod" type="radio" class="custom-control-input" required="" onclick="hideCreditCard()" >
                            <label class="custom-control-label" for="Cash">Cash on Delivery</label>
                        </div>

                        <div class="custom-control custom-radio">
                            <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" required="" onclick="showCreditCard()">
                            <label class="custom-control-label" for="credit">Credit card</label>
                        </div>
                        
                    </div>
                    <div id="creditCardDetails" style="display: none;">
                        <div class="two fields">
                            <div class="field">
                                <label>Name on card</label>
                                <input type="text" class="form-control" id="cc-name" placeholder="" >
                                <small class="text-muted">Full name as displayed on card</small>
                                <div class="invalid-feedback">Name on card is required </div>
                            </div>
                            <div class="field">
                                <label>Credit card number</label>
                                <input type="text" class="form-control" id="cc-number" placeholder="" >
                                <div class="invalid-feedback">Credit card number is required </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="eight wide field">
                                <label>Expiration</label>
                               <input type="text" class="form-control" id="cc-expiration" placeholder="MM/YY" pattern="\d{2}/\d{2}" title="Please enter a valid expiration date in the format MM/YYYY">

                                <div class="invalid-feedback">Expiration date required </div>
                            </div>
                            <div class="eight wide field">
                                <label>CVV</label>
                                <input type="text" class="form-control" id="cc-cvv" placeholder="" >
                                <div class="invalid-feedback">Security code required </div>
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnContinue" CssClass="ui primary button" runat="server" Text="Continue to checkout" OnClick="btnContinue_Click" OnClientClick="return validateForm();" />
                </div>
            </div>
            <div class="col-md-5">
                <div class="ui raised card">
                    <div class="content">
                        <div class="header">YOUR ORDER</div>
                    </div>
                    <div class="content">
                        <!-- Order summary content here -->
                        <asp:Repeater ID="rptCartItems" runat="server">
                            <ItemTemplate>
                                <div class="ui middle aligned divided list">
                                    <div class="item">
                                        <img class="ui avatar image" src='<%# Eval("ImageUrl") %>'>
                                        <div class="content">
                                            <div class="header"><%# Eval("ProductName") %></div>
                                            <div class="description"><%# Eval("Quantity") %> x <%# Eval("Price") %> INR</div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <!-- Remaining order summary HTML content -->
                        <!-- You can keep the static HTML for subtotal, shipping, and total -->
                    </div>
                    <div class="extra content">
                        <div class="ui two column grid">
                            <div class="column">Total price (including taxes):</div>
                            <div class="column"><asp:Literal ID="litTotalWithTaxes" runat="server"></asp:Literal></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showCreditCard() {
            document.getElementById("creditCardDetails").style.display = "block";
        }

        function hideCreditCard() {
            document.getElementById("creditCardDetails").style.display = "none";
        }
    </script>
</asp:Content>