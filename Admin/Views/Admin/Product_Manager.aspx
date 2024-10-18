<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Product_Manager.aspx.cs" Inherits="Admin.Views.Admin.Product_Manager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css" />
    <script>
        $(document).ready(function () {
            $("#GridView1").DataTable();
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

        /* Style for truncated image column */
        .image-column {
            max-width: 200px; /* Adjust the width as per your requirement */
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
                                    <h4>Product Details</h4>
                                </center>
                            </div>
                        </div>
                        <!-- Form elements -->
                        <div class="row">
                            <div class="col-md-5">
                                <label>Product ID</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-label text-success" ID="TextBox1" runat="server" placeholder="ID" style="width: 40px;"></asp:TextBox>
                                        <asp:Button class="btn btn-primary" ID="Go_button" runat="server" Text="Go" OnClick="Button1_Click" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-7">
                                <label>Product Name</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBox2" runat="server" placeholder="Product Name" style="width: 200px;"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Price</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBox3" runat="server" placeholder="Price"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Quantity</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBox6" runat="server" placeholder="Quantity"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>ImageUrl</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBox4" runat="server" placeholder="ImageUrl"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Category</label>
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" 
                                        DataSourceID="SqlDataSourceCategories" DataTextField="CategoryName" DataValueField="CategoryName">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:con %>" 
                                        SelectCommand="SELECT CategoryName FROM Categories"></asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="row">
                            <div class="col-3">
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
                                    <h4>Product List</h4>
                                </center>
                            </div>
                        </div>
                        <!-- GridView -->
                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:con %>" SelectCommand="SELECT * FROM [ProductsAll]"></asp:SqlDataSource>
                            <div class="col">
                                <asp:GridView Class="table table-striped table-bordered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNamesmo="" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="4"> 
                                    <Columns>
                                        <asp:BoundField DataField="ProductID" HeaderText="ID" ReadOnly="True" SortExpression="ProductID" HeaderStyle-CssClass="nosort">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ProductName" HeaderText="Name" SortExpression="ProductName" HeaderStyle-CssClass="nosort">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" HeaderStyle-CssClass="nosort">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" HeaderStyle-CssClass="nosort">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ImageUrl" HeaderText="ImageUrl" SortExpression="ImageUrl" HeaderStyle-CssClass="nosort" ItemStyle-CssClass="image-column">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" HeaderStyle-CssClass="nosort">
                                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                                        </asp:BoundField>
                                    </Columns>
                                    <PagerStyle CssClass="custom-pager-style" /> 
                                    <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" /> 
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
