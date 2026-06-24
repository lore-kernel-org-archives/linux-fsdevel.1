Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8426E71E;
	Wed, 24 Jun 2026 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291863; cv=none; b=uoYj/FmRBxRqs9tQsr1Y6Wfdzoz8UJ3qs1eWWyXWCI8CZrHGQBLULvML1mc4cM3BvBbWO8ZynHClDjgLqMSNWK8ZT/2KiHA8gTJ6rlh+y4JVuoLJVfXL5hsGP533KQO1ITP5FmN1f5VvQkBw/XxSBZsF3yT7rhS26fqJ9VxunLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291863; c=relaxed/simple;
	bh=jwmDAI5b2XlsJXiJV+lWEqi/M/MxOVt3fmjO7nAUapo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7DIXakx74BOtHFntHeISVUw6Dp8D3pcBd0ZMNAXkyp+IoIo2MIvam6qKVenM3PCq4W/spcrdig40JhQGJ/TugVz1svW+QP2bQLAtwBeST9t+AzlUzR1fmvqx2Rosngl7+6wyjIuhFSa9HXOqAVGd/rbmQLxHxXfrDyly7n4R2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAY+cTNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAY+cTNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5B41F000E9;
	Wed, 24 Jun 2026 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782291862;
	bh=DvZo4dfKcQdWMEa+yMtBLcFevAKmXUiorQqiyKg/Gxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bAY+cTNToWBJnKGQDA8gAs/066/N/R8/62SHubnIoaGQ6/UHCzUvqYq1n3mbzFdBp
	 LETETGfxHbxbrXyNBAQzHx2iFg9tzieHx29KhFde+Dga20KnMczAEXOSh2Rx2rSjOE
	 79XDATUQguYAMGovvf2fA4t50uSjxzp3R4vxEKDvBKCsohoWMSnGQ9l7jkgV3fQPZj
	 SPsQPG26dq6gcib+nZwdb678IALaEGryKYHPGJw8vtfJUYrxhLDje3aSsLw6UJucQM
	 q2En0wLaod2vTpivX7eDRfh5vCNvk/+PTNtNJycbR+wFUbNdrE5KqYEwylQ30N58AW
	 /RcFlcKB/QLrQ==
Message-ID: <83df186a-c3e1-488d-8981-94192f36a2ea@kernel.org>
Date: Wed, 24 Jun 2026 11:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead to
 VMA boundaries"
To: Frederick Mayle <fmayle@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Jan Kara <jack@suse.cz>, Kalesh Singh <kaleshsingh@google.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org>
 <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
 <ajWXEn7gECvgG7F5@pedro-suse.lan>
 <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
 <7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>
 <ajk-NMghY50F6Sli@lucifer>
 <20260622095855.50e4276e331cb2d01db7183a@linux-foundation.org>
 <ajlsum91zeh-oRz6@casper.infradead.org>
 <CAJuCfpHaBFtgAyE4jum-=p3u8X3STi3e6i6==fQR+0ksaU2wwA@mail.gmail.com>
 <ajmJT6AAor46gLBw@pedro-suse.lan>
 <CAHCxdc4tBb+U7LrrHH+sTEr5Mv_0hJKV6TMZNrrjb-p28sPBcw@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAHCxdc4tBb+U7LrrHH+sTEr5Mv_0hJKV6TMZNrrjb-p28sPBcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/26 21:28, Frederick Mayle wrote:
