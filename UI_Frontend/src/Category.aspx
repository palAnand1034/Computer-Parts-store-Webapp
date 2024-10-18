<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="Comp_peri_ecomm.Category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <style>
       .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 30px; /* Add margin to separate carousel from product list */
        }

        .product-box {
            width: 300px;
            margin: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            text-align: center;
            background-color: #f8f9fa; /* Change background color */
            border-radius: 10px; /* Add border radius */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add box shadow for depth */
        }

            .product-box img {
                width: 200px;
                height: 200px;
                object-fit: cover; /* Ensure the image covers the container */
                margin-bottom: 20px; /* Add margin below the image */
            }

            .product-box h3 {
                color: #007bff; /* Change title color */
                font-weight: bold;
                margin-bottom: 10px;
            }

            .product-box p {
                color: #555;
                font-size: 18px; /* Increase font size for price */
            }

            /* Add hover effect to product boxes */
            .product-box:hover {
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                transform: translateY(-5px);
            }

            .product-box:hover {
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2), 0 0 32px rgba(0, 123, 255, 0.5); /* Add glow effect on hover */
                transform: translateY(-5px);
            }

        .no-underline {
            text-decoration: none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="product-list">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="product-box">
                    <asp:HyperLink ID="lnkProductDetail" runat="server" NavigateUrl='<%# "product-detail.aspx?productId=" + Eval("ProductID") %>' CssClass="No-underline">
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' AlternateText='<%# Eval("ProductName") %>' />
                        <h4 style="text-align:left;"><%# Eval("ProductName") %></h4>
                        <p style="font-weight: 600;">₹<%# string.Format("{0:C}", Eval("Price")) %></p>
                    </asp:HyperLink>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <%-- <div>view more</div> --%>
    </div>
</asp:Content>