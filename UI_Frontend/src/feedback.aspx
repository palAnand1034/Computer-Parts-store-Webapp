<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="feedback.aspx.cs" Inherits="Comp_peri_ecomm.contactus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
   
    <style>
        /* Add custom CSS styles to enhance the appearance */
        .frame {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        #msg {
            margin-top: 10px;
            font-size: 16px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   
    <div class="frame">
        <h2 style="text-align: center;">Feedback</h2>
        <div class="contact-section">
            <div class="contact-form">
                <div class="form-group">
                    <asp:TextBox ID="txtFeedbackName" runat="server" CssClass="form-control" placeholder="First name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFeedbackName" runat="server" ControlToValidate="txtFeedbackName" ErrorMessage="Name is required." Text="*"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtFeedbackEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFeedbackEmail" runat="server" ControlToValidate="txtFeedbackEmail" ErrorMessage="Email is required." Text="*"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtFeedbackMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Write your message"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFeedbackMessage" runat="server" ControlToValidate="txtFeedbackMessage" ErrorMessage="Message is required." Text="*"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group" style="text-align: center;">
                    <asp:Button ID="btnSendFeedback" runat="server" Text="Send Message" CssClass="btn btn-primary" OnClick="btnSendFeedback_Click" />
                </div>
                <div id="msg" runat="server"></div>
            </div>
        </div>
    </div>


</asp:Content>
