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
    [RoutePrefix("api/area")]
    public class AreaController : ApiController
    {
        [Route("getAreasByCity/id/{id}")]
        [HttpGet]
        public HttpResponseMessage GetAreasByCity(int id)
        {

            List<SearchedModel> model = new List<SearchedModel>();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"select Area_ID as Id, a.Area_Descr from Area as a
                                left join City as c on c.City_ID = a.Owner_City_ID where c.City_ID = " + id;
                model = db.Query<SearchedModel>(sql).ToList();
                model = model.OrderBy(p => p.Area_Descr).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);

        }

        [Route("get/id/{id}")]
        [HttpGet]
        public HttpResponseMessage GetById(int id)
        {

            AreaModel model = new AreaModel();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                model = db.Get<AreaModel>(id);
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);

        }

        [Route("getListByWhere/{text}/{searchBy}")]
        [HttpGet]
        public HttpResponseMessage GetListByWhere(string text, int searchBy)
        {

            string where = "";
            if (!text.Equals("null"))
            {
                where = "where ";
                if (searchBy == 1)
                {
                    where += "a.Area_Descr ";
                }
                else
                {
                    where += "c.City_Descr ";
                }
                where += "like N'" + text + "%'";
            }
            List<SearchedModel> model = new List<SearchedModel>();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"select Area_ID as Id, a.Area_Descr, c.City_Descr from Area as a
                                left join City as c on c.City_ID = a.Owner_City_ID " + where;
                model = db.Query<SearchedModel>(sql).ToList();
                model = model.OrderBy(p => p.City_Descr).ThenBy(p => p.Area_Descr).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);

        }

        [Route("delete")]
        [HttpPost]
        public HttpResponseMessage Delete(AreaModel model)
        {
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"update Telephones_Master set Area_ID = null where Area_ID = " + model.Area_ID +
                            "delete from Area where Area_ID = " + model.Area_ID;
                db.Query(sql);
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [Route("update")]
        [HttpPost]
        public HttpResponseMessage Update(AreaModel model)
        {
            this.Validate(model);
            if (ModelState.IsValid)
            {
                using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    string sql = @"select count(*) as rows from Area as u where Area_Descr = N'" + model.Area_Descr + "'";
                    var result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                    int row;
                    Int32.TryParse(result["rows"].ToString(), out row);
                    if (row == 1)
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Area already exists!");
                    db.Update(model);
                }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        [Route("insert")]
        [HttpPost]
        public HttpResponseMessage Insert(AreaModel model)
        {
            this.Validate(model);
            if (ModelState.IsValid)
            {

                using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
                    string sql = @"select count(*) as rows from Area as u where Area_Descr = N'" + model.Area_Descr + "'";
                    var result = (IDictionary<string, object>)db.Query(sql).FirstOrDefault();
                    int row;
                    Int32.TryParse(result["rows"].ToString(), out row);
                    if (row == 1)
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Area already exists!");
                    db.Insert(model);
                }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }
    }
}
