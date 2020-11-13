using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class NewJobPosting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddPosting_Click(object sender, EventArgs e)
        {
            //insert using parameters from reply page
            SqlDataSource1.InsertParameters["PostingTitle"].DefaultValue = txtTitle.Text;
            SqlDataSource1.InsertParameters["PostingBody"].DefaultValue = txtPostingDesc.Text;
            SqlDataSource1.InsertParameters["txtPostLink"].DefaultValue = txtPostingDesc.Text;
            try
            {
                SqlDataSource1.Insert();
                Response.Redirect("~/JobPostings");
            }
            catch (Exception ex)
            {
                Session["Exception"] = ex;
                Session["Page"] = "~/NewDiscussionPost";
                Response.Redirect("~/ErrorMessage");
            }
        }
    }
}