namespace VidzyCodeFirst_Exercise.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class PopulateGenreTable1 : DbMigration
    {
        public override void Up()
        {
            Sql("INSERT INTO Genres (name) VALUES ('Action'),('Horror'),('Comedy'),('Drama')");
        }
        
        public override void Down()
        {
        }
    }
}
