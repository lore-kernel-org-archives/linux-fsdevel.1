Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26B3C6611
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288446; cv=none; b=sfNc4UW8q+iXZ9i4Kmez7TP7FmIs1/Ld82AiShUaM27nGoDu0mKc8lM5d6aiDbagN15Odiv7KTkOLDrMACetgC1paYp0HauhlR4VhzoXYJ2VYnpNNTEiBTn/dOUHUXREyo3SlLIf827k9l6o753JHh3h+y9aW9TLQ6JQ/1zBgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288446; c=relaxed/simple;
	bh=FjP+aluhuSk+QvkW7jIfR0+lzCaysUDCcukwZWJE8gA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SrsMW6ak3wSi5M15NDK6+iepj50x0itwpAZvMUNF/VPAuupmdyKQj6BzFIjXlT4hayj9kWAUL5toTOXPr9dyXhtlXplxcl3k/V7fbdrb0dsXvvIYKm4UaIlE6eqFoxBMd2ZNX+V9yhjGSMp8bJVZlspTqGKVTBDcPxbL6HCmj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5wvDHKd; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5wvDHKd"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-67df391509fso6626458eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774288443; x=1774893243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zwENltoNbnweMynAxDGHTh9/E9UWCZ6oWdo8zpud4I=;
        b=C5wvDHKdjptnX0GHraZh5uWtuaNat+VFLuRMiKWrSO+LtBv39RvZq5h1hVTibiAn0e
         Ai/Y4zQfR/52FyT58L/8dfZAJNltSo6/JuSeFyJlD3UFaSDiDeE/zzWozzrqzMPFELdU
         tbCaPqefea/N3uw+WDnU3DBsVAigDDBhsTlpFvsyCaRr1aS0WCwwPyhYoBV4usfwX7iw
         Ce/mIx6oPpDWyUoFCN87/7yMW7XwJjyk35bUGzofWhw/ixviRSjQypW0CIoA8OpsO9SO
         qdTPQPZgaVMX4w6E5lH2OIeX1gMmKLPnO9i6YpJ0p4qdU3U1k+Lj/TzqyTsjQuHdEguX
         SkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288443; x=1774893243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zwENltoNbnweMynAxDGHTh9/E9UWCZ6oWdo8zpud4I=;
        b=bBaod3uzqcncSHj4QvqSLtO7q6PhU7fApZ9wHv6o1i5KYwlxrDIa/iS0euBo7qY47G
         327VFI4WKcDR+aCafU3Bw6CjcQI+grb9bzNxvIBv1veRnNCqiK7uGYoUGS55VjQg2wh6
         G5aVPL8l5rOk1phky5153g7WRz4+TfkmBZ+o3SHp04IhdzP6N5wH6eitQL47x4BcVLWV
         hTOAubaouo+5zwqolljBOSIGze+Dx+VUH3KhkEvMoUC+S9K4CEjH/YI70ls8qOTgdIdM
         tO3jStlU0yiguGFz9+XyZR+uWDFruNWxA3ag8HoIr2TaOUOjcir805SzeLy0ad8kCViN
         3MBA==
X-Forwarded-Encrypted: i=1; AJvYcCUDJFeunhxjvbEdtqpCRGI0dLNlRCUe6cOuGBOrfSruNO+duT6TCVhRmz3YRsNTlMhatRzzaWPr2JFOsedU@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEVLF8Ky1YxwG5OEGIOaNNq7J7edNGEKRpXrdD8ZgR8ueiOvt
	bg46oBUUVvkSAnqdof/AYzR9/SHvgnue7j9vq2wvwsslYAwcKa6zIC2ZcrmlzXA62McM6L3dAZH
	utD9DtQ==
X-Received: from ilff9.prod.google.com ([2002:a05:6e02:5e09:b0:4f7:a419:df90])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:8ca:b0:67c:e54:2a7c
 with SMTP id 006d021491bc7-67c22f92886mr8704682eaf.61.1774288443094; Mon, 23
 Mar 2026 10:54:03 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:53:37 +0000
