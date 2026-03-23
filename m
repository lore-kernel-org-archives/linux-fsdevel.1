Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03D3815D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306759; cv=none; b=RBZgSt7UeeS0wh1wOytD+DXQbORV4s/AG3NjS10UPqTAuy2n+0ebu9rLwQC8h1TvMqG4DVRSEjHd3uTswpHvC93DjcbTsU1hgXHayU2uWPli5nr73ncs4SJvetc/eyt1qtOK30VF8LhreAkmJZUI7jyNT9j/oSd/VnSC/ODNCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306759; c=relaxed/simple;
	bh=zQxcsBDyRvOta9eLoddbq9aRQvQbug/qN7ZCdwD19l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Q+A1kXSpmZ0Il8+KkMVUf06bwmJb8DspgQoLlAV9paHSt7T2GTxTswr+LfpHRUag9isG63iadIuWZ4SCfWt6FZMvjEF6Tp8iKXgw/JnJfmKe2SwZO4vUu82HBZV3g/GzSyZNMujVpFdlE6sVIUv8el37efP7Dhg6zLcRZZ0g6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jYGzTZeZ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jYGzTZeZ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260323225914euoutp0224db306e7ff4f9be9a468192fed46a7d~fmpe8EzB_1366213662euoutp02M
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:59:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260323225914euoutp0224db306e7ff4f9be9a468192fed46a7d~fmpe8EzB_1366213662euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774306754;
	bh=P2FUlbBkvBLVFdNmaLX9tGhQ46KhUPmEjRBcpuvYzF8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jYGzTZeZSvGSOJJX3UeovqfeXE/eQUAMlIBHQ8QqNRBO1mZZxzHzrZ7fDQyQsNQcQ
	 SsxDI6AUQIJfT8xkauSatpu33/EBLbcuOgS4iXqsArlRcOjtRxuyx3Cez3B4B3ZwRA
	 BB+1lyBzZhcBKRDxlTC3kldXONQ0oV/dE5I0JEW4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260323225913eucas1p27d37fb261288ce51d50a4a566ba44f7d~fmpd9llab0348903489eucas1p2G;
	Mon, 23 Mar 2026 22:59:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260323225912eusmtip1826bb496df313ad92acb02f2ee6d9af3~fmpctZOkU0832708327eusmtip1M;
	Mon, 23 Mar 2026 22:59:12 +0000 (GMT)
Message-ID: <b482be19-d702-40a0-bb05-9198494f17fa@samsung.com>
Date: Mon, 23 Mar 2026 23:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
To: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>, Andrew
	Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>, David Hildenbrand
	<david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, Alexander
	Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260323175340.3361311-2-avagin@google.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260323225913eucas1p27d37fb261288ce51d50a4a566ba44f7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323175407eucas1p2de1dfc8a6e319580cbc8a3de8ec3d11e
X-EPHeader: CA
X-CMS-RootMailID: 20260323175407eucas1p2de1dfc8a6e319580cbc8a3de8ec3d11e
References: <20260323175340.3361311-1-avagin@google.com>
	<CGME20260323175407eucas1p2de1dfc8a6e319580cbc8a3de8ec3d11e@eucas1p2.samsung.com>
	<20260323175340.3361311-2-avagin@google.com>

On 23.03.2026 18:53, Andrei Vagin wrote:
> Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> AT_HWCAP2, etc.) from a parent process when they have been modified via
> prctl.
>
> To support C/R operations (snapshots, live migration) in heterogeneous
> clusters, we must ensure that processes utilize CPU features available
> on all potential target nodes. To solve this, we need to advertise a
> common feature set across the cluster.
>
> This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  When
> execve() is called, if the current process has MMF_USER_HWCAP set, the
> HWCAP values are extracted from the current auxiliary vector and stored
> in the linux_binprm structure. These values are then used to populate
> the auxiliary vector of the new process, effectively inheriting the
> hardware capabilities.
>
> The inherited HWCAPs are masked with the hardware capabilities supported
> by the current kernel to ensure that we don't report more features than
> actually supported. This is important to avoid unexpected behavior,
> especially for processes with additional privileges.
>
> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrei Vagin <avagin@google.com>

