<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="StockLista.aspx.vb" Inherits="EnterpriseTracking.StockLista" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
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

<%-- CONTENIDO DE PANTALLA --%>
<div class="row" style="margin-top:15px;margin-bottom:15px">
    <div class="col-sm-12">
        <asp:Label ID="lblStockListaTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
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
    <div class="col-md-10">
        <asp:GridView ID="grdProductos" runat="server" CssClass="table table-bordered table-hover table-striped" AutoGenerateColumns="False"  DataKeyNames="ID">
            <Columns>
                <asp:BoundField DataField="Categoria" HeaderText="Categoria" >
                <HeaderStyle Width="15%" />
                </asp:BoundField>
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" >
                <HeaderStyle Width="70%" />
                </asp:BoundField>
                <asp:BoundField DataField="Stock" HeaderText="Stock" >
                <HeaderStyle Width="15%" />
                </asp:BoundField>
            </Columns>
                <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </div>
    <div class="col-md-1">
    </div>
</div>

    <div class="row" style="margin-top:30px;">
    <div class="col-sm-1" style="vertical-align:middle"></div>
    <div class="col-md-10" style="max-height:200px">
<%--        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
        <ajaxToolkit:AreaChart ID="StockChart" runat="server" 
                                ChartHeight="300"  ChartType="Basic" 
                                 CategoryAxisLineColor="#D08AD9" 
                                ValueAxisLineColor="#D08AD9" BaseLineColor="#A156AB" Width="100%">
        </ajaxToolkit:AreaChart> --%>
        <div style="width:100%; height:200px;">
            <canvas id="myChart"></canvas>
        </div>
    </div>
    <div class="col-md-1">
    </div>
</div>




<%--    <asp:Chart ID="Chart1" runat="server">
        <Series>
            <asp:Series Name="Series1"></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
    </asp:Chart>--%>
<script>
function dibujarchart() {
    var ctx = document.getElementById('myChart');
    var chart = new Chart(ctx, {
        // The type of chart we want to create
        type: 'line',
        // The data for our dataset
        data: {
            labels: ["Dic", "Ene", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov"],
            datasets: [{
                label: "Stock",
                //backgroundColor: 'rgb(26, 109, 104)',
                borderColor: 'rgb(26, 109, 104)',
                data: [0, 10, 5, 2, 20, 30, 45, 20, 10, 5, 2, 20, 30, 45],
                tension: 0.1,
            }]
        },

        // Configuration options go here
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: {
                duration: 1000, // general animation time
            }
        }
    });
}

</script>
</asp:Content>
