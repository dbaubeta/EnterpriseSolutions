Public Class ValidarBase
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim d As New Digitos.Validador
        Dim li As New List(Of BE.MensajeError)
        Dim f As New BLL.Facade_Pantalla

        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)

        l = b.Obtener_Idiomas()

        'Traduzco la pagina
        li = d.validarDB()
        Dim sb As New StringBuilder
        Dim idi As New BE.Idioma
        idi = l.Find(Function(c) c.ID = 1)
        If li.Count > 0 Then
            For Each m As BE.MensajeError In li
                sb.AppendLine(f.ObtenerLeyenda(m, idi).texto_Leyenda + "(" + m.Datos + ")" + "<br/>")
            Next
            Me.LitMensajes.Text = sb.ToString
            Session("BaseValidada") = "No"
        Else
            Session("BaseValidada") = "Si"

        End If



    End Sub


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim d As New Digitos.Validador
        d.RecalcularDB()


    End Sub



End Class