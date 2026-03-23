Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537B3CBE9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288449; cv=none; b=aHLr5ZpjWjmIQzXn4DTUbusdTxy4CgrhmS4Ht1gEGePdwfp97wOEvmU58BvBh5WSm+FghlSil5VGhI/kuLfjErGVsbbS8Qs7zPM/0WcVZBEsblcguLXK1UXIkqrGEaetLChzDP8WYJE455pzZMscXw/UU9AIhIqAIrV1sEIfwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288449; c=relaxed/simple;
	bh=IeY0RLDHZw+aV4EbbM8a2QRICo/GVGaL04vytj3zin0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJ/n9sCQAecJKp4NRb7PqIi/6IajnY6tMmIqKBJg4KHXVysrLL4+Y+JCoKp86iw8AaJnke7u/FNu1R6cWeNRGo8WIup3pvUo0xcKo6LW4FyPczRbqb7QX4elnrbkuGIEVRSSOGp05AvW8OP0zsgks5K6+UgKsyU/KK6EZjdcAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcFiFE6F; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcFiFE6F"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-67bf3e1051bso5958461eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774288446; x=1774893246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mLJgPLWSuoj/P2MAtrzoRO0g8BMHCjkX0hvTYs5nb0=;
        b=fcFiFE6FCl3Zzyw+2twqkp0JK8bAiq6rxFUQ+kqSIP4zUnSjiy7Dy0MC+dU+xpiKNY
         boVaGOIRQ6+LiEKqddUXjxnRryWnwLqmYg4g1IRI4S5pDMfACjs/FJFthRFarXoeQMsW
         2dHtrJVzmrpMiW4UHfzyc7B0oMEmRMPYH0Dgo0K1z4lUJCyMit5lzDoPSH+rv5hdyKRM
         mVYmNsbPk1mcgzFVNMlW6PJXj4YGdSELJSMCyKdwO2b9aWB/ZS3nkkqswkhBmiVHUu7L
         tLkowAubtLDxiVGso1O3aTn08DfRS1E5whIGWR3aYtadIx62/CTaCxGGnn5mwxeDILYk
         Niww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288446; x=1774893246;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6mLJgPLWSuoj/P2MAtrzoRO0g8BMHCjkX0hvTYs5nb0=;
        b=rGX6Ujfz2oReY6cC2az017PknQ/tMmbU93d1eOWS5pR/qEfUn5d51b/2/45eaeSRm1
         3AOUbhRWgfphd3XVJGoXC//2F1VYum6Yz1RHGj5NKE/tm3T+fLk1Ue9lg2Zy6YnCU9vB
         x0wlWgmjsqcGNAHGUPZwtpKy7jbVY0yC17okbjqL9OOCq9BkxCg0jyaG/lnux77HWYwc
         ykTap19rAQZCj9obglaEcto1TVS56dIEBOxfMTkTX4hfkcSL3ZbzIhn7Ax1t2B+TsshV
         hScOFZrHSkV76jlunIuQSvqaFnca0AKfoJwE5gg++m3CKX/043/YKNFBtl8OrKO37LYh
         3hmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9KDenb1tzzATFE4jTrfAWCW8KRaRF6rglOOqOdesFXKoZjecAk27QAg7Jsd3E4cGg6arL3TCUQcazrIRv@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5D5H1Z7BKgSELwIuUpxjKgoczlz62DSZF3Xq2zoZLr2KKGgY
	EiK7FMVQITr0TlGcYzoaS0ezt2Y/4QW5Ki5miLskaC48yPK+d0Oeor2ZNyUDfoxXT3D0BN5Dbv3
	UAC7bgQ==
X-Received: from ilbeb14.prod.google.com ([2002:a05:6e02:460e:b0:4f8:5be9:9dbe])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:612:b0:67d:ec7b:cc9d
 with SMTP id 006d021491bc7-67dec7bd049mr3051580eaf.18.1774288445933; Mon, 23
 Mar 2026 10:54:05 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:53:39 +0000
In-Reply-To: <20260323175340.3361311-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323175340.3361311-4-avagin@google.com>
Subject: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
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
Content-Transfer-Encoding: quoted-printable

The mm->saved_auxv array stores the auxiliary vector, which can be
modified via prctl(PR_SET_MM_AUXV) or prctl(PR_SET_MM_MAP). Previously,
accesses to saved_auxv were not synchronized. This was a intentional
trade-off, as the vector was only used to provide information to
userspace via /proc/PID/auxv or prctl(PR_GET_AUXV), and consistency
between the auxv values left to userspace.

With the introduction of hardware capability (HWCAP) inheritance during
execve, the kernel now relies on the contents of saved_auxv to configure
the execution environment of new processes.  An unsynchronized read
during execve could result in a new process inheriting an inconsistent
set of capabilities if the parent process updates its auxiliary vector
concurrently.

While it is still not strictly required to guarantee the consistency of
auxv values on the kernel side, doing so is relatively straightforward.
This change implements synchronization using arg_lock.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/exec.c                |  2 ++
 fs/proc/base.c           | 12 +++++++++---
 include/linux/mm_types.h |  1 -
 kernel/fork.c            |  7 ++++++-
 kernel/sys.c             | 29 ++++++++++++++---------------
 5 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1cd7d87a0e79..dea868d058fa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1791,6 +1791,7 @@ static void inherit_hwcap(struct linux_binprm *bprm)
 	n =3D 1;
 #endif
