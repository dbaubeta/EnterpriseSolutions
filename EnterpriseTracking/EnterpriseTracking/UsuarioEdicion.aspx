<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="UsuarioEdicion.aspx.vb" Inherits="EnterpriseTracking.UsuarioEdicion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="row" style="margin-bottom:20px">
    <div class="col-sm-1" style="vertical-align:middle">
    </div>
    <div class="col-sm-10" style="vertical-align:middle">
        <%-- CONTENIDO DE PANTALLA --%>
        <div class="row" style="margin-bottom:5px">
            <div class="col-sm-12" style="vertical-align:middle">
                <asp:Label ID="lblTituloUsuario" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>
        </div>

        <div class="row" style="margin-bottom:5px">
            <div class="col-sm-1" style="vertical-align:middle">
                <asp:Label ID="lblUsuarioID" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>
            <div class="col-sm-11" style="vertical-align:middle">
                <asp:Label ID="noTranslateUsuarioID" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>        
        </div>

        <div class="row" style="margin-bottom:5px">
            <div class="col-sm-1" style="vertical-align:middle">
                <asp:Label ID="lblUsuarioNombre" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>
            <div class="col-sm-11" style="vertical-align:middle">
                <asp:TextBox ID="txtUsuarioNombre" runat="server" style="width:100%" CssClass="form-control" />
            </div>        
        </div>

        <div class="row" style="margin-bottom:5px">
            <div class="col-sm-1" style="vertical-align:middle">
                <asp:Label ID="lblUsuarioIdioma" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>
            <div class="col-sm-11" style="vertical-align:middle">
                <asp:DropDownList ID="dlIdiomas" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
            </div>        
        </div>

        <div class="row" style="margin-bottom:5px">
            <div class="col-sm-10" style="vertical-align:middle">
            </div>
            <div class="col-sm-2" style="vertical-align:middle">
                <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" style="width: 100%;" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger" style="width: 100%;" />
            </div>        
        </div>


    </div>
    <div class="col-sm-1" style="vertical-align:middle">
    </div>
</div>






</asp:Content>
