Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254273DC84C
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168225; cv=none; b=nlxSWiZO3HHAZlDVGq006HBYW0nXuWRps4nCeIgJ9us2FVz4335HbYoFGY6eQadUr21TsaodY4QmUeZXF+QZG2s5+VXVV82mv5UxUYbflANkJuIwOKtpC6T0PMmQtM+GjPHIu/BEP2k2q3sC2HpC093eHCsOl6rUpOLpfXwH7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168225; c=relaxed/simple;
	bh=xspFFxFjYAqvjceAxqadMuKixodXwHOZDcpMBk8R9S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIzNrSYB57az1s65BmGAPGRfWA4KXj470fsID2UZL/00yORBS5W+yyFfXbDbdtN0gDyCwl0KceNp3nNBnSyrXUfkFZgCtdgQl5iRlG+3qwVMXsHNFQVII4dSZL7WMkoHoXsxra4iq486ZisQa+SGUac62LavWQiixuAyPVB6N3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDJgWm9/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDJgWm9/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48433f36a21so1099094f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168221; x=1788773021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gy3RmBcuruQaR7WrIBsKEmLLWdsVsMuBKWJEzmGMhsc=;
        b=IDJgWm9/RTCQSYlJnx3AujjuI/uDDWAx0223c4yNs/c1oVD1SmQfWxykVZAcPFhzG3
         9kVT03GvpHWIdiUp/gw9nI6BNFzN4KjxI7cb8pTOLyjEz8uVrCfrQGCwfWrgcdkqA1Cg
         4g1bTnJn1vwHmKhU+Br9Xk/EoL2NdVCEjJQeDjKX4uVcCJHnHQFNigYLNijEwQz9nFTG
         pn7GCoUFxnvPj+RYQmK9FVD2j+LaCJBUGVbQk2jKFOOIIZD2XSomPnnfce6jZ6EZnwj8
         AZadTKZc+7u2NJbdXC+VooaXPW0qxlyHUsULCDhXSZzzk8SnSglEr+QLGO6pb1eS3rgI
         d+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168221; x=1788773021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gy3RmBcuruQaR7WrIBsKEmLLWdsVsMuBKWJEzmGMhsc=;
        b=mTrLZ5UiZjHF4Zz2pbJV0reLb8g/CXQAulBY2NAhChGsEw8bEVNeAg+XgZz7eHfMH8
         F/HeYpVGPrETf1XSk6i314gfcUaq0LWutMIKTwEHoxhi49Gny5/GW7HWTeTleIci1Zas
         uCrvg3+1sS/SwFgoMafHgx+GAaCI98JT7r2E5qumI/hEQmiaPJAm/IoC0KwxGKNYFKA5
         FBkl6FVqHSCGwKUnHY2qL5d6+oiBwFpleVVFaMUvMMmlbSM3F8/H9PMX0vVFTPfr2+vG
         l51tmEfDSdl/w7aObN1A/8yBEugVHooo5t+9peGxHEKZo2Ie0b+zxfcnka/B+FSntEkR
         8xuw==
X-Forwarded-Encrypted: i=1; AHgh+RroQRRHsH7XajKRcLwJYcTLfIsMA9eeNb1xFx/hmK33zMA8e73MfceDH3dQBS9owwdEgkRkH1ZCCENhsXY+@vger.kernel.org
X-Gm-Message-State: AFuF++mYvk8IDt7Vd5WqxzHlIgpcuXbRzNcPUKAooXr1WirttTepl5/F
	TeBHFjMYEtr2WHnVGEl0Lav00F1zL/qNFwN1o1NgodCmkygTxp8merJp
X-Gm-Gg: AR+sD11tmfe7dZqbKADYmFBmaTze8sbtonqF7k383degpnoqXm8fBlCbE632aV2otzn
	4PfNrvZYGC566XngB1d+w+Vhszi2y1LwcO7vq80oMfoThwHUJcc3k4su/bqSnE/GpA1U+k6kVli
	x352UW3RIe5uk13S5AdDUKbDGAkic4tKgYof/34OndE5eyemuyA31O4PGeJaRKHa+12yNxBquTg
	3/AM5+sP2bFGT0ojZr4jCBVgCPAOkRVv1tpoPtpjQ4s2c/oGJ2fRgZux46MfCl/iHF7ebGKJD2J
	5Vix/9JYSHlqoPqQ5zPggZh66qKwFfjEKjpfEJAHFft5+8N+3nnk3E739n04ua2gzc86GOdYFmA
	Z4JhXaPn6ayRioy9L7aZcHyo6BrG8lFtiovoQNVHl7aV+aBp+TsB7uuGNehlcYL6wbmWi+Vr+uz
	0TSgLRnqCYWgJH1t5gqyx0adocE64awia8qjW5Uk/jGDa0di7KMuuygthbwqp01G3WNX1ztMdsu
	Q==
