Public Class Leyenda

    Public Function ObtenerLeyendas(ByVal idioma As BE.Idioma, ByVal pantallas As List(Of BE.Pantalla)) As List(Of BE.Leyenda)

        Dim leyendas As New List(Of BE.Leyenda)
        Dim o As New DAL.Leyenda

        ' try-catch-finally
        Try
            ' Abrir connexion
            leyendas = o.ObtenerLeyendas(idioma, pantallas)

        Catch
            ' A simple catch.
            'MessageBox.Show("The requested order could not be loaded into the form.")
        Finally
        End Try


        Return leyendas

    End Function

    Public Function ObtenerLeyenda(ByVal idioma As BE.Idioma, ByVal control As BE.Control) As BE.Leyenda

        Dim leyenda As New BE.Leyenda
        Dim o As New DAL.Leyenda

        ' try-catch-finally
        Try
            ' Abrir connexion
            leyenda = o.ObtenerLeyenda(idioma, control)

        Catch
            ' A simple catch.
            'MessageBox.Show("The requested order could not be loaded into the form.")
        Finally
        End Try


        Return leyenda

    End Function

End Class
