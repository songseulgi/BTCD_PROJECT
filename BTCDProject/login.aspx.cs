using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTCDProject
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["test"] = "hithere";    // 처음 
            this.pwBox.Attributes["onkeypress"] = "if(event.keyCode==13) {" +
                Page.GetPostBackEventReference(this.okBtn) + "; return false;}";    // 추후에는 수정이 필요한 부분
        }

        protected void okBtn_Click(object sender, EventArgs e)
        {

            if (idBox.Text.Length == 0) // 아이디 값 비어있다면
            {
                this.warnLabel.Text = "아이디를 입력해주세요";
            }
            else if (pwBox.Text.Length == 0) // 비밀번호 값 비어있다면
            {
                this.warnLabel.Text = "비밀번호를 입력해주세요";
            }

            if (idBox.Text.Length == 0 && pwBox.Text.Length == 0) // 둘 다 비어이있다면
            {
                this.warnLabel.Text = "아이디/비밀번호를 입력해주세요";
            }
            else if (idBox.Text.Length != 0 && pwBox.Text.Length != 0) // 둘 다 비어있지 않다면
            {
                this.warnLabel.Text = "";

                DBClass.connect();  // 연결
                SqlDataReader reader = DBClass.loginCheck(idBox.Text, pwBox.Text);  // 데이터 받아오기
                if (reader.Read())
                {
                    Session["user_id"] = reader["user_id"].ToString();
                    Session["id"] = idBox.Text;
                    Response.Redirect("./list.aspx");
                }
                else
                    warnLabel.Text = "아이디/비밀번호를 확인해주세요";

                DBClass.disconnect(); // 해제
            }
        }

        protected void joinBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("./join.aspx");
        }
    }
}