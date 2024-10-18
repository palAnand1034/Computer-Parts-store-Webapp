<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Comp_peri_ecomm.Invoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <!-- Link Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Custom Styles */
        .invoice-color {
            color: red !important;
        }

        .header-elements button {
            margin-left: 0.5rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mx-auto mt-16">

        <div class="row">

            <div class="col-md-12">

                <div class="card">
                    <div class="card-header bg-transparent header-elements">
                        <h6 class="card-title">Sale invoice</h6>
                    </div>

                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="mb-4">
                                    <h6>DIGITECH</h6>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="mb-4">
                                    <div class="text-right">
                           <h4 class="invoice-color mb-2 mt-md-2">Invoice #<asp:Label ID="lblInvoiceNumber" runat="server"></asp:Label></h4>
                                        <ul class="list-none mb-0">
                                            <li>Date: <span class="font-semibold">
                                                <asp:Literal ID="litCurrentDate" runat="server" /></span></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex md:flex-wrap">
                            <div class="mb-4 mb-md-2 text-left">
                                <span class="text-gray-600">Invoice To:</span>
                                <ul class="list-none mb-0">
                                    <li>
                                        <asp:Label ID="lblfirst_name" runat="server" /></li>
                                    <li>
                                        <asp:Label ID="lblAddress1" runat="server" /></li>
                                    <li>
                                        <asp:Label ID="lblAddress2" runat="server" /></li>
                                    <li>
                                        <asp:Label ID="lblCity" runat="server" /></li>
                                    <li>
                                        <asp:Label ID="lblPhone" runat="server" /></li>
                                    <li>
                                        <asp:HyperLink ID="hypShippingEmail" runat="server" data-abc="true" /></li>
                                </ul>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-lg">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <asp:Repeater ID="rptProducts" runat="server">
                                        <HeaderTemplate>
                                            <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <h6 class="mb-0"><%# Eval("Product_Name") %></h6>
                                                </td>
                                                <td>₹<%# Eval("Price") %></td>
                                                <td><%# Eval("Quantity") %></td>
                                                <td><span class="font-semibold">₹<%# (Convert.ToInt32(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %></span></td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </table>
                            </div>

                            <div class="card-body">
                                <div class="flex md:flex-wrap">

                                    <div class="pt-2 mb-3 md:w-1/2 md:ml-auto">
                                        <div class="table-responsive">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <th class="text-left">Total:</th>
                                                        <td class="text-right text-primary">
                                                            <asp:Label ID="lblTotal" runat="server" CssClass="font-semibold" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
