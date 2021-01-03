using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Net;

namespace PeeringFunctionOnPremise
{
    public static class OnPremiseTrigger
    {
        [FunctionName("OnPremiseTrigger")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            string name = req.Query["name"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            string hostName = req.HttpContext.Request.Host.Value;
            string responseMessage = string.IsNullOrEmpty(name)
                ? $"OnPremiseTrigger function executed successfully. {hostName}"
                : $"Hello, {name}. OnPremiseTrigger function executed successfully. {hostName}";

            return new OkObjectResult(responseMessage);
        }
    }
}
