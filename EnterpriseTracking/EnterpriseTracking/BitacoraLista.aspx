<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="BitacoraLista.aspx.vb" Inherits="EnterpriseTracking.BitacoraLista" %>
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
  table = document.getElementById('<%= grdBitacora.ClientID%>');
  tr = table.getElementsByTagName("tr");

    // oculto las filas que no matchean el filtro
  for (i = 0; i < tr.length; i++) {
      td = tr[i].getElementsByTagName("td")[1];
      if (td) {
          if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
              tr[i].style.display = "";
          } else {

              td2 = tr[i].getElementsByTagName("td")[2];
              if (td2) {
                  if (td2.innerHTML.toUpperCase().indexOf(filter) > -1) {
                      tr[i].style.display = "";
                  } else {

                      td3 = tr[i].getElementsByTagName("td")[3];
                      if (td3) {
                          if (td3.innerHTML.toUpperCase().indexOf(filter) > -1) {
                              tr[i].style.display = "";
                          } else {
                              tr[i].style.display = "none";
                          }
                      }


                  }
              }

          }
      }
  }
}
</script>


<%-- CONTENIDO DE PANTALLA --%>
<div class="row" style="margin-top:15px;margin-bottom:15px">
    <div class="col-sm-12">
        <asp:Label ID="lblBackupListaTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
    </div>
</div>
<hr />

<div class="row" style="margin-top:2px;margin-bottom:2px">
    <div class="col-sm-1" style="vertical-align:middle"></div>
    <div class="col-sm-5" style="vertical-align:middle">
        <div class="row" style="margin-top:2px;margin-bottom:5px">
            <div class="col-sm-2" style="vertical-align:middle">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:Label ID="lblDesde" runat="server" Text="Label" Width="100%" style="text-align: left; margin-top:5px" Font-Bold="true" ></asp:Label>
            </div>
            <div class="col-sm-4" style="vertical-align:middle">
                <asp:TextBox ID="txtDesde" runat="server" CssClass="form-control" style="width:100%" ></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="imgPopup" TargetControlID="txtDesde" /> <%--Format="dd/MM/yyyy"/>--%>
            </div>
            <div class="col-sm-2" style="vertical-align:middle">
                <asp:Label ID="lblHasta" runat="server" Text="Label" Width="100%" style="text-align: left; margin-top:5px" Font-Bold="true" ></asp:Label>
            </div>
            <div class="col-sm-4" style="vertical-align:middle">
                <asp:TextBox ID="txthasta" runat="server" CssClass="form-control" width="100%" ></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" PopupButtonID="imgPopup2" TargetControlID="txthasta"/> <%--Format="dd/MM/yyyy"/>--%>
            </div>
        </div>

    </div>
    <div class="col-sm-5" style="vertical-align:bottom"></div>
    <div class="col-sm-1" style="vertical-align:middle"></div>
</div>

<div class="row" style="margin-top:2px;">
    <div class="col-sm-1" style="vertical-align:bottom"></div>
    <div class="col-sm-5" style="vertical-align:bottom">
        <div class="row" style="margin-top:2px;margin-bottom:5px">
            <div class="col-sm-10" style="vertical-align:middle"></div>
            <div class="col-sm-2" style="vertical-align:middle">
                <asp:Button ID="btnProcesar" runat="server" Text="Button" cssclass="btn btn-info" Width="100%"/>
            </div>
        </div>
    </div>
    <div class="col-sm-5" style="vertical-align:bottom">
        <div class="col-sm-3" style="vertical-align:bottom">
            <asp:Label ID="lblFiltro" runat="server" Text="Label" Width="100%" style="text-align: right; margin-top:5px" Font-Bold="true" ></asp:Label>
        </div>
        <div class="col-sm-9" style="vertical-align:bottom">
            <input type="text" runat="server" id="txtFiltro" onkeyup="filtrado()" class="form-control" style="width:100%">
        </div> 
    </div>
</div>


<div class="row" style="margin-top:1px;height:100%;">
    <div class="col-md-1" style="height:100%;min-height:200px"></div>
    <div class="col-md-10" style="height:100%">
        <div class="row" style="margin-top:5px;">
            <div class="col-md-12">
                <asp:GridView ID="grdBitacora" runat="server" CssClass="table table-bordered table-hover table-striped table-condensed" AutoGenerateColumns="False" >
                    <Columns>
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" >
                        <HeaderStyle Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" >
                        <HeaderStyle Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Modulo" HeaderText="Modulo" >
                        <HeaderStyle Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Mensaje" HeaderText="Mensaje" >
                        <HeaderStyle Width="40%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Datos" HeaderText="Datos" >
                        <HeaderStyle Width="40%" />
                        </asp:BoundField>
                    </Columns>
                        <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </div>
<%--            <div class="col-md-3">
                <%-- BOTONES ABM --%>
<%--                <asp:Button ID="btnNuevoBackup" runat="server" Text="Button" style="width:50%" CssClass="btn btn-primary" /> <br/><br/>
                <asp:Button ID="btnRestore" runat="server" Text="Button" style="width:50%" CssClass="btn btn-primary"/> <br/><br/>
                <asp:Button ID="btnEliminarBackup" runat="server" Text="Button" style="width:50%" CssClass="btn btn-danger"/> <br/>
            </div>--%>
        </div>
    </div>
    <div class="col-md-1" style="height:100%;min-height:200px"></div>
</div>

</asp:Content>
