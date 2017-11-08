<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="ProductoLista.aspx.vb" Inherits="EnterpriseTracking.ProductoLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        
<!-- Modal Si No -->
<div id="modalConfirmar" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <asp:Image ID="ImagenSiNo" runat="server" Width="60px" Height="60px"  ImageUrl="~/images/question.png" />
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">
          <asp:Label ID="noTranslateModalMessageSiNo" runat="server" Text="Label"></asp:Label>
      </div>
      <div class="modal-footer">
        <button type="button"  ID="btnModalSi" runat="server" class="btn btn-success" data-dismiss="modal"></button>
        <button type="button"  ID="btnModalNo" runat="server" class="btn btn-danger" data-dismiss="modal"></button>
      </div>
    </div>

  </div>
</div>

<!-- Modal Mensaje -->
<div id="modalMensaje" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <asp:Image ID="ImagenMensaje" runat="server" Width="60px" Height="60px"  ImageUrl="~/images/Warning.png" />
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">
          <asp:Label ID="noTranslateModalMessage" runat="server" Text="Label"></asp:Label>
      </div>
      <div class="modal-footer">
        <button type="button"  ID="btnModalOk" runat="server" class="btn btn-success" data-dismiss="modal"></button>
      </div>
    </div>

  </div>
</div>

<%-- CONTENIDO DE PANTALLA --%>
<div class="row" style="margin-top:15px;margin-bottom:15px">
    <div class="col-sm-12">
        <asp:Label ID="lblProductoListaTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
    </div>
</div>
<hr />

<div class="row" style="margin-top:30px;height:100%;">
    <div class="col-sm-1" style="vertical-align:middle"></div>
    <div class="col-sm-1" style="vertical-align:middle">
        <asp:Label ID="lblCliente" runat="server" Text="Label" Width="100%"></asp:Label>
    </div>
    <div class="col-sm-5" style="vertical-align:middle">
            <asp:DropDownList ID="dlClientes" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
    </div> 
</div>
<div class="row" style="margin-top:30px;">
    <div class="col-sm-1" style="vertical-align:middle"></div>
    <div class="col-md-8">
        <asp:GridView ID="grdProductos" runat="server" CssClass="table table-bordered table-hover table-striped table-condensed" AutoGenerateColumns="False" >
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" >
                <HeaderStyle Width="15%" />
                </asp:BoundField>
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" >
                <HeaderStyle Width="70%" />
                </asp:BoundField>
                <asp:BoundField DataField="Categoria" HeaderText="Categoria" >
                <HeaderStyle Width="15%" />
                </asp:BoundField>
            </Columns>
                <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </div>
    <div class="col-md-3">
        <%-- BOTONES ABM --%>
        <asp:Button ID="btnNuevoProducto" runat="server" Text="Button" style="width:50%" CssClass="btn btn-primary" /> <br/><br/>
        <asp:Button ID="btnEditarProducto" runat="server" Text="Button" style="width:50%" CssClass="btn btn-primary"/> <br/><br/>
        <asp:Button ID="btnEliminarProducto" runat="server" Text="Button" style="width:50%" CssClass="btn btn-danger"/> <br/>
    </div>
</div>

</asp:Content>
