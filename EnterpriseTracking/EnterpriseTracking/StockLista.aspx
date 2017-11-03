<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Enterprise.Master" CodeBehind="StockLista.aspx.vb" Inherits="EnterpriseTracking.StockLista" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Chart ID="Chart1" runat="server">
        <Series>
            <asp:Series Name="Series1"></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
    </asp:Chart>

        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
    <ajaxToolkit:AreaChart ID="StockChart" runat="server" 
        ChartHeight="300" ChartWidth="450" ChartType="Basic"
        ChartTitle="United States versus European Widget Production" 
        CategoriesAxis="2007,2008,2009,2010,2011,2012" 
        ChartTitleColor="#0E426C" CategoryAxisLineColor="#D08AD9" 
        ValueAxisLineColor="#D08AD9" BaseLineColor="#A156AB">
        </ajaxToolkit:AreaChart> 


</asp:Content>
