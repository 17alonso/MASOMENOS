--Alonso Rodriguez
-- 19/10/2020

use BDVentas
go

if OBJECT_ID('spLoginCliente') is not null
	drop proc spLoginCliente
go
create proc spLoginCliente
	@Usuario varchar(50), @Contrasena varchar(50)
as
begin
	if exists (select Usuario from TCliente where Usuario=@Usuario)
		if exists (select Contrasena from TCliente where Contrasena=@Contrasena)
		begin
			declare @DatosCliente varchar(50)
			set @DatosCliente = (select Apellidos+''+Nombres from TCliente where Usuario=@Usuario)
			if exists (select Apellidos+''+Nombres as DatosCliente from TCliente where Usuario=@Usuario and Contrasena=@Contrasena)
			select CodError = 0,Mensaje = @DatosCliente
			end
		else select CodError = 1,Mensaje='Error: Usuario y/o Contrasenas incorrectas'
	else select CodError =1,Mensaje = 'Error:Usuario no existe en la base de datos'
end
go

select * from TCliente
exec spLoginCliente 'jimenez@gmail.com','123'