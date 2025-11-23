using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GrTabStore.Migrations
{
    /// <inheritdoc />
    public partial class addedmoreattributestoproduct : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Description",
                table: "Products",
                newName: "color");

            migrationBuilder.AddColumn<string>(
                name: "Dimentions",
                table: "Products",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "RaportRate",
                table: "Products",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<double>(
                name: "Resolution",
                table: "Products",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "connectedOS",
                table: "Products",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "connectionType",
                table: "Products",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "usbPortType",
                table: "Products",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Dimentions",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "RaportRate",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "Resolution",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "connectedOS",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "connectionType",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "usbPortType",
                table: "Products");

            migrationBuilder.RenameColumn(
                name: "color",
                table: "Products",
                newName: "Description");
        }
    }
}
