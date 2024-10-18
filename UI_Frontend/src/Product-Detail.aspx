﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product-Detail.aspx.cs" Inherits="Comp_peri_ecomm.Product_Detail" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <style>
        /*****************globals*************/
        body {
            font-family: 'open sans';
            overflow-x: hidden;
        }

        img {
            max-width: 100%;
        }

        .preview {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
        }

        @media screen and (max-width: 996px) {
            .preview {
                margin-bottom: 20px;
            }
        }

        .preview-pic {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1;
        }

        .preview-thumbnail.nav-tabs {
            border: none;
            margin-top: 15px;
        }

            .preview-thumbnail.nav-tabs li {
                width: 18%;
                margin-right: 2.5%;
            }

                .preview-thumbnail.nav-tabs li img {
                    max-width: 100%;
                    display: block;
                }

                .preview-thumbnail.nav-tabs li a {
                    padding: 0;
                    margin: 0;
                }

                .preview-thumbnail.nav-tabs li:last-of-type {
                    margin-right: 0;
                }

        .tab-content {
            overflow: hidden;
        }

            .tab-content img {
                width: 100%;
                -webkit-animation-name: opacity;
                animation-name: opacity;
                -webkit-animation-duration: .3s;
                animation-duration: .3s;
            }

        .card {
            margin-top: 50px;
            background: #eee;
            padding: 3em;
            line-height: 1.5em;
        }

        @media screen and (min-width: 997px) {
            .wrapper {
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex;
            }
        }

        .details {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
        }

        .colors {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1;
        }

        .product-title, .price, .sizes, .colors {
            text-transform: UPPERCASE;
            font-weight: bold;
        }

            .checked, .price span {
                color: #ff9f1a;
            }

        .product-title, .rating, .product-description, .price, .vote, .sizes {
            margin-bottom: 15px;
        }

        .product-title {
            margin-top: 0;
        }

        .size {
            margin-right: 10px;
        }

            .size:first-of-type {
                margin-left: 40px;
            }

        .color {
            display: inline-block;
            vertical-align: middle;
            margin-right: 10px;
            height: 2em;
            width: 2em;
            border-radius: 2px;
        }

            .color:first-of-type {
                margin-left: 20px;
            }

        .add-to-cart, .like {
            background: #ff9f1a;
            padding: 1.2em 1.5em;
            border: none;
            text-transform: UPPERCASE;
            font-weight: bold;
            color: #fff;
            -webkit-transition: background .3s ease;
            transition: background .3s ease;
        }

            .add-to-cart:hover, .like:hover {
                background: #b36800;
                color: #fff;
            }

        .not-available {
            text-align: center;
            line-height: 2em;
        }

            .not-available:before {
                font-family: fontawesome;
                content: "\f00d";
                color: #fff;
            }

        .orange {
            background: #ff9f1a;
        }

        .green {
            background: #85ad00;
        }

        .blue {
            background: #0076ad;
        }

        .tooltip-inner {
            padding: 1.3em;
        }

        @-webkit-keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3);
            }

            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1);
            }
        }

        @keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3);
            }

            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1);
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2 style="color: white;">Product Detail</h2>
    </div>
    
    <div class="container">
        <div class="card">
            <div class="container-fliud">
                <div class="  row">
                    <div class="preview col-md-6">

                        <div class="preview-pic tab-content">
                            <div class="tab-pane active" id="pic-1">
                                <asp:Image ID="imgProduct" runat="server" ImageUrl="" />
                            </div>

                        </div>
                    </div>

                    <div class="details col-md-6">
                        <asp:Label ID="lblProductName" runat="server" Text="" class="product-title"></asp:Label>
                        <div class="rating">
                            <!-- Rating stars omitted for brevity -->
                        </div>
                        <asp:Label ID="lblDescription" runat="server" Text="" class="product-description"></asp:Label>
                        <h4 class="price">current price: ₹<span><asp:Label ID="lblPrice" runat="server" Text=""></asp:Label></span></h4>

                        <div class="col lv-item-info">
                            <strong>Quantity:</strong><br />
                            <asp:DropDownList ID="ddlQuantity" runat="server" CssClass="mx-2" Enabled="True">
                            </asp:DropDownList>
                        </div>

                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" class="add-to-cart btn btn-default" />
                        <asp:Button ID="btnAddtoWishlist" runat="server" Text="Add to Wishlist" OnClick="btnAddToWishlist_Click" class="add-to-wishlist btn btn-default" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
