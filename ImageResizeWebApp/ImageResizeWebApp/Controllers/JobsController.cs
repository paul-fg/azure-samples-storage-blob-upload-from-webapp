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

        [HttpGet("[action]"), Authorize]
        public IActionResult GetJobs() 
        {
            var email = this.User.Identity.Name;

            return Ok("ok test2");
        }
    }
}
