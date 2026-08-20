Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2E449EAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231927; cv=none; b=eQ8XDYkR/p6RkfSoMM1VTqTKvf92lzSJqh9CM/oct7mXhctmzLUSgAj4Ze+Rur3WyjWwo266n9l7smB9YXH7V/pJFXqYZEXx6mlMd/FkQfnz2cufssuPlNLHItYzXTNF6qOUJbmXdUxW4rc0hQurHkq3DAdbN9bpPbv+rXp5eaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231927; c=relaxed/simple;
	bh=5dLODDxq/3apC3tgo/+UYPQ68vpq9esvWORYDhKADVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsxT/v3pX//aEgawHhzuKk75Kege1kEF+XX+fFkeWQ901kZ/ypvNv+e8VwTAm8bKxzcgilh5X2X2gvBl9wNqT48sd5KSbb6YDkDRpmijVzVmA7ybWaWefd4X8vq/+PwykAX18hZlORjcTHFbEAtbOEXXXlC/3FAHh5JPmt6qof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9E/gxps; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9E/gxps"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1930863f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231921; x=1787836721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYbEtEXZu+xF5hfb2YmFgZkOm/c5VxJE4N0FZpACyEY=;
        b=Y9E/gxps8y3mrJegV/bp5y8PcL1tV9BjAE1kclWGW9OaeG14hYFvLiTp+BY62nVHjH
         GorUfJo8JQdrK3dsn/5rw3WPfgGQhiudjlW95LS3zSKdfvo1SeR4IyVDbEa0PerTC4rS
         WDpK21PReCv4a0X0osNKJ5Qi2aRRhUd1KKS1bjCyIh5jfQTDbIsIajY4AK+eQH0S9N78
         e1P5N/GwxhyH2h5g6ElDS7idUErzNVDFNvmEUr5f6D7W7R5crnyHxDir+29UiqmndDQ6
         VRiRChveBdlLQZE9oh3LOGDtpE1W2hWzD/4VmjwiBzN88YrWYg7VOsN1jaSs1NNFi+4t
         6NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231921; x=1787836721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYbEtEXZu+xF5hfb2YmFgZkOm/c5VxJE4N0FZpACyEY=;
        b=qB7vLMFr3ikKylDzcQzcqkaActbeQL2d4QJctp0xk2GBKRG6OSfw+lI8ZjMU+XAhH6
         U7dT0uk4JCyF0rCOi4V/n+Ik8mFeQAs75g/B8812BP2dP7Yy9YujC/pJsPXdvR8IVVlW
         zXGY6WHNXSDb4J859ycvXtKgpsffajXcA4ZF8nYE3VT4HPtWAgxSGarcoABtrwdtZA3d
         mbJ/KSWPyzN5M8wukEjm7yt8euNIz8OqOHqq74RSj7L8daNmAxZU+38E9Sxld9k65GDX
         w+8dT8u+9iA1YbbIOJd6od6h9ragaIaYAY9fye3iAcW4zbIqioOH8m5DrlFa7jt99491
         eOnw==
X-Forwarded-Encrypted: i=1; AHgh+RolAtbILOgTX8UtSGeRuHQ2XzstjqQKvtLJ+cxZi3gbIcaV88RS9GfB/L0AdPS73DZbFuTM3wmHkw/QRRpj@vger.kernel.org
X-Gm-Message-State: AOJu0YwvnRfOCUKUPHQZx9J+seHtr7r1Ni5HHUXXiMF2wqc3P5YQ6jxL
	PeWcIU/QZ7qXcIsp1TM4QYyvBpy3cTBfKfe47CalnQjiWMsH/j99xt6k
X-Gm-Gg: AR+sD10O/IVbbDXZ7/s7NUVWx6aLlfeTgrtdHx/F/EZ1rL9+4BjdVK9bODCHRKuvC5n
	eplYqtFXdBGqsUSCSR+DCmO/9HwHhx+5F1A5hjrvAt7hHhgdMom2gAngIHTk/lP5m4inctB/jbB
	NRdjbmzPnXlnhOWP7LLEm4qrDkljXUuysQFVlk0JvZd5haME0S9PZpYEvvisr4RCwX5xOKntSDJ
	Cnhuw/fPam3BkfcwhXEISy7xEphlOuNFt+ah6PT3MN3IGeg9QeKgvE9k/jfrwzzelGmoTB1BWVB
	R89wrWZT/4RAZyqEsg3/EDDqOQR7AN2CjnaGsZUj0TiHJlRbyWa+y7WjrBn8Gb9HiPYByoq/C+K
	k9yOmQVk7vg+0CUoobFHJoGfwtK++wlZXVOEvtxvZuBL5xYSSOLg3eeGz9PjfPp1UveI2gixvVB
	Ohy4/mJVc0qNT8v69uhUJDgK6YsmNZiJTEdjsbTqTtJ3XAFzeCwc9aFCrdDxlcvDCWLpYgMe/EG
	aDP
X-Received: by 2002:a05:600c:a30f:b0:499:b01e:911c with SMTP id 5b1f17b1804b1-499b01e9125mr101732655e9.2.1787231921093;
        Thu, 20 Aug 2026 06:18:41 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0e473dsm136027275e9.15.2026.08.20.06.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:18:40 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v2 2/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Thu, 20 Aug 2026 16:18:00 +0300
