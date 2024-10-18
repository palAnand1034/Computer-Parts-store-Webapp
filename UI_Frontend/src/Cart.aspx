<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Comp_peri_ecomm.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <!-- Link Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .card {
            margin: 20px 0;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .lv-header {
            background-color: #007bff;
            color: #fff;
            border-radius: 10px 10px 0 0;
            padding: 10px;
        }

        .lv-item {
            background-color: #fff;
            border-radius: 0 0 10px 10px;
            padding: 10px;
            margin-bottom: 10px;
        }

        .lv-item img {
            width: 100px;
            height: 100px;
            border-radius: 5px;
        }

        .lv-item-info {
            margin-top: 10px;
        }

        .btn-delete {
            color: #dc3545;
        }

        .btn-delete:hover {
            color: #a71d2a;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-8">
            <asp:ListView ID="lvcart" runat="server" ItemPlaceholderID="itemPlaceholder"
                OnItemDeleting="lvcart_ItemDeleting"
                DataKeyNames="Cart_ItemId">
                <LayoutTemplate>
                    <div class="lv-header row">
                        <div class="col-2"><strong>Product Image</strong></div>
                        <div class="col"><strong>Product Name</strong></div>
                        <div class="col"><strong>Quantity</strong></div>
                        <div class="col"><strong>Price</strong></div>
                        <div class="col"><strong>Action</strong></div>
                    </div>
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
    <div class="lv-item row">
        <div class="col-2">
            <img src='<%# Eval("ImageUrl") %>' alt="Product Image" />
        </div>
        <div class="col lv-item-info">
            <strong>Product Name:</strong><br />
            <%# Eval("ProductName") %>
        </div>
        <div class="col lv-item-info">
            <strong>Quantity:</strong><br />
            <asp:DropDownList ID="ddlQuantity" runat="server" CssClass="form-select" Enabled="True" AutoPostBack="true" OnSelectedIndexChanged="ddlQuantity_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        <div class="col lv-item-info">
            <strong>Price:</strong><br />
            <%# Eval("Price", "{0:c}") %>
        </div>
        <div class="col lv-item-info">
            <asp:LinkButton ID="btnDelete" CssClass="btn btn-delete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Cart_ItemId") %>'>Delete</asp:LinkButton>
        </div>
        <asp:HiddenField ID="hdnCartItemId" runat="server" Value='<%# Eval("Cart_ItemId") %>' />
        <asp:HiddenField ID="hdnMaxQuantity" runat="server" Value='<%# Eval("Quantity") %>' />
        <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Eval("Quantity") %>' /> <!-- Add this line -->
    </div>
</ItemTemplate>

            </asp:ListView>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-3">
                        <p class="mb-0">Total price:</p>
                        <p class="mb-0"><asp:Literal ID="litTotalPrice" runat="server"></asp:Literal></p>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <p class="mb-0">CGST (8%):</p>
                        <p class="mb-0"><asp:Literal ID="litCGST" runat="server"></asp:Literal></p>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <p class="mb-0">SGST (8%):</p>
                        <p class="mb-0"><asp:Literal ID="litSGST" runat="server"></asp:Literal></p>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between">
                        <p class="mb-0">Total price (including taxes):</p>
                        <p class="mb-0 fw-bold"><asp:Literal ID="litTotalWithTaxes" runat="server"></asp:Literal></p>
                    </div>
                    <div class="mt-3">
                        <a href="OrderSummary.aspx" class="btn btn-success w-100 mb-2">Make Purchase</a>
                        <a href="Default.aspx" class="btn btn-light w-100 border">Back to shop</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
