<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="TransmisionesLista.aspx.vb" Inherits="EnterpriseTracking.TransmisionesLista" EnableEventValidation="false" %>  
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

    <div class="row" style="margin-top:15px;">
        <div class="col-md-1"></div>
        <div class="col-md-11">
            <asp:Image ID="ImgFactPresente" runat="server" ImageUrl="~/Images/Success.png" Height="20px" Width="20px"/>
            <asp:Label ID="noTranslateFactPresente" runat="server" Text="Label"></asp:Label>
            <asp:Image ID="ImgFactFaltante" runat="server" ImageUrl="~/Images/Error.png" style="margin-left:10px" Height="20px" Width="20px"/>
            <asp:Label ID="noTranslateFactFaltante" runat="server" Text="Label"></asp:Label>
            <asp:Image ID="ImgJustificado" runat="server" ImageUrl="~/Images/justificado.png" style="margin-left:10px" Height="20px" Width="20px"/>
            <asp:Label ID="noTranslateJustificado" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
    <div class="row" style="margin-top:5px;">
        <div class="col-sm-1" style="vertical-align:middle"></div>
        <div class="col-md-10" style=" overflow-x:auto; box-shadow: 2px 2px 1px #888888; min-height:100%">
            <asp:GridView ID="noTranslategrdTransmisiones" runat="server" CssClass="table table-bordered table-hover table-striped" AutoGenerateColumns="False" >
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" >
                    <HeaderStyle Width="30px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Distribuidor" HeaderText="Distribuidor" >
                    <HeaderStyle Width="150px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px" >
                        <ItemTemplate>
                            <asp:ImageButton ID="idia1" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia2" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia3" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia4" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia5" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia6" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia7" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia8" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia9" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia10" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia11" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia12" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia13" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia14" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia15" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia16" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia17" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia18" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia19" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia20" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia21" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia22" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia23" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia24" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia25" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia26" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia27" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia28" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia29" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia30" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="22px" ItemStyle-Width="22px">
                        <ItemTemplate>
                            <asp:ImageButton ID="idia31" runat="server"  
                                 OnClick="ImagenClick" ToolTip="" Height="20px" Width="20px"
                                CommandArgument='<%# Container.DataItemIndex + 1 %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                    <HeaderStyle BackColor="#0C5991" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </div>
        <div class="col-sm-1" style="vertical-align:middle"></div>
        

    </div>


</asp:Content>
