<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="YourOrders.aspx.cs" Inherits="Comp_peri_ecomm.YourOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <style>
        /* Updated carousel styles */
        #carousel-slider {
            height: 500px; /* Adjust the height as needed */
        }

        /* Updated product list styles */
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
            min-height:400px;
            border: 1px solid #ccc;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class=" container">

        <h1>Your Orders</h1>
        <%--<asp:ObjectDataSource ID="ordersDataSource" runat="server" 
    SelectMethod="GetOrders" TypeName="Comp_peri_ecomm.Data.YourOrdersData">
    <SelectParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>--%>
        <div class="row">
            <asp:ListView ID="ordersListView" runat="server">
                <LayoutTemplate>
                    <ul>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="col-md-4" style="float: left; text-align: left!important;">
                        <div class="product-box">
                            <p><strong>Order ID:</strong> <%# Eval("Order_id") %></p>
                            <p><strong>Product Name:</strong> <%# Eval("Product_Name") %></p>
                            <p><strong>Quantity:</strong> <%# Eval("Quantity") %></p>
                            <p><strong>Price:</strong> ₹<%# Eval("Price") %></p>
                            <p><strong>Order Status:</strong> <%# Eval("Order_status") %></p>
                            <p><strong>Order Date:</strong> <%# Eval("Order_date") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>

</asp:Content>
