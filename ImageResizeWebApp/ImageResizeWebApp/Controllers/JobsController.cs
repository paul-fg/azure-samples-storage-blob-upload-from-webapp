using System;
using System.Diagnostics;
using System.IO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Configuration;

namespace ImageResizeWebApp.Controllers
{
    [Route("api/[controller]")]
    public class JobsController : Controller
    {
        IConfiguration _config;

        public JobsController(IConfiguration config)
        {
            _config = config;
        }

        string BASE_DATA_DIR = "Data" + Path.DirectorySeparatorChar.ToString(),
            JOB_LIST_JSON_1 = "closeoutsread-job-list.json",
            JOB_JSON_1 = "128827-job.json",
            JOB_TEMPLATES_JSON_1 = "128827-job-templates.json";

        private string readFile(string fileName){
            string lines = "";
            try
            {
                using (StreamReader sr = new StreamReader(BASE_DATA_DIR + fileName))
                {
                    lines = sr.ReadToEnd();
                    Debug.WriteLine(lines);
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine("The file could not be read:");
                Debug.WriteLine(e.Message);
            }
            return lines;
        }

        [HttpGet("")]
        public IActionResult Jobs() 
        {
            //var email = this.User.Identity.Name;

            //return Ok("ok test2");
            return Ok(readFile(JOB_LIST_JSON_1));
        }

        [HttpGet("[action]")]
        public IActionResult Job(string email)
        {
            //var email = this.User.Identity.Name;

            //return Ok("ok test2");
            return Ok(readFile(JOB_JSON_1));
        }

        [HttpGet("job/[action]")]
        public IActionResult Templates(string email)
        {
            //var email = this.User.Identity.Name;

            //return Ok("ok test2");
            return Ok(readFile(JOB_TEMPLATES_JSON_1));
        }
    }
}
