using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Dapper;

namespace PhoneBookApi.Models
{
    public class UserModel
    {
        public LoginModel loginModel { get; set; }

        public TelephoneMasterModel telephoneMasterModel { get; set; }

        public TelephoneDetailModel telephoneDetailModel { get; set; }
      
    }

    [Table("Users")]
    public class LoginModel
    {
        [Dapper.Key]
        public long Id { get; set; }

        [MinLength(5)]
        [MaxLength(70)]
        [Dapper.Required]
        public string username { get; set; }

        [MinLength(5)]
        [MaxLength(70)]
        [Dapper.Required]
        public string password { get; set; }
    }

    [Table("Telephones_Master")]
    public class TelephoneMasterModel
    {
        [Dapper.Key]
        public long ID { get; set; }

        [MinLength(3)]
        [MaxLength(70)]
        [Dapper.Required]
        public string Firstname { get; set; }

        [MinLength(3)]
        [MaxLength(70)]
        [Dapper.Required]
        public string Lastname { get; set; }

        [EmailAddress]
        public string Mail { get; set; }

        public long userID { get; set; }

        public long Area_ID { get; set; }

    }

    [Table("Telephones_Detail")]
    public class TelephoneDetailModel
    {
        [Dapper.Key]
        public long Entry_ID { get; set; }

        [Phone]
        [MaxLength(15)]
        [Dapper.Required]
        public string Phone_Number { get; set; }

        public long Kind_ID { get; set; }
        public long Owner_ID { get; set; }

    }

    public class ProfileModel
    {
        public string password { get; set; }
        public string Phone_Number { get; set; }
        public long Kind_ID { get; set; }
        public long Owner_ID { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Mail { get; set; }
        public long Area_ID { get; set; }
        public long Entry_ID { get; set; }
        public long City_ID { get; set; }
        public long ID { get; set; }
    }
}