<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contactus.aspx.cs" Inherits="Comp_peri_ecomm.contactus1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <!-- Add meta tags for better SEO -->
    <meta name="description" content="Contact us for any inquiries or issues. Our customer support team is dedicated to assisting you.">
    <meta name="keywords" content="contact us, customer support, inquiries, assistance">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Us</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CSS -->
        <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Custom Background CSS -->
        <style>
            body {
                background-color: #fff; /* Set white background */
            }
            .contact-heading {
                background-color: #f8f9fa; /* Set background color for the heading container */
                padding: 20px; /* Adjust padding as needed */
                text-align: center; /* Center align content */
                margin-bottom: 20px; /* Add some space below the container */
            }
            .contact-heading h2 {
                font-size: 36px; /* Increase font size */
                color: #007bff; /* Set color to blue */
            }
            .contact-content {
                background-color: #fff; /* Set white background for content */
                padding: 20px; /* Add padding */
            }
        </style>
    </head>
    <body>
        <!-- Heading Container Begin -->
        <div class="container-fluid contact-heading">
            <img src="imgs/contact.png"  alt="Contact Image">
            <h2>Contact Us</h2>
        </div>
            
        <!-- Heading Container End -->

        <!-- Content Begin -->
        <section class="contact spad">
            <div class="container contact-content">
                <div class="row">
                    <div class="col-lg-6">
                       <div class="contact__info" style="font-size: 18px;"> <!-- Add inline style to set font size -->
    <p style="font-size: 18px;">Our dedicated customer support team is here to assist you with any inquiries or issues.</p> <!-- Increase font size -->
    <ul class="contact__list" style="font-size: 18px;"> <!-- Increase font size -->
        <li>
            <span class="icon"><i class="fas fa-map-marker-alt"></i></span>
            <div class="info">
                <h4 style="font-size: 20px;">Location</h4> <!-- Increase font size -->
                <p style="font-size: 18px;">RK Talreja College, Ulhasnagar</p> <!-- Increase font size -->
            </div>
        </li>
        <li>
            <span class="icon"><i class="fas fa-phone-alt"></i></span>
            <div class="info">
                <h4 style="font-size: 20px;">Phone</h4> <!-- Increase font size -->
                <p style="font-size: 18px;">+91 997-560-7843</p> <!-- Increase font size -->
            </div>
        </li>
        <li>
            <span class="icon"><i class="fas fa-envelope"></i></span>
            <div class="info">
                <h4 style="font-size: 20px;">Email</h4> <!-- Increase font size -->
                <p style="font-size: 18px;"><a href="mailto:snehalupadhyay01@gmail.com">snehalupadhyay01@gmail.com</a></p> <!-- Increase font size -->
            </div>
        </li>
    </ul>
</div>

                    </div>
                </div>
            </div>
        </section>
        <!-- Content End -->

        
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</asp:Content>
