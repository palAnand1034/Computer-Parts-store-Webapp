<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Category_Management.aspx.cs" Inherits="Admin.Views.Admin.Category_Management" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css" />
    <script>
        $(document).ready(function () {
            $('#GridView1').DataTable({
                "paging": true, // Enable pagination
                "pageLength": 10, // Number of rows per page
                "lengthChange": false, // Disable length change dropdown
                "searching": false, // Disable search bar
                "ordering": true, // Enable sorting
                "info": true, // Enable info
                "autoWidth": false // Disable auto width calculation
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-8rBNg7Zv7nh1t5y47/JH3OEwg0aGJoQHTFF68KW4fyuT0blNMC6M5k9dZPw17/kP+BXiKsMqIqV92x0I7rFZgQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* Custom CSS for layout */
        .color {
            background-image: url('https://localhost:44343/imgs/geometric-crystal-background-backgrounds.jpg');
            margin: auto;
            padding: inherit;
        }

        .nosort {
            pointer-events: none;
            cursor: default;
        }

        /* Form and table containers */
        .container-fluid {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .form-container {
            width: calc(45% - 15px);
            padding-right: 15px;
            box-sizing: border-box; /* Add this line to include padding in width calculation */
        }

        .table-container {
            width: calc(55% - 15px); /* Adjusted width to accommodate padding */
            padding-left: 15px;
        }

        /* Limit the width of the form and table containers on smaller screens */
        @media (max-width: 992px) {
            .form-container,
            .table-container {
                width: 100%;
                padding: 0 15px;
            }
        }
    </style>
    <div class="color">
        <div class="container-fluid">
            <!-- Form container -->
            <div class="form-container">
                <br />
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Category Details</h4>
                                </center>
                            </div>
                        </div>
                        <!-- Form elements -->
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="TextBox1" runat="server" placeholder="ID"></asp:TextBox>
                                        <asp:Button class="btn btn-primary" ID="Button1" runat="server" Text="Go" OnClick="Button1_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBox2" runat="server" placeholder="Category Name"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="row">
                            <div class="col-4">
                                <asp:Button ID="Button2" class="btn btn-lg btn-block btn-success" runat="server" Text="Add" OnClick="Button2_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="Button3" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="Button3_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="Button4" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="Button4_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Table container -->
            <div class="table-container">
                <br />
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Category List</h4>
                                </center>
                            </div>
                        </div>
                        <!-- GridView -->
                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:con %>" SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
                            <div class="col">
                                <asp:GridView Class="table table-striped table-bordered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNamesmo="" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="9">
                                    <Columns>
                                        <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" ReadOnly="True" SortExpression="CategoryID" HeaderStyle-CssClass="nosort">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CategoryName" HeaderText="CategoryName" SortExpression="CategoryName" HeaderStyle-CssClass="nosort">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