Message-ID: <20260820131801.68759-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820131801.68759-1-tasos.papagiannnis@gmail.com>
References: <20260820131801.68759-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When security_bprm_check runs, the arg and env strings for the exec have
been copied into bprm->mm. The new address space has not been associated
yet with a task_struct until exec_mmap(), so existing BPF user memory
helpers can only read from the calling task's old address space.

This patch adds bpf_copy_from_user_bprm() and
bpf_copy_from_user_bprm_str() kfuncs. Both use the mm_struct provided by
struct linux_binprm.

Register these kfuncs on both MMU and NOMMU systems. On NOMMU systems,
exec arguments are staged in bprm->page[] rather than mapped in bprm->mm,
so the kfuncs return -EOPNOTSUPP.

bpf_copy_from_user_bprm() has similar semantics as
bpf_copy_from_user_task(). bpf_copy_from_user_bprm_str() copies one
NUL-terminated string and returns its size including the NUL terminator.
It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.

This patch registers both kfuncs with KF_SLEEPABLE because accessing the
remote address space can fault. This allows BPF LSM programs attached to
security_bprm_check to read arguments beginning at bprm->p and reject an
exec based on its command-line arguments.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 128 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index f1863a891db6..1cd06f9e4890 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Google LLC. */
 
+#include <linux/binfmts.h>
 #include <linux/bpf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf.h>
@@ -379,6 +380,131 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
 	return d_real_inode(file_dentry(file));
 }
 
+/**
+ * bpf_copy_from_user_bprm - Copy data from a binary parameter address space
+ * @dst:             Destination address, in kernel space
+ * @dst__sz:         Number of bytes to copy
+ * @unsafe_ptr__ign: Source address in the binary parameter address space
+ * @bprm:            Binary parameters whose address space will be used
+ * @flags:           Reserved for future use; must be zero
+ *
+ * Copies data from the nascent address space associated with @bprm. This is
+ * useful for reading the argument and environment strings before the new
+ * address space is installed by exec_mmap(). For example, at the
+ * bprm_check_security LSM hook, @bprm->p points at the first argument string.
+ *
+ * The destination is zeroed if the requested number of bytes cannot be copied
+ * in full.
+ *
+ * Return: 0 on success, -EINVAL if @flags is non-zero, -EOPNOTSUPP on
+ * NOMMU systems, or -EFAULT if the copy fails or is partial.
+ */
+__bpf_kfunc int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
+					const void __user *unsafe_ptr__ign,
+					const struct linux_binprm *bprm, u64 flags)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm;
+	int ret;
+#endif
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+#ifdef CONFIG_MMU
+	mm = bprm->mm;
+	if (!mm) {
+		memset(dst, 0, dst__sz);
+		return -EFAULT;
+	}
+
+	ret = access_remote_vm(mm, (unsigned long)unsafe_ptr__ign,
+			       dst, dst__sz, 0);
+	if (ret != dst__sz) {
+		memset(dst, 0, dst__sz);
+		return -EFAULT;
+	}
+
+	return 0;
+#else
+	memset(dst, 0, dst__sz);
+	return -EOPNOTSUPP;
+#endif
+}
+
+/**
+ * bpf_copy_from_user_bprm_str - Copy a string from binary parameter memory
+ * @dst:             Destination address, in kernel space. This buffer must be
+ *                   at least @dst__sz bytes long
+ * @dst__sz:         Maximum number of bytes to copy, including the trailing NUL
+ * @unsafe_ptr__ign: Source address in the binary parameter address space
+ * @bprm:            Binary parameters whose address space will be used
+ * @flags:           The only supported flag is BPF_F_PAD_ZEROS
+ *
+ * Copies a NUL-terminated string from the nascent address space associated
+ * with @bprm. If the string is too long, @dst is still NUL-terminated unless
+ * @dst__sz is zero.
+ *
+ * If BPF_F_PAD_ZEROS is set, the unused portion of @dst is cleared on success
+ * and all of @dst is cleared on failure.
+ *
+ * Return: The number of copied bytes including the NUL terminator on success,
+ * or a negative error code on failure. On NOMMU systems, -EOPNOTSUPP is
+ * returned.
+ */
+__bpf_kfunc int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
+					    const void __user *unsafe_ptr__ign,
+					    const struct linux_binprm *bprm,
+					    u64 flags)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm;
+	int ret;
+#endif
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+#ifdef CONFIG_MMU
+	mm = bprm->mm;
+	if (!mm) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+		else
+			*(char *)dst = '\0';
+
+		return -EFAULT;
+	}
+
+	ret = copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign,
+				 dst, dst__sz, 0);
+	if (ret < 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+
+		return ret;
+	}
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst + ret, 0, dst__sz - ret);
+
+	return ret + 1;
+#else
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst, 0, dst__sz);
+	else
+		*(char *)dst = '\0';
+
+	return -EOPNOTSUPP;
+#endif
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -390,6 +516,8 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_copy_from_user_bprm, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_bprm_str, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.55.0

