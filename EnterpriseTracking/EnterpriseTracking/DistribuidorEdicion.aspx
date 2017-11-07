<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="DistribuidorEdicion.aspx.vb" Inherits="EnterpriseTracking.DistribuidorEdicion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<!-- Referencia a API Google maps -->    
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBclJiCQNdKGN5FV5Xr1elig-2Yk32vx8A"></script>

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
                <asp:Label ID="lblTitulo" runat="server" Text="Label" Width="100%" Font-Size="XX-Large" ></asp:Label>
            </div>
        </div>
        <hr />
    </div>
    <div class="col-sm-1" style="vertical-align:middle">
    </div>
</div>
<div class="row" style="margin-bottom:20px">
    <div class="col-sm-1" style="vertical-align:middle">
    </div>
    <div class="col-sm-5" style="vertical-align:middle">
        <div class="row" style="margin-top:10px;margin-bottom:15px;">
            <div class="col-sm-3" style="padding-top:3px">
                <asp:Label ID="lblDistribuidorID" runat="server" Text="Label" Width="100%" Font-Bold="true" style="text-align:right;"></asp:Label><br/>
            </div>    
            <div class="col-sm-8" style="padding-top:3px">
                <asp:Label ID="noTranslateDistribuidorID" runat="server" Text="Label" Width="100%"></asp:Label>
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-3" style="padding-top:8px">
                <asp:Label ID="lblIDReal" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-8" style="padding-top:3px">
                <asp:TextBox ID="txtIDRealDistribuidor" runat="server" style="width:100%" CssClass="form-control" />
<%--                <asp:RequiredFieldValidator ID="RqFVtxtDistribuidorNombre" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtDistribuidorNombre" ></asp:RequiredFieldValidator>--%>
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-3" style="padding-top:8px">
                <asp:Label ID="lblDistribuidorNombre" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-8" style="padding-top:3px">
                <asp:TextBox ID="txtDistribuidorNombre" runat="server" style="width:100%" CssClass="form-control" />
