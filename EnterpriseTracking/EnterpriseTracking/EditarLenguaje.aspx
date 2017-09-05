<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="EditarLenguaje.aspx.vb" Inherits="EnterpriseTracking.EditarLenguaje" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
      <div class="row" style="margin-bottom:20px">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-1" style="vertical-align:middle">
            <asp:Label ID="lblLenguajeNombre" runat="server" Text="Label" Width="100%"></asp:Label>
        </div>
        <div class="col-sm-5" style="vertical-align:middle">
            <asp:TextBox ID="txtLenguajeNombre" runat="server" style="width:100%" CssClass="form-control" />
        </div>        
        <div class="col-sm-4" style="vertical-align:middle">
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorLenguajeNombre" runat="server" ErrorMessage="Error!" ControlToValidate="txtLenguajeNombre" />
        </div>

      </div>
      <div class="row">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-10">
            <div class="container-fluid" style="height:100vh; overflow: scroll">
                <asp:GridView ID="grdLeyendas" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" >
                <Columns>
                    <asp:BoundField DataField="IDLeyenda" HeaderText="IDLeyenda" >
                    <HeaderStyle Width="20%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TextoLeyenda" HeaderText="TextoLeyenda" >
                    <HeaderStyle Width="20%" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="NuevoTextoLeyenda">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtNuevoTextoLeyenda" runat="server" style="width:100%" CssClass="form-control"/>
                                </div>
                                <div class="col-sm-8">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNuevaLeyenda" runat="server" ErrorMessage="Error!" ControlToValidate="txtNuevoTextoLeyenda" />
                                </div>
                            </div>
                        </ItemTemplate>
                        <HeaderStyle Width="60%" />
                    </asp:TemplateField>
                </Columns>
                </asp:GridView>
            </div>
        </div>
        <div class="col-sm-1">
        </div>
      </div>
      <div class="row" style="margin-top:10px">
        <div class="col-sm-10">
        </div>
        <div class="col-sm-1">
          <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" style="width: 100%;" />
        </div>
<%--        <div class="col-sm-1">
          <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass ="btn btn-danger" style="width: 100%;"/>
        </div>--%>
        <div class="col-sm-1">
        </div>
    </div>
    </div>
</asp:Content>
