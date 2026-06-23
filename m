Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95A38B7BA
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242899; cv=pass; b=lrwojC7kUQ2RM5JTVFNUKMqVktSoAAtKhiR1mAqzXx3dQH0abgt5Mvt+oqNiRA6AnjQZ8VdkBJLHW2y4Ljwn2OMWbWZFQ5re6tlIhONgo0Om5NtyJHKvUMHdoE/ymhxmhzI+q6YzHa2jScw4mQamqyyKrL0J19WqpOa5lXGAeCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242899; c=relaxed/simple;
	bh=5rEG/tN9LTwtOz5+nsFHM+D1acVebq1i74OGh/pL4AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7b14aYKl13IRT1v82DI0yggHJmF/MCQZ1+HPzoFYJFSgsMByN/Nsdk1fnXEKicOD4RIINm7N2mIhpCBoy9BRyYi9va7XB8x312FSqMOUOkM/Oz+yQP0hQvasFufhOE4fFgH4Pgw7Gx/kk+xXaRdBaENwREfYywzBwEV2CLOtds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuKYjP3x; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuKYjP3x"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-133362c30cfso1444c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 12:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782242897; cv=none;
        d=google.com; s=arc-20260327;
        b=NW5KbBDdp4Dd1nShqg+iMvQ35ayrlJKL1QXLaqOx91hGf8h3LqBIxFwpMHa85C7Hgp
         6U7dWzoFoSqAS8I41uB8w4I4iyyi7JGAbypHXen/MFS9BFO/Qk7o1YtFs7gEHNnpZuC4
         I370tvfXHm1MMB+CQe3bMWkxSaLFSuJZcid1uA3CoKkRB24gMs5hqHiFxkOfw7uv3afx
         ffkXalzzcQykJdRkUrA6pNzM9dB4IDPEFHtj1X/ozNJ3PAmYIeMDoJjqU2ktfqaC6O71
         rZop/W0p7WNqKfssXxvcFOE1DabU2pJhLflX0q7rx1xqjfrNCfPb+Laeh5oh4rw1Pnd+
         /6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctSNWPFltveQs2acbQSRG8EL+kNJGfmjRALamlmiSv4=;
        fh=htZCUr+VrZ5JJGLbT0TQlContncViea3u5EqYGnUlEc=;
        b=qqA18vPjdJUTLPJHLcsqS9xyee+/NK96o7z9gQsznCQYgoX4Q6ZTim/jnHcjxjU/aq
         arSE8knBPr175Xcj4AR0RcAcXCpZyyeoA3oKh1dfBwpC4jr2YDigAzjdoiytTYViGSvL
         Lacj+0eWF85OF6YEDcWPdVEA4xAbOff/q4kvddyXuKEBnyTXhYmcNaI1XDEi+emV6csb
         LbeQ+OZ3AfdUcO8KungCvbNwsyYwbz40uSRZDGm/z/4zkANNld5FwkWMnZzJ9h/gTmR/
         LNp+7lUtvOdKCWMQlKYv/0k7a+33RZPhU5ODNnPE1UKC6p9AEzBF5oI0+GxnDZ5hQISS
         R0eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782242897; x=1782847697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ctSNWPFltveQs2acbQSRG8EL+kNJGfmjRALamlmiSv4=;
        b=IuKYjP3x4t8C3Lv6nTYGK/ZUpm37qefaocWm+Eg/XAVy7PZdDjHdTusUb8WKkbYNIi
         a1wjEI4c8ZkMA1NnwLZJXPudrrADFMBZHu4TalFKiZY/mhMm/7X47yX04jVJ2t9Tq1Jh
         JGTuyE0yuqAOKDcNyVtIHEiwH2v4ANGmZ8zRx8GCtxYrLjM2M+ecC1LEVaw0qs/hTZUu
         APgp4gYRBnlNB7n56x/Ssr/VGCWJiAfgsXlkIcFa5Z/dMXRQIQ9H9t4saVr+RPjgY0Om
         4fJz/6gQjPtyHQUih3jpwQTF1pD6AAdSSSIWZNJjUt+Hm3zV7c1KFZrKdNdKvP8JJGM4
         Pw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242897; x=1782847697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctSNWPFltveQs2acbQSRG8EL+kNJGfmjRALamlmiSv4=;
        b=N83ZcV3CFsMBgv9KqiPT08J6PTc/R03fvovlYEVd8ulA7IHHidQYRf0h+x4OSGJu3/
         BnCgu4bVeu3lZAx4tKYAI0/hsWUS5gd90AOV0rz4NzXNQcxI1U3isoGYbAjo7sNss1Nh
         P39nlFP+W6/ztQqgCf+xC5ZrFlEmnnTA5YsErEsa/hyBvcNJ9uOJZkVfA0CUH8BZILtR
         opTkiGEk5J/t3EjKVhF+hckDmeVOTc8mDm6VEW5XYyUAAkYFMMLwGO6afmqXndPr74XZ
         CnPw4vMbK6tpjmR5hIK/kPqfKXU0AGO195MaMbYZ7bWCmRxn2mGB1Un+Rd6gE+kIk9x8
         0igw==
