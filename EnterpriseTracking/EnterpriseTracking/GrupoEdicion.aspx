<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="GrupoEdicion.aspx.vb" Inherits="EnterpriseTracking.GrupoEdicion" %>
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
                <asp:Label ID="lblTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
            </div>
        </div>
        <hr />

        <div class="row" style="margin-top:10px;margin-bottom:15px;">
            <div class="col-sm-2" style="padding-top:3px">
                <asp:Label ID="lblGrupoID" runat="server" Text="Label" Width="100%" Font-Bold="true" style="text-align:right;"></asp:Label><br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:Label ID="noTranslateGrupoID" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-2" style="padding-top:8px">
                <asp:Label ID="lblGrupoNombre" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-3" style="padding-top:3px">
                <asp:TextBox ID="txtGrupoNombre" runat="server" style="width:100%" CssClass="form-control" />
<%--                <asp:RequiredFieldValidator ID="RqFVtxtGrupoNombre" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtGrupoNombre" ></asp:RequiredFieldValidator>--%>
            </div>        
        </div>

        <div class="row" style="margin-top:20px">
            <div class="col-sm-5" style="padding-top:8px">
                <div class="container-fluid" style="min-height:25vh; height:25vh; overflow-y: scroll; overflow-x:hidden; border:1px solid #cecece; padding-left:0px"  >
                    <asp:GridView ID="grdGruposDisponibles" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="table-condensed" GridLines="None" style="width:103%">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID"></asp:BoundField>
                        <asp:BoundField DataField="nombretraducido" HeaderText="nombretraducido" ><HeaderStyle Width="84.9%" /></asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelected" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="15%" />
                            <ItemStyle HorizontalAlign="Center"  />
                        </asp:TemplateField>
                    </Columns>
                        <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
                        <rowstyle height="10" />
                    </asp:GridView>
                </div>
                <div class=" container-fluid " style="min-height:25vh; height:25vh; overflow-y: scroll; overflow-x:hidden; border:1px solid #cecece; padding-left:0px"  >
                    <asp:GridView ID="grdPermisosDisponibles" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="table-condensed" GridLines="None" style="width:103%">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID"></asp:BoundField >
                        <asp:BoundField DataField="nombretraducido" HeaderText="nombretraducido" ><HeaderStyle Width="84.9%" /></asp:BoundField>
                        <asp:TemplateField  >
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelected" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="15%" />
                            <ItemStyle HorizontalAlign="Center"  />
                        </asp:TemplateField>
                    </Columns>
                        <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
                        <rowstyle height="10" />
                    </asp:GridView>
                </div>


            </div>

            <div class="col-sm-1" style="padding-top:8px; text-align:center;">
                <br/><br/>
                <asp:ImageButton ID="noTranslateImgFlechaDerecha" runat="server" ImageUrl='/Images/Flecha-derecha.png' Width="90px" Height="90px"></asp:ImageButton>
                <br/>
                <asp:ImageButton ID="noTranslateImgFlechaIzquierda" runat="server" ImageUrl='/Images/Flecha-izquierda.png' Width="90px" Height="90px"></asp:ImageButton>
            </div>
            

            <div class="col-sm-5" style="padding-top:8px">
                <div class=" container-fluid " style="min-height:50vh; height:100%; overflow-y: scroll; overflow-x:hidden; border:1px solid #cecece; padding-left:0px"  >
                    <asp:GridView ID="grdElementosSeleccionados" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="table-condensed" GridLines="None" style="width:103%">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID"></asp:BoundField>
                        <asp:BoundField DataField="nombretraducido" HeaderText="nombretraducido" ><HeaderStyle Width="84.9%" /></asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelected" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="15%" />
                            <ItemStyle HorizontalAlign="Center"  />
                        </asp:TemplateField>
                    </Columns>
                        <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
                        <rowstyle height="10" />
                    </asp:GridView>
                </div>

            </div>
        </div>


        <div class="row" style="margin-top:20px">
            <div class="col-sm-8">
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
