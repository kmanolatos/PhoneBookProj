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
    [RoutePrefix("api/city")]
    public class CityController : ApiController
    {
        [Route("getList")]
        [HttpGet]
        public HttpResponseMessage GetList()
        {
            List<CityModel> model = new List<CityModel>();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                model = db.GetList<CityModel>().ToList();
                model = model.OrderBy(p => p.City_Descr).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [Route("get/id/{id}")]
        [HttpGet]
        public HttpResponseMessage GetById(int id)
        {
            CityModel model = new CityModel();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                model = db.Get<CityModel>(id);
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [Route("getListByWhere/{text}")]
        [HttpGet]
        public HttpResponseMessage GetListByWhere(string text)
        {
            string where = "";
            if (!text.Equals("null"))
            {
                where += "where City_Descr like '" + text + "%'";
            }
            List<SearchedModel> model = new List<SearchedModel>();
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"select City_ID as Id, City_Descr from City " + where;
                model = db.Query<SearchedModel>(sql).ToList();
                model = model.OrderBy(p => p.City_Descr).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [Route("delete")]
        [HttpPost]
        public HttpResponseMessage Delete(CityModel model)
        {
            using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
            {
                string sql = @"update Area set Owner_City_ID = null where Owner_City_ID = " + model.City_ID +
                            "delete from City where City_ID = " + model.City_ID;
                db.Query(sql);
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [Route("update")]
        [HttpPost]
        public HttpResponseMessage Update(CityModel model)
        {
            this.Validate(model);
            if (ModelState.IsValid)
            {
                using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
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
        public HttpResponseMessage Insert(CityModel model)
        {
            this.Validate(model);
            if (ModelState.IsValid)
            {
                using (IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString))
                {
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
