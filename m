Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A151D555;
	Fri, 13 Mar 2026 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391308; cv=none; b=NiMriGK2Ts4qn+QgIOAetCFlV8ZpDeIl/BujeMpvga/KiPlfQtAOZeqqTRdQ3sXEDDDc/IYjAaytnIOrplWGQqrzEOJDID0u16GLDeInxTCoGwXwh4lQNHBOTUN1WEitQQAQuhegvNCAx3EdUSquMM/Ry9L0EesKlkoWwQFNrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391308; c=relaxed/simple;
	bh=WJwnuQ7vXFIbqrvaHByYGzOg2KNIZW1uF/KO5yoTbtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/JSihw1A0wl7tgvQYDOWgF6cqzc1ed5KB/ZtHlZMK/OnX5tQqwH5x2huR4DIyz9bhTCRcR25cd/XDanvA1FO78Ce0N/7klBAla0SaOWAj4OYZtsCuTahNq3HiwMdbsh8Ql/pNgnvNAQZgU1FLC8d/aC9hQavDeH+raoGCMln/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C0I93hcd; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C0I93hcd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773391304; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CN48FU1i1sUqZBxESLMVXkFpxzJXnKPZ1jbKm0REr3U=;
	b=C0I93hcdZhMfV0IRRopd6aW4D3Ic2SDdXY60wFRWEne9SjbN5RD+DYwAlYviPfhsjzWkNJGnigBVaDiRSCeJ02Tw6sDtieFejbydKe1TpOxWd7ZHrDXNp80uRbRPlH92cvrBG2hHvvXr6pK/gYxrm7DE7+gJ2ZvDLtgGFbah1t8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X-rhBv5_1773391301;
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X-rhBv5_1773391301 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 16:41:42 +0800
Message-ID: <349671d5-f5aa-48a2-9bba-00aef167b836@linux.alibaba.com>
Date: Fri, 13 Mar 2026 16:41:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] binfmt_elf: Align eligible read-only PT_LOAD
 segments to PMD_SIZE for THP
To: WANG Rui <r@hev.cc>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@kernel.org>, Dev Jain <dev.jain@arm.com>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 usama.arif@linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260310031138.509730-1-r@hev.cc>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260310031138.509730-1-r@hev.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CC Usama

On 3/10/26 11:11 AM, WANG Rui wrote:
> Changes since [v3]:
> * Fixed compilation failure under !CONFIG_TRANSPARENT_HUGEPAGE.
> * No functional changes otherwise.
> 
> Changes since [v2]:
> * Renamed align_to_pmd() to should_align_to_pmd().
> * Added benchmark results to the commit message.
> 
> Changes since [v1]:
> * Dropped the Kconfig option CONFIG_ELF_RO_LOAD_THP_ALIGNMENT.
> * Moved the alignment logic into a helper align_to_pmd() for clarity.
> * Improved the comment explaining why we skip the optimization
>    when PMD_SIZE > 32MB.
> 
> When Transparent Huge Pages (THP) are enabled in "always" mode,
> file-backed read-only mappings can be backed by PMD-sized huge pages
> if they meet the alignment and size requirements.
> 
> For ELF executables loaded by the kernel ELF binary loader, PT_LOAD
> segments are normally aligned according to p_align, which is often
> only page-sized. As a result, large read-only segments that are
> otherwise eligible may fail to be mapped using PMD-sized THP.
> 
> A segment is considered eligible if:
> 
> * THP is in "always" mode,
> * it is not writable,
> * both p_vaddr and p_offset are PMD-aligned,
> * its file size is at least PMD_SIZE, and
> * its existing p_align is smaller than PMD_SIZE.
> 
> To avoid excessive address space padding on systems with very large
> PMD_SIZE values, this optimization is applied only when PMD_SIZE <= 32MB,
> since requiring larger alignments would be unreasonable, especially on
> 32-bit systems with a much more limited virtual address space.
> 
> This increases the likelihood that large text segments of ELF
> executables are backed by PMD-sized THP, reducing TLB pressure and
> improving performance for large binaries.
> 
> This only affects ELF executables loaded directly by the kernel
> binary loader. Shared libraries loaded by user space (e.g. via the
> dynamic linker) are not affected.

Usama posted a similar patchset[1], and I think using exec_folio_order() 
for exec-segment alignment is reasonable. In your case, you can override 
exec_folio_order() to return a PMD‑sized order.

[1] 
https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev/

> Benchmark
> 
> Machine: AMD Ryzen 9 7950X (x86_64)
> Binutils: 2.46
> GCC: 15.2.1 (built with -z,noseparate-code + --enable-host-pie)
> 
> Workload: building Linux v7.0-rc1 vmlinux with x86_64_defconfig.
> 
>                  Without patch        With patch
> instructions    8,246,133,611,932    8,246,025,137,750
> cpu-cycles      8,001,028,142,928    7,565,925,107,502
> itlb-misses     3,672,158,331        26,821,242
> time elapsed    64.66 s              61.97 s
> 
> Instructions are basically unchanged. iTLB misses drop from ~3.67B to
> ~26M (~99.27% reduction), which results in about a ~5.44% reduction in
> cycles and ~4.18% shorter wall time for this workload.
> 
> [v3]: https://lore.kernel.org/linux-fsdevel/20260310013958.103636-1-r@hev.cc
> [v2]: https://lore.kernel.org/linux-fsdevel/20260304114727.384416-1-r@hev.cc
> [v1]: https://lore.kernel.org/linux-fsdevel/20260302155046.286650-1-r@hev.cc
> 
> WANG Rui (2):
>    huge_mm: add stubs for THP-disabled configs
>    binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for
>      THP
> 
>   fs/binfmt_elf.c         | 29 +++++++++++++++++++++++++++++
>   include/linux/huge_mm.h | 10 ++++++++++
>   2 files changed, 39 insertions(+)
> 

