using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTCDProject
{
    public partial class paper_result : System.Web.UI.Page
    {
        public string report_id = "";
        public string user_id = "";
        public string page_num = "";
        public string id_value = "";
        public static string CONSTR = @"Server=172.101.0.4,1433;uid=sa;pwd=Sb11011101;database=ReportDB";

        protected void Page_Load(object sender, EventArgs e)
        {
            // ***************** list와 write 그리고 result 페이지에 공통적으로 들어가서 체크되어야 할 부분 ***************** 
            // 세션의 값이 존재하는지 확인 -> 즉 로그인이 되어있는가 확인

            if (Session["user_id"] != null)                       // 세션에 값이 존재하면 (로그인이 되어있다)
            {
                user_id = Session["user_id"].ToString();          // user_id 변수에 Session의 user_id값을 복사한다
                id_value = Session["id"].ToString();
            }
            else                                                  // 세션에 값이 들어있지 않다면 (로그인 실패)
            {
                Response.Redirect("./login.aspx");                // 로그인창으로 redirect를 걸어준다
            }
            // **********************************************************************************************************

            report_id = Request.QueryString["report_id"];
            page_num = Request.QueryString["page_num"];
            userLbl.Text = id_value;

            SqlConnection conn = new SqlConnection(CONSTR);
            conn.Open();


            string sql = "SELECT * FROM REPORTTBL WHERE report_id=" + report_id;
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            // 4. 페이지에 보여주기

            while (reader.Read())
            {
                name.Text = reader["name"].ToString();
                company.Text = reader["company"].ToString();
                position.Text = reader["position"].ToString();
                term1.Text = reader["term1"].ToString();
                location1.Text = reader["location1"].ToString();
                memo1.Text = reader["memo1"].ToString();
                label_memo1.Text = reader["MEMO_PAY"].ToString();
                label_memo2.Text = reader["MEMO_ROOM"].ToString();
                label_memo3.Text = reader["MEMO_FOOD"].ToString();
                label_memo4.Text = reader["MEMO_WORK"].ToString();
            }
            reader.Close();

            string sql2 = "SELECT * FROM EXTERNTBL WHERE report_id=" + report_id;
            SqlCommand cmd2 = new SqlCommand(sql2, conn);
            SqlDataReader reader2 = cmd2.ExecuteReader();

            while (reader2.Read())
            {
                if (reader2["EXT_ID"].ToString().Equals("1"))
                {
                    name1.Text = reader2["ENAME"].ToString();
                    name_copy1.Text = reader2["ENAME"].ToString();
                    position1.Text = reader2["EPOSITION"].ToString();
                    pay_trans1.Text = reader2["EPAY_TRANS"].ToString();
                    pay_toll1.Text = reader2["EPAY_TOLL"].ToString();
                    pay_room1.Text = reader2["EPAY_ROOM"].ToString();
                    pay_food1.Text = reader2["EPAY_FOOD"].ToString();
                    pay_work1.Text = reader2["EPAY_WORK"].ToString();
                    pay_total1.Text = reader2["EPAY_TOTAL"].ToString();
                }
                else if (reader2["EXT_ID"].ToString().Equals("2"))
                {

                    name2.Text = reader2["ENAME"].ToString();
                    name_copy2.Text = reader2["ENAME"].ToString();
                    position2.Text = reader2["EPOSITION"].ToString();
                    pay_trans2.Text = reader2["EPAY_TRANS"].ToString();
                    pay_toll2.Text = reader2["EPAY_TOLL"].ToString();
                    pay_room2.Text = reader2["EPAY_ROOM"].ToString();
                    pay_food2.Text = reader2["EPAY_FOOD"].ToString();
                    pay_work2.Text = reader2["EPAY_WORK"].ToString();
                    pay_total2.Text = reader2["EPAY_TOTAL"].ToString();
           
                }
                else if (reader2["EXT_ID"].ToString().Equals("3"))
                {
                    name3.Text = reader2["ENAME"].ToString();
                    name_copy3.Text = reader2["ENAME"].ToString();
                    position3.Text = reader2["EPOSITION"].ToString();
                    pay_trans3.Text = reader2["EPAY_TRANS"].ToString();
                    pay_toll3.Text = reader2["EPAY_TOLL"].ToString();
                    pay_room3.Text = reader2["EPAY_ROOM"].ToString();
                    pay_food3.Text = reader2["EPAY_FOOD"].ToString();
                    pay_work3.Text = reader2["EPAY_WORK"].ToString();
                    pay_total3.Text = reader2["EPAY_TOTAL"].ToString();
                }
                else if (reader2["EXT_ID"].ToString().Equals("4"))
                {
                    name4.Text = reader2["ENAME"].ToString();
                    name_copy4.Text = reader2["ENAME"].ToString();
                    position4.Text = reader2["EPOSITION"].ToString();
                    pay_trans4.Text = reader2["EPAY_TRANS"].ToString();
                    pay_toll4.Text = reader2["EPAY_TOLL"].ToString();
                    pay_room4.Text = reader2["EPAY_ROOM"].ToString();
                    pay_food4.Text = reader2["EPAY_FOOD"].ToString();
                    pay_work4.Text = reader2["EPAY_WORK"].ToString();
                    pay_total4.Text = reader2["EPAY_TOTAL"].ToString();
                }
            }
            reader2.Close();

            if (!name2.Text.Equals(""))
            {
                term2.Text = term1.Text;
                location2.Text = location1.Text;
            }

            if (!name3.Text.Equals(""))
            {
                term3.Text = term1.Text;
                location3.Text = location1.Text;
            }

            if (!name4.Text.Equals(""))
            {
                term4.Text = term1.Text;
                location4.Text = location1.Text;
            }

            // 출발 도착부분 가져오기
            string sql4 = "SELECT * FROM TRANSPORT WHERE REPORT_ID=" + report_id;
            SqlCommand cmd4 = new SqlCommand(sql4, conn);
            reader = cmd4.ExecuteReader();

            while (reader.Read())
            {
                start.Text = reader["start"].ToString();
                start_dis.Text = reader["start_type"].ToString();
                departure.Text = reader["departure"].ToString();
                mid_loc1.Text = reader["mid_loc1"].ToString();
                mid_loc2.Text = reader["mid_loc2"].ToString();
                mid_loc3.Text = reader["mid_loc3"].ToString();
                mid_loc4.Text = reader["mid_loc4"].ToString();
                mid_loc5.Text = reader["mid_loc5"].ToString();
                mid_dis1.Text = reader["loc1_dis"].ToString();
                mid_dis2.Text = reader["loc2_dis"].ToString();
                mid_dis3.Text = reader["loc3_dis"].ToString();
                mid_dis4.Text = reader["loc4_dis"].ToString();
                mid_dis5.Text = reader["loc5_dis"].ToString();
                total_dis2.Text = reader["total_dis"].ToString();
            }
            reader.Close();


            // 상단 체크값 가져오기
            string sql3 = "SELECT * FROM TRANSPORT_GROUP WHERE REPORT_ID=" + report_id;
            SqlCommand cmd3 = new SqlCommand(sql3, conn);
            reader = cmd3.ExecuteReader();

            while (reader.Read())
            {
                if (reader["CAR"].ToString().Equals("1"))
                {
                    carCck.Checked = true;
                }

                if (reader["SUBWAY"].ToString().Equals("1"))
                {
                    trainCck.Checked = true;
                }

                if (reader["BUS"].ToString().Equals("1"))
                {
                    busCck.Checked = true;
                }

                if (reader["SHIP"].ToString().Equals("1"))
                {
                    boatCck.Checked = true;
                }

                if (reader["AIRFLY"].ToString().Equals("1"))
                {
                    airCck.Checked = true;
                }
            }

            reader.Close();

            //// 하단 체크값 가져오기
            string sql5 = "SELECT * FROM ATTACH_GROUP WHERE REPORT_ID=" + report_id;
            SqlCommand cmd5 = new SqlCommand(sql5, conn);
            reader = cmd5.ExecuteReader();

            while (reader.Read())
            {
                if (reader["card_bill"].ToString().Equals("1"))
                {
                    card_bill.Checked = true;
                }

                if (reader["toll_bill"].ToString().Equals("1"))
                {
                    toll_bill.Checked = true;
                }

                if (reader["transe_bill"].ToString().Equals("1"))
                {
                    transe_bill.Checked = true;
                }

                if (reader["etc_bill"].ToString().Equals("1"))
                {
                    etc_bill.Checked = true;
                }
            }

            reader.Close();
            conn.Close();
        }

        // 돌아가기 버튼클릭
        protected void backBtn_Click(object sender, EventArgs e)
        {
            // 해당 페이지에 hidden으로 저장한 page_num값, 로그인한 아이디 값을 가지고 
            // list.aspx로 리다이렉트
            Response.Redirect("./list.aspx?page_num=" + page_num);
        }

        // 프린트 버튼클릭


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

        protected void logoutBtn_Click1(object sender, EventArgs e)
        {
            Response.Redirect("./login.aspx");
        }
    }
}