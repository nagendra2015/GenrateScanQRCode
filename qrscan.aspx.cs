using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using System.Data;

namespace eAPF.admin
{
    public partial class qrscan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetQRCodeName(string qrCodeContent)
        {
            string connectionString = ConfigurationSettings.AppSettings["Con"].ToString();
            string name = string.Empty;
            name = "";

            string ipAddress = HttpContext.Current.Request.UserHostAddress; 
            try
            {



                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    if(con.State==ConnectionState.Closed)
                    con.Open();
                    //string query = "SELECT ContactName+' '+ContactDesignation +'  '+ContactOrg as Details FROM QRInformation WHERE QRCodeNo = @Content";

                 //   string query = "SELECT ContactName+' '+ContactDesignation +'  '+ContactOrg as Details FROM QRInformation WHERE QRCodeNo = @Content";
                    SqlCommand cmd = new SqlCommand("spValidateQrInformation", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    
                    cmd.Parameters.AddWithValue("@qrCode", qrCodeContent);
                    cmd.Parameters.AddWithValue("@ipAddress", ipAddress);
                    name = (string)cmd.ExecuteScalar();
                }

            }
            catch (Exception ex)
            { }

            return name;
        }


        [WebMethod]
        public static string GetGreetingNew()
        {
            return "Hello, from the server! qr scan code";
        }
    }
}