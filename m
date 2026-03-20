Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF053093A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998135; cv=none; b=FnmjBbfvXzF7UZzR0UrYqN1loXAXcY0+2y7j8cx4O1SlNB5yWG/otpWlE8ICv4lJy+hPVA0x0W5mWezMJqqi4lHu7UFaP8U9t05h/jnfTkGyNBapT3gcjNmDW72Gasg2R0sMWJO/LbGJU4PT8WT+LYHON+1Pp9/JH+kBhJnRCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998135; c=relaxed/simple;
	bh=WPaZ7NKR7qfo1qpeMCvB6o+QbKWvpcD0+bfbh4PjCkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=elNC2ng6FxzLCDNuEmjMNvRCilB77kpfKo3JGbuj+n6k2vOKRxMKS4nFnDRHiKnOkVmM6EEiqoqjTyKyRvX6yOLKgFloS9JpMLXiAEFOxxxOfhYM2kTS7fXejVe9duePHgo6UtyBkx+T9xhYziFyuKRlwSa/pQF8wXVz/VtSM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pSrpsAnM; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pSrpsAnM"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260320091528euoutp0101e372c68b9bcb28b80491ded781d46a~egeYq756K0639006390euoutp01P
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 09:15:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260320091528euoutp0101e372c68b9bcb28b80491ded781d46a~egeYq756K0639006390euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773998128;
	bh=FhrhAWTDLCv4QpWslCOMFZjZp7w7pCo7mghOdDhsrrU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pSrpsAnM3G02TX/+KzwU0cjPdmiqWZN49h48fzpVHgzD9F3sNIPW+VNiDtv6q3N0F
	 i7rPBfgER7dwIDvL9hIl18IVHKqfM2ZSieiRmOoH1Wa6BLYlgK6DhCqGsno/IxUMia
	 I/bGMRIfy7PHEZmg7ZVJLHl16kUwFU2aeCEVbIi8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260320091528eucas1p14a64767f916b556d30cfa00bfd320ace~egeYI1ZHq1593615936eucas1p1c;
	Fri, 20 Mar 2026 09:15:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260320091527eusmtip124a7aacd9e9a03c52228bba3dcc39044~egeXHj7801699616996eusmtip15;
	Fri, 20 Mar 2026 09:15:26 +0000 (GMT)
Message-ID: <aec9c36d-d67a-4b61-9950-57b95afedf75@samsung.com>
Date: Fri, 20 Mar 2026 10:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/4] exec: inherit HWCAPs from the parent process
To: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>, Andrew
	Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev, Chen Ridong
	<chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, David
	Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny
	<mkoutny@suse.com>, Alexander Mikhalitsyn
	<aleksandr.mikhalitsyn@futurfusion.io>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260217180108.1420024-3-avagin@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260320091528eucas1p14a64767f916b556d30cfa00bfd320ace
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260320091528eucas1p14a64767f916b556d30cfa00bfd320ace
X-EPHeader: CA
X-CMS-RootMailID: 20260320091528eucas1p14a64767f916b556d30cfa00bfd320ace
References: <20260217180108.1420024-1-avagin@google.com>
	<20260217180108.1420024-3-avagin@google.com>
	<CGME20260320091528eucas1p14a64767f916b556d30cfa00bfd320ace@eucas1p1.samsung.com>

Hi,

On 17.02.2026 19:01, Andrei Vagin wrote:
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

This patch landed in yesterday's linux-next as commit ac8c259ce0d5 
("exec: inherit HWCAPs from the parent process"). In my tests I found 
that it causes regression on my Khadas VIM3L board, which is based 
on Amlogic Meson SM1 (S905D3) SoC 
(arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts). Running init 
process fails after this patch:

Freeing unused kernel memory: 13696K
Run /sbin/init as init process
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4-next-20260319 
#12369 PREEMPT
Hardware name: Khadas VIM3L (DT)

What is probably important here, this board (for some internal, 
historical reasons) uses armv7l rootfs, but other boards used in my 
tests, based on different SoCs, also use such rootfs and boot fine with 
yesterday's linux-next. Reverting ac8c259ce0d5 commit (together with 
0ea77bbf3b98 due to dependencies) on top of next-20260319 fixes this issue.