In-Reply-To: <20260323175340.3361311-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323175340.3361311-2-avagin@google.com>
Subject: [PATCH 1/4] exec: inherit HWCAPs from the parent process
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>, Andrei Vagin <avagin@google.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"

Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
AT_HWCAP2, etc.) from a parent process when they have been modified via
prctl.

To support C/R operations (snapshots, live migration) in heterogeneous
clusters, we must ensure that processes utilize CPU features available
on all potential target nodes. To solve this, we need to advertise a
common feature set across the cluster.

This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  When
execve() is called, if the current process has MMF_USER_HWCAP set, the
HWCAP values are extracted from the current auxiliary vector and stored
in the linux_binprm structure. These values are then used to populate
the auxiliary vector of the new process, effectively inheriting the
hardware capabilities.

The inherited HWCAPs are masked with the hardware capabilities supported
by the current kernel to ensure that we don't report more features than
actually supported. This is important to avoid unexpected behavior,
especially for processes with additional privileges.

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/binfmt_elf.c          | 13 ++++++---
 fs/binfmt_elf_fdpic.c    | 13 ++++++---
 fs/exec.c                | 62 ++++++++++++++++++++++++++++++++++++++++
 include/linux/binfmts.h  | 11 +++++++
 include/linux/mm_types.h |  2 ++
 kernel/fork.c            |  3 ++
 kernel/sys.c             |  5 +++-
 7 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fb857faaf0d6..d99db73c76f0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -183,6 +183,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	int ei_index;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
+	bool user_hwcap = mm_flags_test(MMF_USER_HWCAP, mm);
 
 	/*
 	 * In some cases (e.g. Hyper-Threading), we want to avoid L1
@@ -247,7 +248,8 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	 */
 	ARCH_DLINFO;
 #endif
-	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
+	NEW_AUX_ENT(AT_HWCAP, user_hwcap ?
+			      (bprm->hwcap & ELF_HWCAP) : ELF_HWCAP);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
 	NEW_AUX_ENT(AT_PHDR, phdr_addr);
@@ -265,13 +267,16 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
 	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
 #ifdef ELF_HWCAP2
-	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
+	NEW_AUX_ENT(AT_HWCAP2, user_hwcap ?
+			       (bprm->hwcap2 & ELF_HWCAP2) : ELF_HWCAP2);
 #endif
 #ifdef ELF_HWCAP3
-	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
+	NEW_AUX_ENT(AT_HWCAP3, user_hwcap ?
+			       (bprm->hwcap3 & ELF_HWCAP3) : ELF_HWCAP3);
 #endif
 #ifdef ELF_HWCAP4
-	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
+	NEW_AUX_ENT(AT_HWCAP4, user_hwcap ?
+			       (bprm->hwcap4 & ELF_HWCAP4) : ELF_HWCAP4);
 #endif
 	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
 	if (k_platform) {
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 95b65aab7daa..92c88471455a 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -508,6 +508,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	unsigned long flags = 0;
 	int ei_index;
 	elf_addr_t *elf_info;
+	bool user_hwcap = mm_flags_test(MMF_USER_HWCAP, mm);
 
 #ifdef CONFIG_MMU
 	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
@@ -629,15 +630,19 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	 */
 	ARCH_DLINFO;
 #endif
-	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
+	NEW_AUX_ENT(AT_HWCAP,	user_hwcap ?
+				(bprm->hwcap & ELF_HWCAP) : ELF_HWCAP);
 #ifdef ELF_HWCAP2
-	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
+	NEW_AUX_ENT(AT_HWCAP2,	user_hwcap ?
+				(bprm->hwcap2 & ELF_HWCAP2) : ELF_HWCAP2);
 #endif
 #ifdef ELF_HWCAP3
-	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
+	NEW_AUX_ENT(AT_HWCAP3,	user_hwcap ?
+				(bprm->hwcap3 & ELF_HWCAP3) : ELF_HWCAP3);
 #endif
 #ifdef ELF_HWCAP4
-	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
+	NEW_AUX_ENT(AT_HWCAP4,	user_hwcap ?
+				(bprm->hwcap4 & ELF_HWCAP4) : ELF_HWCAP4);
 #endif
 	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
 	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
diff --git a/fs/exec.c b/fs/exec.c
index 9ea3a775d51e..1cd7d87a0e79 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1775,6 +1775,65 @@ static int bprm_execve(struct linux_binprm *bprm)
 	return retval;
 }
 
