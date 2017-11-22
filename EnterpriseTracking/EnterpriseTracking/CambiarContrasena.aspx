﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="CambiarContrasena.aspx.vb" Inherits="EnterpriseTracking.CambiarContrasena" %>
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

<div class="row" style="margin-bottom:20px">
    <div class="col-sm-1" style="vertical-align:middle">
    </div>
    <div class="col-sm-10" style="vertical-align:middle">
        <%-- CONTENIDO DE PANTALLA --%>
        <div class="row" style="margin-top:15px;margin-bottom:15px">
            <div class="col-sm-12">
                <asp:Label ID="lblCambiarContrasenaTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
            </div>
        </div>
        <hr />

        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-2" style="padding-top:8px">
                <asp:Label ID="lblContrasenaActual" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:TextBox runat="server" ID="txtcontrasena" TextMode="Password" CssClass="form-control" />
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-2" style="padding-top:8px">
                <asp:Label ID="lblNuevaContrasena" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:TextBox runat="server" ID="txtNuevaContrasena" TextMode="Password" CssClass="form-control" />
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-2" style="padding-top:8px">
                <asp:Label ID="lblRepetircontrasena" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:TextBox runat="server" ID="txtRepetirContrasena" TextMode="Password" CssClass="form-control" />
            </div>        
        </div>
        <div class="row" style="margin-top:20px">
            <div class="col-sm-9">
            </div>
            <div class="col-sm-3">
                <div class="row">
                    <div class="col-sm-6">
                    </div>
                    <div class="col-sm-6">
                        <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" style="width:100%" />
                    </div>
                </div>
            </div>        
        </div>


    </div>
    <div class="col-sm-1" style="vertical-align:middle">
    </div>
</div>

</asp:Content>