> ---
>   fs/binfmt_elf.c          |  8 ++---
>   fs/binfmt_elf_fdpic.c    |  8 ++---
>   fs/exec.c                | 63 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/binfmts.h  | 11 +++++++
>   include/linux/mm_types.h |  2 ++
>   kernel/fork.c            |  3 ++
>   kernel/sys.c             |  5 +++-
>   7 files changed, 91 insertions(+), 9 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 3eb734c192e9..aec129e33f0b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -246,7 +246,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>   	 */
>   	ARCH_DLINFO;
>   #endif
> -	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> +	NEW_AUX_ENT(AT_HWCAP, bprm->hwcap);
>   	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
>   	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>   	NEW_AUX_ENT(AT_PHDR, phdr_addr);
> @@ -264,13 +264,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>   	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
>   	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
>   #ifdef ELF_HWCAP2
> -	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
> +	NEW_AUX_ENT(AT_HWCAP2, bprm->hwcap2);
>   #endif
>   #ifdef ELF_HWCAP3
> -	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
> +	NEW_AUX_ENT(AT_HWCAP3, bprm->hwcap3);
>   #endif
>   #ifdef ELF_HWCAP4
> -	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
> +	NEW_AUX_ENT(AT_HWCAP4, bprm->hwcap4);
>   #endif
>   	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
>   	if (k_platform) {
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index a3d4e6973b29..55b482f03c82 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -629,15 +629,15 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>   	 */
>   	ARCH_DLINFO;
>   #endif
> -	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
> +	NEW_AUX_ENT(AT_HWCAP,	bprm->hwcap);
>   #ifdef ELF_HWCAP2
> -	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
> +	NEW_AUX_ENT(AT_HWCAP2,	bprm->hwcap2);
>   #endif
>   #ifdef ELF_HWCAP3
> -	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
> +	NEW_AUX_ENT(AT_HWCAP3,	bprm->hwcap3);
>   #endif
>   #ifdef ELF_HWCAP4
> -	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
> +	NEW_AUX_ENT(AT_HWCAP4,	bprm->hwcap4);
>   #endif
>   	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
>   	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
> diff --git a/fs/exec.c b/fs/exec.c
> index 2e3a6593c6fd..9c70776fca9e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1454,6 +1454,17 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
>   	 */
>   	bprm->is_check = !!(flags & AT_EXECVE_CHECK);
>   
> +	bprm->hwcap = ELF_HWCAP;
> +#ifdef ELF_HWCAP2
> +	bprm->hwcap2 = ELF_HWCAP2;
> +#endif
> +#ifdef ELF_HWCAP3
> +	bprm->hwcap3 = ELF_HWCAP3;
> +#endif
> +#ifdef ELF_HWCAP4
> +	bprm->hwcap4 = ELF_HWCAP4;
> +#endif
> +
>   	retval = bprm_mm_init(bprm);
>   	if (!retval)
>   		return bprm;
> @@ -1775,6 +1786,55 @@ static int bprm_execve(struct linux_binprm *bprm)
>   	return retval;
>   }
>   
> +static void inherit_hwcap(struct linux_binprm *bprm)
> +{
> +	struct mm_struct *mm = current->mm;
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
> +		unsigned long type = mm->saved_auxv[i];
> +		unsigned long val = mm->saved_auxv[i + 1];
> +
> +		switch (type) {
> +		case AT_NULL:
> +			goto done;
> +		case AT_HWCAP:
> +			bprm->hwcap = val & ELF_HWCAP;
> +			break;
> +#ifdef ELF_HWCAP2
> +		case AT_HWCAP2:
> +			bprm->hwcap2 = val & ELF_HWCAP2;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP3
> +		case AT_HWCAP3:
> +			bprm->hwcap3 = val & ELF_HWCAP3;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP4
> +		case AT_HWCAP4:
> +			bprm->hwcap4 = val & ELF_HWCAP4;
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
> @@ -1843,6 +1903,9 @@ static int do_execveat_common(int fd, struct filename *filename,
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
> index 8731606d8d36..2f3c6ad48c0a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1918,6 +1918,8 @@ enum {
>   #define MMF_TOPDOWN		31	/* mm searches top down by default */
>   #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
>   
> +#define MMF_USER_HWCAP		32	/* user-defined HWCAPs */
> +
>   #define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>   				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>   				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e832da9d15a4..4c92a2bc3cbb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1104,6 +1104,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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

