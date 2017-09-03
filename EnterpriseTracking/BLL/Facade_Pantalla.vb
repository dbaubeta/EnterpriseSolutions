Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.IO



Public Class Facade_Pantalla

    Public Sub Aplicar_Permisos(ByVal p_formulario As Object)

    End Sub

    Public Function Obtener_Leyendas(ByVal m As BE.MensajeError) As BE.Leyenda
        Obtener_Leyendas = Nothing
    End Function

    Public Sub Traducir(ByRef p_formulario As Object, ByVal p_idioma As BE.Idioma)

        Dim Master As MasterPage
        If IsNothing(p_formulario.Master) Then
            Master = p_formulario
        Else
            Master = DirectCast(p_formulario.Master, MasterPage)
        End If
        Dim mastername = Path.GetFileName(Master.Request.Path)
        TraducirLeyendas(Master, p_idioma, mastername)


        'Dim formname = Path.GetFileName(p_formulario.Request.Path)
        'TraducirLeyendas(p_formulario, p_idioma, formname) 

    End Sub


    Private Function obtenerLeyenda(ID As String, p_idioma As BE.Idioma)


        Dim o As BE.Leyenda = p_idioma.Leyendas.Find(Function(c) c.IDLeyenda = ID)
        If IsNothing(o) Then
            Return "Language not found"
        Else
            Return o.texto_Leyenda
        End If



    End Function


    Private Sub TraducirLeyendas(ByRef p_formulario As Object, ByVal p_idioma As BE.Idioma, formname As String)

        For Each c As Control In p_formulario.Controls

            'traducir controles
            If Not c.ID Is Nothing Then
                Dim leyenda As String = obtenerLeyenda(formname + "_" + c.ID.ToString, p_idioma)
                If Not leyenda Is Nothing Then
                    'boton
                    If TypeOf c Is Button Then
                        Dim boton As Button = TryCast(c, Button)
                        boton.Text = leyenda
                    End If

                    'textbox
                    If TypeOf c Is TextBox Then
                        Dim txt As TextBox = TryCast(c, TextBox)
                        txt.Text = leyenda
                    End If

                    'label
                    If TypeOf c Is Label Then
                        Dim etiqueta As Label = TryCast(c, Label)
                        etiqueta.Text = leyenda
                    End If

                    'html
                    If TypeOf c Is HtmlGenericControl Then
                        Dim controlHTML As HtmlGenericControl = DirectCast(c, HtmlGenericControl)
                        controlHTML.InnerText = leyenda
                    End If
                    If TypeOf c Is HtmlButton Then
                        Dim botonHTML As HtmlButton = DirectCast(c, HtmlButton)
                        botonHTML.InnerText = leyenda
                    End If


                End If
                'End If
            End If

            'si el control contiene otros controles itero sobre ellos
            'para ver si hay que traducirlos
            If (c.Controls.Count > 0) Then
                'llamada recursiva
                TraducirLeyendas(c, p_idioma, formname)
            End If
        Next

    End Sub

End Class
