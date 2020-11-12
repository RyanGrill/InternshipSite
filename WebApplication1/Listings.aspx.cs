using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InternshipSite.Forms
{
    public partial class Listings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grdListings_PreRender(object sender, EventArgs e)
        {
            grdListings.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}