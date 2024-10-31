#ifndef M1_ELF_COMPAT_H
#define M1_ELF_COMPAT_H

#include <stdint.h>  // For standard integer types

// Machine types
#define EM_MIPS       8       // MIPS R3000
#define EM_PPC64      21      // PowerPC 64-bit
#define EM_ARM        40      // ARM
#define EM_AARCH64    183     /* ARM 64 bit */

// ELF Class
#define ELFCLASS32    1       // 32-bit objects
#define ELFCLASS64    2       // 64-bit objects

// Object file types
#define ET_REL         1  // Relocatable file

// Special section indices
#define SHN_COMMON     0xfff2  // Common symbols

// Symbol bindings
#define STB_LOCAL      0  // Local symbol
#define STB_GLOBAL     1  // Global symbol
#define STB_WEAK       2  // Weak symbol
#define STB_LOPROC     13 // Processor-specific
#define STB_HIPROC     15 // Processor-specific

// Symbol types
#define STT_NOTYPE     0  // Symbol type is unspecified
#define STT_OBJECT     1  // Symbol is a data object
#define STT_FUNC       2  // Symbol is a code object
#define STT_SECTION    3  // Symbol associated with a section
#define STT_FILE       4  // Symbol's name is file name
#define STT_LOPROC     13 // Processor-specific
#define STT_HIPROC     15 // Processor-specific
#define STT_SPARC_REGISTER 13 // SPARC register

// Relocation types (x86)
#define R_386_32       1  // Direct 32-bit
#define R_386_PC32     2  // PC relative 32-bit

// Relocation types (ARM)
#define R_ARM_ABS32    2  // Direct 32-bit
#define R_ARM_REL32    3  // PC relative 32-bit

// Section header flags
#define SHF_ALLOC      0x2        // Section is allocatable
#define SHF_EXECINSTR  0x4        // Section contains executable instructions

// ELF class
#define ELFCLASS32     1  // 32-bit objects
#define ELFCLASS64     2  // 64-bit objects

// ELF data encoding
#define ELFDATA2LSB    1  // LSB data encoding
#define ELFDATA2MSB    2  // MSB data encoding

// Processor architectures
#define EM_PPC64       21 // PowerPC 64-bit
#define EM_ARM         40 // ARM
#define EM_MIPS        8  // MIPS R3000
#define EM_SPARC       2  // SPARC
#define EM_SPARCV9     43 // SPARC V9

// Symbol info macros
#define ELF32_ST_BIND(info) ((info) >> 4)
#define ELF64_ST_BIND(info) ((info) >> 4)
#define ELF32_ST_TYPE(info) ((info) & 0xf)
#define ELF64_ST_TYPE(info) ((info) & 0xf)


// Basic ELF types
typedef uint16_t Elf32_Half;
typedef uint32_t Elf32_Word;
typedef int32_t  Elf32_Sword;
typedef uint32_t Elf32_Addr;
typedef uint32_t Elf32_Off;

typedef uint16_t Elf64_Half;
typedef uint32_t Elf64_Word;
typedef int32_t  Elf64_Sword;
typedef uint64_t Elf64_Addr;
typedef uint64_t Elf64_Off;
typedef uint64_t Elf64_Xword;
typedef int64_t  Elf64_Sxword;

// ARM Relocation types
#define R_ARM_ABS32              2    // Direct 32-bit
#define R_ARM_REL32              3    // PC-relative 32-bit
#define R_ARM_MOVW_ABS_NC        43   // MOVW (lower 16 bits)
#define R_ARM_MOVT_ABS           44   // MOVT (upper 16 bits)
#define R_ARM_PC24               4    // 24-bit PC-relative
#define R_ARM_CALL               28   // BL (branch with link)
#define R_ARM_JUMP24             29   // 24-bit jump
#define R_ARM_THM_MOVW_ABS_NC    47   // Thumb MOVW (lower 16 bits)
#define R_ARM_THM_MOVT_ABS       48   // Thumb MOVT (upper 16 bits)
#define R_ARM_THM_JUMP19         72   // Thumb 19-bit jump
#define R_ARM_THM_PC22           10   // Thumb PC-relative 22-bit
#define R_ARM_THM_JUMP24         30   // Thumb 24-bit jump

// MIPS Relocation types
#define R_MIPS_LO16              4    // Low 16 bits
#define R_MIPS_26                2    // 26-bit jump
#define R_MIPS_32                6    // Direct 32-bit

// Macros for relocation info
#define ELF32_R_SYM(info)        ((info) >> 8)
#define ELF32_R_TYPE(info)       ((uint32_t)(info) & 0xff)
#define ELF64_R_SYM(info)        ((info) >> 32)
#define ELF64_R_TYPE(info)       ((uint32_t)(info) & 0xffffffff)


// ELF Header
typedef struct {
    unsigned char e_ident[16];
    Elf32_Half    e_type;
    Elf32_Half    e_machine;
    Elf32_Word    e_version;
    Elf32_Addr    e_entry;
    Elf32_Off     e_phoff;
    Elf32_Off     e_shoff;
    Elf32_Word    e_flags;
    Elf32_Half    e_ehsize;
    Elf32_Half    e_phentsize;
    Elf32_Half    e_phnum;
    Elf32_Half    e_shentsize;
    Elf32_Half    e_shnum;
    Elf32_Half    e_shstrndx;
} Elf32_Ehdr;