> On Mon, Jun 22, 2026 at 3:29 PM Pedro Falcato <pfalcato@suse.de> wrote:
>>
>> On Mon, Jun 22, 2026 at 10:57:30AM -0700, Suren Baghdasaryan wrote:
>>>
>>> Thanks for the suggestion! That sounds sensible to me.
>>
>> I don't think this works. Here's an example readelf -a from a random,
>> trivial ELF I have:
>>
>> pfalcato@pedro-suse:~/linux> cc -g main.c
>> pfalcato@pedro-suse:~/linux> readelf -a a.out
>> ELF Header:
>>   Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
>>   Class:                             ELF64
>>   Data:                              2's complement, little endian
>>   Version:                           1 (current)
>>   OS/ABI:                            UNIX - System V
>>   ABI Version:                       0
>>   Type:                              EXEC (Executable file)
>>   Machine:                           Advanced Micro Devices X86-64
>>   Version:                           0x1
>>   Entry point address:               0x401040
>>   Start of program headers:          64 (bytes into file)
>>   Start of section headers:          18448 (bytes into file)
>>   Flags:                             0x0
>>   Size of this header:               64 (bytes)
>>   Size of program headers:           56 (bytes)
>>   Number of program headers:         14
>>   Size of section headers:           64 (bytes)
>>   Number of section headers:         38
>>   Section header string table index: 37
>>
>> Section Headers:
>>   [Nr] Name              Type             Address           Offset
>>        Size              EntSize          Flags  Link  Info  Align
>>   [ 0]                   NULL             0000000000000000  00000000
>>        0000000000000000  0000000000000000           0     0     0
>>   [ 1] .note.gnu.pr[...] NOTE             0000000000400350  00000350
>>        0000000000000040  0000000000000000   A       0     0     8
>>   [ 2] .note.gnu.bu[...] NOTE             0000000000400390  00000390
>>        0000000000000024  0000000000000000   A       0     0     4
>>   [ 3] .interp           PROGBITS         00000000004003b4  000003b4
>>        000000000000001c  0000000000000000   A       0     0     1
>>   [ 4] .hash             HASH             00000000004003d0  000003d0
>>        0000000000000024  0000000000000004   A       6     0     8
>>   [ 5] .gnu.hash         GNU_HASH         00000000004003f8  000003f8
>>        000000000000001c  0000000000000000   A       6     0     8
>>   [ 6] .dynsym           DYNSYM           0000000000400418  00000418
>>        0000000000000060  0000000000000018   A       7     1     8
>>   [ 7] .dynstr           STRTAB           0000000000400478  00000478
>>        000000000000004a  0000000000000000   A       0     0     1
>>   [ 8] .gnu.version      VERSYM           00000000004004c2  000004c2
>>        0000000000000008  0000000000000002   A       6     0     2
>>   [ 9] .gnu.version_r    VERNEED          00000000004004d0  000004d0
>>        0000000000000030  0000000000000000   A       7     1     8
>>   [10] .rela.dyn         RELA             0000000000400500  00000500
>>        0000000000000030  0000000000000018   A       6     0     8
>>   [11] .rela.plt         RELA             0000000000400530  00000530
>>        0000000000000018  0000000000000018  AI       6    24     8
>>   [12] .init             PROGBITS         0000000000401000  00001000
>>        000000000000001b  0000000000000000  AX       0     0     4
>>   [13] .plt              PROGBITS         0000000000401020  00001020
>>        0000000000000020  0000000000000010  AX       0     0     16
>>   [14] .text             PROGBITS         0000000000401040  00001040
>>        000000000000011b  0000000000000000  AX       0     0     16
>>   [15] .fini             PROGBITS         000000000040115c  0000115c
>>        000000000000000d  0000000000000000  AX       0     0     4
>>   [16] .rodata           PROGBITS         0000000000402000  00002000
>>        0000000000000004  0000000000000004  AM       0     0     4
>>   [17] .eh_frame_hdr     PROGBITS         0000000000402004  00002004
>>        000000000000002c  0000000000000000   A       0     0     4
>>   [18] .eh_frame         PROGBITS         0000000000402030  00002030
>>        0000000000000088  0000000000000000   A       0     0     8
>>   [19] .note.ABI-tag     NOTE             00000000004020b8  000020b8
>>        0000000000000020  0000000000000000   A       0     0     4
>>   [20] .init_array       INIT_ARRAY       0000000000403de8  00002de8
>>        0000000000000008  0000000000000008  WA       0     0     8
>>   [21] .fini_array       FINI_ARRAY       0000000000403df0  00002df0
>>        0000000000000008  0000000000000008  WA       0     0     8
>>   [22] .dynamic          DYNAMIC          0000000000403df8  00002df8
>>        00000000000001e0  0000000000000010  WA       7     0     8
>>   [23] .got              PROGBITS         0000000000403fd8  00002fd8
>>        0000000000000010  0000000000000008  WA       0     0     8
>>   [24] .got.plt          PROGBITS         0000000000403fe8  00002fe8
>>        0000000000000020  0000000000000008  WA       0     0     8
>>   [25] .data             PROGBITS         0000000000404008  00003008
>>        0000000000000010  0000000000000000  WA       0     0     8
>>   [26] .bss              NOBITS           0000000000404018  00003018
>>        0000000000000008  0000000000000000  WA       0     0     1
>>   [27] .comment          PROGBITS         0000000000000000  00003018
>>        0000000000000019  0000000000000001  MS       0     0     1
>>   [28] .debug_aranges    PROGBITS         0000000000000000  00003040
>>        0000000000000150  0000000000000000           0     0     16
>>   [29] .debug_info       PROGBITS         0000000000000000  00003190
>>        0000000000000444  0000000000000000           0     0     1
>>   [30] .debug_abbrev     PROGBITS         0000000000000000  000035d4
>>        0000000000000245  0000000000000000           0     0     1
>>   [31] .debug_line       PROGBITS         0000000000000000  00003819
>>        0000000000000274  0000000000000000           0     0     1
>>   [32] .debug_str        PROGBITS         0000000000000000  00003a8d
>>        0000000000000540  0000000000000001  MS       0     0     1
>>   [33] .debug_line_str   PROGBITS         0000000000000000  00003fcd
>>        0000000000000163  0000000000000001  MS       0     0     1
>>   [34] .debug_rnglists   PROGBITS         0000000000000000  00004130
>>        0000000000000042  0000000000000000           0     0     1
>>   [35] .symtab           SYMTAB           0000000000000000  00004178
>>        0000000000000360  0000000000000018          36    20     8
>>   [36] .strtab           STRTAB           0000000000000000  000044d8
>>        00000000000001bc  0000000000000000           0     0     1
>>   [37] .shstrtab         STRTAB           0000000000000000  00004694
>>        0000000000000176  0000000000000000           0     0     1
>> Key to Flags:
>>   W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
>>   L (link order), O (extra OS processing required), G (group), T (TLS),
>>   C (compressed), x (unknown), o (OS specific), E (exclude),
>>   D (mbind), l (large), p (processor specific)
>>
>> Notice the section header table, and how it starts after program text and
>> program data, and how all the other ELF gunk (debug info, symtab,
>> strtab(s)) also goes after .data. So (mostly) the real problematic readahead
>> would be on the RW VMA that covers .data.
>>
>> (This also matches my understanding of linkers, where they generally do
>> (to put it simply) ELF headers - program headers - .text - .data - .bss, with
>> stripable gunk after it.)
>>
>> It's also the case that synchronous RA on VM_EXEC is already pretty
>> conservative and limited, see the big if (vm_flags & VM_EXEC) in
>> do_sync_mmap_readahead(). (I think the underlying logic behind also
>> implies that async RA will not be started against these pages, but I
>> am not sure).
>>
>> --
>> Pedro
> 
> Yes, I think readahead of VM_EXEC is already restricted to the VMA.
> Maybe there is an edge case where someone does buffered reads on an
> ELF file, leaving a PG_readahead flag inside the VM_EXEC range, then
> it could trigger async readahead beyond the end, but that sounds
> minor.
> 
> For next steps: Suppose we show the mmap usage in this video encoder
> is significantly inefficient compared to buffered reads or a big mmap
> and that project accepts a contribution to move away from the small
> mmaps. Would we be comfortable attempting this again as is? Probably
> there would be a lag before all users of the encoder update and they
> may see this bad perf.

How could you be sure that there isn't some other proprietary (or even just
another open-source) software out there that relies on similar things, but
doesn't provide easy benchmarks that can easily catch this?

-- 
Cheers,

David
