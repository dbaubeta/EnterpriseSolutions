<%@ Page UICulture="auto" Culture="auto" Language="vb" AutoEventWireup="false" CodeBehind="home.aspx.vb" Inherits="idioma.home" %>

<%@ Register assembly="idioma" namespace="idioma" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Button ID="btnEs" runat="server" Text="Es" />
        <asp:Button ID="btnEn" runat="server" Text="En" />
    
    </div>
        <cc1:miboton ID="miboton1" runat="server" Text="Español" />
        <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
    </form>
</body>
</html>
