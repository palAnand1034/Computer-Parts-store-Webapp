<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Comp_peri_ecomm.Default" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="Header" runat="server">
    <style>
        /* Updated carousel styles */
        #carousel-slider {
            height: 500px; /* Adjust the height as needed */
            z-index:auto;
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
            transition: box-shadow 0.3s, transform 0.3s; /* Add transition effect */
        }

        .product-box h4 {
            color: black; /* Set product name color to black */
            transition: color 0.3s; /* Add transition effect */
        }

        .product-box:hover img {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2), 0 0 32px rgba(0, 123, 255, 0.5); /* Add glow effect on hover */
        }

        .product-box:hover h4 {
            color: #007bff; /* Change product name color on hover */
        }

        .No-underline:hover {
            text-decoration: none !important; /* Remove underline on hover */
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <center>
        <br />
<%--        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" rel="stylesheet" />--%>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<%--        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>--%>
        <div class="wrapper">
            <div id="carousel-slider" class="carousel slide carousel-slider" data-ride="carousel" data-interval="7000">
        
                <div class="carousel-inner" role="listbox">
                    
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="imgs/1stslider.jpeg" alt="First slide">
                    </div>
                   
                    <div class="carousel-item">
                        <img class="dblock w-100"src="imgs/14thslider.jpeg"" alt="Second slide">
                    </div>
                    
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/13thslider.jpeg" alt="Third slide">
                    </div>
                   
                    <div class="carousel-item">
                        <img class="d-block w-100"src="imgs/12thslider.jpeg" alt="Fifth slide">
                    </div>
                   
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/2ndslider.jpeg" alt="Sixth slide">
                    </div>
                    
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/3rdslider.jpeg" alt="Seventth slide">
                    </div>
                    
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/4thslider.jpeg" alt="Eighth slide">
                    </div>
                   
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/5thslider.jpeg" alt="Nineth slide">
                    </div>
                    
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/6thslider.jpeg" alt="Tenth slide">
                    </div>
                    <!--/Tenth slide-->
                    <!--Eleventh slide-->
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/7thslider.jpeg" alt="Eleventh slide">
                    </div>
                    <!--/Eleventh slide-->
                    <!--Twelth slide-->
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/8thslider.jpeg" alt="Twelth slide">
                    </div>
                    <!--/Twelth slide-->
                    <!--Thirteenth slide-->
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/9thslider.jpeg" alt="Thirteenth slide">
                    </div>
                    <!--/Thirteenth slide-->
                    <!--Fourteenth slide-->
                    <div class="carousel-item">
                        <img class="d-block w-100"src="imgs/10thslider.jpeg" alt="Fourteenth slide">
                    </div>
                    <!--/Fourteenth slide-->
                    <!--Fifteenth slide-->
                    <div class="carousel-item">
                        <img class="d-block w-100" src="imgs/11thslider.jpeg" alt="Fifteenth slide">
                    </div>
                    <!--/Fifteenth slide-->
                </div>
                <a class="carousel-control-prev" href="#carousel-slider" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carousel-slider" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </center>
    <div class="product-list">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="product-box">
<asp:HyperLink ID="lnkProductDetail" runat="server" NavigateUrl='<%# "product-detail.aspx?productId=" + Eval("ProductID") %>' CssClass="No-underline">
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' AlternateText='<%# Eval("ProductName") %>' />
                        <h4 style="text-align: left;"><%# Eval("ProductName") %></h4>
                        <p style="font-weight: 600;">₹<%# string.Format("{0:C}", Eval("Price")) %></p>
                    </asp:HyperLink>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
