<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="Admin.Views.Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="bg-gray-100">
    <div class="container-fluid">
        <div class="row mt-5 mb-5"></div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <form id="form1" runat="server" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
                    <div>
                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-9">
                                <img src="../Assets/Images/LOGO.png" width="190" height="60" />
                            </div>
                        </div>
                    </div>
                    <div class="mt-3">
                        <label for="Full name" class="block text-gray-700 text-sm font-bold mb-2">Full Name</label>
                        <asp:TextBox ID="txt_name" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mt-3">
                        <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                        <asp:TextBox ID="Txt_ID" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mt-3">
                        <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
                        <asp:TextBox ID="Txt_pass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mt-3">
                        <asp:Button class="btn btn-success btn-block btn-lg" ID="Button1" runat="server" Text="Sign Up" OnClick="Button1_Click" />
                    </div>
                </form>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</body>
</html>
