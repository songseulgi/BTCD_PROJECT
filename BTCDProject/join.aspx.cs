using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTCDProject
{
    public partial class join : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void okBtn_Click(object sender, EventArgs e)
        {
            // 체크될 flag들의 값이 모두 1이라면 DB에 값 넣기 실행
            if (idFlag.Value.ToString().Equals("1") && idBox.Text.ToString().Length > 0 && pwBox.Text.ToString().Length > 0 && pwrBox.Text.ToString().Length > 0)
            {
                DBClass.connect(); // 연결

                DBClass.insertId(nameBox.Text, idBox.Text, pwBox.Text);

                DBClass.disconnect(); // 연결해제

                Response.Redirect("./login.aspx");
            }
            else
            {
                string alert = "";
                if (nameBox.Text.ToString().Length == 0)
                {
                    alert += " 이름";
                }

                if (idBox.Text.ToString().Length == 0)
                {
                    alert += " 아이디";
                }

                if (pwBox.Text.ToString().Length == 0)
                {
                    alert += " 비밀번호";
                }

                if (pwrBox.Text.ToString().Length == 0)
                {
                    alert += " 비밀번호 재확인";
                }

                alert += "을 확인해주세요";
                Page.ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + alert + "');", true);
            }
        }

        // 체크 버튼을 눌렀을 때
        protected void chkBtn_Click(object sender, EventArgs e)
        {
            if (idBox.Text.Length > 0)
            {
                DBClass.connect();

                if (DBClass.idCheck(idBox.Text) == false)
                {
                    idFlag.Value = "0";
                    Page.ClientScript.RegisterStartupScript(GetType(), "alert", "alert('이미 사용중인 아이디입니다');", true);
                    idBox.Text = "";
                }
                else
                {
                    idFlag.Value = "1";
                    Page.ClientScript.RegisterStartupScript(GetType(), "alert", "alert('사용가능한 아이디입니다');", true);
                }

                DBClass.disconnect();
            }
        }
    }
}