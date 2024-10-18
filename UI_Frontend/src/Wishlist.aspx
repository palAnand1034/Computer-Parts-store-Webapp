<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="Comp_peri_ecomm.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <!-- Link Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom Styles */
        .card {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .title {
            margin-bottom: 20px;
            text-align: center;
        }

        .cart {
            text-align: center;
        }

        .lv-header {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
        }

        .lv-item {
            background-color: #fff;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .lv-item img {
            width: 100px;
            height: 100px;
            display: block;
            margin: 0 auto;
            border-radius: 5px;
        }

        .lv-item-info {
            margin-top: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <asp:ListView ID="lvWishlist" runat="server" ItemPlaceholderID="itemPlaceholder" OnItemDeleting="lvWishlist_ItemDeleting" DataKeyNames="Wishlist_ItemId">
                    <LayoutTemplate>
                        <div class="lv-header row">
                            <div class="col"><strong>Product Image</strong></div>
                            <div class="col"><strong>Product Name</strong></div>
                            <div class="col"><strong>Action</strong></div>
                            <!-- Add Action column -->
                        </div>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div class="lv-item row">
                            <div class="col-2">
                                <img src='<%# Eval("ImageUrl") %>' alt="Product Image" class="img-fluid" />
                            </div>
                            <div class="col lv-item-info">
                                <strong>Product Name:</strong><br />
                                <%# Eval("ProductName") %>
                            </div>
                            <div class="col lv-item-info">
                                <!-- Delete button -->
                                <asp:LinkButton ID="btnDelete" CssClass="btn btn-sm btn-outline-danger" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Wishlist_ItemId") %>'>Delete</asp:LinkButton>
                            </div>
                            <asp:HiddenField ID="hdnWishlistItemId" runat="server" Value='<%# Eval("Wishlist_ItemId") %>' />
                            <!-- Add this line -->
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>
