<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="User_management.aspx.cs" Inherits="Admin.Views.Admin.User_management" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .color {
            background-color: #edf2f7;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="color py-5">
        <div class="container mx-auto">
            <div class="flex flex-wrap justify-between">
                <div class="w-full md:w-5/12">
                    <div class="bg-white shadow-md rounded-md p-5">
                        <h4 class="text-lg font-semibold text-center mb-3">User Details</h4>
                        <div class="flex items-center justify-center mb-3">
                            <img src="../../Assets/Images/generaluser.png" alt="User" class="w-20">
                        </div>
                        <hr class="mb-3">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block">User ID</label>
                                <div class="input-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBox1" runat="server" placeholder="User ID" class="form-control rounded-md">
                                    </asp:TextBox>
                                    <asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server" OnClick="LinkButton4_Click">
                                        <i class="fas fa-check-circle"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <div>
                                <label class="block">Full Name</label>
                                <asp:TextBox CssClass="form-control" ID="TextBox2" runat="server" placeholder="Full Name" ReadOnly="True"
                                    class="form-control rounded-md">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-3">
                            <div>
                                <label class="block">Date of Birth</label>
                                <asp:TextBox CssClass="form-control" ID="TextBox8" runat="server" placeholder="Date of Birth" TextMode="Date"
                                    ReadOnly="True" class="form-control rounded-md">
                                </asp:TextBox>
                            </div>
                            <div>
                                <label class="block">Contact No</label>
                                <asp:TextBox CssClass="form-control" ID="TextBox3" runat="server" placeholder="Contact No" ReadOnly="True"
                                    class="form-control rounded-md">
                                </asp:TextBox>
                            </div>
                            <div>
                                <label class="block">Email ID</label>
                                <asp:TextBox CssClass="form-control" ID="TextBox4" runat="server" placeholder="Email ID" ReadOnly="True"
                                    class="form-control rounded-md">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="mt-3">
                            <label class="block">Full Address</label>
                            <asp:TextBox CssClass="form-control" ID="TextBox6" runat="server" placeholder="Full Address" TextMode="MultiLine"
                                Rows="2" ReadOnly="True" class="form-control rounded-md">
                            </asp:TextBox>
                        </div>
                        <div class="mt-3">
                            <asp:Button ID="Button2" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete User Permanently"
                                OnClick="Button2_Click" />
                        </div>
                    </div>
                </div>
                <div class="w-full md:w-7/12 mt-5 md:mt-0">
                    <div class="bg-white shadow-md rounded-md p-5">
                        <h4 class="text-lg font-semibold text-center mb-3">User List</h4>
                        <hr class="mb-3">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:con %>"
                            SelectCommand="SELECT * FROM [Signup]"></asp:SqlDataSource>
                        <div class="table-responsive">
                            <asp:GridView Class="table table-striped table-bordered" ID="GridView1" runat="server" AutoGenerateColumns="False"
                                DataKeyNamesmo="" DataSourceID="SqlDataSource1">
                                <Columns>
                                    <asp:BoundField DataField="user_id" HeaderText="Id" ReadOnly="True" SortExpression="user_id"
                                        HeaderStyle-CssClass="nosort" />
                                    <asp:BoundField DataField="full_name" HeaderText="Name" SortExpression="full_name"
                                        HeaderStyle-CssClass="nosort" />
                                    <asp:BoundField DataField="dob" HeaderText="Date of Birth" SortExpression="dob"
                                        HeaderStyle-CssClass="nosort" />
                                    <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email"
                                        HeaderStyle-CssClass="nosort" />
                                    <asp:BoundField DataField="contact_no" HeaderText="Contact number" SortExpression="contact_no"
                                        HeaderStyle-CssClass="nosort" />
                                    <asp:BoundField DataField="full_address" HeaderText="Address" SortExpression="full_address"
                                        HeaderStyle-CssClass="nosort" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
