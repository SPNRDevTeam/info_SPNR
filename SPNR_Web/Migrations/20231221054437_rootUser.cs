using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SPNR_Web.Migrations
{
    /// <inheritdoc />
    public partial class rootUser : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "Login", "Password" },
                values: new object[] { new Guid("f7c0b3fb-efed-414b-95b8-043efc9e24bc"), "root_user", "AQAAAAIAAYagAAAAEAdzXpS+NOjqjUhwet6RqBjMsF84qY1Bu5k6jIDOeE6IVG5wRN6VUwKB+5ubmxt3Vg==" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("f7c0b3fb-efed-414b-95b8-043efc9e24bc"));
        }
    }
}
