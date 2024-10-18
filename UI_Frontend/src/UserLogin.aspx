
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="Comp_peri_ecomm.UserLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <style>
       /* Background */
       .color {
          background-image: url('https://localhost:44343/imgs/geometric-crystal-background-backgrounds.jpg');
          background-size: cover;
          padding: 50px 0;
          height: 100vh;
       }
       /* Card Styling */
       .card {
          background-color: #fff;
          border-radius: 10px;
          box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
          padding: 20px;
       }
       /* Form Styling */
       .form-group {
          margin-bottom: 20px;
       }
       .form-control {
          border: 1px solid #ccc;
          border-radius: 5px;
          padding: 10px;
          width: 100%;
       }
       /* Button Styling */
       .btn {
          border-radius: 5px;
          padding: 10px 20px;
          cursor: pointer;
       }
       .btn-success {
          background-color: #28a745;
          color: #fff;
          border: none;
       }
       .btn-success:hover {
          background-color: #218838;
       }
       .btn-info {
          background-color: #17a2b8;
          color: #fff;
          border: none;
       }
       .btn-info:hover {
          background-color: #138496;
       }
       /* Link Styling */
       a {
          color: #333;
       }
       a:hover {
          text-decoration: underline;
       }
   </style>
   <div class="color">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="text-center">
                        <img src="imgs/generaluser.png" width="130px" alt="User Icon" />
                    </div>
                    <div class="text-center">
                        <h3>User Login</h3>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="Txt_ID">User ID</label>
                                <asp:TextBox CssClass="form-control" ID="Txt_ID" runat="server" placeholder="UserId" ValidationGroup="loginGroup"></asp:TextBox>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Txt_ID" ErrorMessage="User ID is required" ForeColor="Red" ValidationGroup="loginGroup"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label for="Txt_pass">Password</label>
                                <asp:TextBox CssClass="form-control" ID="Txt_pass" runat="server" placeholder="Password" TextMode="Password" ValidationGroup="loginGroup"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Txt_pass" ErrorMessage="Password is required" ForeColor="Red" ValidationGroup="loginGroup"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Button CssClass="btn btn-success btn-block" ID="Login" runat="server" Text="Login" OnClick="Login_Click" ValidationGroup="loginGroup" />
                            </div>
                            <div class="form-group">
                                <asp:Button CssClass="btn btn-info btn-block btn-lg" ID="signupbtn" runat="server" Text="SignUp" OnClick="SignUp_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <a href="Default.aspx">&lt;&lt; Back to Home</a>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>

