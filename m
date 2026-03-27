Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FC22B8B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630428; cv=none; b=kES58EolnqvL0HI6x41LzF0yZx1ndLBpwUIfPBDTtGnv0kO+1h/HlCtKszVW6ew55CgglHKo3F3+XOKHTHtx2m9KEVdKThrNk5SlLG8HcrPmQsDqxMRi0rO4QpDe+wYpil1rxkDaQ8IEAd343b8LVeP2Bj1248Sjbn6TSTuWBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630428; c=relaxed/simple;
	bh=Gl6KmMcq+tjSc4jpZX6oUnfWp7Ff3JAsTfx9UiwXWgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2yhQaDW7cXa84n3FgrP1G7trhtWFeRM8RFqAeep0roRMCWDFbVH9uilPvbzpwIXJxFeLQbMbDQtfKrTGVL0tGH36SpIi5lMMt07Pz60UsbOrY96bEJTqbAgVGC7VBTfnq4n0iNm8qIYakxBjdFzFhbFRK8vtzJQX+YSCrnlFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f75mPENZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f75mPENZ"
Message-ID: <0725ce97-b8a3-47c9-952f-7b512873cc35@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774630424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9csAY2Lvawgp7Rsam87YjKnm7rldK4hTm6EIfaKTPo=;
	b=f75mPENZ/0pogd7iZftgXzxU1U3uP/uDnUH51xNQ/Zl5ECBs158ZiTywN4eeQRE3ZbgIbD
	SOe/t2tapJrZ/LL8Ctf7vJeDgJkGGx5TgRBO6QFlILAZ2e8der8tSRw0PhdSMLZ2+GanQJ
	v6cbU9Vsavrir2wRkkI4EJWCx3V2d4c=
Date: Fri, 27 Mar 2026 12:53:34 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE
 coalescing
Content-Language: en-GB
To: WANG Rui <r@hev.cc>
Cc: Liam.Howlett@oracle.com, ajd@linux.ibm.com, akpm@linux-foundation.org,
 apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 brauner@kernel.org, catalin.marinas@arm.com, david@kernel.org,
 dev.jain@arm.com, jack@suse.cz, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.l, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, npache@redhat.com,
 pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org,
 ryan.roberts@arm.com, surenb@google.com, vbabka@kernel.org,
 viro@zeniv.linux.org.uk, willy@infradead.org
References: <20260320140315.979307-4-usama.arif@linux.dev>
 <20260320160519.80962-1-r@hev.cc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260320160519.80962-1-r@hev.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 20/03/2026 19:05, WANG Rui wrote:
> Hi Usama,
> 
> On Fri, Mar 20, 2026 at 10:04 PM Usama Arif <usama.arif@linux.dev> wrote:
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 8e89cc5b28200..042af81766fcd 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -49,6 +49,7 @@
>>  #include <uapi/linux/rseq.h>
>>  #include <asm/param.h>
>>  #include <asm/page.h>
>> +#include <linux/pagemap.h>
>>
>>  #ifndef ELF_COMPAT
>>  #define ELF_COMPAT 0
>> @@ -488,19 +489,51 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
>>         return 0;
>>  }
>>
>> -static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
>> +static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr,
>> +                                      struct file *filp)
>>  {
>>         unsigned long alignment = 0;
>> +       unsigned long max_folio_size = PAGE_SIZE;
>>         int i;
>>
>> +       if (filp && filp->f_mapping)
>> +               max_folio_size = mapping_max_folio_size(filp->f_mapping);
> 
> From experiments (with 16K base pages), mapping_max_folio_size() appears to
> depend on the filesystem. It returns 8M on ext4, while on btrfs it always
> falls back to PAGE_SIZE (it seems CONFIG_BTRFS_EXPERIMENTAL=y may change this).
> This looks overly conservative and ends up missing practical optimization
> opportunities.

mapping_max_folio_size() reflects what the page cache will actually
allocate for a given filesystem, since readahead caps folio allocation
at mapping_max_folio_order() (in page_cache_ra_order()). If btrfs
reports PAGE_SIZE, readahead won't allocate large folios for it, so
there are no large folios to coalesce PTEs for, aligning the binary
beyond that would only reduce ASLR entropy for no benefit.

I don't think we should over-align binaries on filesystems that can't
take advantage of it.

> 
>> +
>>         for (i = 0; i < nr; i++) {
>>                 if (cmds[i].p_type == PT_LOAD) {
>>                         unsigned long p_align = cmds[i].p_align;
>> +                       unsigned long size;
>>
>>                         /* skip non-power of two alignments as invalid */
>>                         if (!is_power_of_2(p_align))
>>                                 continue;
>>                         alignment = max(alignment, p_align);
>> +
>> +                       /*
>> +                        * Try to align the binary to the largest folio
>> +                        * size that the page cache supports, so the
>> +                        * hardware can coalesce PTEs (e.g. arm64
>> +                        * contpte) or use PMD mappings for large folios.
>> +                        *
>> +                        * Use the largest power-of-2 that fits within
>> +                        * the segment size, capped by what the page
>> +                        * cache will allocate. Only align when the
>> +                        * segment's virtual address and file offset are
>> +                        * already aligned to the folio size, as
>> +                        * misalignment would prevent coalescing anyway.
>> +                        *
>> +                        * The segment size check avoids reducing ASLR
>> +                        * entropy for small binaries that cannot
>> +                        * benefit.
>> +                        */
>> +                       if (!cmds[i].p_filesz)
>> +                               continue;
>> +                       size = rounddown_pow_of_two(cmds[i].p_filesz);
>> +                       size = min(size, max_folio_size);
>> +                       if (size > PAGE_SIZE &&
>> +                           IS_ALIGNED(cmds[i].p_vaddr, size) &&
>> +                           IS_ALIGNED(cmds[i].p_offset, size))
>> +                               alignment = max(alignment, size);
> 
> In my patch [1], by aligning eligible segments to PMD_SIZE, THP can quickly
> collapse them into large mappings with minimal warmup. That doesn’t happen
> with the current behavior. I think allowing a reasonably sized PMD (say <= 32M)
> is worth considering. All we really need here is to ensure virtual address
> alignment. The rest can be left to THP under always, which can decide whether
> to collapse or not based on memory pressure and other factors.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc
> 
>>                 }
>>         }
>>
>> @@ -1104,7 +1137,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>>                         }
>>
>>                         /* Calculate any requested alignment. */
>> -                       alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
>> +                       alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum,
>> +                                                     bprm->file);
>>
>>                         /**
>>                          * DOC: PIE handling
>> --
>> 2.52.0
>>
> 
> Thanks,
> Rui