+static void inherit_hwcap(struct linux_binprm *bprm)
+{
+	struct mm_struct *mm = current->mm;
+	bool compat = in_compat_syscall();
+	int i, n;
+
+#ifdef ELF_HWCAP4
+	n = 4;
+#elif defined(ELF_HWCAP3)
+	n = 3;
+#elif defined(ELF_HWCAP2)
+	n = 2;
+#else
+	n = 1;
+#endif
+
+	for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
+		unsigned long type, val;
+
+		if (!compat) {
+			type = mm->saved_auxv[i];
+			val = mm->saved_auxv[i + 1];
+		} else {
+			compat_uptr_t *auxv = (compat_uptr_t *)mm->saved_auxv;
+
+			type = auxv[i];
+			val = auxv[i + 1];
+		}
+
+		switch (type) {
+		case AT_NULL:
+			goto done;
+		case AT_HWCAP:
+			bprm->hwcap = val;
+			break;
+#ifdef ELF_HWCAP2
+		case AT_HWCAP2:
+			bprm->hwcap2 = val;
+			break;
+#endif
+#ifdef ELF_HWCAP3
+		case AT_HWCAP3:
+			bprm->hwcap3 = val;
+			break;
+#endif
+#ifdef ELF_HWCAP4
+		case AT_HWCAP4:
+			bprm->hwcap4 = val;
+			break;
+#endif
+		default:
+			continue;
+		}
+		n--;
+	}
+done:
+	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
+}
+
 static int do_execveat_common(int fd, struct filename *filename,
 			      struct user_arg_ptr argv,
 			      struct user_arg_ptr envp,
@@ -1843,6 +1902,9 @@ static int do_execveat_common(int fd, struct filename *filename,
 			     current->comm, bprm->filename);
 	}
 
+	if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+		inherit_hwcap(bprm);
+
 	return bprm_execve(bprm);
 }
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 65abd5ab8836..94a3dcf9b1d2 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_BINFMTS_H
 #define _LINUX_BINFMTS_H
 
+#include <linux/elf.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
 #include <asm/exec.h>
@@ -67,6 +68,16 @@ struct linux_binprm {
 	unsigned long exec;
 
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
+	unsigned long hwcap;
+#ifdef ELF_HWCAP2
+	unsigned long hwcap2;
+#endif
+#ifdef ELF_HWCAP3
+	unsigned long hwcap3;
+#endif
+#ifdef ELF_HWCAP4
+	unsigned long hwcap4;
+#endif
 
 	char buf[BINPRM_BUF_SIZE];
 } __randomize_layout;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3cc8ae722886..62dde645f469 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1919,6 +1919,8 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
 
+#define MMF_USER_HWCAP		32	/* user-defined HWCAPs */
+
 #define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
diff --git a/kernel/fork.c b/kernel/fork.c
index bc2bf58b93b6..2ac277aa078c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1105,6 +1105,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 
 		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
+
+		if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+			mm_flags_set(MMF_USER_HWCAP, mm);
 	} else {
 		__mm_flags_overwrite_word(mm, default_dump_filter);
 		mm->def_flags = 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index cdbf8513caf6..e4b0fa2f6845 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2157,8 +2157,10 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	 * not introduce additional locks here making the kernel
 	 * more complex.
 	 */
-	if (prctl_map.auxv_size)
+	if (prctl_map.auxv_size) {
 		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
+		mm_flags_set(MMF_USER_HWCAP, mm);
+	}
 
 	mmap_read_unlock(mm);
 	return 0;
@@ -2190,6 +2192,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 
 	task_lock(current);
 	memcpy(mm->saved_auxv, user_auxv, len);
+	mm_flags_set(MMF_USER_HWCAP, mm);
 	task_unlock(current);
 
 	return 0;
-- 
2.53.0.983.g0bb29b3bc5-goog

