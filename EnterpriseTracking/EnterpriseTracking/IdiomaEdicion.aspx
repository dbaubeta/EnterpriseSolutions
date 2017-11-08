<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="IdiomaEdicion.aspx.vb" Inherits="EnterpriseTracking.EditarLenguaje" %>
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
            <asp:Label ID="lblTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
        </div>
    </div>
    <hr />
    <div class="container-fluid">
      <div class="row" style="margin-bottom:20px">
        <div class="col-sm-1"></div>
        <div class="col-sm-1" style="vertical-align:middle">
            <asp:Label ID="lblLenguajeReferencia" runat="server" Text="Label" Width="100%"></asp:Label>
        </div>
        <div class="col-sm-5" style="vertical-align:middle">
                <asp:DropDownList ID="dlIdiomas" runat="server" CssClass="form-control"  AutoPostBack="True"></asp:DropDownList>
        </div>        
        <div class="col-sm-4" style="vertical-align:middle"></div>

      </div>

      <div class="row" style="margin-bottom:20px">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-1" style="vertical-align:middle">
            <asp:Label ID="lblLenguajeNombre" runat="server" Text="Label" Width="100%"></asp:Label>
        </div>
        <div class="col-sm-5" style="vertical-align:middle">
            <asp:TextBox ID="txtLenguajeNombre" runat="server" style="width:100%" CssClass="form-control" />
        </div>        
      </div>

      <div class="row" style="margin-bottom:20px">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-1" style="vertical-align:middle">
            <asp:Label ID="lblLenguajeCultura" runat="server" Text="Label" Width="100%"></asp:Label>
        </div>
        <div class="col-sm-5" style="vertical-align:middle">
            <asp:TextBox ID="txtLenguajeCultura" runat="server" style="width:100%" CssClass="form-control" />
        </div>        
      </div>

      <div class="row">
        <div class="col-sm-1">
        </div>
        <div class="col-sm-10">
            <div class="container-fluid" style="height:100vh; overflow: scroll;">
                <asp:GridView ID="grdLeyendas" runat="server" CssClass="table table-bordered table-hover table-striped table-condensed" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" >
                <Columns>
                    <asp:BoundField DataField="IDLeyenda" HeaderText="IDLeyenda" >
                    <HeaderStyle Width="15%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TextoLeyenda" HeaderText="TextoLeyenda" >
                    <HeaderStyle Width="15%" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="NuevoTextoLeyenda">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtNuevoTextoLeyenda" runat="server" style="width:100%" CssClass="form-control"/>
                                </div>
                                <div class="col-sm-4">
<%--                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNuevaLeyenda" runat="server" ErrorMessage="Error!" ControlToValidate="txtNuevoTextoLeyenda" />--%>
                                </div>
                            </div>
                        </ItemTemplate>
                        <HeaderStyle Width="70%" />
                    </asp:TemplateField>
                </Columns>
                    <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </div>
        </div>
        <div class="col-sm-1">
        </div>
      </div>
      <div class="row" style="margin-top:10px">
        <div class="col-sm-9">
        </div>
        <div class="col-sm-1">
          <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" style="width: 100%;" />
        </div>
        <div class="col-sm-1">
          <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass ="btn btn-danger" style="width: 100%;"/>
        </div>
        <div class="col-sm-1">
        </div>
    </div>
    </div>
</asp:Content>
