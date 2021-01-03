using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Net.Http;
using System.Globalization;

namespace PeeringFunctionOnPremise
{
    public static class OnPremiseToCloudTrigger
    {
        
        /// <summary>
        /// The client.
        /// </summary>
        private static readonly HttpClient httpClient = new HttpClient();

        /// <summary>
        /// OnPremiseToCloudTrigger.
        /// </summary>
        /// <remarks>
        /// This trigger is not used. It might be useful in the future.  
        /// </remarks>
        [FunctionName("OnPremiseToCloudTrigger")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            string name = req.Query["name"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            var cloudAPIMUrl = Environment.GetEnvironmentVariable("cloudAPIMUrl", EnvironmentVariableTarget.Process);
            System.Console.WriteLine(cloudAPIMUrl);
            
            cloudAPIMUrl = string.Format(CultureInfo.InvariantCulture, cloudAPIMUrl, name);
            System.Console.WriteLine(cloudAPIMUrl);

            var response = httpClient.GetAsync(cloudAPIMUrl).Result;

            return new OkObjectResult(response.Content.ReadAsStringAsync().Result);
        }
    }
}
