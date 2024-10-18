<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Admin.Views.Login" %>

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
                        <label for="username" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mt-3">
                        <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
                        <asp:TextBox ID="Txt_pass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mt-3">
                        <asp:Button Text="Login" runat="server" CssClass="btn btn-success btn-block" ID="LoginBtn" OnClick="LoginBtn_Click" />
                    </div>
                    
                </form>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</body>
</html>
