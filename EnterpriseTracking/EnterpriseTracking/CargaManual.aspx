<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="CargaManual.aspx.vb" Inherits="EnterpriseTracking.CargaManual" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:FileUpload ID="fuArchivo" runat="server" />
    <hr />
    <asp:Button ID="btnUpload" Text="Upload" runat="server"/>
    <br />


</asp:Content>
