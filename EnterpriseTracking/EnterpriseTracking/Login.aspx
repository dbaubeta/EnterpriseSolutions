<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="EnterpriseTracking.Login" %>
<!DOCTYPE html>
<link href="Content/bootstrap.css" rel="stylesheet" />
<script src="Scripts/jquery-1.9.1.js"></script>
<script src="Scripts/bootstrap.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function openModalSiNo() {
            $('#modalConfirmar').modal('show');
        }
   </script>
    <script type="text/javascript">
        function openModalOk() {
            $('#modalMensaje').modal('show');
        }
   </script>
         <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBclJiCQNdKGN5FV5Xr1elig-2Yk32vx8A&sensor=false">
     </script>
</head>
<body  onload="initialize()">
    <form runat="server">
        <nav class="navbar navbar-inverse">
          <div class="container-fluid">
            <div class="row" style="margin-bottom:10px;margin-top:10px">
              <div class="col-sm-10">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">Enterprise</a>
                </div>
                <ul class="nav navbar-nav"></ul>
              </div>
            <%-- IDIOMAS--%>              
              <div class="col-sm-2" style="height:100%;vertical-align:middle;">
                    <asp:DropDownList ID="dlIdiomas" runat="server" CssClass="form-control"  AutoPostBack="True" style="vertical-align:middle;"></asp:DropDownList>
              </div>
            </div>
        </div>
        </nav>
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

    <div class="container-fluid body-content" style="margin-left:15px; margin-right:15px">
    <div class="alert alert-danger" id="msjError" runat="server">
        <strong>Danger!</strong> 
    </div>
    <div class="row" style="margin-top:30px;">
        <div class="col-md-7">
                  <asp:Label ID="lblEnterpriseTracking" runat="server" Text="Enterprise Tracking" Font-Size="XX-Large"></asp:Label><br/>
                  <asp:Label ID="lblDescripcionSistema" runat="server" Text="Label" Font-Size="Large"></asp:Label>
        </div>
        <div class="col-md-5">
            <section id="loginForm">
                <div class="form-horizontal panel panel-default" style="padding:15px">
                    <asp:Label ID="lblIngresesusdatos" runat="server" Text="Label" Font-Size="Large"></asp:Label>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <asp:Label runat="server" Id="lblUsuario" AssociatedControlID="txtUsuario" CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtUsuario" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidatorErrorUsuario" ControlToValidate="txtUsuario" CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="lblPassword" AssociatedControlID="txtcontrasena" CssClass="col-md-2 control-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtcontrasena" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidatorErrorPassword" ControlToValidate="txtcontrasena" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" ID="btnLogin" OnClick="LogIn" Text="Log in" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
                <p> </p>
            </section>
        </div>

          <div id="mapArea" style="width: 500px; height: 500px;">
          </div>
 
          <asp:Literal ID="Literal2" runat="server"></asp:Literal>

<%--        <script type='text/javascript'>function initialize() {var mapOptions = {center: new google.maps.LatLng(28.3213, 77.5435),zoom: 2,mapTypeId : google.maps.MapTypeId.ROADMAP};var myMap = new google.maps.Map(document.getElementById('mapArea'), mapOptions);var marker1 = new google.maps.Marker({ position: new google.maps.LatLng(28.8, 77.03), map: myMap, title: 'New Delhi'}); var marker2 = new google.maps.Marker({ position: new google.maps.LatLng(18.98, 72.83), map: myMap, title: 'Mumbai'});}</script>--%>

    </div>

            <hr />
            <footer>
                <p>&copy; <%: DateTime.Now.Year %> - Enterprise Solutions</p>
            </footer>
        </div>
    </form>


    

</body>
</html>





