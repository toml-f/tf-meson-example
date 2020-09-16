!> Example application
program tfex
   use, intrinsic :: iso_fortran_env, only : output_unit, error_unit
   use toml
   implicit none
   integer :: length
   character(len=:), allocatable :: argument
   type(toml_table), allocatable :: table
   logical :: exist

   if (abs(command_argument_count()) == 1) then
      call get_command_argument(1, length=length)
      allocate(character(len=length) :: argument)
      call get_command_argument(1, argument)
   else
      write(error_unit, '(a)') "Expects file name as argument"
      error stop
   end if

   inquire(file=argument, exist=exist)
   if (.not.exist) then
      write(error_unit, '(a, ":", 1x, a)') &
         & "Could not find file", argument
      error stop
   end if

   call read_toml(table, argument)

   if (.not.allocated(table)) then
      write(error_unit, '(a, 1x, a)') &
         & "Could not read TOML document in", argument
      error stop
   end if

   call write_toml(table, output_unit)

end program tfex
