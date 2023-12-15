namespace SPNR_Web.Utils
{
    public class FileHandler : IFileHandler
    {
        readonly string _mediaPath;
        public FileHandler(IWebHostEnvironment webHost)
        {
            _mediaPath = Path.Combine(webHost.WebRootPath, @"media");
        }

        public void Delete(string path)
        {
            if (File.Exists(path))
            {
                File.Delete(path);
            }
        }

        public string? Save(IFormFile? file)
        {
            if (file is null) return null;
            string fullPath = Path.Combine(_mediaPath, Guid.NewGuid().ToString() + Path.GetExtension(file.FileName));

            using (var fStream = new FileStream(fullPath, FileMode.Create))
            {
                file.CopyTo(fStream);
            }

            return fullPath;
        }
    }
}
