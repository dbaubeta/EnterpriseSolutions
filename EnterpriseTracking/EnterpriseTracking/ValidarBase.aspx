<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ValidarBase.aspx.vb" Inherits="EnterpriseTracking.ValidarBase" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<link href="Content/bootstrap.css" rel="stylesheet" />
<script src="Scripts/jquery-1.9.1.js"></script>
<script src="Scripts/bootstrap.js"></script>
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
              <div class="col-sm-2" style="height:100%;vertical-align:middle;">
              </div>
            </div>
        </div>
        </nav>

        <asp:Button ID="Button1" runat="server" Text="Recalcular" />
        <br/>
        <asp:Literal ID="LitMensajes" runat="server"></asp:Literal>
    
    <hr />
    <footer>
        <p>&copy; <%: DateTime.Now.Year %> - Enterprise Solutions</p>
    </footer>

</form>
</body>
</html>
