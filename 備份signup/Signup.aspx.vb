
Partial Class Signup
    Inherits System.Web.UI.Page
    Protected Sub accountValidator_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles accountValidator.ServerValidate
        Dim accountText As String = TextBoxAccount.Text
        Dim rexUrl As New Regex("[^a-z0-9]")

        If accountText.Length < 6 And accountText.Length > 0 Then
            accountValidator.ErrorMessage = "至少輸入六碼"
            args.IsValid = False
            Exit Sub
        ElseIf rexUrl.IsMatch(TextBoxAccount.Text) Then
            accountValidator.ErrorMessage = "帳號請輸入數字與英文"
            args.IsValid = False
            Exit Sub
        End If
    End Sub

    Protected Sub pwValidator_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles pwValidator.ServerValidate
        Dim pw As String = TextBoxPassword.Text

        If pw.Length < 6 And pw.Length > 0 Then
            pwValidator.ErrorMessage = "至少六碼的密碼組合"
            args.IsValid = False
            Exit Sub
        End If
    End Sub

    Protected Sub descriptionValidator_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles descriptionValidator.ServerValidate
        If TextBoxDescription.Text.Length > 150 Then
            args.IsValid = False
            Exit Sub
        End If
    End Sub

    Protected Sub BtnSubmit_Click(sender As Object, e As EventArgs) Handles BtnSubmit.Click
        'get each information from textbox
        Dim account As String = TextBoxAccount.Text
        Dim password As String = TextBoxPassword.Text
        Dim passwordConfirm As String = TextBoxPasswordConfirm.Text
        Dim email As String = TextBoxEmail.Text
        Dim name As String = TextBoxName.Text
        Dim description As String = TextBoxDescription.Text
        Dim headPictureFileNmae As String = ""

        Dim checkValidator As Boolean = accountRequired.IsValid And accountValidator.IsValid And pwValidator.IsValid And pwRequired.IsValid And pwcRequired.IsValid And pwcCompare.IsValid And _
                emailRequired.IsValid And emailValidator.IsValid And nameRequired.IsValid And descriptionValidator.IsValid
        If Not checkValidator Then
            Exit Sub
        End If

        'process upload head picture
        'Dim path As String = Server.MapPath("~\")
        'Dim fileOK As Boolean = False

        'If FileUploadHeadPic.HasFile Then
        '    Dim allowedExtensions As String() = {".jpg", ".jpeg", ".png", ".gif"}
        '    Dim fileExtension As String = System.IO.Path.GetExtension(FileUploadHeadPic.FileName).ToLower()

        '    For i As Integer = 0 To allowedExtensions.Length - 1
        '        If fileExtension = allowedExtensions(i) Then
        '            fileOK = True
        '        End If
        '    Next
        '    If fileOK Then
        '        Try
        '            'rename file
        '            headPictureFileNmae = System.IO.Path.GetFileNameWithoutExtension(FileUploadHeadPic.FileName)
        '            headPictureFileNmae = account & "_jptDB_hdp" & fileExtension

        '            FileUploadHeadPic.PostedFile.SaveAs(path & headPictureFileNmae)
        '            ImageHeadPicture.ImageUrl = headPictureFileNmae
        '            'Response.Write("<Script language='JavaScript'>alert('檔案上傳成功');</Script>")
        '        Catch ex As Exception
        '            Response.Write("<Script language='JavaScript'>alert('檔案上傳失敗" & ex.Message & "');</Script>")
        '            Exit Sub
        '        End Try
        '    Else
        '        Response.Write("<Script language='JavaScript'>alert('不支援圖片格式以外之檔案上傳');</Script>")
        '        Exit Sub
        '    End If
        'End If

        'save sign up information to database
        Dim conn1 As System.Data.SqlClient.SqlConnection
        conn1 = New System.Data.SqlClient.SqlConnection
        conn1.ConnectionString = ConfigurationManager.ConnectionStrings("JustPhotoDBConnStr").ConnectionString.ToString()
        Dim cmd1 As System.Data.SqlClient.SqlCommand
        cmd1 = New System.Data.SqlClient.SqlCommand
        cmd1.Connection = conn1
        cmd1.CommandType = Data.CommandType.StoredProcedure
        cmd1.CommandText = "CREATEACCOUNT"

        '@ID int,
        '@account nvarchar(15),
        '@password nvarchar(30),
        '@name nvarchar(30),
        '@email nvarchar(50),
        '@description nvarchar(150),
        '@headPicture nvarchar(25),

        cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter("@ID", System.Data.SqlDbType.Int))
        cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter("@account", System.Data.SqlDbType.NVarChar, 15))
        cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter("@password", System.Data.SqlDbType.NVarChar, 30))
        cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter("@name", System.Data.SqlDbType.NVarChar, 30))
        cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter("@email", System.Data.SqlDbType.NVarChar, 50))
        cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter("@description", System.Data.SqlDbType.NVarChar, 150))
        cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter("@headPicture", System.Data.SqlDbType.NVarChar, 25))

        cmd1.Parameters("@ID").Value = System.DBNull.Value
        cmd1.Parameters("@account").Value = account
        cmd1.Parameters("@password").Value = password
        cmd1.Parameters("@name").Value = name
        cmd1.Parameters("@email").Value = email
        cmd1.Parameters("@description").Value = description
        cmd1.Parameters("@headPicture").Value = headPictureFileNmae

        conn1.Open()
        Dim dr1 As System.Data.SqlClient.SqlDataReader
        dr1 = cmd1.ExecuteReader
        If dr1.Read Then
            Dim getRetCode As Integer = Integer.Parse(dr1(0).ToString)

            Select Case getRetCode
                Case 0
                    Response.Write("<Script language='JavaScript'>alert('註冊成功！');</Script>")
                    Response.Redirect("~/Default.aspx")
                Case 1
                    Response.Write("<Script language='JavaScript'>alert('帳號已經存在，請修改！');</Script>")
                Case 2
                    Response.Write("<Script language='JavaScript'>alert('信箱已經存在，請修改！');</Script>")
                Case 9
                    Response.Write("<Script language='JavaScript'>alert('資料已經更新！');</Script>")
                Case Else
                    Response.Write("<Script language='JavaScript'>alert('哪邊出錯了？！');</Script>")
            End Select


        End If
        dr1.Close()
        conn1.Close()
    End Sub

    Protected Sub BtnCancel_Click(sender As Object, e As EventArgs) Handles BtnCancel.Click
        Response.Redirect("~\Default.aspx")
    End Sub
End Class
