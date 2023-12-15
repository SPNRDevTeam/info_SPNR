namespace SPNR_Web.Utils
{
    public interface IFileHandler
    {
        string? Save(IFormFile? file);
        void Delete(string path);
    }
}
