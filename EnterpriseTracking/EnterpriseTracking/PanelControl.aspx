<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="PanelControl.aspx.vb" Inherits="EnterpriseTracking.PanelControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
<script type="text/javascript">
    function openModalJustificacion() {
        $('#modalJustificacion').modal('show');
    }
    function openModalJustificacionBorrado() {
        $('#modalJustificacionborrado').modal('show');
    }
</script>


<!-- Modal Si No -->
<div id="modalConfirmar" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <asp:Image ID="ImagenSiNo" runat="server" Width="60px" Height="60px"  ImageUrl="~/images/question.png" />
        <button type="button" class="close" data-dismiss="modal">&times;</button>
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

<!-- Modal Justificacion -->
<div id="modalJustificacion" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <asp:Label ID="lblJustificacionTitulo" runat="server" Text="Label" Font-Size="X-Large" ></asp:Label>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
          <asp:Label ID="noTranslateModalDistribuidorJustificacion" runat="server" Text="Label"></asp:Label>
          <asp:Label ID="noTranslateModalFechaJustificacion" runat="server" Text="Label"></asp:Label><br/>
          <asp:TextBox ID="txtjustificacion" runat="server" style="width:100%" CssClass="form-control" />
      </div>
      <div class="modal-footer">
        <asp:Button runat="server" ID="btnModalAceptar" Text="" cssclass="btn btn-success" OnClick="Aceptar_Click" />
        <button type="button"  ID="btnModalCancelar" runat="server" class="btn btn-danger" data-dismiss="modal"></button>
      </div>
    </div>

  </div>
</div>
    


<%-- CONTENIDO DE PANTALLA --%>
<div class="row" style="margin-top:10px;margin-bottom:15px">
    <div class="col-sm-12">
        <asp:Label ID="lblTransmisionesListaTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
    </div>
</div>
<hr />

<div class="row" style="margin-top:5px;height:100%;">
    <div class="col-sm-1" style="vertical-align:middle"></div>
    <div class="col-sm-1" style="vertical-align:middle">
        <asp:Label ID="lblCliente" runat="server" Text="Label" Width="100%"></asp:Label>
    </div>
    <div class="col-sm-5" style="vertical-align:middle">
        <asp:DropDownList ID="dlClientes" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
    </div>
</div> 
<div class="row" style="margin-top:5px;">
        <div class="col-sm-2" style="vertical-align:middle"></div>
    <div class="col-sm-2" style="vertical-align:middle">
        <asp:DropDownList ID="dlmes" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
    </div>
    <div class="col-sm-1" style="vertical-align:middle">
        <asp:DropDownList ID="dlano" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
    </div>
</div>

<div class="row" style="margin-top:20px;">
    <div class="col-sm-2" style="vertical-align:middle"></div>
    <div class="col-md-8" style=" overflow-x:auto; min-height:100%">
        <asp:GridView ID="grdTransmisiones" runat="server" CssClass="table table-bordered table-hover table-striped table-condensed" AutoGenerateColumns="False" DataKeyNames="ID"  >
            <Columns>
                <asp:BoundField DataField="Distribuidor" HeaderText="Distribuidor" ItemStyle-HorizontalAlign="Left" >
                <HeaderStyle Width="60%" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Porcentaje">
                    <ItemTemplate>
                        <asp:Literal ID="LitPorcentaje" runat="server"></asp:Literal>
                    </ItemTemplate>
                    <HeaderStyle Width="20%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Invasion"  >
                    <ItemTemplate>
                        <asp:ImageButton ID="ImgInvasion" runat="server" ImageURL="Images/error.png" Width="25px" Height="25px"/>
                    </ItemTemplate>
                    <HeaderStyle Width="10%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Stock critico" HeaderStyle-HorizontalAlign="Center" >
                    <ItemTemplate>
                        <asp:ImageButton ID="ImgStockCritico" runat="server" Width="25px" Height="25px" />
                    </ItemTemplate>
                    <HeaderStyle Width="10%" />
                    
                </asp:TemplateField>
            </Columns>
                <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center"/>
                <RowStyle HorizontalAlign="Center" ></RowStyle>
        </asp:GridView>
    </div>
    <div class="col-sm-2" style="vertical-align:middle"></div>
</div>



</asp:Content>
