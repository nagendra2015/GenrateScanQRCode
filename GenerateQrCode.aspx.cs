using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using QRCoder;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Configuration;
using System.Data;

namespace eAPF.admin
{
    public partial class GenerateQrCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindGridView();
            }
        }

        protected void BindGridView()
        {
            // Replace with your database connection string
            string connectionString = ConfigurationSettings.AppSettings["Con"].ToString();


            using (SqlConnection con = new SqlConnection(connectionString))
            {
                if(con.State==ConnectionState.Closed)
                con.Open();
                // string query = "SELECT ID, Content FROM QRCodes";

                // string query = "SELECT QRCodeNo as ID, ContactName as Content FROM QRInformation";
                string query = "SELECT QRCodeNo, ContactName,ContactDesignation,ContactOrg,EmailId,ContactMob  FROM QRInformation";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adp.Fill(ds);
                
                qrCodesGridView.DataSource = ds.Tables[0];
                qrCodesGridView.DataBind();
            }
        }

        /*
        protected void DownloadButton_Click(object sender, EventArgs e)
        {
            Button downloadButton = (Button)sender;
            string qrCodeID = downloadButton.CommandArgument;

            // Generate QR code and save as image
            using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
            {
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(qrCodeID, QRCodeGenerator.ECCLevel.Q);
                QRCode qrCode = new QRCode(qrCodeData);
                Bitmap qrCodeImage = qrCode.GetGraphic(20);

                // Save the QR code image to a file
                string imagePath = Server.MapPath("~/Images/qrcode_" + qrCodeID + ".png");
                qrCodeImage.Save(imagePath, System.Drawing.Imaging.ImageFormat.Png);
            }

            // Trigger download of the QR code image
            Response.Redirect("~/Images/qrcode_" + qrCodeID + ".png");
        }
        */

        protected void DownloadButton_Click(object sender, EventArgs e)
        {
            Button downloadButton = (Button)sender;
            string qrCodeID = downloadButton.CommandArgument;

            // Generate QR code and save as image
            using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
            {
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(qrCodeID, QRCodeGenerator.ECCLevel.Q);
                QRCode qrCode = new QRCode(qrCodeData);
                Bitmap qrCodeImage = qrCode.GetGraphic(20);

                // Save the QR code image to a file
                string imagePath = Server.MapPath("~/Images/qrcode_" + qrCodeID + ".png");
                qrCodeImage.Save(imagePath, System.Drawing.Imaging.ImageFormat.Png);

                // Trigger download of the QR code image
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment; filename=qrcode_" + qrCodeID + ".png");
                Response.TransmitFile(imagePath);
                Response.End();
            }
        }

        protected void qrCodesGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            qrCodesGridView.PageIndex = e.NewPageIndex;
            BindGridView();
        }
    }
}