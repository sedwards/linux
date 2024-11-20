OUTPUT_ARCH(aarch64)
ENTRY(_text)
jiffies = jiffies_64;
PECOFF_FILE_ALIGNMENT = 0x200;

SECTIONS
{
    /* Discard unused or unnecessary sections */
    /DISCARD/ : {
        *(.exitcall.exit)
        *(.discard)
        *(.discard.*)
        *(.export_symbol)
        *(.modinfo)
        *(.gnu.version*)
    }
    /DISCARD/ : {
        *(.interp)
        *(.dynamic)
        *(.dynsym)
        *(.dynstr)
        *(.hash)
        *(.gnu.hash)
    }

    /* Initialize .head.text section */
    . = ((-1 << (48 - 1)) + 0x80000000);  /* Base address */
    .head.text : {
        _text = .;
        KEEP(*(.head.text))
    }

    .text : ALIGN(0x10000) { /* Align to 64KB */
    _stext = .;

    /* IRQ Entry Text Section */
    . = ALIGN(4); 
    __irqentry_text_start = .; 
    *(.irqentry.text) 
    __irqentry_text_end = .;

    /* SoftIRQ Entry Text Section */
    . = ALIGN(4); 
    __softirqentry_text_start = .; 
    *(.softirqentry.text) 
    __softirqentry_text_end = .;

    /* General Entry Text Section */
    . = ALIGN(4); 
    __entry_text_start = .; 
    *(.entry.text) 
    __entry_text_end = .;

    /* Main Text Sections */
    . = ALIGN(4); 
    *(.text.hot .text.hot.*)
    *(.text .text.fixup)
    *(.text.unlikely .text.unlikely.*)
    *(.text.unknown .text.unknown.*)

    /* No-Instrumentation Section */
    . = ALIGN(4); 
    __noinstr_text_start = .; 
    *(.noinstr.text)
    
    /* CPU Idle Section */
    __cpuidle_text_start = .; 
    *(.cpuidle.text)
    __cpuidle_text_end = .;
    __noinstr_text_end = .;

    /* Other Text Sections */
    *(.ref.text)
    *(.text.asan.* .text.tsan.*)

    /* Scheduler Text Section */
    . = ALIGN(4); 
    __sched_text_start = .; 
    *(.sched.text) 
    __sched_text_end = .;

    /* Lock Text Section */
    . = ALIGN(4); 
    __lock_text_start = .; 
    *(.spinlock.text) 
    __lock_text_end = .;

    /* KProbes Text Section */
    . = ALIGN(4); 
    __kprobes_text_start = .; 
    *(.kprobes.text) 
    __kprobes_text_end = .;

    /* Hypervisor ID Mapping and Hypervisor Text Sections */
    . = ALIGN(4096); 
    __hyp_idmap_text_start = .; 
    *(.hyp.idmap.text) 
    __hyp_idmap_text_end = .;

    __hyp_text_start = .; 
    *(.hyp.text)
    . = ALIGN(4096); 
    __hyp_text_end = .;

    /* Warning Section */
    *(.gnu.warning)
}

/* . = ALIGN(0x00010000); */
 _etext = .;

/******************************************************/
. = ALIGN(4096);  /* Align to 4KB page size */

.rodata : AT(ADDR(.rodata)) {
    __start_rodata = .;
    *(.rodata) 
    *(.rodata.*)
    
    . = ALIGN(32); 
    __sched_class_highest = .;
    *(__stop_sched_class) *(__dl_sched_class) *(__rt_sched_class)
    *(__fair_sched_class) *(__ext_sched_class) *(__idle_sched_class)
    __sched_class_lowest = .;

    . = ALIGN(8); 
    __start_ro_after_init = .;
    *(.data..ro_after_init)
    __end_ro_after_init = .;

    . = ALIGN(8); 
    __start___jump_table = .;
    KEEP(*(__jump_table))
    __stop___jump_table = .;

    . = ALIGN(8); 
    __start___tracepoints_ptrs = .;
    KEEP(*(__tracepoints_ptrs))
    __stop___tracepoints_ptrs = .;
    *(__tracepoints_strings)
}

.rodata1 : AT(ADDR(.rodata1)) { 
    *(.rodata1) 
}

.pci_fixup : AT(ADDR(.pci_fixup)) {
    __start_pci_fixups_early = .;
    KEEP(*(.pci_fixup_early))
    __end_pci_fixups_early = .;

    __start_pci_fixups_header = .;
    KEEP(*(.pci_fixup_header))
    __end_pci_fixups_header = .;

    __start_pci_fixups_final = .;
    KEEP(*(.pci_fixup_final))
    __end_pci_fixups_final = .;

    __start_pci_fixups_enable = .;
    KEEP(*(.pci_fixup_enable))
    __end_pci_fixups_enable = .;

    __start_pci_fixups_resume = .;
    KEEP(*(.pci_fixup_resume))
    __end_pci_fixups_resume = .;

    __start_pci_fixups_suspend = .;
    KEEP(*(.pci_fixup_suspend))
    __end_pci_fixups_suspend = .;

    __start_pci_fixups_resume_early = .;
    KEEP(*(.pci_fixup_resume_early))
    __end_pci_fixups_resume_early = .;

    __start_pci_fixups_suspend_late = .;
    KEEP(*(.pci_fixup_suspend_late))
    __end_pci_fixups_suspend_late = .;
}

__ksymtab : AT(ADDR(__ksymtab)) {
    __start___ksymtab = .;
    KEEP(*(SORT(___ksymtab+*)))
    __stop___ksymtab = .;
}

__ksymtab_gpl : AT(ADDR(__ksymtab_gpl)) {
    __start___ksymtab_gpl = .;
    KEEP(*(SORT(___ksymtab_gpl+*)))
    __stop___ksymtab_gpl = .;
}

__kcrctab : AT(ADDR(__kcrctab)) {
    __start___kcrctab = .;
    KEEP(*(SORT(___kcrctab+*)))
    __stop___kcrctab = .;
}

__kcrctab_gpl : AT(ADDR(__kcrctab_gpl)) {
    __start___kcrctab_gpl = .;
    KEEP(*(SORT(___kcrctab_gpl+*)))
    __stop___kcrctab_gpl = .;
}

__ksymtab_strings : AT(ADDR(__ksymtab_strings)) { 
    *(__ksymtab_strings) 
}

__init_rodata : AT(ADDR(__init_rodata)) { 
    *(.ref.rodata) 
}

__param : AT(ADDR(__param)) {
    __start___param = .;
    KEEP(*(__param))
    __stop___param = .;
}

__modver : AT(ADDR(__modver)) {
    __start___modver = .;
    KEEP(*(__modver))
    __stop___modver = .;
}

. = ALIGN(4); 
__ex_table : AT(ADDR(__ex_table)) {
    __start___ex_table = .;
    KEEP(*(__ex_table))
    __stop___ex_table = .;
}

/DISCARD/ : { 
    *(.note.GNU-stack) 
    *(.note.gnu.property) 
}

.notes : AT(ADDR(.notes)) {
    __start_notes = .;
    KEEP(*(.note.*))
    __stop_notes = .;
}

. = ALIGN(4096);  /* End alignment for rodata */
__end_rodata = .;

.got : ALIGN(8) {
    __start_got = .;  /* Symbol marking the start of the .got section */
    KEEP(*(.got))     /* Include all .got contents */
    KEEP(*(.got.*))   /* Include .got.* patterns */
    __stop_got = .;   /* Symbol marking the end of the .got section */
}

.got.plt : ALIGN(8) {
    __start_got_plt = .;
    KEEP(*(.got.plt))
    __stop_got_plt = .;
}
ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")

/* Read-only data text section with alignment */
.rodata.text : {
    . = ALIGN(0x1000); 
    __idmap_text_start = .;
    *(.idmap.text)
    __idmap_text_end = .;
    . = ALIGN(1 << 12);
}

/* Page directories with alignment */
idmap_pg_dir = .;
. += (1 << 12);
reserved_pg_dir = .;
. += (1 << 12);
swapper_pg_dir = .;
. += (1 << 12);

/* EFI Stub Section */
.efi.stub : ALIGN(4K) {
    KEEP(*(.efi.stub));
}

.efi.stub.got : ALIGN(4K) {
    __efistub_got_start = .;
    KEEP(*(.efi.stub.got))
    __efistub_got_end = .;
}

/* Initialization section alignment */
. = ALIGN(0x10000);
__init_begin = .;
__inittext_begin = .;

/* Initialization text section */
.init.text : ALIGN(4K) {
/* .init.text : AT(ADDR(.init.text) - 0) { */
      _sinittext = .;
      *(.init.text .init.text.*)
      *(.text.startup)
      _einittext = .;
}

/* Exit text section */
__exittext_begin = .;
.exit.text : {
    *(.exit.text)
    *(.text.exit)
}
__exittext_end = .;

/* Alternate instructions */
.altinstructions : {
    __alt_instructions = .;
    *(.altinstructions)
    __alt_instructions_end = .;
}


/* Align to 64 KB and mark the end of init text and beginning of init data */
. = ALIGN(0x10000);
__inittext_end = .;


. = ALIGN(0x10000);
.data.rel : { *(.data.rel) }
. = ALIGN(0x10000);
.data.rel.local : { *(.data.rel.local) }
. = ALIGN(0x10000);
.data.rel.ro.local : { *(.data.rel.ro.local) }

__initdata_begin = .;

/* Initialization of page directories with clarified alignment logic */
init_idmap_pg_dir = .;

/* Calculate additional page directory space based on conditions */
. += ((1 + 
    (( ((48 - 4) / (12 - 3)) - 1 > 3) ? 
        (((_end - 1) >> ((12 - 3) * (4 - 2) + 3) + 3 * (12 - 3)) 
         - ((-((1 << (48 - 1)) + 0x80000000)) >> ((12 - 3) * (4 - 2) + 3) + 3 * (12 - 3)) + 1) 
        : 0) 
    + (( ((48 - 4) / (12 - 3)) - 1 > 2) ? 
        (((_end - 1) >> ((12 - 3) * (4 - 2) + 3) + 2 * (12 - 3)) 
         - ((-((1 << (48 - 1)) + 0x80000000)) >> ((12 - 3) * (4 - 2) + 3) + 2 * (12 - 3)) + 1) 
        : 0) 
    + (( ((48 - 4) / (12 - 3)) - 1 > 1) ? 
        (((_end - 1) >> ((12 - 3) * (4 - 2) + 3) + 1 * (12 - 3)) 
         - ((-((1 << (48 - 1)) + 0x80000000)) >> ((12 - 3) * (4 - 2) + 3) + 1 * (12 - 3)) + 1) 
        : 0)) + 3) * (1 << 12);

init_idmap_pg_end = .;

/* Initramfs section */
.init.ramfs : ALIGN(4K) {
    __initramfs_start = .;
    KEEP(*(.init.ramfs));
    __initramfs_end = .;
}

/* Initramfs metadata section */
.init.ramfs.info : ALIGN(8) {
    __initramfs_size = ABSOLUTE(__initramfs_end - __initramfs_start);
    KEEP(*(.init.ramfs.info));
}

/* Global Offset Table (GOT) Section */
.got : ALIGN(8) {
    KEEP(*(.got));
    KEEP(*(.got.*));
}


.builtin_fw : {
    __start_builtin_fw = .;
    KEEP(*(.builtin_fw))
    __end_builtin_fw = .;
}

.earlycon_table : {
    __earlycon_table = .;
    KEEP(*(.earlycon_table))
    __earlycon_table_end = .;
}

/* Init data section with sorted and aligned entries */
.init.data : {
    KEEP(*(SORT(___kentry+*)))
    *(.init.data .init.data.*)
    *(.init.rodata .init.rodata.*)

    /* Tables with specific alignments */
    . = ALIGN(8); __clk_of_table = .; KEEP(*(__clk_of_table)) KEEP(*(__clk_of_table_end));
    . = ALIGN(8); __reservedmem_of_table = .; KEEP(*(__reservedmem_of_table)) KEEP(*(__reservedmem_of_table_end));
    . = ALIGN(8); __timer_of_table = .; KEEP(*(__timer_of_table)) KEEP(*(__timer_of_table_end));
    . = ALIGN(8); __cpu_method_of_table = .; KEEP(*(__cpu_method_of_table)) KEEP(*(__cpu_method_of_table_end));

    /* Device tree blob initialization */
    . = ALIGN(32); __dtb_start = .; KEEP(*(.dtb.init.rodata)) __dtb_end = .;

    /* Additional tables */
    . = ALIGN(8); __irqchip_of_table = .; KEEP(*(__irqchip_of_table)) KEEP(*(__irqchip_of_table_end));
    . = ALIGN(8); __kunit_init_suites_start = .; KEEP(*(.kunit_init_test_suites)) __kunit_init_suites_end = .;

    /* Setup init calls with alignment */
    . = ALIGN(16); __setup_start = .; KEEP(*(.init.setup)) __setup_end = .;

    /* Initcall stages with organized sections */
    __initcall_start = .; KEEP(*(.initcallearly.init))
    __initcall0_start = .; KEEP(*(.initcall0.init)) KEEP(*(.initcall0s.init))
    __initcall1_start = .; KEEP(*(.initcall1.init)) KEEP(*(.initcall1s.init))
    __initcall2_start = .; KEEP(*(.initcall2.init)) KEEP(*(.initcall2s.init))
    __initcall3_start = .; KEEP(*(.initcall3.init)) KEEP(*(.initcall3s.init))
    __initcall4_start = .; KEEP(*(.initcall4.init)) KEEP(*(.initcall4s.init))
    __initcall5_start = .; KEEP(*(.initcall5.init)) KEEP(*(.initcall5s.init))
    __initcallrootfs_start = .; KEEP(*(.initcallrootfs.init)) KEEP(*(.initcallrootfss.init))
    __initcall6_start = .; KEEP(*(.initcall6.init)) KEEP(*(.initcall6s.init))
    __initcall7_start = .; KEEP(*(.initcall7.init)) KEEP(*(.initcall7s.init))
    __initcall_end = .;

    /* Console initialization calls */
    __con_initcall_start = .; KEEP(*(.con_initcall.init)) __con_initcall_end = .;

    /* Miscellaneous sections */
    *(.init.altinstructions .init.bss)
}

/* Exit data section */
.exit.data : {
    *(.exit.data .exit.data.*)
    *(.fini_array .fini_array.*)
    *(.dtors .dtors.*)
}

/* Runtime data sections with alignment */
. = ALIGN(8); runtime_shift_d_hash_shift : AT(ADDR(runtime_shift_d_hash_shift) - 0) {
    __start_runtime_shift_d_hash_shift = .;
    KEEP(*(runtime_shift_d_hash_shift))
    __stop_runtime_shift_d_hash_shift = .;
}

. = ALIGN(8); runtime_ptr_dentry_hashtable : AT(ADDR(runtime_ptr_dentry_hashtable) - 0) {
    __start_runtime_ptr_dentry_hashtable = .;
    KEEP(*(runtime_ptr_dentry_hashtable))
    __stop_runtime_ptr_dentry_hashtable = .;
}

/* Per-CPU data section with alignment */
. = ALIGN(1 << 12); .data..percpu : AT(ADDR(.data..percpu) - 0) {
    __per_cpu_load = .;
    __per_cpu_start = .;
    *(.data..percpu..first)
    . = ALIGN(1 << 12);
    *(.data..percpu..page_aligned)
    . = ALIGN(1 << 6);
    *(.data..percpu..read_mostly)
    . = ALIGN(1 << 6);
    *(.data..percpu)
    *(.data..percpu..shared_aligned)
    __per_cpu_end = .;
}


/*********************************************/


 .rela.dyn : ALIGN(4096) {
  __pi_rela_start = .;
  *(.rela .rela*)
  __pi_rela_end = .;
 }
 .relr.dyn : ALIGN(4096) {
  __pi_relr_start = .;
  *(.relr.dyn)
  __pi_relr_end = .;
 }

/* Align and mark the end of initialization data */
. = ALIGN(0x00010000);
__initdata_end = .;
__init_end = .;


_edata = .;

/* Data sections */
_data = .;
_sdata = .;
.data : ALIGN(4K) {
    /* Stack initialization */
    . = ALIGN(16K);
    __start_init_stack = .;
    init_thread_union = .;
    init_stack = .;
    KEEP(*(.data..init_task))
    KEEP(*(.data..init_thread_info))
    . = __start_init_stack + (16K);
    __end_init_stack = .;

    /* No-save data sections */
    . = ALIGN(4K);
    __nosave_begin = .;
    *(.data..nosave)
    . = ALIGN(4K);
    __nosave_end = .;

    /* Page-aligned data */
    . = ALIGN(4K);
    *(.data..page_aligned)

    /* Cache-line-aligned data */
    . = ALIGN(64);
    *(.data..cacheline_aligned)

    /* Read-mostly data */
    . = ALIGN(64);
    *(.data..read_mostly)

    /* Other data sections */
    *(.xiptext)
    *(.data)
    *(.data..decrypted)
    *(.ref.data)
    *(.data..shared_aligned)
    *(.data.unlikely)

    /* Once-only data */
    __start_once = .;
    *(.data.once)
    __end_once = .;

    /* Tracepoints */
    . = ALIGN(32);
    *(__tracepoints)

    /* Dynamic debugging classes */
    . = ALIGN(8);
    __start___dyndbg_classes = .;
    KEEP(*(__dyndbg_classes))
    __stop___dyndbg_classes = .;

    /* Dynamic debugging entries */
    . = ALIGN(8);
    __start___dyndbg = .;
    KEEP(*(__dyndbg))
    __stop___dyndbg = .;

    /* Allocation tags */
    . = ALIGN(8);
    __start_alloc_tags = .;
    KEEP(*(alloc_tags))
    __stop_alloc_tags = .;

    /* KUnit test suites */
    . = ALIGN(8);
    __kunit_suites_start = .;
    KEEP(*(.kunit_test_suites))
    __kunit_suites_end = .;

    CONSTRUCTORS
}

/* MMU-off writable data section */
.mmuoff.data.write : ALIGN(2K) {
    __mmuoff_data_start = .;
    *(.mmuoff.data.write)
}

/* MMU-off readable data section */
.mmuoff.data.read : ALIGN(2K) {
    *(.mmuoff.data.read)
    __mmuoff_data_end = .;
}
 __pecoff_data_rawsize = ABSOLUTE(. - __initdata_begin);

_edata = .;
 . = ALIGN(0); __bss_start = .;

/* Small BSS Section */
.sbss : AT(ADDR(.sbss) - 0) {
    *(.dynsbss)      /* Dynamic small BSS */
    *(.sbss)         /* Small BSS */
    *(.scommon)      /* Small common symbols */
}

/* Main BSS Section */
.bss : AT(ADDR(.bss) - 0) {
    . = ALIGN(1 << 12);        /* Align to 4KB */
    *(.bss..page_aligned)      /* Page-aligned BSS */
    . = ALIGN(1 << 12);        /* Ensure further alignment */
    *(.dynbss)                 /* Dynamic BSS */
    *(.bss)                    /* General BSS */
    *(COMMON)                  /* Common symbols */
}
. = ALIGN(0); __bss_stop = .;

 init_pg_dir = .;
 . += ((1 << 12) * ((1 + (((5 - 1)) > 3 ? ((((((_end)) - 1) >> (((12 - 3) * (4 - (2)) + 3) + 3 * (12 - 3))) - (((((((-(((1)) << (((48)) - 1)))) + (0x80000000))))) >> (((12 - 3) * (4 - (2)) + 3) + 3 * (12 - 3))) + 1) + (0)) : 0) + (((5 - 1)) > 2 ? ((((((_end)) - 1) >> (((12 - 3) * (4 - (2)) + 3) + 2 * (12 - 3))) - (((((((-(((1)) << (((48)) - 1)))) + (0x80000000))))) >> (((12 - 3) * (4 - (2)) + 3) + 2 * (12 - 3))) + 1) + (0)) : 0) + (((5 - 1)) > 1 ? ((((((_end)) - 1) >> (((12 - 3) * (4 - (2)) + 3) + 1 * (12 - 3))) - (((((((-(((1)) << (((48)) - 1)))) + (0x80000000))))) >> (((12 - 3) * (4 - (2)) + 3) + 1 * (12 - 3))) + 1) + (0)) : 0)) + (5 + 1)));
 init_pg_end = .;
 . += 0x00001000;
 early_init_stack = .;
 . = ALIGN(0x00010000);
 __pecoff_data_size = ABSOLUTE(. - __initdata_begin);

/* End of kernel data */
_end = .;

/* Stab debugging sections */
.stab : { *(.stab) }
.stabstr : { *(.stabstr) }
.stab.excl : { *(.stab.excl) }
.stab.exclstr : { *(.stab.exclstr) }
.stab.index : { *(.stab.index) }
.stab.indexstr : { *(.stab.indexstr) }

/* Debug information sections */
.debug : { *(.debug) }
.line : { *(.line) }
.debug_srcinfo : { *(.debug_srcinfo) }
.debug_sfnames : { *(.debug_sfnames) }
.debug_aranges : { *(.debug_aranges) }
.debug_pubnames : { *(.debug_pubnames) }
.debug_info : { *(.debug_info .gnu.linkonce.wi.*) }
.debug_abbrev : { *(.debug_abbrev) }
.debug_line : { *(.debug_line) }
.debug_frame : { *(.debug_frame) }
.debug_str : { *(.debug_str) }
.debug_loc : { *(.debug_loc) }
.debug_macinfo : { *(.debug_macinfo) }
.debug_pubtypes : { *(.debug_pubtypes) }
.debug_ranges : { *(.debug_ranges) }
.debug_weaknames : { *(.debug_weaknames) }
.debug_funcnames : { *(.debug_funcnames) }
.debug_typenames : { *(.debug_typenames) }
.debug_varnames : { *(.debug_varnames) }
.debug_gnu_pubnames : { *(.debug_gnu_pubnames) }
.debug_gnu_pubtypes : { *(.debug_gnu_pubtypes) }
.debug_types : { *(.debug_types) }
.debug_addr : { *(.debug_addr) }
.debug_line_str : { *(.debug_line_str) }
.debug_loclists : { *(.debug_loclists) }
.debug_macro : { *(.debug_macro) }
.debug_names : { *(.debug_names) }
.debug_rnglists : { *(.debug_rnglists) }
.debug_str_offsets : { *(.debug_str_offsets) }

/* Additional debugging and metadata sections */
.comment : { *(.comment) }
.symtab : { *(.symtab) }
.strtab : { *(.strtab) }
.shstrtab : { *(.shstrtab) }

/* Kernel size and flags */
_kernel_size_le_lo32 = ((_end - _text) & 0xffffffff);
_kernel_size_le_hi32 = ((_end - _text) >> 32) & 0xffffffff;
_kernel_flags_le_lo32 = (((0 << 0) | (((12 - 10) / 2) << (0 + 1)) | (1 << ((0 + 1) + 2))) & 0xffffffff);
_kernel_flags_le_hi32 = ((((0 << 0) | (((12 - 10) / 2) << (0 + 1)) | (1 << ((0 + 1) + 2)))) >> 32) & 0xffffffff;

/* Procedure Linkage Table (PLT) */
.plt : {
    *(.plt)
    *(.plt.*)
    *(.iplt)
    *(.igot .igot.plt)
}

 ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
 .data.rel.ro : { *(.data.rel.ro) }
 ASSERT(SIZEOF(.data.rel.ro) == 0, "Unexpected RELRO detected!")
}
PROVIDE(__efistub__GLOBAL_OFFSET_TABLE_ = _GLOBAL_OFFSET_TABLE_);
/* PROVIDE(__efistub__GLOBAL_OFFSET_TABLE_ = __start_got); */
PROVIDE(__efistub_primary_entry = primary_entry);
PROVIDE(__efistub_caches_clean_inval_pou = __pi_caches_clean_inval_pou);
PROVIDE(__efistub__text = _text);
PROVIDE(__efistub__end = _end);
PROVIDE(__efistub___inittext_end = __inittext_end);
PROVIDE(__efistub__edata = _edata);
PROVIDE(__efistub_screen_info = screen_info);
PROVIDE(__efistub__ctype = _ctype);
PROVIDE(__pi___memcpy = __pi_memcpy);
PROVIDE(__pi___memmove = __pi_memmove);
PROVIDE(__pi___memset = __pi_memset);
PROVIDE(__pi_id_aa64isar1_override = id_aa64isar1_override);
PROVIDE(__pi_id_aa64isar2_override = id_aa64isar2_override);
PROVIDE(__pi_id_aa64mmfr0_override = id_aa64mmfr0_override);
PROVIDE(__pi_id_aa64mmfr1_override = id_aa64mmfr1_override);
PROVIDE(__pi_id_aa64mmfr2_override = id_aa64mmfr2_override);
PROVIDE(__pi_id_aa64pfr0_override = id_aa64pfr0_override);
PROVIDE(__pi_id_aa64pfr1_override = id_aa64pfr1_override);
PROVIDE(__pi_id_aa64smfr0_override = id_aa64smfr0_override);
PROVIDE(__pi_id_aa64zfr0_override = id_aa64zfr0_override);
PROVIDE(__pi_arm64_sw_feature_override = arm64_sw_feature_override);
PROVIDE(__pi_arm64_use_ng_mappings = arm64_use_ng_mappings);
PROVIDE(__pi__ctype = _ctype);
PROVIDE(__pi_memstart_offset_seed = memstart_offset_seed);
PROVIDE(__pi_init_idmap_pg_dir = init_idmap_pg_dir);
PROVIDE(__pi_init_idmap_pg_end = init_idmap_pg_end);
PROVIDE(__pi_init_pg_dir = init_pg_dir);
PROVIDE(__pi_init_pg_end = init_pg_end);
PROVIDE(__pi_swapper_pg_dir = swapper_pg_dir);
PROVIDE(__pi__text = _text);
PROVIDE(__pi__stext = _stext);
PROVIDE(__pi__etext = _etext);
PROVIDE(__pi___start_rodata = __start_rodata);
PROVIDE(__pi___inittext_begin = __inittext_begin);
PROVIDE(__pi___inittext_end = __inittext_end);
PROVIDE(__pi___initdata_begin = __initdata_begin);
PROVIDE(__pi___initdata_end = __initdata_end);
PROVIDE(__pi__data = _data); 
PROVIDE(__pi___bss_start = __bss_start);
PROVIDE(__pi___bss_stop = __bss_stop);
PROVIDE(__pi__end = _end);
ASSERT(__hyp_idmap_text_end - __hyp_idmap_text_start <= (1 << 12),
 "HYP init code too big")
ASSERT(__idmap_text_end - (__idmap_text_start & ~(0x00001000 - 1)) <= 0x00001000,
 "ID map text too big or misaligned")
ASSERT(_text == ((((-(((1)) << (((48)) - 1)))) + (0x80000000))), "HEAD is misaligned")
ASSERT(swapper_pg_dir - reserved_pg_dir == ((1 << 12)),
       "RESERVED_SWAPPER_OFFSET is wrong!")
ASSERT(4096 >= 0x00001000, "KEXEC_CONTROL_PAGE_SIZE is broken")