X-Forwarded-Encrypted: i=1; AFNElJ8trmZiiFYe9/8hU9IqmQXEjZf8D+pxAqHnughDecEifCwbK8EFF/7MX+bE/m5wL4WnhEf94ahE/sE9ubsw@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLMkpgBvGoroEUAlPRCBC6TZrRTlVvXHbPCOEgXdQ6fXLOosg
	NPmAIMJ5WQiu0TOoDtThSsUJ+YugRMjOj8kpuhNS5ZFz7n0tZ1cXUI2E2KKEgdbXNdjP025BGVD
	PCkImr4I2qZ47o18pmX1MMFeUb1Ncw9MQh6ph46GJ
X-Gm-Gg: AfdE7cn+1IdjJtuKxdw1POPrZbziJtb4GWGbpADtXFFsnXDAMWgRpeFq5hNC8aw+87Q
	SYPRzG3qPTY/Amav3re+JK1duq13q/3wLPwK1SCJwjH76HJ+sEffSN88s/uXp92IJY0L6Ers6sH
	1srUppV+zSKtwMlWOp8HDrAT2MekhkKburxfcfMq4j0Rxtq+mu8BK49KXsW6K6IeUO6RIpFR2JQ
	O2sf2BlEX47pLEsvPqhQFFH4Dmdk6V9plFUsbnNcYrTk4XJd3vZXCb8mUEIZ7L3YOm+1/gyUYxX
	r4ORK2J/zhg+eWzWskroqpr53sawPhM=
X-Received: by 2002:a05:7022:425:b0:134:f1e8:e598 with SMTP id
 a92af1059eb24-139cf6de08dmr36512c88.25.1782242896523; Tue, 23 Jun 2026
 12:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org> <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
 <ajWXEn7gECvgG7F5@pedro-suse.lan> <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
 <7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>
 <ajk-NMghY50F6Sli@lucifer> <20260622095855.50e4276e331cb2d01db7183a@linux-foundation.org>
 <ajlsum91zeh-oRz6@casper.infradead.org> <CAJuCfpHaBFtgAyE4jum-=p3u8X3STi3e6i6==fQR+0ksaU2wwA@mail.gmail.com>
 <ajmJT6AAor46gLBw@pedro-suse.lan>
In-Reply-To: <ajmJT6AAor46gLBw@pedro-suse.lan>
From: Frederick Mayle <fmayle@google.com>
Date: Tue, 23 Jun 2026 12:28:04 -0700
X-Gm-Features: AVVi8CcOsPAJMGtHSDI_xQS9hzq9FYfdzP8LiSZKEPxLt6IQSan8Zod7orip3Qc
Message-ID: <CAHCxdc4tBb+U7LrrHH+sTEr5Mv_0hJKV6TMZNrrjb-p28sPBcw@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead to
 VMA boundaries"
To: Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:29=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Mon, Jun 22, 2026 at 10:57:30AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Jun 22, 2026 at 10:11=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Mon, Jun 22, 2026 at 09:58:55AM -0700, Andrew Morton wrote:
> > > > > > much as I personally find restricting mmap readahead to a VMA a=
 sensible