v5 fixed the issue I've observed here:

https://lore.kernel.org/all/aec9c36d-d67a-4b61-9950-57b95afedf75@samsung.com/

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   fs/binfmt_elf.c          | 13 ++++++---
>   fs/binfmt_elf_fdpic.c    | 13 ++++++---
>   fs/exec.c                | 62 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/binfmts.h  | 11 +++++++
>   include/linux/mm_types.h |  2 ++
>   kernel/fork.c            |  3 ++
>   kernel/sys.c             |  5 +++-
>   7 files changed, 100 insertions(+), 9 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index fb857faaf0d6..d99db73c76f0 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -183,6 +183,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>   	int ei_index;
>   	const struct cred *cred = current_cred();
>   	struct vm_area_struct *vma;
> +	bool user_hwcap = mm_flags_test(MMF_USER_HWCAP, mm);
>   
>   	/*
>   	 * In some cases (e.g. Hyper-Threading), we want to avoid L1
> @@ -247,7 +248,8 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>   	 */
>   	ARCH_DLINFO;
>   #endif
> -	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> +	NEW_AUX_ENT(AT_HWCAP, user_hwcap ?
> +			      (bprm->hwcap & ELF_HWCAP) : ELF_HWCAP);
>   	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
>   	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>   	NEW_AUX_ENT(AT_PHDR, phdr_addr);
> @@ -265,13 +267,16 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>   	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
>   	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
>   #ifdef ELF_HWCAP2
> -	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
> +	NEW_AUX_ENT(AT_HWCAP2, user_hwcap ?
> +			       (bprm->hwcap2 & ELF_HWCAP2) : ELF_HWCAP2);
>   #endif
>   #ifdef ELF_HWCAP3
> -	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
> +	NEW_AUX_ENT(AT_HWCAP3, user_hwcap ?
> +			       (bprm->hwcap3 & ELF_HWCAP3) : ELF_HWCAP3);
>   #endif
>   #ifdef ELF_HWCAP4
> -	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
> +	NEW_AUX_ENT(AT_HWCAP4, user_hwcap ?
> +			       (bprm->hwcap4 & ELF_HWCAP4) : ELF_HWCAP4);
>   #endif
>   	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
>   	if (k_platform) {
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 95b65aab7daa..92c88471455a 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -508,6 +508,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>   	unsigned long flags = 0;
>   	int ei_index;
>   	elf_addr_t *elf_info;
> +	bool user_hwcap = mm_flags_test(MMF_USER_HWCAP, mm);
>   
>   #ifdef CONFIG_MMU
>   	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
> @@ -629,15 +630,19 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>   	 */
>   	ARCH_DLINFO;
>   #endif
> -	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
> +	NEW_AUX_ENT(AT_HWCAP,	user_hwcap ?
> +				(bprm->hwcap & ELF_HWCAP) : ELF_HWCAP);
>   #ifdef ELF_HWCAP2
> -	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
> +	NEW_AUX_ENT(AT_HWCAP2,	user_hwcap ?
> +				(bprm->hwcap2 & ELF_HWCAP2) : ELF_HWCAP2);
>   #endif
>   #ifdef ELF_HWCAP3
> -	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
> +	NEW_AUX_ENT(AT_HWCAP3,	user_hwcap ?
> +				(bprm->hwcap3 & ELF_HWCAP3) : ELF_HWCAP3);
>   #endif
>   #ifdef ELF_HWCAP4
> -	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
> +	NEW_AUX_ENT(AT_HWCAP4,	user_hwcap ?
> +				(bprm->hwcap4 & ELF_HWCAP4) : ELF_HWCAP4);
>   #endif
>   	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
>   	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
> diff --git a/fs/exec.c b/fs/exec.c
> index 9ea3a775d51e..1cd7d87a0e79 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1775,6 +1775,65 @@ static int bprm_execve(struct linux_binprm *bprm)
>   	return retval;
>   }
>   
> +static void inherit_hwcap(struct linux_binprm *bprm)
> +{
> +	struct mm_struct *mm = current->mm;
> +	bool compat = in_compat_syscall();
> +	int i, n;
> +
> +#ifdef ELF_HWCAP4
> +	n = 4;
> +#elif defined(ELF_HWCAP3)
> +	n = 3;
> +#elif defined(ELF_HWCAP2)
> +	n = 2;
> +#else
> +	n = 1;
> +#endif
> +
> +	for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
> +		unsigned long type, val;
> +
> +		if (!compat) {
> +			type = mm->saved_auxv[i];
> +			val = mm->saved_auxv[i + 1];
> +		} else {
> +			compat_uptr_t *auxv = (compat_uptr_t *)mm->saved_auxv;
> +
> +			type = auxv[i];
> +			val = auxv[i + 1];
> +		}
> +
> +		switch (type) {
> +		case AT_NULL:
> +			goto done;
> +		case AT_HWCAP:
> +			bprm->hwcap = val;
> +			break;
> +#ifdef ELF_HWCAP2
> +		case AT_HWCAP2:
> +			bprm->hwcap2 = val;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP3
> +		case AT_HWCAP3:
> +			bprm->hwcap3 = val;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP4
> +		case AT_HWCAP4:
> +			bprm->hwcap4 = val;
> +			break;
> +#endif
> +		default:
> +			continue;
> +		}
> +		n--;
> +	}
> +done:
> +	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
> +}
> +
>   static int do_execveat_common(int fd, struct filename *filename,
>   			      struct user_arg_ptr argv,
>   			      struct user_arg_ptr envp,
> @@ -1843,6 +1902,9 @@ static int do_execveat_common(int fd, struct filename *filename,
>   			     current->comm, bprm->filename);
>   	}
>   
> +	if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> +		inherit_hwcap(bprm);
> +
>   	return bprm_execve(bprm);
>   }
>   
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 65abd5ab8836..94a3dcf9b1d2 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -2,6 +2,7 @@
>   #ifndef _LINUX_BINFMTS_H
>   #define _LINUX_BINFMTS_H
>   
> +#include <linux/elf.h>
>   #include <linux/sched.h>
>   #include <linux/unistd.h>
>   #include <asm/exec.h>
> @@ -67,6 +68,16 @@ struct linux_binprm {
>   	unsigned long exec;
>   
>   	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
> +	unsigned long hwcap;
> +#ifdef ELF_HWCAP2
> +	unsigned long hwcap2;
> +#endif
> +#ifdef ELF_HWCAP3
> +	unsigned long hwcap3;
> +#endif
> +#ifdef ELF_HWCAP4
> +	unsigned long hwcap4;
> +#endif
>   
>   	char buf[BINPRM_BUF_SIZE];
>   } __randomize_layout;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3cc8ae722886..62dde645f469 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1919,6 +1919,8 @@ enum {
>   #define MMF_TOPDOWN		31	/* mm searches top down by default */
>   #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
>   
> +#define MMF_USER_HWCAP		32	/* user-defined HWCAPs */
> +
>   #define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>   				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>   				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bc2bf58b93b6..2ac277aa078c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1105,6 +1105,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   
>   		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
>   		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
> +
> +		if (mm_flags_test(MMF_USER_HWCAP, current->mm))
> +			mm_flags_set(MMF_USER_HWCAP, mm);
>   	} else {
>   		__mm_flags_overwrite_word(mm, default_dump_filter);
>   		mm->def_flags = 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index cdbf8513caf6..e4b0fa2f6845 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2157,8 +2157,10 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>   	 * not introduce additional locks here making the kernel
>   	 * more complex.
>   	 */
> -	if (prctl_map.auxv_size)
> +	if (prctl_map.auxv_size) {
>   		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
> +		mm_flags_set(MMF_USER_HWCAP, mm);
> +	}
>   
>   	mmap_read_unlock(mm);
>   	return 0;
> @@ -2190,6 +2192,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>   
>   	task_lock(current);
>   	memcpy(mm->saved_auxv, user_auxv, len);
> +	mm_flags_set(MMF_USER_HWCAP, mm);
>   	task_unlock(current);
>   
>   	return 0;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

