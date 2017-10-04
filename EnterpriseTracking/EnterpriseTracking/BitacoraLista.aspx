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
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
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
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
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
        <asp:Label ID="lblBackupListaTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
    </div>
</div>
<hr />


<div class="row" style="margin-top:30px;height:100%;">
    <div class="col-md-1" style="height:100%;min-height:200px"></div>
    <div class="col-md-10" style="height:100%">
        <div class="row" style="margin-top:30px;">
            <div class="col-md-12">
                <asp:GridView ID="grdBitacora" runat="server" CssClass="table table-bordered table-hover table-striped" AutoGenerateColumns="False" >
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
                        <HeaderStyle Width="70%" />
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
            </div>--%>--%>
        </div>
    </div>
    <div class="col-md-1" style="height:100%;min-height:200px"></div>
</div>

</asp:Content>
