Public Class StockLista
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim s2 As New AjaxControlToolkit.AreaChartSeries()
        s2.Name = "Europe"
        s2.AreaColor = "#D08AD9"
        s2.Data = New Decimal() {49, 77, 95, 68, 70, 79}

        Me.StockChart.Series.Add(s2)

    End Sub

End Class