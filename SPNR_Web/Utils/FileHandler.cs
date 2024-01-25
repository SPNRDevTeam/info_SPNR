using Microsoft.AspNetCore;

namespace SPNR_Web.Utils
{
    public class FileHandler : IFileHandler
    {
        readonly string _rootPath;
        public FileHandler(IWebHostEnvironment webHost)
        {
            _rootPath = webHost.WebRootPath;
        }

        public void Delete(string? path)
        {
            if (path == null) return;
            string fullPath = _rootPath + path.Replace("~", "");
            if (File.Exists(fullPath))
            {
                File.Delete(fullPath);
            }
        }

        public string? Save(IFormFile? file)
        {
            if (file is null) return null;
            string _mediaPath = Path.Combine(_rootPath, @"media");
            string newFilename = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
            string fullPath = Path.Combine(_mediaPath, newFilename);
            string retPath = Path.Combine("\\media", newFilename);

            using (var fStream = new FileStream(fullPath, FileMode.Create))
            {
                file.CopyTo(fStream);
            }

            return retPath.Replace('\\', '/');
        }
    }
}
