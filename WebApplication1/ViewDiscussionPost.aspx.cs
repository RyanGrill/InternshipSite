﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;


namespace WebApplication1
{
    public partial class ViewDiscussionPost : System.Web.UI.Page
    {
        //db connection string
        public string url = ConfigurationManager.ConnectionStrings["InternshipSiteDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsAdmin())
            {
                btnDelete.Visible = true;
            }
            
            //get post id, establish connection
            string postID = Request["id"];
            OleDbConnection connection = new OleDbConnection(url);
            connection.Open();
            
            //create adpater for connection & command, fill data table, fill to page
            string selectCommand = "SELECT Title, PostBody FROM QAPosts WHERE PostID=@id OR ReplyID=@id";
            OleDbDataAdapter adapter = new OleDbDataAdapter(selectCommand, connection);
            OleDbParameter parameter = new OleDbParameter("id", OleDbType.VarChar, 5);
            adapter.SelectCommand.Parameters.Add(parameter).Value = postID;
            DataTable table = new DataTable();
            adapter.Fill(table);
            ListView1.DataSource = table;
            ListView1.DataBind();
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            //set visibility on page for reply
            btnReply.Visible = false;
            replyInstructLabel.Visible = true;
            txtReplyTitle.Visible = true;
            txtReplyDesc.Visible = true;
            btnSubmitReply.Visible = true;
        }

        protected void btnSubmitReply_Click(object sender, EventArgs e)
        {
            //establish parameters
            string postID = Request["id"];
            SqlDataSource1.InsertParameters["Title"].DefaultValue = txtReplyTitle.Text;
            SqlDataSource1.InsertParameters["PostBody"].DefaultValue = txtReplyDesc.Text;
            SqlDataSource1.InsertParameters["ReplyID"].DefaultValue = postID;
            try
            {
                //try to insert, then refresh page
                SqlDataSource1.Insert();
                Response.Redirect(Request.Url.ToString(), false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                //catch error, redirect to error page
                Session["Exception"] = ex;
                Session["Page"] = "ViewDiscussionPost.aspx?id=" + postID;
                Response.Redirect("~/ErrorMessage");
            }
        }

        protected bool IsAdmin()
        {
            return User.IsInRole("admin");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string postID = Request["id"];
            OleDbConnection connection = new OleDbConnection(url);

            string deleteCommand = "DELETE FROM QAPosts WHERE PostID=@id OR ReplyID=@id";
            OleDbCommand dbCommand = new OleDbCommand(deleteCommand, connection);
            OleDbParameter parameter = new OleDbParameter("id", OleDbType.VarChar, 5);
            dbCommand.Parameters.Add(parameter).Value = postID;

            try
            {
                using (connection)
                {
                    connection.Open();
                    dbCommand.ExecuteNonQuery();
                }
                
                Response.Redirect("~/StudentDiscussion", false);
            }
            catch(Exception ex)
            {
                Session["Exception"] = ex;
                Session["Page"] = "ViewDiscussionPost.aspx?id=" + postID;
                Response.Redirect("~/ErrorMessage");
            }
        }
    }
}