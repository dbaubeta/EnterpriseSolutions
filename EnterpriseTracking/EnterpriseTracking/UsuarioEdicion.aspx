﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="UsuarioEdicion.aspx.vb" Inherits="EnterpriseTracking.UsuarioEdicion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- Modal -->
<div id="modalConfirmar" class="modal fade" role="dialog">
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
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
                <asp:Label ID="lblTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
            </div>
        </div>
        <hr />

        <div class="row" style="margin-top:10px;margin-bottom:15px;">
            <div class="col-sm-2" style="padding-top:3px">
                <asp:Label ID="lblUsuarioID" runat="server" Text="Label" Width="100%" Font-Bold="true" style="text-align:right;"></asp:Label><br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:Label ID="noTranslateUsuarioID" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-2" style="padding-top:8px">
                <asp:Label ID="lblUsuarioNombre" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:TextBox ID="txtUsuarioNombre" runat="server" style="width:100%" CssClass="form-control" />
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-2" style="padding-top:8px">
                <asp:Label ID="lblContraseña" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:TextBox ID="txtContraseña" runat="server" style="width:100%" CssClass="form-control" textmode="Password" />
            </div>        
        </div>
        <%-- DROPDOWN LIST --%>
        <div class="row" style="margin-top:10px">
            <div class="col-sm-2" style="padding-top:8px">
                <asp:Label ID="lblUsuarioIdioma" runat="server" Text="Label" Width="100%" Font-Bold="true" style="text-align:right;"></asp:Label><br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:DropDownList ID="dlIdiomas" runat="server" CssClass="form-control"  AutoPostBack="False"></asp:DropDownList>
            </div>        
        </div>
        <%-- CHECKBOX --%>
        <div class="row" style="margin-top:10px">
            <div class="col-sm-2" style="padding-top:5px">
                <asp:Label ID="lblUsuarioabilitado" runat="server" Text="Label" Width="100%" Font-Bold="true" style="text-align:right;"></asp:Label>
            </div>
            <div class="col-sm-3" style="padding-top:5px">
			    <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-default btn-xs">
				        <input type="checkbox" hidden="hidden" runat="server" ID="chkHabilitado">
				        <span class="glyphicon glyphicon-ok"></span>
			        </label>            
                </div>
            </div>        
        </div>
        <div class="row" style="margin-top:20px">
            <div class="col-sm-9">
            </div>
            <div class="col-sm-3">
                <div class="row">
                    <div class="col-sm-6">
                        <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" style="width:100%" />
                    </div>
                    <div class="col-sm-6">
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger" style="width:100%"  />
                    </div>
                </div>
            </div>        
        </div>


    </div>
    <div class="col-sm-1" style="vertical-align:middle">
    </div>
</div>






</asp:Content>