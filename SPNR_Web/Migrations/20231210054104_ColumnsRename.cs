using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SPNR_Web.Migrations
{
    /// <inheritdoc />
    public partial class ColumnsRename : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ImgUrl",
                table: "News",
                newName: "ImgPath");

            migrationBuilder.AlterColumn<string>(
                name: "ImgPath",
                table: "Headers",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "ImgPath",
                table: "Blocks",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ImgPath",
                table: "News",
                newName: "ImgUrl");

            migrationBuilder.AlterColumn<string>(
                name: "ImgPath",
                table: "Headers",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ImgPath",
                table: "Blocks",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);
        }
    }
}