typedef struct {
    unsigned char e_ident[16];
    Elf64_Half    e_type;
    Elf64_Half    e_machine;
    Elf64_Word    e_version;
    Elf64_Addr    e_entry;
    Elf64_Off     e_phoff;
    Elf64_Off     e_shoff;
    Elf64_Word    e_flags;
    Elf64_Half    e_ehsize;
    Elf64_Half    e_phentsize;
    Elf64_Half    e_phnum;
    Elf64_Half    e_shentsize;
    Elf64_Half    e_shnum;
    Elf64_Half    e_shstrndx;
} Elf64_Ehdr;

// Section header
typedef struct {
    Elf32_Word sh_name;
    Elf32_Word sh_type;
    Elf32_Word sh_flags;
    Elf32_Addr sh_addr;
    Elf32_Off  sh_offset;
    Elf32_Word sh_size;
    Elf32_Word sh_link;
    Elf32_Word sh_info;
    Elf32_Word sh_addralign;
    Elf32_Word sh_entsize;
} Elf32_Shdr;

typedef struct {
    Elf64_Word sh_name;
    Elf64_Word sh_type;
    Elf64_Xword sh_flags;
    Elf64_Addr sh_addr;
    Elf64_Off  sh_offset;
    Elf64_Xword sh_size;
    Elf64_Word sh_link;
    Elf64_Word sh_info;
    Elf64_Xword sh_addralign;
    Elf64_Xword sh_entsize;
} Elf64_Shdr;

// Symbol table entry
typedef struct {
    Elf32_Word    st_name;
    Elf32_Addr    st_value;
    Elf32_Word    st_size;
    unsigned char st_info;
    unsigned char st_other;
    Elf32_Half    st_shndx;
} Elf32_Sym;

typedef struct {
    Elf64_Word    st_name;
    unsigned char st_info;
    unsigned char st_other;
    Elf64_Half    st_shndx;
    Elf64_Addr    st_value;
    Elf64_Xword   st_size;
} Elf64_Sym;

// Relocation table entry
typedef struct {
    Elf32_Addr r_offset;
    Elf32_Word r_info;
} Elf32_Rel;

typedef struct {
    Elf32_Addr  r_offset;
    Elf32_Word  r_info;
    Elf32_Sword r_addend;
} Elf32_Rela;

typedef struct {
    Elf64_Addr r_offset;
    Elf64_Xword r_info;
} Elf64_Rel;

typedef struct {
    Elf64_Addr  r_offset;
    Elf64_Xword r_info;
    Elf64_Sxword r_addend;
} Elf64_Rela;

// ELF identification indices
#define EI_MAG0       0
#define EI_MAG1       1
#define EI_MAG2       2
#define EI_MAG3       3
#define EI_CLASS      4
#define EI_DATA       5
#define EI_VERSION    6
#define EI_OSABI      7
#define EI_ABIVERSION 8
#define EI_PAD        9
#define EI_NIDENT     16

// Magic number and versions
#define ELFMAG0       0x7f
#define ELFMAG1       'E'
#define ELFMAG2       'L'
#define ELFMAG3       'F'
#define ELFMAG        "\177ELF"
#define SELFMAG       4
#define EV_CURRENT    1

// ELF data encoding
#define ELFDATA2LSB   1
#define ELFDATA2MSB   2

// Object file types
#define ET_EXEC       2
#define ET_DYN        3

// Symbol types
#define STT_NOTYPE    0
#define STT_OBJECT    1
#define STT_FUNC      2
#define STT_SECTION   3
#define STT_FILE      4

// Section types
#define SHT_NULL          0
#define SHT_PROGBITS      1
#define SHT_SYMTAB        2
#define SHT_STRTAB        3
#define SHT_RELA          4
#define SHT_HASH          5
#define SHT_DYNAMIC       6
#define SHT_NOTE          7
#define SHT_NOBITS        8
#define SHT_REL           9
#define SHT_SHLIB         10
#define SHT_DYNSYM        11
#define SHT_INIT_ARRAY    14
#define SHT_FINI_ARRAY    15
#define SHT_PREINIT_ARRAY 16
#define SHT_GROUP         17
#define SHT_SYMTAB_SHNDX  18

// Special section indices
#define SHN_UNDEF         0
#define SHN_LORESERVE     0xff00
#define SHN_HIRESERVE     0xffff
#define SHN_XINDEX        0xffff

// Machine types
#define EM_386            3
#define EM_X86_64         62
#define EM_S390           22
#define EM_PARISC         15
#define EM_PPC            20

// AArch64 Relocation types
#define R_AARCH64_ABS64   257  // Direct 64-bit
#define R_AARCH64_PREL64  258  // PC-relative 64-bit

// Macros for symbol info extraction
#define ELF32_ST_TYPE(info) ((info) & 0xf)
#define ELF64_ST_TYPE(info) ((info) & 0xf)

// Other necessary constants can be added here as required

#endif // M1_ELF_COMPAT_H

