using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Dapper;

namespace PhoneBookApi.Models
{
    [Table("City")]
    public class CityModel
    {
        [Dapper.Key]
        public long City_ID { get; set; }

        [MinLength(3)]
        [MaxLength(50)]
        [Dapper.Required]
        public string City_Descr { get; set; }
    }
}