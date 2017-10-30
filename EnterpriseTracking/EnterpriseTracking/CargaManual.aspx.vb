Imports System.IO
Imports System.Xml
Imports System.Xml.Schema

Public Class CargaManual
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click

        Dim folderPath As String = Server.MapPath("~/files/")
        Dim xsdfile As String = Server.MapPath("~/xml/secuencia.xsd")
        Dim mytab As String = "<span style=""text-indent: 5em;""></span>"
        Dim f As New BLL.Facade_Pantalla

        ' Si no existe el directorio lo creo
        If Not Directory.Exists(folderPath) Then
            Directory.CreateDirectory(folderPath)
        End If


        If Not String.IsNullOrEmpty(fuArchivo.FileName) Then
            'Guardo el archivo 
            Dim archivosalida As String = folderPath & Path.GetFileName(fuArchivo.FileName)
            fuArchivo.SaveAs(archivosalida)


            Dim s As New BE.Secuencia
            Dim bs As New BLL.Secuencia
            Dim l As List(Of BE.MensajeError)
            Dim l2 As List(Of BE.MensajeError)

            l = bs.Cargar(archivosalida, xsdfile, s)
            Dim sb As New StringBuilder
            sb.AppendLine("<div class=""row"" style=""margin-top:15px;margin-bottom:15px"">")
            sb.AppendLine("<div class=""col-sm-12"">")
            sb.AppendLine("<span style=""font-family:verdana;font-size:x-large"">" + f.ObtenerLeyenda(New BE.MensajeError("TituloResultadoCargaSecuencia"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "</span>")
            sb.AppendLine("</div>")
            sb.AppendLine("</div>")
            sb.AppendLine("<hr />")

            If IsNothing(l) Then
                sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError("CargaSeqListaBienFormado"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "    </span><span style=""color:green;left-margin:5px;"">[" + f.ObtenerLeyenda(New BE.MensajeError("Correcto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "]</span><br/>")
                sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError("CargaSeqListaValido"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "    </span><span style=""color:green;left-margin:5px;"">[" + f.ObtenerLeyenda(New BE.MensajeError("Correcto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "]</span><br/>")

                l2 = bs.Validar(s)
                If IsNothing(l2) Then
                    sb.AppendLine("<br/>")
                    sb.AppendLine("<br/>")
                    sb.AppendLine("<span style=""font-family:verdana;;font-size:x-large"">" + f.ObtenerLeyenda(New BE.MensajeError("DetallesdeSecuencia"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "    </span><br/>")
                    sb.AppendLine("<hr />")
                    sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError("VendedoresCargados"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + " : " + s.Lista_Vendedores.Count.ToString + "</span><br/>")
                    sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError("PuntosVentaCargados"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + " : " + s.Lista_PDV.Count.ToString + "</span><br/>")
                    sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError("FacturasCargados"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + " : " + s.Lista_Facturas.Count.ToString + "</span><br/>")
                    sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError("StockCargados"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + " : " + s.Lista_Stock.Count.ToString + "</span><br/>")
                Else
                    For Each m As BE.MensajeError In l2
                        If Not String.IsNullOrEmpty(m.IDError) Then
                            Dim correcto As String = ""
                            If Not String.IsNullOrEmpty(m.Mensaje) Then correcto = "<span style=""color:" + IIf(m.Mensaje = "Fallo", "red", "green") + ";left-margin:5px;"">[" + f.ObtenerLeyenda(New BE.MensajeError(m.Mensaje), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "]</span>"
                            sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError(m.IDError), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "    </span>" + correcto + "<br/>")
                        Else
                            sb.AppendLine("<span style=""font-family:verdana;"">" + m.Mensaje + "    </span><br/>")
                        End If
                    Next

                End If
            Else

                For Each m As BE.MensajeError In l
                    If Not String.IsNullOrEmpty(m.IDError) Then
                        Dim correcto As String = ""
                        If Not String.IsNullOrEmpty(m.Mensaje) Then correcto = "<span style=""color:" + IIf(m.Mensaje = "Fallo", "red", "green") + ";left-margin:5px;"">[" + f.ObtenerLeyenda(New BE.MensajeError(m.Mensaje), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "]</span>"
                        sb.AppendLine("<span style=""font-family:verdana;"">" + f.ObtenerLeyenda(New BE.MensajeError(m.IDError), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "    </span>" + correcto + "<br/>")
                    Else
                        sb.AppendLine("<span style=""font-family:verdana;"">" + m.Mensaje + "    </span><br/>")
                    End If
                Next

            End If

            Me.litMensajes.Text = sb.ToString


        Else
            MostrarMensajeModal("IngreseArchivoRequerido", True, True)

        End If
    End Sub



#Region "Modal"

    Private Sub MostrarMensajeModal(Msg As String, simple As Boolean, Optional traducir As Boolean = True)

        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla
        m.IDError = Msg
        If Not simple Then
            If traducir Then
                Try
                    noTranslateModalMessageSiNo.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Catch ex As Exception
                    noTranslateModalMessageSiNo.Text = Msg
                End Try
            Else
                noTranslateModalMessageSiNo.Text = Msg
            End If
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalSiNo();", True)
        Else
            If traducir Then
                Try
                    noTranslateModalMessage.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Catch ex As Exception
                    noTranslateModalMessage.Text = Msg
                End Try
            Else
                noTranslateModalMessage.Text = Msg
            End If
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalOk();", True)
        End If

    End Sub
#End Region











End Class


