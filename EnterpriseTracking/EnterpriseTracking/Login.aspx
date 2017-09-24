<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="EnterpriseTracking.Login" %>
<!DOCTYPE html>
<link href="Content/bootstrap.css" rel="stylesheet" />
<script src="Scripts/jquery-1.9.1.js"></script>
<script src="Scripts/bootstrap.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
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
                        <asp:Label runat="server" ID="lblPassword" AssociatedControlID="txtContraseña" CssClass="col-md-2 control-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtContraseña" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidatorErrorPassword" ControlToValidate="txtContraseña" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" ID="btnLogin" OnClick="LogIn" Text="Log in" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
                <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                </p>
                <p>
                    <%-- Enable this once you have account confirmation enabled for password reset functionality
                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                    --%>
                </p>
            </section>
        </div>
    </div>

            <hr />
            <footer>
                <p>&copy; <%: DateTime.Now.Year %> - My ASP.NET Application</p>
            </footer>
        </div>
    </form>
</body>
</html>