> > > > > > thing to do). We just need to figure out how to improve the And=
roid
> > > > > > usecase.
> > > >
> > > > Would a helpful heuristic be to do what 7b32f64bc512 is doing, but =
only
> > > > if PROT_EXEC?
> > >
> > > I was wondering the same thing.  But I think it's right to back this =
out
> > > for now and try that after -rc1 so it gets some time soaking and
> > > bot-teesting.
> >
> > Thanks for the suggestion! That sounds sensible to me.
>
> I don't think this works. Here's an example readelf -a from a random,
> trivial ELF I have:
>
> pfalcato@pedro-suse:~/linux> cc -g main.c
> pfalcato@pedro-suse:~/linux> readelf -a a.out
> ELF Header:
>   Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF64
>   Data:                              2's complement, little endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              EXEC (Executable file)
>   Machine:                           Advanced Micro Devices X86-64
>   Version:                           0x1
>   Entry point address:               0x401040
>   Start of program headers:          64 (bytes into file)
>   Start of section headers:          18448 (bytes into file)
>   Flags:                             0x0
>   Size of this header:               64 (bytes)
>   Size of program headers:           56 (bytes)
>   Number of program headers:         14
>   Size of section headers:           64 (bytes)
>   Number of section headers:         38
>   Section header string table index: 37
>
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
>   [ 0]                   NULL             0000000000000000  00000000
>        0000000000000000  0000000000000000           0     0     0
>   [ 1] .note.gnu.pr[...] NOTE             0000000000400350  00000350
>        0000000000000040  0000000000000000   A       0     0     8
>   [ 2] .note.gnu.bu[...] NOTE             0000000000400390  00000390
>        0000000000000024  0000000000000000   A       0     0     4
>   [ 3] .interp           PROGBITS         00000000004003b4  000003b4
>        000000000000001c  0000000000000000   A       0     0     1
>   [ 4] .hash             HASH             00000000004003d0  000003d0
>        0000000000000024  0000000000000004   A       6     0     8
>   [ 5] .gnu.hash         GNU_HASH         00000000004003f8  000003f8
>        000000000000001c  0000000000000000   A       6     0     8
>   [ 6] .dynsym           DYNSYM           0000000000400418  00000418
>        0000000000000060  0000000000000018   A       7     1     8
>   [ 7] .dynstr           STRTAB           0000000000400478  00000478
>        000000000000004a  0000000000000000   A       0     0     1
>   [ 8] .gnu.version      VERSYM           00000000004004c2  000004c2
>        0000000000000008  0000000000000002   A       6     0     2
>   [ 9] .gnu.version_r    VERNEED          00000000004004d0  000004d0
>        0000000000000030  0000000000000000   A       7     1     8
>   [10] .rela.dyn         RELA             0000000000400500  00000500
>        0000000000000030  0000000000000018   A       6     0     8
>   [11] .rela.plt         RELA             0000000000400530  00000530
>        0000000000000018  0000000000000018  AI       6    24     8
>   [12] .init             PROGBITS         0000000000401000  00001000
>        000000000000001b  0000000000000000  AX       0     0     4
>   [13] .plt              PROGBITS         0000000000401020  00001020
>        0000000000000020  0000000000000010  AX       0     0     16
>   [14] .text             PROGBITS         0000000000401040  00001040
>        000000000000011b  0000000000000000  AX       0     0     16
>   [15] .fini             PROGBITS         000000000040115c  0000115c
>        000000000000000d  0000000000000000  AX       0     0     4
>   [16] .rodata           PROGBITS         0000000000402000  00002000
>        0000000000000004  0000000000000004  AM       0     0     4
>   [17] .eh_frame_hdr     PROGBITS         0000000000402004  00002004
>        000000000000002c  0000000000000000   A       0     0     4
>   [18] .eh_frame         PROGBITS         0000000000402030  00002030
>        0000000000000088  0000000000000000   A       0     0     8
>   [19] .note.ABI-tag     NOTE             00000000004020b8  000020b8
>        0000000000000020  0000000000000000   A       0     0     4
>   [20] .init_array       INIT_ARRAY       0000000000403de8  00002de8
>        0000000000000008  0000000000000008  WA       0     0     8
>   [21] .fini_array       FINI_ARRAY       0000000000403df0  00002df0
>        0000000000000008  0000000000000008  WA       0     0     8
>   [22] .dynamic          DYNAMIC          0000000000403df8  00002df8
>        00000000000001e0  0000000000000010  WA       7     0     8
>   [23] .got              PROGBITS         0000000000403fd8  00002fd8
>        0000000000000010  0000000000000008  WA       0     0     8
>   [24] .got.plt          PROGBITS         0000000000403fe8  00002fe8
>        0000000000000020  0000000000000008  WA       0     0     8
>   [25] .data             PROGBITS         0000000000404008  00003008
>        0000000000000010  0000000000000000  WA       0     0     8
>   [26] .bss              NOBITS           0000000000404018  00003018
>        0000000000000008  0000000000000000  WA       0     0     1
>   [27] .comment          PROGBITS         0000000000000000  00003018
>        0000000000000019  0000000000000001  MS       0     0     1
>   [28] .debug_aranges    PROGBITS         0000000000000000  00003040
>        0000000000000150  0000000000000000           0     0     16
>   [29] .debug_info       PROGBITS         0000000000000000  00003190
>        0000000000000444  0000000000000000           0     0     1
>   [30] .debug_abbrev     PROGBITS         0000000000000000  000035d4
>        0000000000000245  0000000000000000           0     0     1
>   [31] .debug_line       PROGBITS         0000000000000000  00003819
>        0000000000000274  0000000000000000           0     0     1
>   [32] .debug_str        PROGBITS         0000000000000000  00003a8d
>        0000000000000540  0000000000000001  MS       0     0     1
>   [33] .debug_line_str   PROGBITS         0000000000000000  00003fcd
>        0000000000000163  0000000000000001  MS       0     0     1
>   [34] .debug_rnglists   PROGBITS         0000000000000000  00004130
>        0000000000000042  0000000000000000           0     0     1
>   [35] .symtab           SYMTAB           0000000000000000  00004178
>        0000000000000360  0000000000000018          36    20     8
>   [36] .strtab           STRTAB           0000000000000000  000044d8
>        00000000000001bc  0000000000000000           0     0     1
>   [37] .shstrtab         STRTAB           0000000000000000  00004694
>        0000000000000176  0000000000000000           0     0     1
> Key to Flags:
>   W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
>   L (link order), O (extra OS processing required), G (group), T (TLS),
>   C (compressed), x (unknown), o (OS specific), E (exclude),
>   D (mbind), l (large), p (processor specific)
>
> Notice the section header table, and how it starts after program text and
> program data, and how all the other ELF gunk (debug info, symtab,
> strtab(s)) also goes after .data. So (mostly) the real problematic readah=
ead
> would be on the RW VMA that covers .data.
>
> (This also matches my understanding of linkers, where they generally do
> (to put it simply) ELF headers - program headers - .text - .data - .bss, =
with
> stripable gunk after it.)
>
> It's also the case that synchronous RA on VM_EXEC is already pretty
> conservative and limited, see the big if (vm_flags & VM_EXEC) in
> do_sync_mmap_readahead(). (I think the underlying logic behind also
> implies that async RA will not be started against these pages, but I
> am not sure).
>
> --
> Pedro

Yes, I think readahead of VM_EXEC is already restricted to the VMA.
Maybe there is an edge case where someone does buffered reads on an
ELF file, leaving a PG_readahead flag inside the VM_EXEC range, then
it could trigger async readahead beyond the end, but that sounds
minor.

For next steps: Suppose we show the mmap usage in this video encoder
is significantly inefficient compared to buffered reads or a big mmap
and that project accepts a contribution to move away from the small
mmaps. Would we be comfortable attempting this again as is? Probably
there would be a lag before all users of the encoder update and they
may see this bad perf.

If it isn't OK as is for the foreseeable future, we could consider
applying the limit conditionally. Maybe a CONFIG or sysfs option. Or,
use some heuristic to turn it on automatically, e.g. only for ELF
files, or files with VM_EXEC mappings.

We are planning to measure how this change affects memory usage of
Android devices in the field, but we don't have the data yet.
