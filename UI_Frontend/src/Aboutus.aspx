<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Aboutus.aspx.cs" Inherits="Comp_peri_ecomm.Aboutus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #fff;
            color: #000;
        }

        .frame {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color:#CCD3CA;
        }

        .AboutUs {
            text-align: center;
        }

        .Picture {
            text-align: center;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

         .Picture img {
            max-width: 100%;
            max-height: 400px; /* Adjust maximum height */
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }
    </style>
   <div class="frame">
        <div class="row">
            <div class="col-md-6">
                <!-- Left side with the about us picture -->
                <div class="Picture">
                    <br />
                     <br />
                     <br />
                     <br />
                   <br />
                     <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br  /> <br /> 
           
                    <img src="imgs/Digi.png" alt="About us Poster" />
                </div>
            </div>
            <div class="col-md-6">
                <!-- Right side with description-->
                <div class="AboutUs">
                    <h2>About Us</h2>
                    <p>
                        Welcome to our computer inventory parts selling website. We are dedicated to providing high-quality computer parts to meet the needs of our customers. Our team is committed to delivering exceptional service and support to ensure a seamless experience.
                    </p>
                    <p>
                        Whether you are a tech enthusiast, a professional, or a business owner, we have the right components for you. From processors to graphics cards, from memory modules to storage solutions, we offer a wide range of products to suit your requirements.
                    </p>
                    <p>
                        With a focus on reliability and affordability, we strive to be your trusted partner in building and upgrading your computer systems. Thank you for choosing us for your computer parts needs.
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
