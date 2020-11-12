using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace WebApplication1
{
    public partial class ViewResumePost : System.Web.UI.Page
    {
        public string url = ConfigurationManager.ConnectionStrings["InternshipSiteDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            string postID = Request["id"];
            OleDbConnection connection = new OleDbConnection(url);
            connection.Open();

            string selectCommand = "SELECT Title, Body FROM ResumePosts WHERE ID=@id OR ReplyID=@id";
            OleDbDataAdapter adapter = new OleDbDataAdapter(selectCommand, connection);
            OleDbParameter parameter = new OleDbParameter("id", OleDbType.VarChar, 5);
            adapter.SelectCommand.Parameters.Add(parameter).Value = postID;
            DataTable table = new DataTable();
            adapter.Fill(table);
            ListView1.DataSource = table;
            ListView1.DataBind();
        }

        protected void lnkBtnDownload_Click(object sender, EventArgs e)
        {
            string postID = Request["id"];
            string docSavePath = string.Concat(Server.MapPath("~/UploadedItems/DownloadedResume"));
            OleDbConnection conn = new OleDbConnection(url);
            byte[] docBytes;

            using (var cmd = new OleDbCommand("SELECT Resume FROM ResumePosts WHERE ID=@id", conn))
            {
                conn.Open();
                OleDbParameter parameter = new OleDbParameter("id", OleDbType.VarChar, 5);
                cmd.Parameters.Add(parameter).Value = postID;
                docBytes = (byte[])cmd.ExecuteScalar();
            }
            File.WriteAllBytes(docSavePath, docBytes);

            Response.ContentType = "Application/msword";
            Response.AppendHeader("Content-Disposition", "attachment; filename=DownloadedResume.docx");
            Response.TransmitFile(docSavePath);
            Response.End();
        }

        protected void btnSubmitReply_Click(object sender, EventArgs e)
        {
            string postID = Request["id"];
            SqlDataSource1.InsertParameters["Title"].DefaultValue = txtReplyTitle.Text;
            SqlDataSource1.InsertParameters["Body"].DefaultValue = txtReplyDesc.Text;
            SqlDataSource1.InsertParameters["ReplyID"].DefaultValue = postID;
            try
            {
                SqlDataSource1.Insert();
                Response.Redirect(Request.Url.ToString(), false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                Session["Exception"] = ex;
                Session["Page"] = "ViewDiscussionPost.aspx?id=" + postID;
                Response.Redirect("~/ErrorMessage");
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            btnReply.Visible = false;
            replyInstructLabel.Visible = true;
            txtReplyTitle.Visible = true;
            txtReplyDesc.Visible = true;
            btnSubmitReply.Visible = true;
        }
    }
}