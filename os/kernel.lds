ENTRY(start)

SECTIONS
{
    . = 0x500;          /* kernel load address */

    .text :
    {
        *(.text*)
    }

    .data :
    {
        *(.data*)
    }

    .bss :
    {
        *(.bss*)
    }
}

