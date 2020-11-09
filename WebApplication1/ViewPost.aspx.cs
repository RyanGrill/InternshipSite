using System;
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
    public partial class ViewPost : System.Web.UI.Page
    {
        public string url = ConfigurationManager.ConnectionStrings["InternshipSiteDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            string postID = Request["id"];
            
            string selectCommand = "SELECT [Title], [PostBody] FROM QAPosts WHERE PostID=@id OR WHERE ReplyID=@id";
            using (OleDbDataAdapter adapter = new OleDbDataAdapter(selectCommand, url))
            {
                OleDbParameter parameter = new OleDbParameter("id", OleDbType.Char) { Value = postID };
                adapter.SelectCommand.Parameters.Add(parameter);
                DataTable table = new DataTable();
                ListView1.DataSource = table;
                ListView1.DataBind();
            }

        }
    }
}