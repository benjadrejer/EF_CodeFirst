using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace VidzyCodeFirst_Exercise
{
    public class VidzyContext: DbContext
    {
        public VidzyContext()
            : base("name=VidzyDbContext")
        {

        }

        public DbSet<Video> Videos { get; set; }
        public DbSet<Genre> Genres { get; set; }
        public DbSet<Tag> Tags { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new EntityConfigurations.VideoConfiguration());
            modelBuilder.Configurations.Add(new EntityConfigurations.GenreConfiguration());

        }
    }
}
