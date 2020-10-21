﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BSBlogApp.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Title = "Home";

            return View();
        }
        public ActionResult Posts()
        {
            ViewBag.Title = "Posts";
            
            return View();
        }
        public ActionResult Login()
        {
            ViewBag.Title = "Login";

            return View();
        }
    }
}