<%--                <asp:RequiredFieldValidator ID="RqFVtxtDistribuidorNombre" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtDistribuidorNombre" ></asp:RequiredFieldValidator>--%>
            </div>        
        </div>
        <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-3" style="padding-top:8px">
                <asp:Label ID="lblmail" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-8" style="padding-top:3px">
                <asp:TextBox ID="txtmail" runat="server" style="width:100%" CssClass="form-control" />
            </div>        
        </div>
        <%-- DROPDOWN LIST --%>
        <div class="row" style="margin-top:10px">
            <div class="col-sm-3" style="padding-top:8px">
                <asp:Label ID="lblDistribuidorProvincia" runat="server" Text="Label" Width="100%" Font-Bold="true" style="text-align:right;"></asp:Label><br/>
            </div>    
            <div class="col-sm-8" style="padding-top:3px">
                <asp:DropDownList ID="dlProvincias" runat="server" CssClass="form-control"  AutoPostBack="False"></asp:DropDownList>
            </div>        
        </div>
        <%-- DROPDOWN LIST --%>
        <div class="row" style="margin-top:10px">
            <div class="col-sm-3" style="padding-top:8px">
                <asp:Label ID="lblDistribuidorUsuario" runat="server" Text="Label" Width="100%" Font-Bold="true" style="text-align:right;"></asp:Label><br/>
            </div>    
            <div class="col-sm-8" style="padding-top:3px">
                <asp:DropDownList ID="dlUsuarios" runat="server" CssClass="form-control"  AutoPostBack="False"></asp:DropDownList>
            </div>        
        </div>
        <%-- LABEL + Checks --%>
        <div class="row" style="margin-top:10px" >
            <div class="col-sm-3" style="padding-top:8px">
                <asp:Label ID="lblDiasFacturacion" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div>    
            <div class="col-sm-8" style="padding-top:3px">
                <asp:Label ID="DomingoCorto" runat="server" Text="Label" ></asp:Label><asp:CheckBox ID="chkDomingo" runat="server" />
                <asp:Label ID="LunesCorto" runat="server" Text="Label" style="margin-left:5px"></asp:Label><asp:CheckBox ID="chkLunes" runat="server" />
                <asp:Label ID="MartesCorto" runat="server" Text="Label" style="margin-left:5px"></asp:Label><asp:CheckBox ID="chkMartes" runat="server" />
                <asp:Label ID="MiercolesCorto" runat="server" Text="Label" style="margin-left:5px"></asp:Label><asp:CheckBox ID="chkMiercoles" runat="server" />
                <asp:Label ID="JuevesCorto" runat="server" Text="Label" style="margin-left:5px"></asp:Label><asp:CheckBox ID="chkJueves" runat="server" />
                <asp:Label ID="ViernesCorto" runat="server" Text="Label" style="margin-left:5px"></asp:Label><asp:CheckBox ID="chkViernes" runat="server" />
                <asp:Label ID="SabadoCorto" runat="server" Text="Label" style="margin-left:5px"></asp:Label><asp:CheckBox ID="chkSabado" runat="server" />
            </div>        
        </div>

    </div>
    <div class="col-sm-5" style="vertical-align:middle">
                <%-- LABEL + TEXTBOX --%>
        <div class="row" style="margin-top:5px" >
             <div class="col-sm-3" style="padding-top:8px">
                <asp:Label ID="lblAreaVentas" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
            </div> 
             <div class="col-sm-8" style="padding-top:8px">
                <div class="row">
                    <div class="col-sm-4" style="padding-top:8px">
                        <asp:Label ID="lblAreaVentasLat" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
                    </div>    
                    <div class="col-sm-7" style="padding-top:3px">
                        <asp:Textbox ID="txtAreaVentasLat" runat="server" style="width:100%" CssClass="form-control" />
                    </div>        
                </div>
                <%-- LABEL + TEXTBOX --%>
                <div class="row" style="margin-top:5px" >
                    <div class="col-sm-4" style="padding-top:8px">
                        <asp:Label ID="lblAreaVentasLong" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
                    </div>    
                    <div class="col-sm-7" style="padding-top:3px">
                        <asp:Textbox ID="txtAreaVentasLong" runat="server" style="width:100%" CssClass="form-control" />
                    </div>        
                </div>
                <%-- LABEL + TEXTBOX --%>
                <div class="row" style="margin-top:5px" >
                    <div class="col-sm-4" style="padding-top:8px">
                        <asp:Label ID="lblAreaVentasRadio" runat="server" Text="Label" Font-Bold="true" Width="100%" style="text-align:right;"></asp:Label> <br/>
                    </div>    
                    <div class="col-sm-5" style="padding-top:3px">
                        <asp:TextBox ID="txtAreaVentasRadio" runat="server" style="width:100%" CssClass="form-control" />
                    </div>        
                    <div class="col-sm-3" style="padding-top:3px">
                        <asp:Button ID="btndibujarmapa" runat="server" CssClass="btn btn-default" style="width:100%"  />
                    </div>        
                </div>
            </div>
        </div>
        <%-- MAPA --%>
        <div class="row" style="margin-top:5px" >
            <div class="col-sm-12" style="padding-top:8px">
                <script type="text/javascript">
                    var oldmarker = new google.maps.Marker;
                    var oldcircle = new google.maps.Circle;
                    window.onload = function () {
                        if (navigator.geolocation) {
                            navigator.geolocation.getCurrentPosition(function (position) {
                                var latitude = position.coords.latitude;
                                var longitude = position.coords.longitude;
                                var mapOptions = {
                                    center: new google.maps.LatLng(latitude, longitude),
                                    zoom: 14,
                                    mapTypeId: google.maps.MapTypeId.ROADMAP
                                };
                                var infoWindow = new google.maps.InfoWindow();
                                var latlngbounds = new google.maps.LatLngBounds();
                                var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
                                google.maps.event.addListener(map, 'click', function (e) {
                                    var latlng = new google.maps.LatLng(e.latLng.lat(), e.latLng.lng());
                                    var geocoder = geocoder = new google.maps.Geocoder();
                                    geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                                        if (status == google.maps.GeocoderStatus.OK) {
                                            if (results[1]) {
                                                oldmarker.setMap(null);
                                                var marker = new google.maps.Marker({ position: latlng, map: map });
                                                oldmarker=marker;
                                                document.getElementById("<%=txtAreaVentasLat.ClientID%>").value = e.latLng.lat();
                                                document.getElementById("<%=txtAreaVentasLong.ClientID%>").value = e.latLng.lng();
                                                oldcircle.setMap(null);
                                                var circleoptions = { strokeColor: '#800000', strokeOpacity: 1.0, strokeWeight: 1, fillColor: '#C64D45', fillOpacity: 0.5, map: map, center: latlng, radius: parseInt(document.getElementById("<%=txtAreaVentasRadio.ClientID%>").value) };
                                                circle = new google.maps.Circle(circleoptions);
                                                oldcircle = circle;

                                            }
                                        }
                                    });
                                });
                            });
                        } else {
                            alert("Geolocation API is not supported in your browser.");
                        }
                    }
                </script>
                <div id="dvMap" style="width: 100%; height: 350px"></div>
            </div>
        </div>    
    </div>
    <div class="col-sm-1" style="vertical-align:middle">
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
<%--<asp:Literal ID="LitMaps" runat="server"></asp:Literal>--%>
</asp:Content>
