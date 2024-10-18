<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="customPC.aspx.cs" Inherits="Comp_peri_ecomm.custompc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <label>Processor (CPU):</label>
        <asp:DropDownList ID="ddlCPU" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged">
            <asp:ListItem>select CPU</asp:ListItem>
            <asp:ListItem>Intel i5 14th gen</asp:ListItem>
            <asp:ListItem>Intel i9 14th gen</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="component-selection">
        <label>Graphics card (GPU):</label>
        <asp:DropDownList ID="ddlGPU" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" Width="132px">
            <asp:ListItem>select CPU</asp:ListItem>
            <asp:ListItem>Gigabyte Rtx 4060 Ti Aero Oc 16Gb Graphics Card</asp:ListItem>
            <asp:ListItem>Msi Rtx 4060 Ti Gaming X Slim White 8Gb Graphics Card</asp:ListItem>
        </asp:DropDownList>
    </div>

   <div class="component-selection">
            <label>Memory (RAM):</label>
            <asp:DropDownList ID="ddlRAM" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" Width="162px">
                <asp:ListItem>select Memory</asp:ListItem>
                <asp:ListItem>Corsair Dominator Platinum Rgb 32Gb (16Gbx2) Ddr5 Dram 6200Mhz Desktop Ram White</asp:ListItem>
                <asp:ListItem>TeamGroup T-Force Desktop Ram Vulcan Series 16Gb (16Gbx1) Ddr5 5200MHz</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="component-selection">
            <label>Monitor:</label>
            <asp:DropDownList ID="ddlMonitor" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" Width="155px">
                <asp:ListItem>select Monitor</asp:ListItem>
                <asp:ListItem>Samsung Odyssey G3 LS24AG322NWXXL 24 Inch Fhd Gaming Monitor</asp:ListItem>
                <asp:ListItem>Msi G2722 27 Inch Ips Fhd Gaming Monitor</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="component-selection">
            <label>Mouse:</label>
            <asp:DropDownList ID="ddlMouse" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" Width="146px">
                <asp:ListItem>select Mouse</asp:ListItem>
                <asp:ListItem>HyperX Pulsefire Haste Rgb Ergonomic Wired Gaming Mouse</asp:ListItem>
                <asp:ListItem>Logitech G502 X Lightspeed Wireless Gaming Mouse (Black)</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="component-selection">
            <label>Keyboard:</label>
            <asp:DropDownList ID="ddlKeyboard" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" Width="174px">
                <asp:ListItem>select Keyboard</asp:ListItem>
                <asp:ListItem>HyperX Alloy Origins Core Pbt Tenkeyless Mechanical Gaming Keyboard Blue Clicky Switches</asp:ListItem>
                <asp:ListItem>Asus Rog Strix Scope Nx Tkl Mechanical Gaming Keyboard Red Switches</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="component-selection">
            <label>Motherboard:</label>
            <asp:DropDownList ID="ddlMotherboard" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" Width="202px">
                <asp:ListItem>select Motherboard</asp:ListItem>
                <asp:ListItem>Asus Prime H610M-A Wifi Lga1700 Matx Motherboard</asp:ListItem>
                <asp:ListItem>Msi Mag B760M Mortar Wifi II Lga1700 Matx Motherboard</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="component-selection">
            <label>Case:</label>
            <asp:DropDownList ID="ddlcase" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" Width="139px">
                <asp:ListItem>select Case</asp:ListItem>
                <asp:ListItem>Corsair 3000D Airflow SI Edition Atx Mid Tower Cabinet</asp:ListItem>
                <asp:ListItem>Ant Esports ICE-410TG Argb Eatx Mid Tower Cabinet (White)</asp:ListItem>
            </asp:DropDownList>
        </div>
        

    <div class="total-cost">
        <p>Total Cost: <asp:Label ID="totalAmountCell" runat="server"></asp:Label></p>
    </div>
</asp:Content>
