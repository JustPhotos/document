<%@ Page Title="Just Photos - 註冊帳號" Language="VB" MasterPageFile="~/JustPhotoMaster.master" AutoEventWireup="false" CodeFile="Signup.aspx.vb" Inherits="Signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 90px;
        }
        .auto-style2 {
            height: 50px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="signupBlock" class="signupStyle">
        <table align="center">
            <tr>
                <th colspan="2">Sign up</th>
            </tr>
            <tr>
                <td style="font-family: 微軟正黑體;" class="auto-style1 auto-style2">
                    帳號
                </td>
                <td>
                    <asp:TextBox ID="TextBoxAccount" runat="server" placeholder="數字與英文，至少六碼" MaxLength="15" class="signupNormalTextBox" AutoCompleteType="Disabled"></asp:TextBox>
					<br />
                    <asp:RequiredFieldValidator ID="accountRequired" runat="server" ErrorMessage="請輸入帳號" ControlToValidate="TextBoxAccount" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 13px; width: 188px" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:CustomValidator ID="accountValidator" runat="server" ErrorMessage="至少輸入六碼" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 13px; width: 188px" ControlToValidate="TextBoxAccount" EnableClientScript="False" Display="Dynamic"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td style="font-family: 微軟正黑體" class="auto-style1 auto-style2">
                    密碼
                </td>
                <td>
                    <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password" placeholder="輸入密碼" MaxLength="30" class="signupNormalTextBox" AutoCompleteType="Disabled"></asp:TextBox>
					<br />
                    <asp:RequiredFieldValidator ID="pwRequired" runat="server" ErrorMessage="請輸入密碼" ControlToValidate="TextBoxPassword" EnableClientScript="False" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 16px; width: 181px" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="pwValidator" runat="server" ErrorMessage="至少六碼英數字元" ControlToValidate="TextBoxPassword" EnableClientScript="False" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 16px; width: 181px"></asp:CustomValidator>
                </td>
            </tr>
			<tr>
                <td style="font-family: 微軟正黑體" class="auto-style1 auto-style2">
                    密碼確認
                </td>
                <td>
                    <asp:TextBox ID="TextBoxPasswordConfirm" runat="server" TextMode="Password" placeholder="再輸入一次密碼" MaxLength="30" class="signupNormalTextBox" AutoCompleteType="Disabled"></asp:TextBox>
					<br />
                    <asp:RequiredFieldValidator ID="pwcRequired" runat="server" ErrorMessage="請輸入密碼確認" ControlToValidate="TextBoxPasswordConfirm" EnableClientScript="False" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 16px; width: 181px" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:CompareValidator ID="pwcCompare" runat="server" ErrorMessage="密碼不同，請重新輸入" EnableClientScript="False" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 16px; width: 181px" ControlToCompare="TextBoxPassword" ControlToValidate="TextBoxPasswordConfirm"></asp:CompareValidator>
                </td>
            </tr>
			<tr>
                <td style="font-family: 微軟正黑體" class="auto-style1 auto-style2">
                    Email
                </td>
                <td>
                    <asp:TextBox ID="TextBoxEmail" runat="server" placeholder="輸入信箱" MaxLength="50" class="signupNormalTextBox" AutoCompleteType="Disabled"></asp:TextBox>
					<br />
                    <asp:RequiredFieldValidator ID="emailRequired" runat="server" ErrorMessage="請輸入信箱" ControlToValidate="TextBoxEmail" EnableClientScript="False" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 16px; width: 181px" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:RegularExpressionValidator ID="emailValidator" runat="server" ErrorMessage="信箱格式錯誤" ControlToValidate="TextBoxEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" EnableClientScript="False" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 16px; width: 181px" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
            </tr>
			<tr>
                <td style="font-family: 微軟正黑體" class="auto-style1 auto-style2">
                    名稱
                </td>
                <td>
                    <asp:TextBox ID="TextBoxName" runat="server" placeholder="輸入姓名" MaxLength="30" class="signupNormalTextBox" AutoCompleteType="Disabled"></asp:TextBox>
					<br />
                    <asp:RequiredFieldValidator ID="nameRequired" runat="server" ErrorMessage="請輸入姓名" ControlToValidate="TextBoxName" EnableClientScript="False" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 16px; width: 181px" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
			<tr>
                <td style="font-family: 微軟正黑體" class="auto-style1">
                    描述
                    <br />
                    <br />
                    <br />
                    <br />
                </td>
                <td>
                    <asp:TextBox ID="TextBoxDescription" runat="server" placeholder="輸入個人描述(150字以內)" Columns="50" Height="70px" Rows="3" TextMode="MultiLine" Width="650px" style="overflow: hidden; resize: none;" MaxLength="150" AutoCompleteType="Disabled"></asp:TextBox>
					<br />
                    <asp:CustomValidator ID="descriptionValidator" runat="server" ErrorMessage="描述不能超過150字" Font-Bold="True" Font-Size="X-Small" ForeColor="Red" style="height: 13px; width: 188px" ControlToValidate="TextBoxDescription" EnableClientScript="False" Display="Dynamic"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <asp:Button ID="BtnSubmit" runat="server" Text="註冊" Font-Names="微軟正黑體" />
                    <asp:Button ID="BtnCancel" runat="server" Text="取消" Font-Names="微軟正黑體" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

