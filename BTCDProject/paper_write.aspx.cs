using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTCDProject
{
    public partial class paper_write : System.Web.UI.Page

    {
        public string report_id = "";
        public string user_id = "";
        public string page_num = "";
        public string id_value = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)                       // 세션에 값이 존재하면 (로그인이 되어있다)
            {
                user_id = Session["user_id"].ToString();          // user_id 변수에 Session의 user_id값을 복사한다
                id_value = Session["id"].ToString();
            }
            else                                                  // 세션에 값이 들어있지 않다면 (로그인 실패)
            {
                Response.Redirect("./login.aspx");                // 로그인창으로 redirect를 걸어준다
            }
            
            // report_id = Request.QueryString["report_id"];
            // page_num = Request.QueryString["page_num"];
            userLbl.Text = id_value;

            // Server.UrlDecode를 써주는 이유는 한글이 깨지는것을 방지하기 위함
            name.Text = Server.UrlDecode(Request.Cookies["user_name1"].Value); // 기안자
            // 소속
            position.Text = Server.UrlDecode(Request.Cookies["position1"].Value); // 직위
            

            // 교통수단 체크 유무

            if (Request.Cookies["carCck"].Value.Equals("1"))
            {
                carCck.Checked = true;
            }

            if (Request.Cookies["trainCck"].Value.Equals("1"))
            {
                trainCck.Checked = true;
            }

            if (Request.Cookies["busCck"].Value.Equals("1"))
            {
                busCck.Checked = true;
            }

            if (Request.Cookies["boatCck"].Value.Equals("1"))
            {
                boatCck.Checked = true;
            }

            if (Request.Cookies["airCck"].Value.Equals("1"))
            {
                airCck.Checked = true;
            }

            // 

            name1.Text = Server.UrlDecode(Request.Cookies["user_name1"].Value);
            name2.Text = Server.UrlDecode(Request.Cookies["user_name2"].Value);
            name3.Text = Server.UrlDecode(Request.Cookies["user_name3"].Value);
            name4.Text = Server.UrlDecode(Request.Cookies["user_name4"].Value);

            position1.Text = Server.UrlDecode(Request.Cookies["position1"].Value);
            position2.Text = Server.UrlDecode(Request.Cookies["position2"].Value);
            position3.Text = Server.UrlDecode(Request.Cookies["position3"].Value);
            position4.Text = Server.UrlDecode(Request.Cookies["position4"].Value);

            term1.Text = Request.Cookies["cal_date1"].Value + dayDefine(Request.Cookies["cal_date2"].Value);
            if(name2.Text.Length != 0) 
                term2.Text = Request.Cookies["cal_date1"].Value + dayDefine(Request.Cookies["cal_date2"].Value);
            if (name3.Text.Length != 0)
                term3.Text = Request.Cookies["cal_date1"].Value + dayDefine(Request.Cookies["cal_date2"].Value);
            if (name4.Text.Length != 0)
                term4.Text = Request.Cookies["cal_date1"].Value + dayDefine(Request.Cookies["cal_date2"].Value);

            name_copy1.Text = Server.UrlDecode(Request.Cookies["user_name1"].Value);
            name_copy2.Text = Server.UrlDecode(Request.Cookies["user_name2"].Value);
            name_copy3.Text = Server.UrlDecode(Request.Cookies["user_name3"].Value);
            name_copy4.Text = Server.UrlDecode(Request.Cookies["user_name4"].Value);
            // 출장지


            pay_trans1.Text = Request.Cookies["pay_trans1"].Value;
            pay_trans2.Text = Request.Cookies["pay_trans2"].Value;
            pay_trans3.Text = Request.Cookies["pay_trans3"].Value;
            pay_trans4.Text = Request.Cookies["pay_trans4"].Value;

            pay_toll1.Text = Request.Cookies["pay_toll1"].Value;
            pay_toll2.Text = Request.Cookies["pay_toll2"].Value;
            pay_toll3.Text = Request.Cookies["pay_toll3"].Value;
            pay_toll4.Text = Request.Cookies["pay_toll4"].Value;

            pay_room1.Text = Request.Cookies["pay_room1"].Value;
            pay_room2.Text = Request.Cookies["pay_room2"].Value;
            pay_room3.Text = Request.Cookies["pay_room3"].Value;
            pay_room4.Text = Request.Cookies["pay_room4"].Value;

            pay_food1.Text = Request.Cookies["pay_food1"].Value;
            pay_food2.Text = Request.Cookies["pay_food2"].Value;
            pay_food3.Text = Request.Cookies["pay_food3"].Value;
            pay_food4.Text = Request.Cookies["pay_food4"].Value;

            pay_work1.Text = Request.Cookies["pay_work1"].Value;
            pay_work2.Text = Request.Cookies["pay_work2"].Value;
            pay_work3.Text = Request.Cookies["pay_work3"].Value;
            pay_work4.Text = Request.Cookies["pay_work4"].Value;

            pay_total1.Text = sumPay(pay_trans1.Text, pay_toll1.Text, pay_room1.Text, pay_food1.Text, pay_work1.Text);
            pay_total2.Text = sumPay(pay_trans2.Text, pay_toll2.Text, pay_room2.Text, pay_food2.Text, pay_work2.Text);
            pay_total3.Text = sumPay(pay_trans3.Text, pay_toll3.Text, pay_room3.Text, pay_food3.Text, pay_work3.Text);
            pay_total4.Text = sumPay(pay_trans4.Text, pay_toll4.Text, pay_room4.Text, pay_food4.Text, pay_work4.Text);

            // 영수증 체크 유무
            if (Request.Cookies["card_bill"].Value.Equals("1"))
            {
                card_bill.Checked = true;
            }
            if (Request.Cookies["toll_bill"].Value.Equals("1"))
            {
                toll_bill.Checked = true;
            }
            if (Request.Cookies["transe_bill"].Value.Equals("1"))
            {
                transe_bill.Checked = true;
            }
            if (Request.Cookies["etc_bill"].Value.Equals("1"))
            {
                etc_bill.Checked = true;
            }



            // 모든것들을 다 적고, 쿠키들을 모조리 초기화시켜준다
            //foreach (string key in Request.Cookies.AllKeys)
            //{
            //    HttpCookie cookie = new HttpCookie(key);
            //    cookie.Expires = DateTime.UtcNow.AddDays(-7); // 쿠키는 삭제할 수 없다, 쿠키의 기한을 -7일까지로 주는것으로 대신한다
            //    Response.Cookies.Add(cookie);
            //}
        }

        // 들어올 날짜가 있을때 확인해주는 함수
        public string dayDefine(string data)
        {
            if (data.Length != 0) {
                return "-" + data;
            }
            return "";
        }

        // 들어온 string형의 비용들을 모두 합산하여 string으로 돌려주는 함수
        public string sumPay(string trans, string toll, string room, string food, string work)
        {
            int a, b, c, d, e, sum;

            if (trans.Length != 0)
                a = int.Parse(trans);
            else
                a = 0;

            if (toll.Length != 0)
                b = int.Parse(toll);
            else
                b = 0;

            if (room.Length != 0)
                c = int.Parse(room);
            else
                c = 0;

            if (food.Length != 0)
                d = int.Parse(food);
            else
                d = 0;

            if (work.Length != 0)
                e = int.Parse(work);
            else
                e = 0;

            sum = a + b + c + d + e;
            if (sum == 0)
            {
                return "";
            }
            return sum + "";
        }


        // 돌아가기 버튼클릭
        protected void backBtn_Click(object sender, EventArgs e)
        {
            // 해당 페이지에 hidden으로 저장한 page_num값, 로그인한 아이디 값을 가지고 
            // list.aspx로 리다이렉트
            Response.Redirect("./list.aspx?page_num=" + page_num);
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session["user_id"] = "";
            Session["id"] = "";
            Session.Abandon();
            Response.Redirect("./login.aspx");
        }

        protected void writeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("./paper_write.aspx");
        }

        protected void listBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("./list.aspx");
        }

        protected void testBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("./list.aspx");
        }
    }
}