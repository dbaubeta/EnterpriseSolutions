Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Data


Public Class Facade_Pantalla

    Public Sub Aplicar_Permisos(ByVal p_formulario As Object)

    End Sub

    Public Function Obtener_Leyendas(ByVal m As BE.MensajeError) As BE.Leyenda
        Obtener_Leyendas = Nothing
    End Function

    Public Sub Traducir(ByRef p_formulario As Object, ByVal p_idioma As BE.Idioma)

        For Each c As Control In p_formulario.Controls

            'traducir controles
            If Not c.ID Is Nothing Then

                'boton
                If TypeOf c Is Button Then
                    Dim boton As Button = TryCast(c, Button)
                    boton.Text = obtenerLeyenda(c.ID.ToString, p_idioma)

                    'TextBox
                ElseIf TypeOf c Is TextBox Then
                    Dim txt As TextBox = TryCast(c, TextBox)
                    txt.ToolTip = obtenerLeyenda(c.ID.ToString, p_idioma)

                    'label
                ElseIf TypeOf c Is Label Then
                    Dim etiqueta As Label = TryCast(c, Label)
                    etiqueta.Text = obtenerLeyenda(c.ID.ToString, p_idioma)

                    'htmlGeneric
                ElseIf TypeOf c Is HtmlGenericControl Then
                    Dim controlHTML As HtmlGenericControl = DirectCast(c, HtmlGenericControl)
                    controlHTML.InnerText = obtenerLeyenda(c.ID.ToString, p_idioma)

                    'htmlButton
                ElseIf TypeOf c Is HtmlButton Then
                    Dim botonHTML As HtmlButton = DirectCast(c, HtmlButton)
                    botonHTML.InnerText = obtenerLeyenda(c.ID.ToString, p_idioma)

                    ' RequiredFieldValidator
                ElseIf TypeOf c Is RequiredFieldValidator Then
                    Dim req As RequiredFieldValidator = DirectCast(c, RequiredFieldValidator)
                    req.Attributes("ErrorMessage") = obtenerLeyenda(c.ID.ToString, p_idioma)
                    req.Text = obtenerLeyenda(c.ID.ToString, p_idioma)

                    'Gridview
                ElseIf TypeOf c Is GridView Then
                    Dim gv As GridView = DirectCast(c, GridView)
                    For i = 0 To gv.Columns.Count - 1
                        Dim nombrecol As String = "columna" + i.ToString.Trim
                        gv.HeaderRow.Cells(i).Text = obtenerLeyenda(c.ID.ToString + "_" + nombrecol, p_idioma)
                    Next
                End If

            End If

            'si el control contiene otros controles itero sobre ellos
            'para ver si hay que traducirlos
            If (c.Controls.Count > 0) Then
                'llamada recursiva
                Traducir(c, p_idioma) ', formname)
            End If

        Next

    End Sub


    Private Function obtenerLeyenda(ID As String, p_idioma As BE.Idioma)


        Dim o As BE.Leyenda = p_idioma.Leyendas.Find(Function(c) c.IDLeyenda = ID)

        ' Este codigo es para que me pida por pantalla las leyendas y no tener que cargarla en la base de datos
        ' ** NO ES UN CODIGO PARA LA VERSION FINAL, SINO PARA HACERME MAS FACIL LA VIDA
        If IsNothing(o) Then

            o = New BE.Leyenda
            o.IDLeyenda = ID
            o.texto_Leyenda = ""
            Do While o.texto_Leyenda = ""
                o.texto_Leyenda = InputBox("Ingresa el valor para " + ID + " (idioma:" + p_idioma.Nombre + ")", "Falta la entrada de idioma")
            Loop
            p_idioma.Leyendas.Add(o)
            Dim bi As New BLL.Idioma
            bi.Guardar(p_idioma)
            Return o.texto_Leyenda
        Else
            Return o.texto_Leyenda
        End If



    End Function


End Class
