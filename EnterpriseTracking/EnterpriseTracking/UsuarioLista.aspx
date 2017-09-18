<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="UsuarioLista.aspx.vb" Inherits="EnterpriseTracking.UsuarioLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="row" style="margin-top:30px;height:100%;">
    <div class="col-md-1" style="height:100%;min-height:200px"></div>
    <div class="col-md-10" style="height:100%">
        <div class="row" style="margin-top:30px;">
            <div class="col-md-9">
                <asp:GridView ID="grdUsuarios" runat="server" CssClass="table table-bordered table-hover table-striped" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" >
                        <HeaderStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" >
                        <HeaderStyle Width="55%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Idioma" HeaderText="Idioma" >
                        <HeaderStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Habilitado" HeaderText="Habilitado" >
                        <HeaderStyle Width="15%" />
                        </asp:BoundField>
                    </Columns>
                        <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </div>
            <div class="col-md-3">
                <%-- BOTONES ABM --%>
                <asp:Button ID="btnNuevoUsuario" runat="server" Text="Button" /> <br/>
                <asp:Button ID="btnEditarUsuario" runat="server" Text="Button" /> <br/>
                <asp:Button ID="btnEliminarUsuario" runat="server" Text="Button" /> <br/>
            </div>
        </div>
    </div>
    <div class="col-md-1" style="height:100%;min-height:200px"></div>
</div>
</asp:Content>
