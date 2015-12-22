<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list.aspx.cs" Inherits="BTCDProject.list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="~/common.css" />
    <!-- 리스트에 스타일 적용 -->
    <title>출장목록</title>
</head>
<body>
    <!-- 주로 aspx.cs에서 작업하게됩니다 -->
    <form id="form1" runat="server">
        <div id="Container">
            <div class="headerwrap">
                <div class="Top_bar">
                    <a href="./list.aspx" class="com_logo"></a>
                    <div id="status">
                        <asp:Button ID="logoutBtn" Text="로그아웃" runat="server" CssClass="out_btn" OnClick="logoutBtn_Click1" />
                        <asp:Label CssClass="idLbl" Text="&nbsp;님&nbsp;|&nbsp;" runat="server"></asp:Label><asp:Label ID="userLbl" CssClass="idLbl" Text="송슬기" runat="server"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="navimenu">
                <div class="menu_title">
                    <a href="./paper_write01.aspx" class="write_icon"></a>
                    <a href="./list.aspx" class="list_icon"></a>
                </div>
            </div>

            <!-- 컨텐츠 -->
            <div class="contentBox">
            <div class="content">
                <!-- table은 datagrid를 사용해 구현 -->
                <asp:Label ID="tableLbl" CssClass="lbl" Text="Business Travel Command Document" runat="server" /><br /><br />
                            <asp:DataGrid ID="DataGridt" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="None" OnPageIndexChanged="DataGridt_PageIndexChanged1">
                                <AlternatingItemStyle BackColor="#F3F3F5" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                <Columns>
                                    <asp:BoundColumn DataField="row_num" HeaderText="글번호" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundColumn>
                                    
                                    <asp:HyperLinkColumn DataTextField="term1" HeaderText="출장일" DataNavigateUrlField="report_id" DataNavigateUrlFormatString="paper_result.aspx?report_id={0}" HeaderStyle-Width="400px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="400px"></HeaderStyle>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:HyperLinkColumn>
                                    <asp:BoundColumn DataField="location1" HeaderText="출장지" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center" Width="200px"></HeaderStyle>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundColumn>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC" />
                                <HeaderStyle BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                <SelectedItemStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            </asp:DataGrid>
            </div>
            </div>
        </div>
    </form>
</body>
</html>
