!> Example module to interact with TOML documents
module toml
   use tomlf
   implicit none
   public


contains


!> Process an input file to a TOML data structure
subroutine read_toml(table, file)

   !> TOML data structure
   type(toml_table), allocatable, intent(out) :: table

   !> Name of the TOML file
   character(len=*), intent(in) :: file

   integer :: unit

   open(file=file, newunit=unit)
   call toml_parse(table, unit)
   close(unit)

end subroutine read_toml


!> Writeout an input file to a TOML data structure
subroutine write_toml(table, unit)

   !> TOML data structure
   type(toml_table), intent(inout) :: table

   !> Unit for I/O
   integer :: unit

   type(toml_serializer) :: ser

   ser = toml_serializer(unit)
   call table%accept(ser)

end subroutine write_toml


end module toml
