Imports System.IO
Imports System.Runtime.CompilerServices
Imports System.Windows.Forms.VisualStyles.VisualStyleElement

Public Class Form1
    Public oraconn
    Public orarec
    Public sqlz As String
    Public FormHeader As String
    Private OKR_sum As Integer
    Private LPN_sum As Integer


    Private Sub Initialize_connection()
        oraconn = CreateObject("ADODB.Connection")
        orarec = CreateObject("ADODB.Recordset")
        oraconn.Open(My.Resources.db_path)
    End Sub

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'відкриваю форму на увесь екран
        Me.WindowState = FormWindowState.Maximized
        'вставляю полоску прокрутки вертикальну
        Me.HorizontalScroll.Maximum = 0
        Me.AutoScroll = True
        Initialize_connection()
        Refresh_all()
    End Sub

    Private Sub Refresh_all()
        DataGridView_lotki_refresh()
        DataGridView_ZAPAS_refresh()
        DataGridView_SORTER_refresh()
        DataGridView_ASN_refresh()
        Form1.ActiveForm.Text = "VisioPriem обновлено: все " & Now
    End Sub

    Private Sub Button_lotki_Click(sender As Object, e As EventArgs) Handles Button_lotki.Click
        DataGridView_lotki_refresh()
        Form1.ActiveForm.Text = "VisioPriem обновлено: лотки " & Now
    End Sub

    Private Sub Button_SORTER_Click(sender As Object, e As EventArgs) Handles Button_SORTER.Click
        DataGridView_SORTER_refresh()
        Form1.ActiveForm.Text = "VisioPriem обновлено: сортер " & Now
    End Sub

    Private Sub Button_ZAPAS_Click(sender As Object, e As EventArgs) Handles Button_ZAPAS.Click
        DataGridView_ZAPAS_refresh()
        Form1.ActiveForm.Text = "VisioPriem обновлено: запасы " & Now
    End Sub

    Private Sub Button_ASN_Click(sender As Object, e As EventArgs) Handles Button_ASN.Click
        DataGridView_ASN_refresh()
        Form1.ActiveForm.Text = "VisioPriem обновлено: приходы " & Now
    End Sub

    Private Sub ButtonRefresh_Click(sender As Object, e As EventArgs) Handles ButtonRefresh.Click
        Refresh_all()
    End Sub

    Private Sub Close_connection()
        oraconn.close()
    End Sub

    Private Sub Form1_Closing(sender As Object, e As System.ComponentModel.CancelEventArgs) Handles MyBase.Closing
        Close_connection()
        oraconn = Nothing
        orarec = Nothing
    End Sub

    Private Sub DataGridView_lotki_refresh()
        DataGridView_lotki.Rows.Clear()

        orarec.Open(My.Resources.sql_LOTKI, oraconn)
        Do Until orarec.EOF
            DataGridView_lotki.Rows.Add(orarec.Fields(0).Value,
                                       orarec.Fields(1).Value,
                                       orarec.Fields(2).Value,
                                       orarec.Fields(3).Value)
            orarec.MoveNext()
        Loop
        orarec.Close()
    End Sub

    Private Sub DataGridView_ZAPAS_refresh()
        DataGridView_ZAPAS.Rows.Clear()

        orarec.Open(My.Resources.sql_ZAPAS, oraconn)
        Do Until orarec.EOF
            DataGridView_ZAPAS.Rows.Add(orarec.Fields(0).Value,
                                       orarec.Fields(1).Value,
                                       orarec.Fields(2).Value,
                                       orarec.Fields(3).Value)
            orarec.MoveNext()
        Loop
        orarec.Close()
    End Sub

    Private Sub DataGridView_SORTER_refresh()
        DataGridView_SORTER.Rows.Clear()

        orarec.Open(My.Resources.sql_SORTER, oraconn)

        Do Until orarec.EOF
            If Not IsDBNull(orarec.Fields(0).Value) Then
                DataGridView_SORTER.Rows.Add(orarec.Fields(0).Value,
                                             orarec.Fields(1).Value,
                                             orarec.Fields(2).Value,
                                             orarec.Fields(3).Value)
            Else
                DataGridView_SORTER.Rows.Add("Всього:",
                                             "",
                                             orarec.Fields(2).Value,
                                             orarec.Fields(3).Value)
            End If
            orarec.MoveNext()
        Loop
        DataGridView_SORTER.Rows(8).DefaultCellStyle.BackColor = Color.Aqua
        orarec.Close()
    End Sub

    Private Sub DataGridView_ASN_refresh()
        DataGridView_ASN.Rows.Clear()

        orarec.Open(My.Resources.sql_ASN, oraconn)
        Do Until orarec.EOF
            DataGridView_ASN.Rows.Add(orarec.Fields(0).Value,
                                      orarec.Fields(1).Value,
                                      orarec.Fields(2).Value,
                                      orarec.Fields(3).Value,
                                      orarec.Fields(4).Value,
                                      orarec.Fields(5).Value,
                                      orarec.Fields(6).Value,
                                      orarec.Fields(7).Value,
                                      orarec.Fields(8).Value)
            orarec.MoveNext()
        Loop
        orarec.Close()
    End Sub
End Class