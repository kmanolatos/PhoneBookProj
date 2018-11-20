using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AutoMapper;
using Dapper;
using PhoneBookApi.Models;

namespace PhoneBookApi.Controllers
{
    [RoutePrefix("api/home")]
    public class HomeController : ApiController
    {

        [Route("getListByWhere/{userId}/{text}/{searchBy}")]
        [HttpGet]
        public HttpResponseMessage GetListByWhere(int userId, string text, int searchBy)
        {
            string sWhere = "", whereUserId = "";
            if (userId > 0)
            {
                whereUserId = "inner join Users as u on u.Id = tm.UserID and u.Id != " + userId;
            }
            if (!text.Equals("null"))
            {
                sWhere = "where ";
                if (searchBy == 1)
                {
                    sWhere += "tm.Firstname ";
                }
                else if (searchBy == 2)
                {
                    sWhere += "tm.Lastname ";
                }
                else
                {
                    sWhere += "td.Phone_Number ";
                }
                sWhere += "like '" + text + "%'";
            }
            List<SearchedModel> model = new List<SearchedModel>();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"select tm.Firstname, tm.Lastname, tm.Mail, td.Phone_Number, tk.Kind_Descr, c.City_Descr, a.Area_Descr from Telephones_Master as tm
                                inner join Telephones_Detail as td on td.Owner_ID = tm.ID
                                left join Telephone_Kind as tk on tk.Kind_ID = td.Kind_ID
                                left join Area as a on a.Area_ID = tm.Area_ID
                                left join City as c on c.City_ID = a.Owner_City_ID " + whereUserId + " " + sWhere;
                model = db.Query<SearchedModel>(sql).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }
    }
}
