Imports System.Data


Public Class EditarLenguaje
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub

    Private Sub grdLeyendas_PreRender(sender As Object, e As EventArgs) Handles grdLeyendas.PreRender

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("IDLeyenda")
        dt.Columns.Add("TextoLeyenda")
        'dt.Columns.Add("NuevoTextoLeyenda")

        Dim i As BE.Idioma = Session("Idioma")
        For Each l In i.Leyendas

            Dim dr As DataRow = dt.NewRow
            dr("IDLeyenda") = l.IDLeyenda
            dr("TextoLeyenda") = l.texto_Leyenda
            'dr("NuevoTextoLeyenda") = l.texto_Leyenda
            dt.Rows.Add(dr)
        Next

        grdLeyendas.DataSource = Nothing
        grdLeyendas.DataSource = dt
        grdLeyendas.DataBind()

        grdLeyendas.UseAccessibleHeader = True
        grdLeyendas.HeaderRow.TableSection = TableRowSection.TableHeader

    End Sub

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim falta As Boolean = False
        For Each gvr As GridViewRow In Me.grdLeyendas.Rows
            Dim tb As TextBox = DirectCast(gvr.FindControl("txtNuevoTextoLeyenda"), TextBox)
            If tb.Text = "" Or IsNothing(tb.Text) Then
                falta = True
            End If
        Next

        If falta Then
            MsgBox("Falta")
        Else
            MsgBox("tan todos")
        End If

    End Sub
End Class