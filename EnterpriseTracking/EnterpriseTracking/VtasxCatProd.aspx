<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="VtasxCatProd.aspx.vb" Inherits="EnterpriseTracking.VtasxCatProd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/Chart.js"></script>
        
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

<!-- Filtrado client side -->
<script>

    function clickenfila() {
        filtrado();
        dibujarcharts();
    }

    function filtrado() {
        // variables 
        var input, filter, table, tr, td, i;
        input = document.getElementById('<%= txtFiltro.ClientID%>');
  filter = input.value.toUpperCase();
  table = document.getElementById('<%= grdVentas.ClientID%>');
  tr = table.getElementsByTagName("tr");

    // oculto las filas que no matchean el filtro
  for (i = 0; i < tr.length; i++) {
      td = tr[i].getElementsByTagName("td")[0];
      if (td) {
          if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
              tr[i].style.display = "";
          } else {

              td2 = tr[i].getElementsByTagName("td")[1];
              if (td2) {
                  if (td2.innerHTML.toUpperCase().indexOf(filter) > -1) {
                      tr[i].style.display = "";
                  } else {
                      tr[i].style.display = "none";
                  }
              }

          }
      }
  }
}
</script>


<%-- CONTENIDO DE PANTALLA --%>
<div class="row" style="margin-top:15px;margin-bottom:15px">
    <div class="col-sm-8">
        <asp:Label ID="lblVtasxCatProdTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
    </div>
    <div class="col-sm-4">
        <div class="col-sm-3" style="vertical-align:middle">
            <asp:Label ID="lblCliente" runat="server" Text="Label" Width="100%" style="text-align: right; margin-top:3px" Font-Bold="true" ></asp:Label>
        </div>
        <div class="col-sm-9" style="vertical-align:middle">
                <asp:DropDownList ID="dlClientes" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
        </div> 
    </div>
</div>
<hr />

<div class="row" style="margin-top:2px;height:100%;">

    <div class="col-sm-1" style="vertical-align:middle"></div>    

    <div class="col-sm-6" style="vertical-align:middle">

        <div class="row" style="margin-top:2px;height:100%;">
            <div class="col-sm-2" style="vertical-align:middle">
                <asp:Label ID="lblDistribuidor" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>
            <div class="col-sm-10" style="vertical-align:middle">
                    <asp:DropDownList ID="dlDistribuidores" runat="server" CssClass="form-control" ></asp:DropDownList>
            </div> 
        </div>
        <div class="row" style="margin-top:2px;margin-bottom:15px">
            <div class="col-sm-2" style="vertical-align:middle">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:Label ID="lblDesde" runat="server" Text="Label" Width="100%" style="text-align: left; margin-top:5px" Font-Bold="true" ></asp:Label>
            </div>
            <div class="col-sm-4" style="vertical-align:middle">
                <asp:TextBox ID="txtDesde" runat="server" CssClass="form-control" ></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server"  PopupButtonID="imgPopup" TargetControlID="txtDesde"/> <%--Format="dd/MM/yyyy"/>--%>
            </div>
            <div class="col-sm-2" style="vertical-align:middle">
                <asp:Label ID="lblHasta" runat="server" Text="Label" Width="100%" style="text-align: left; margin-top:5px" Font-Bold="true" ></asp:Label>
            </div>
            <div class="col-sm-4" style="vertical-align:middle">
                <asp:TextBox ID="txthasta" runat="server" CssClass="form-control" ></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server"  PopupButtonID="imgPopup2" TargetControlID="txthasta"/> <%--Format="dd/MM/yyyy"/>--%>
            </div>
        </div>
        <div class="row" style="margin-top:2px;margin-bottom:15px">
            <div class="col-sm-11" style="vertical-align:middle">
            </div>
            <div class="col-sm-1" style="vertical-align:middle">
                <asp:Button ID="btnProcesar" runat="server" Text="Button" cssclass="btn btn-info"/>
            </div>
        </div>
            
        <div class="row" style="margin-top:15px;margin-bottom:15px">
            <div class="col-sm-4" style="vertical-align:middle"></div>
            <div class="col-sm-8">
                <div class="col-sm-3" style="vertical-align:middle">
                    <asp:Label ID="lblFiltro" runat="server" Text="Label" Width="100%" style="text-align: right; margin-top:5px" Font-Bold="true" ></asp:Label>
                </div>
                <div class="col-sm-9" style="vertical-align:middle">
                    <input type="text" runat="server" id="txtFiltro" onkeyup="filtrado()" class="form-control" style="width:100%">
                </div> 
            </div>

        </div>

        <div class="row" style="margin-top:15px;">
            <div class="col-md-12">
                <asp:GridView ID="grdVentas" runat="server" CssClass="table table-bordered table-hover table-striped table-condensed" AutoGenerateColumns="False"  DataKeyNames="ID">
                    <Columns>
                        <asp:BoundField DataField="Categoria" HeaderText="Categoria" >
                        <HeaderStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" >
                        <HeaderStyle Width="55%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unidades" HeaderText="Unidades" >
                        <HeaderStyle Width="15%" /> 
                        </asp:BoundField>
                        <asp:BoundField DataField="Monto" HeaderText="Monto" >
                        <HeaderStyle Width="15%" />
                        </asp:BoundField>
                    </Columns>
                        <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </div>
        </div>

    </div>
    <div class="col-sm-4" style="vertical-align:middle"><canvas id="torta"></canvas></div> 
    <div class="col-sm-1" style="vertical-align:middle"></div>
</div>


<%-- Selector de distribuidor --%>

<%-- Grafico de Stock Anual --%>
<div class="row" style="margin-top:30px;">
    <div class="col-sm-1" style="vertical-align:middle"></div>
    <div class="col-md-10" style="max-height:200px">
        <div style="width:100%; height:200px;">
            <canvas id="historial"></canvas>
        </div>
    </div>
    <div class="col-md-1">
    </div>
</div>

<asp:Literal ID="LitChart" runat="server"></asp:Literal>
<asp:Literal ID="LitTorta" runat="server"></asp:Literal>
<script>
    function dibujarcharts() {
        dibujarhistorial();
        dibujartorta();
    }
</script>

</asp:Content>
