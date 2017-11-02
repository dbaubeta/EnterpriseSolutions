<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="TransmisionesLista.aspx.vb" Inherits="EnterpriseTracking.TransmisionesLista" %>
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
        <asp:Label ID="lblTransmisionesListaTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
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
        <div class="col-sm-2" style="vertical-align:middle"></div>
    <div class="col-sm-2" style="vertical-align:middle">
        <asp:DropDownList ID="dlmes" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
    </div>
    <div class="col-sm-1" style="vertical-align:middle">
        <asp:DropDownList ID="dlano" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
    </div>
</div>

    <div class="row" style="margin-top:30px;">
        <div class="col-md-1"></div>
        <div class="col-md-3"></div>
    </div>
    <div class="row" style="margin-top:30px;">
        <div class="col-sm-1" style="vertical-align:middle"></div>
        <div class="col-md-8">
            <asp:GridView ID="grdTransmisioness" runat="server" CssClass="table table-bordered table-hover table-striped" AutoGenerateColumns="False" >
                <Columns>
                    <asp:BoundField DataField="Distribuidor" HeaderText="Distribuidor" >
                    <HeaderStyle Width="30%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia01" HeaderText="01" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia02" HeaderText="02" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia03" HeaderText="03" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia04" HeaderText="04" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia05" HeaderText="05" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia06" HeaderText="06" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia07" HeaderText="07" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia08" HeaderText="08" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia09" HeaderText="09" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia10" HeaderText="10" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia11" HeaderText="11" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia12" HeaderText="12" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia13" HeaderText="13" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia14" HeaderText="14" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia15" HeaderText="15" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia16" HeaderText="16" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia17" HeaderText="17" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia18" HeaderText="18" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia19" HeaderText="19" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia20" HeaderText="20" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia21" HeaderText="21" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia22" HeaderText="22" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia23" HeaderText="23" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia24" HeaderText="24" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia25" HeaderText="25" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia26" HeaderText="26" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia27" HeaderText="27" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia28" HeaderText="28" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia29" HeaderText="29" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia30" HeaderText="30" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dia31" HeaderText="31" >
                    <HeaderStyle Width="2%" />
                    </asp:BoundField>
                </Columns>
                    <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </div>

    </div>
</div>

</asp:Content>