=20
+	spin_lock(&mm->arg_lock);
 	for (i =3D 0; n && i < AT_VECTOR_SIZE; i +=3D 2) {
 		unsigned long type, val;
=20
@@ -1831,6 +1832,7 @@ static void inherit_hwcap(struct linux_binprm *bprm)
 		n--;
 	}
 done:
+	spin_unlock(&mm->arg_lock);
 	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
 }
=20
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4c863d17dfb4..b5496cec888e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1083,14 +1083,20 @@ static ssize_t auxv_read(struct file *file, char __=
user *buf,
 {
 	struct mm_struct *mm =3D file->private_data;
 	unsigned int nwords =3D 0;
+	unsigned long saved_auxv[AT_VECTOR_SIZE];
=20
 	if (!mm)
 		return 0;
+
+	spin_lock(&mm->arg_lock);
+	memcpy(saved_auxv, mm->saved_auxv, sizeof(saved_auxv));
+	spin_unlock(&mm->arg_lock);
+
 	do {
 		nwords +=3D 2;
-	} while (mm->saved_auxv[nwords - 2] !=3D 0); /* AT_NULL */
-	return simple_read_from_buffer(buf, count, ppos, mm->saved_auxv,
-				       nwords * sizeof(mm->saved_auxv[0]));
+	} while (saved_auxv[nwords - 2] !=3D 0); /* AT_NULL */
+	return simple_read_from_buffer(buf, count, ppos, saved_auxv,
+				       nwords * sizeof(saved_auxv[0]));
 }
=20
 static const struct file_operations proc_auxv_operations =3D {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 62dde645f469..10351af5851b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1255,7 +1255,6 @@ struct mm_struct {
 		unsigned long start_code, end_code, start_data, end_data;
 		unsigned long start_brk, brk, start_stack;
 		unsigned long arg_start, arg_end, env_start, env_end;
-
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
=20
 #ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
diff --git a/kernel/fork.c b/kernel/fork.c
index 2ac277aa078c..3880ce0d44f9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1106,8 +1106,13 @@ static struct mm_struct *mm_init(struct mm_struct *m=
m, struct task_struct *p,
 		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags =3D current->mm->def_flags & VM_INIT_DEF_MASK;
=20
-		if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+		if (mm_flags_test(MMF_USER_HWCAP, current->mm)) {
+			spin_lock(&current->mm->arg_lock);
 			mm_flags_set(MMF_USER_HWCAP, mm);
+			memcpy(mm->saved_auxv, current->mm->saved_auxv,
+			       sizeof(mm->saved_auxv));
+			spin_unlock(&current->mm->arg_lock);
+		}
 	} else {
 		__mm_flags_overwrite_word(mm, default_dump_filter);
 		mm->def_flags =3D 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index e4b0fa2f6845..c679b5797e73 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2147,20 +2147,11 @@ static int prctl_set_mm_map(int opt, const void __u=
ser *addr, unsigned long data
 	mm->arg_end	=3D prctl_map.arg_end;
 	mm->env_start	=3D prctl_map.env_start;
 	mm->env_end	=3D prctl_map.env_end;
-	spin_unlock(&mm->arg_lock);
-
-	/*
-	 * Note this update of @saved_auxv is lockless thus
-	 * if someone reads this member in procfs while we're
-	 * updating -- it may get partly updated results. It's
-	 * known and acceptable trade off: we leave it as is to
-	 * not introduce additional locks here making the kernel
-	 * more complex.
-	 */
 	if (prctl_map.auxv_size) {
-		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
 		mm_flags_set(MMF_USER_HWCAP, mm);
+		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
 	}
+	spin_unlock(&mm->arg_lock);
=20
 	mmap_read_unlock(mm);
 	return 0;
@@ -2190,10 +2181,10 @@ static int prctl_set_auxv(struct mm_struct *mm, uns=
igned long addr,
=20
 	BUILD_BUG_ON(sizeof(user_auxv) !=3D sizeof(mm->saved_auxv));
=20
-	task_lock(current);
-	memcpy(mm->saved_auxv, user_auxv, len);
+	spin_lock(&mm->arg_lock);
 	mm_flags_set(MMF_USER_HWCAP, mm);
-	task_unlock(current);
+	memcpy(mm->saved_auxv, user_auxv, len);
+	spin_unlock(&mm->arg_lock);
=20
 	return 0;
 }
@@ -2481,9 +2472,17 @@ static inline int prctl_get_mdwe(unsigned long arg2,=
 unsigned long arg3,
 static int prctl_get_auxv(void __user *addr, unsigned long len)
 {
 	struct mm_struct *mm =3D current->mm;
+	unsigned long auxv[AT_VECTOR_SIZE];
 	unsigned long size =3D min_t(unsigned long, sizeof(mm->saved_auxv), len);
=20
-	if (size && copy_to_user(addr, mm->saved_auxv, size))
+	if (!size)
+		return sizeof(mm->saved_auxv);
+
+	spin_lock(&mm->arg_lock);
+	memcpy(auxv, mm->saved_auxv, size);
+	spin_unlock(&mm->arg_lock);
+
+	if (copy_to_user(addr, auxv, size))
 		return -EFAULT;
 	return sizeof(mm->saved_auxv);
 }
--=20
2.53.0.983.g0bb29b3bc5-goog

