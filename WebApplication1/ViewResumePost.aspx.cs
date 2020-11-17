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
        //connection string used to connect to db
        public string url = ConfigurationManager.ConnectionStrings["InternshipSiteDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsAdmin())
            {
                btnDelete.Visible = true;
            }
            
            //request post id passed from previous page
            string postID = Request["id"];
            //create connection and open it
            OleDbConnection connection = new OleDbConnection(url);
            connection.Open();

            //create command, add parameters, fill data into structure for use in the page, then push to page
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
            //request post id, create path for temp save of file for distribution
            string postID = Request["id"];
            string docSavePath = string.Concat(Server.MapPath("~/UploadedItems/DownloadedResume"));
            OleDbConnection conn = new OleDbConnection(url);
            byte[] docBytes;

            //create command, fill parameters, then get the bytes of the document
            using (var cmd = new OleDbCommand("SELECT Resume FROM ResumePosts WHERE ID=@id", conn))
            {
                conn.Open();
                OleDbParameter parameter = new OleDbParameter("id", OleDbType.VarChar, 5);
                cmd.Parameters.Add(parameter).Value = postID;
                docBytes = (byte[])cmd.ExecuteScalar();
            }
            //write the file to the path with the bytes
            File.WriteAllBytes(docSavePath, docBytes);

            //transfer file to end user
            Response.ContentType = "Application/msword";
            Response.AppendHeader("Content-Disposition", "attachment; filename=DownloadedResume.docx");
            Response.TransmitFile(docSavePath);
            Response.End();
        }

        protected void btnSubmitReply_Click(object sender, EventArgs e)
        {
            //get post id, create parameters for insertion
            string postID = Request["id"];
            SqlDataSource1.InsertParameters["Title"].DefaultValue = txtReplyTitle.Text;
            SqlDataSource1.InsertParameters["Body"].DefaultValue = txtReplyDesc.Text;
            SqlDataSource1.InsertParameters["ReplyID"].DefaultValue = postID;
            try
            {
                //try to insert to db, then refresh page to show new reply
                SqlDataSource1.Insert();
                Response.Redirect(Request.Url.ToString(), false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                //catch failure, redirect to error page
                Session["Exception"] = ex;
                Session["Page"] = "ViewResumePost.aspx?id=" + postID;
                Response.Redirect("~/ErrorMessage");
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            //set visibility for reply text boxes/buttons
            btnReply.Visible = false;
            replyInstructLabel.Visible = true;
            txtReplyTitle.Visible = true;
            txtReplyDesc.Visible = true;
            btnSubmitReply.Visible = true;
        }

        protected bool IsAdmin()
        {
            return User.IsInRole("admin");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string postID = Request["id"];
            OleDbConnection connection = new OleDbConnection(url);

            string deleteCommand = "DELETE FROM ResumePosts WHERE ID=@id OR ReplyID=@id";
            OleDbCommand dbCommand = new OleDbCommand(deleteCommand, connection);
            OleDbParameter parameter = new OleDbParameter("id", OleDbType.VarChar, 5);
            dbCommand.Parameters.Add(parameter).Value = postID;

            using (connection)
            {
                connection.Open();
                dbCommand.ExecuteNonQuery();
            }
            Response.Redirect("~/ResumeReview", false);
        }
    }
}