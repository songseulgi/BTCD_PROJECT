<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="join.aspx.cs" Inherits="BTCDProject.join" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="~/common.css" />
    <!-- jQuery를 이용해서 keypress가 일어났을 경우에는 항상 flag를 0으로 바꿔준다  -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script>

        // 회원가입시 id, 비밀번호의 유효성 검사
        // 이름은 2글자~10글자의 제한을 둔다
        // id는 크게 글자 수 제한을 두지 않는다
        // 
        $(document).ready(function () {

            // 성명박스 확인
            $("#nameBox").focusout(function () {
                if ($("#nameBox").val().length > 1 && $("#nameBox").val().length < 11) {
                    
                }
                else {
                    alert('성명을 다시 입력해주세요!');
                    $("#nameBox").focus();
                }
            });

            // id 박스의 조작에 대한 확인
            $("#idBox").keydown(function () {       // ID에 대한 flag가 1이 되더라도
                $("#idLbl").text('0');              // idBox에 키보드 조작이 생기면
            });                                     // flag를 다시 0으로 바꿔준다

            // pw 박스 확인
            $("#pwBox").focusout(function () {
                if ($("#pwBox").val().length > 5 && $("#pwBox").val().length < 15) {
                    
                } else {
                    alert('비밀번호는 최소 6자 이상 14자 이하로 결정해주세요')
                    $("#pwBox").focus();
                }
            });

            // pwr 박스 확인
            $("#pwrBox").focusout(function () {
                if ($("#pwrBox").val() == $("#pwBox").val()) {
                    
                } else {
                    alert('입력하신 비밀번호와 맞지않습니다');
                    $("#pwrBox").focus();
                }
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <asp:Label ID="nateLbl" runat="server"></asp:Label>
            <div class="loginDiv">
            <table class="loginTbl">
                <colgroup>
                    <col="20%" />
                    <col="60%" />
                    <col="20%" />
                </colgroup>

                <tr>
                    <td colspan="3"><h2> 회원가입 </h2></td>
                </tr>

                <tr>
                    <td><span>성명</span></td>
                    <td>
                        <asp:TextBox ID="nameBox" runat="server" placeholder="성명을 입력하세요"></asp:TextBox>
                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td><span>아이디</span></td>
                    <td>
                        <asp:HiddenField ID="idFlag" runat="server" Value="0" />
                        <asp:TextBox ID="idBox" runat="server" placeholder="아이디를 입력하세요"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="chkBtn" runat="server" Text="중복확인" OnClick="chkBtn_Click" class="joinbtn"/>
                    </td>
                </tr>
                <tr>
                    <td><span>비밀번호</span></td>
                    <td>
                        <asp:TextBox ID="pwBox" runat="server" TextMode="Password" placeholder="비밀번호를 입력하세요" CssClass="under"></asp:TextBox>
                    </td>    
                    <td>

                    </td>
                </tr>
                <tr>
                    <td><span>비밀번호재확인</span></td>
                    <td>
                        <asp:TextBox ID="pwrBox" runat="server" TextMode="Password" placeholder="비밀번호를 확인해주세요" CssClass="under"></asp:TextBox>
                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td style="text-align:center" colspan="3">
                        <asp:Button ID="backBtn" runat="server" Text="뒤로가기" OnClick="backBtn_Click" class="joinbtn"/>
                        <asp:Button ID="okBtn" runat="server" Text="회원등록" OnClick="okBtn_Click" class="joinbtn"/>
                    </td>
                </tr>
            </table>
        </div>
        </div>
    </form>
</body>
</html>
