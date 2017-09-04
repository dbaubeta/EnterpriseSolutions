<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="EditarLenguaje.aspx.vb" Inherits="EnterpriseTracking.EditarLenguaje" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-10">
            <div style="width: 100%; height: 400px; overflow: scroll">
                <asp:GridView ID="grdLeyendas" runat="server" CssClass="table table-hover table-striped" AutoGenerateColumns="False" >
                <Columns>
                    <asp:BoundField DataField="IDLeyenda" HeaderText="IDLeyenda" />
                    <asp:BoundField DataField="TextoLeyenda" HeaderText="TextoLeyenda" />
                    <asp:TemplateField HeaderText="NuevoTextoLeyenda">
                    <ItemTemplate>
                    <asp:TextBox ID="txtNuevoTextoLeyenda" runat="server"/>
                    </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                </asp:GridView>
            </div>
        </div>
        <div class="col-sm-1">
        </div>
      </div>
      <div class="row">
        <div class="col-sm-9">
        </div>
        <div class="col-sm-1">
          <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" style="width: 100%;" />
        </div>
        <div class="col-sm-1">
          <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass ="btn btn-danger" style="width: 100%;"/>
        </div>
        <div class="col-sm-1">
        </div>
    </div>


    </div>
</asp:Content>
