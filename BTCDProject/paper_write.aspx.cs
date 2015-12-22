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
        public static string CONSTR = @"Server=172.101.0.4,1433;uid=sa;pwd=Sb11011101;database=ReportDB";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null && Session["id"] != null)                       // 세션에 값이 존재하면 (로그인이 되어있다)
            {
                user_id = Session["user_id"].ToString();          // user_id 변수에 Session의 user_id값을 복사한다
                id_value = Session["id"].ToString();
            }
            else                                                  // 세션에 값이 들어있지 않다면 (로그인 실패)
            {
                Response.Redirect("./login.aspx");                // 로그인창으로 redirect를 걸어준다
            }

            // report_id = Request.QueryString["report_id"]; // report_id는 값을 읽어올때나 필요
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
            if (name2.Text.Length != 0)
                term2.Text = Request.Cookies["cal_date1"].Value + dayDefine(Request.Cookies["cal_date2"].Value);
            if (name3.Text.Length != 0)
                term3.Text = Request.Cookies["cal_date1"].Value + dayDefine(Request.Cookies["cal_date2"].Value);
            if (name4.Text.Length != 0)
                term4.Text = Request.Cookies["cal_date1"].Value + dayDefine(Request.Cookies["cal_date2"].Value);

            name_copy1.Text = Server.UrlDecode(Request.Cookies["user_name1"].Value);
            name_copy2.Text = Server.UrlDecode(Request.Cookies["user_name2"].Value);
            name_copy3.Text = Server.UrlDecode(Request.Cookies["user_name3"].Value);
            name_copy4.Text = Server.UrlDecode(Request.Cookies["user_name4"].Value);

            // 출장지 쿠키에서 받아오는 부분
            start.Text = Server.UrlDecode(Request.Cookies["start"].Value);
            mid_loc1.Text = Server.UrlDecode(Request.Cookies["mid_loc1"].Value);
            mid_loc2.Text = Server.UrlDecode(Request.Cookies["mid_loc2"].Value);
            mid_loc3.Text = Server.UrlDecode(Request.Cookies["mid_loc3"].Value);
            mid_loc4.Text = Server.UrlDecode(Request.Cookies["mid_loc4"].Value);
            mid_loc5.Text = Server.UrlDecode(Request.Cookies["mid_loc5"].Value);
            departure.Text = Server.UrlDecode(Request.Cookies["departure"].Value);

            //자차일경우 거리 받아오는 부분
            start_dis.Text = Server.UrlDecode(Request.Cookies["start_dis"].Value);
            mid_dis1.Text = Server.UrlDecode(Request.Cookies["mid_dis1"].Value);
            mid_dis2.Text = Server.UrlDecode(Request.Cookies["mid_dis2"].Value);
            mid_dis3.Text = Server.UrlDecode(Request.Cookies["mid_dis3"].Value);
            mid_dis4.Text = Server.UrlDecode(Request.Cookies["mid_dis4"].Value);
            mid_dis5.Text = Server.UrlDecode(Request.Cookies["mid_dis5"].Value);
            total_dis2.Text = Server.UrlDecode(Request.Cookies["total_dis2"].Value);

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
            if (data.Length != 0)
            {
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

        // top_bar Button...
        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session["user_id"] = "";
            Session["id"] = "";
            Session.Abandon();
            Response.Redirect("./login.aspx");
        }

        // nav Buttons...
        protected void writeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("./paper_write.aspx");
        }

        protected void listBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("./list.aspx");
        }

        // ok button...
        protected void okBtn_Click(object sender, EventArgs e)
        {
            SqlConnection conn;
            SqlDataReader reader;
            SqlCommand cmd;
            string MAX = "";

            // 1.ReportTBL에 값 넣기
            conn = new SqlConnection();
            conn.ConnectionString = CONSTR;
            conn.Open();
            string query = "INSERT INTO REPORTTBL(NAME, USER_ID, COMPANY, POSITION, TERM1, LOCATION1, MEMO1, MEMO_PAY, MEMO_ROOM, MEMO_FOOD, MEMO_WORK) "
                            + "VALUES(@name, @user_id, @company, @position, @term, @location, @memo, @memo_pay, @memo_room, @memo_food, @memo_work)";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@name", name.Text);
            cmd.Parameters.AddWithValue("@user_id", user_id);
            cmd.Parameters.AddWithValue("@company", company.Text);
            cmd.Parameters.AddWithValue("@position", position.Text);
            cmd.Parameters.AddWithValue("@term", term1.Text);
            cmd.Parameters.AddWithValue("@location", location1.Text);
            cmd.Parameters.AddWithValue("@memo", memo1.Text);
            cmd.Parameters.AddWithValue("@memo_pay", label_memo1.Text);
            cmd.Parameters.AddWithValue("@memo_room", label_memo2.Text);
            cmd.Parameters.AddWithValue("@memo_food", label_memo3.Text);
            cmd.Parameters.AddWithValue("@memo_work", label_memo4.Text);
            reader = cmd.ExecuteReader();
            reader.Close();

            // 해당 명령서의 값 가져오기
            DBClass.connect();
            MAX = DBClass.getReportMax();
            DBClass.disconnect();

            // 2.transport_group 검토
            // 이 곳에서는 if문을 사용하여 관련된 외부자만 넣어준다
            string query2 = "INSERT INTO TRANSPORT_GROUP(REPORT_ID, CAR, BUS, SUBWAY, AIRFLY, SHIP) "
                            + "VALUES(@report_id, @car, @bus, @subway, @airfly, @ship)";
            SqlCommand cmd2 = new SqlCommand(query2, conn);
            cmd2.Parameters.AddWithValue("@report_id", MAX);
            // 체크값들
            if (carCck.Checked == true)
                cmd2.Parameters.AddWithValue("@car", "1");
            else
                cmd2.Parameters.AddWithValue("@car", "0");

            if (busCck.Checked == true)
                cmd2.Parameters.AddWithValue("@bus", "1");
            else
                cmd2.Parameters.AddWithValue("@bus", "0");

            if (trainCck.Checked == true)
                cmd2.Parameters.AddWithValue("@subway", "1");
            else
                cmd2.Parameters.AddWithValue("@subway", "0");

            if (airCck.Checked == true)
                cmd2.Parameters.AddWithValue("@airfly", "1");
            else
                cmd2.Parameters.AddWithValue("@airfly", "0");

            if (boatCck.Checked == true)
                cmd2.Parameters.AddWithValue("@ship", "1");
            else
                cmd2.Parameters.AddWithValue("@ship", "0");
            // 쿼리실행
            SqlDataReader reader2 = cmd2.ExecuteReader();
            reader2.Close();


            // ********************************************* //
            // 3.transport 테이블에 값 넣기
            // SqlCommand cmd3 = DBClass.transportInsert();
            string query3 = "INSERT INTO TRANSPORT() VALUES()";
            // ********************************************* //



            // 4.external 검토
            string query4 = "INSERT INTO EXTERNTBL(EXT_ID, REPORT_ID, ENAME, EPOSITION, EPAY_TRANS, EPAY_TOLL, EPAY_ROOM, EPAY_FOOD, EPAY_WORK, EPAY_TOTAL) "
                            + "VALUES(@ext_id, @report_id, @ename, @eposition, @epay_trans, @epay_toll, @epay_room, @epay_food, @epay_work, @epay_total)";
            SqlCommand cmd4 = new SqlCommand(query4, conn);
            SqlDataReader reader4;
            if (!name_copy1.Text.Equals(""))
            {
                cmd4.Parameters.AddWithValue("@ext_id", "1");
                cmd4.Parameters.AddWithValue("@report_id", MAX);
                cmd4.Parameters.AddWithValue("@ename", name_copy1.Text);
                cmd4.Parameters.AddWithValue("@eposition", position1.Text);
                cmd4.Parameters.AddWithValue("@epay_trans", pay_trans1.Text);
                cmd4.Parameters.AddWithValue("@epay_toll", pay_toll1.Text);
                cmd4.Parameters.AddWithValue("@epay_room", pay_room1.Text);
                cmd4.Parameters.AddWithValue("@epay_food", pay_food1.Text);
                cmd4.Parameters.AddWithValue("@epay_work", pay_work1.Text);
                cmd4.Parameters.AddWithValue("@epay_total", pay_total1.Text);
                reader4 = cmd4.ExecuteReader();
                reader4.Close();
            }

            SqlCommand cmd5 = new SqlCommand(query4, conn);
            if (!name_copy2.Text.Equals(""))
            {
                cmd5.Parameters.AddWithValue("@ext_id", "2");
                cmd5.Parameters.AddWithValue("@report_id", MAX);
                cmd5.Parameters.AddWithValue("@ename", name_copy2.Text);
                cmd5.Parameters.AddWithValue("@eposition", position2.Text);
                cmd5.Parameters.AddWithValue("@epay_trans", pay_trans2.Text);
                cmd5.Parameters.AddWithValue("@epay_toll", pay_toll2.Text);
                cmd5.Parameters.AddWithValue("@epay_room", pay_room2.Text);
                cmd5.Parameters.AddWithValue("@epay_food", pay_food2.Text);
                cmd5.Parameters.AddWithValue("@epay_work", pay_work2.Text);
                cmd5.Parameters.AddWithValue("@epay_total", pay_total2.Text);
                reader4 = cmd5.ExecuteReader();
                reader4.Close();
            }

            SqlCommand cmd6 = new SqlCommand(query4, conn);
            if (!name_copy3.Text.Equals(""))
            {
                cmd6.Parameters.AddWithValue("@ext_id", "3");
                cmd6.Parameters.AddWithValue("@report_id", MAX);
                cmd6.Parameters.AddWithValue("@ename", name_copy3.Text);
                cmd6.Parameters.AddWithValue("@eposition", position3.Text);
                cmd6.Parameters.AddWithValue("@epay_trans", pay_trans3.Text);
                cmd6.Parameters.AddWithValue("@epay_toll", pay_toll3.Text);
                cmd6.Parameters.AddWithValue("@epay_room", pay_room3.Text);
                cmd6.Parameters.AddWithValue("@epay_food", pay_food3.Text);
                cmd6.Parameters.AddWithValue("@epay_work", pay_work3.Text);
                cmd6.Parameters.AddWithValue("@epay_total", pay_total3.Text);
                reader4 = cmd6.ExecuteReader();
                reader4.Close();
            }

            SqlCommand cmd7 = new SqlCommand(query4, conn);
            if (!name_copy4.Text.Equals(""))
            {
                cmd7.Parameters.AddWithValue("@ext_id", "4");
                cmd7.Parameters.AddWithValue("@report_id", MAX);
                cmd7.Parameters.AddWithValue("@ename", name_copy4.Text);
                cmd7.Parameters.AddWithValue("@eposition", position4.Text);
                cmd7.Parameters.AddWithValue("@epay_trans", pay_trans4.Text);
                cmd7.Parameters.AddWithValue("@epay_toll", pay_toll4.Text);
                cmd7.Parameters.AddWithValue("@epay_room", pay_room4.Text);
                cmd7.Parameters.AddWithValue("@epay_food", pay_food4.Text);
                cmd7.Parameters.AddWithValue("@epay_work", pay_work4.Text);
                cmd7.Parameters.AddWithValue("@epay_total", pay_total4.Text);
                reader4 = cmd7.ExecuteReader();
                reader4.Close();
            }

            // 5.attach_group 검토
            string query5 = "INSERT INTO ATTACH_GROUP(REPORT_ID, USER_ID, CARD_BILL, TOLL_BILL, TRANSE_BILL, ETC_BILL) VALUES(@report_id, @user_id, @card_bill, @toll_bill, @transe_bill, @etc_bill)";
            SqlCommand cmd8 = new SqlCommand(query5, conn);
            cmd8.Parameters.AddWithValue("@report_id", MAX);
            cmd8.Parameters.AddWithValue("@user_id", user_id);

            if (card_bill.Checked == true)
                cmd8.Parameters.AddWithValue("@card_bill", "1");
            else
                cmd8.Parameters.AddWithValue("@card_bill", "0");

            if (toll_bill.Checked == true)
                cmd8.Parameters.AddWithValue("@toll_bill", "1");
            else
                cmd8.Parameters.AddWithValue("@toll_bill", "0");

            if (transe_bill.Checked == true)
                cmd8.Parameters.AddWithValue("@transe_bill", "1");
            else
                cmd8.Parameters.AddWithValue("@transe_bill", "0");

            if (etc_bill.Checked == true)
                cmd8.Parameters.AddWithValue("@etc_bill", "1");
            else
                cmd8.Parameters.AddWithValue("@etc_bill", "0");

            SqlDataReader reader5 = cmd8.ExecuteReader();
            reader5.Close();

            conn.Close();
            // 마지막에
            Response.Redirect("./list.aspx");
        }
    }
}