X-Received: by 2002:a05:600c:4f49:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49cd52b2c93mr119072045e9.0.1788168221065;
        Mon, 31 Aug 2026 02:23:41 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm318248155e9.9.2026.08.31.02.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:23:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/7] mm: Add copy_remote_mm_str()
Date: Mon, 31 Aug 2026 12:22:59 +0300
Message-ID: <20260831092305.42062-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_remote_vm_str() gets the target address space from a struct
task_struct. This does not work for an address space that exists but is
not yet associated with a task_struct, such as the mm held by struct
linux_binprm during exec.

Add copy_remote_mm_str(), which operates directly on a struct mm_struct.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 33 +++++++++++++++++++++++++++++----
 mm/nommu.c         | 33 +++++++++++++++++++++++++++++----
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..eede435bf4a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3222,6 +3222,8 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
 #ifdef CONFIG_BPF_SYSCALL
+extern int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags);
 extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 			      void *buf, int len, unsigned int gup_flags);
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 6b8280cfc1db..4c5f0b629889 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7141,12 +7141,15 @@ EXPORT_SYMBOL_GPL(access_process_vm);
  * Copy a string from another process's address space as given in mm.
  * If there is any error return -EFAULT.
  */
-static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
+static int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
 				void *buf, int len, unsigned int gup_flags)
 {
 	void *old_buf = buf;
 	int err = 0;
 
+	if (unlikely(len == 0))
+		return 0;
+
 	*(char *)buf = '\0';
 
 	if (mmap_read_lock_killable(mm))
@@ -7218,6 +7221,27 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return buf - old_buf;
 }
 
+/**
+ * copy_remote_mm_str - copy a string from a remote address space.
+ * @mm:         the remote address space
+ * @addr:       start address to read from
+ * @buf:        destination buffer
+ * @len:        number of bytes to copy
+ * @gup_flags:  flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	return __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -7229,8 +7253,9 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
  * The caller must hold a reference on @mm.
  *
  * Return: number of bytes copied from @addr (source) to @buf (destination);
- * not including the trailing NUL. Always guaranteed to leave NUL-terminated
- * buffer. On any error, return -EFAULT.
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
  */
 int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		       void *buf, int len, unsigned int gup_flags)
@@ -7247,7 +7272,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index ed3934bc2de4..94e3709e95fd 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1716,13 +1716,16 @@ EXPORT_SYMBOL_GPL(access_process_vm);
  * Copy a string from another process's address space as given in mm.
  * If there is any error return -EFAULT.
  */
-static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
+static int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
 				void *buf, int len)
 {
 	unsigned long addr_end;
 	struct vm_area_struct *vma;
 	int ret = -EFAULT;
 
+	if (unlikely(len == 0))
+		return 0;
+
 	*(char *)buf = '\0';
 
 	if (mmap_read_lock_killable(mm))
@@ -1752,6 +1755,27 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return ret;
 }
 
+/**
+ * copy_remote_mm_str - copy a string from a remote address space.
+ * @mm:         the remote address space
+ * @addr:       start address to read from
+ * @buf:        destination buffer
+ * @len:        number of bytes to copy
+ * @gup_flags:  flags modifying lookup behaviour (unused)
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	return __copy_remote_mm_str(mm, addr, buf, len);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -1763,8 +1787,9 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
  * The caller must hold a reference on @mm.
  *
  * Return: number of bytes copied from @addr (source) to @buf (destination);
- * not including the trailing NUL. Always guaranteed to leave NUL-terminated
- * buffer. On any error, return -EFAULT.
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
  */
 int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		       void *buf, int len, unsigned int gup_flags)
@@ -1781,7 +1806,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
-- 
2.55.0

