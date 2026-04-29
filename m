Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633653FD134
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471587; cv=none; b=fv5LBVAz9pQoVL4K7EQ8Xhn+yuHw6b6OevejVoHKOFEexUT4PG70yZlPEhza+BCbgJUnfT55k00hAD1N8EbrE8z/1muxiN829Vi/6pxrSZsaRHkq1rzDQxyW5WDtAnNa6bMh72g/rXrUeDjKOMtyFJ6R6cp6p7MUbpNO6KhWhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471587; c=relaxed/simple;
	bh=COwMwrBOiB+O/06tJip7Ij2FXBCJhMYn1sGJAPpd4ec=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m15EOMdseOF2wxPZaRJvw8Q8ap3gTWCNO6GHrF1ugouXrIMAyd6TdcDGKoFVvKePbaFvqZPISNvnXnATq2+AEYZsIaAz4bRhvhH+pptW8grYw6I/FV3UvBuu1pRzv1tFiSU5FZuycuI9NtTDe0Bsk1IwLu9B6Ppb7OJ1mh1lj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WieNgYDI; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WieNgYDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1777471574; x=1777730774;
	bh=Z1KNcjEEKcv05+sz7vMzcaXgFwk3tchSwg3UuKDWHxU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WieNgYDIZGjk/kg8Ju4pAtD70Ho2eNzrdZ+lWd+/C3Yr+XJcIo70h46Jww4UhRHmQ
	 JDHI0TAuOvzNtak53YmzM20R8ZHDJpGLyhI5ZJBr3ze64oXKGZmTQUAOYCaUWksrKJ
	 xhw0Xf+tpi/slvU+mpc37C0YB5FQzRI99uTZb7PicAoBk2l9fRLvjq7lGCHPWk3g87
	 sqN+sce3oddhTUIFGOb0T1Lza20zO4QW2w/NEY7NdmlyWZ7skBEr7dk/IhPnWGY2zw
	 bgkMpbSDcQfi1IDCTzqIm5HW6JsOu4zjDu7USwBQtnNxXc2V0jJbXCODh01i+xaUbj
	 MU3Qe2d4iORVQ==
Date: Wed, 29 Apr 2026 14:06:10 +0000
To: david.laight.linux@gmail.com, riel@surriel.com, perry.yuan@amd.com, jgross@suse.com, ljs@kernel.org, justinstitt@google.com, hpa@zytor.com, shuah@kernel.org, nathan@kernel.org, sohil.mehta@intel.com, mathieu.desnoyers@efficios.com, brauner@kernel.org, ethantidmore06@gmail.com, dave.hansen@linux.intel.com, maciej.wieczor-retman@intel.com, mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org, peterz@infradead.org, viro@zeniv.linux.org.uk, superman.xpt@gmail.com, rdunlap@infradead.org, aliceryhl@google.com, ilpo.jarvinen@linux.intel.com, david@kernel.org, xin@zytor.com, seanjc@google.com, tglx@kernel.org, houwenlong.hwl@antgroup.com, yury.norov@gmail.com, rppt@kernel.org, oleg@redhat.com, nick.desaulniers+lkml@gmail.com, vmalik@redhat.com, morbo@google.com, ryan.roberts@arm.com, kees@kernel.org
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, m.wieczorretman@pm.me
Subject: [PATCH v7 2/4] x86/process: Add a procfs file with hardware address masking
Message-ID: <2eaf9bfbd2d823afdc90f40364b9a9c31aaeba24.1777470980.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1777470980.git.m.wieczorretman@pm.me>
References: <cover.1777470980.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 9bd4df8c93361cdfe81f5e078e9b930f15a2a65f
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

While the user should expect 4 bit tags from the lam interface current
hardware supports 6 bit tags. Such tag width is also used internally by
the kernel so the kernel-hardware treatment of addresses that came from
userspace is consistent.

Add a procfs file with the hardware supported untag mask. It may be used
by debuggers to recreate hardware or kernel handling of user pointers.
At the same time the returned value from this file shouldn't be relied
on by regular lam user programs since it might change with future
hardware. For a stable interface they should use the ARCH_GET_UNTAG_MASK
arch_prctl() syscall instead.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v7:
- Add the patch to the series.

 arch/x86/Kconfig             |  1 +
 arch/x86/kernel/process_64.c | 18 ++++++++++++++++++
 fs/proc/Kconfig              |  4 ++++
 fs/proc/base.c               |  6 ++++++
 include/linux/uaccess.h      |  5 +++++
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..1ec303cca1ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2194,6 +2194,7 @@ config ADDRESS_MASKING
 =09bool "Linear Address Masking support"
 =09depends on X86_64
 =09depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
+=09select PROC_ADDRESS_MASKING if PROC_FS
 =09help
 =09  Linear Address Masking (LAM) modifies the checking that is applied
 =09  to 64-bit linear addresses, allowing software to use of the
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 8b8aaf1d740b..44c4a80fc658 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -800,6 +800,24 @@ static long prctl_map_vdso(const struct vdso_image *im=
age, unsigned long addr)
 #define LAM_TAG_BITS=09=094
 #define LAM_UNTAG_MASK=09=09~GENMASK(60, 57)
=20
+#ifdef CONFIG_PROC_ADDRESS_MASKING
+
+int proc_address_mask(struct seq_file *s, struct pid_namespace *ns,
+=09=09      struct pid *pid, struct task_struct *tsk)
+{
+=09struct mm_struct *mm;
+
+=09mm =3D get_task_mm(tsk);
+=09if (mm) {
+=09=09seq_printf(s, "0x%llx\n", mm->context.untag_mask);
+=09=09mmput(mm);
+=09}
+
+=09return 0;
+}
+
+#endif
+
 static void enable_lam_func(void *__mm)
 {
 =09struct mm_struct *mm =3D __mm;
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 6ae966c561e7..0094e185a7b2 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -127,3 +127,7 @@ config PROC_PID_ARCH_STATUS
 config PROC_CPU_RESCTRL
 =09def_bool n
 =09depends on PROC_FS
+
+config PROC_ADDRESS_MASKING
+=09def_bool n
+=09depends on PROC_FS
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4c863d17dfb4..9483ad4197e1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3421,6 +3421,9 @@ static const struct pid_entry tgid_base_stuff[] =3D {
 =09ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 =09ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
+#ifdef CONFIG_PROC_ADDRESS_MASKING
+=09ONE("address_mask", S_IRUSR, proc_address_mask),
+#endif
 };
=20
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *c=
tx)
@@ -3755,6 +3758,9 @@ static const struct pid_entry tid_base_stuff[] =3D {
 =09ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 =09ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
+#ifdef CONFIG_PROC_ADDRESS_MASKING
+=09ONE("address_mask", S_IRUSR, proc_address_mask),
+#endif
 };
=20
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ct=
x)
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 4fe63169d5a2..c02d254a1a1e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -869,4 +869,9 @@ void __noreturn usercopy_abort(const char *name, const =
char *detail,
 =09=09=09       unsigned long len);
 #endif
=20
+#ifdef CONFIG_PROC_ADDRESS_MASKING
+int proc_address_mask(struct seq_file *s, struct pid_namespace *ns,
+=09=09      struct pid *pid, struct task_struct *tsk);
+#endif
+
 #endif=09=09/* __LINUX_UACCESS_H__ */
--=20
2.53.0


