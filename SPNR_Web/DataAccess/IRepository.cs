using System.Linq.Expressions;

namespace SPNR_Web.DataAccess
{
    public interface IRepository<T> where T : class 
    {
        void Add(T entity);
        IEnumerable<T> ReadAll();
        IQueryable<T> ReadWhere(Expression<Func<T, bool>> filter);
        T? ReadFirst(Expression<Func<T, bool>> filter);
        void Update(T entity);
        void Remove(T entity);
        void RemoveRange(IEnumerable<T> entities);
    }
}