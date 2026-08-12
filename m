Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B49431484
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533135; cv=none; b=hxZAP3s3t5qiB0UOFA2rX0RDE+jvL/5ScAASkLkFyxPpYm0XOKxm26WuiGdeq91lN7ttB3gV/0wkSoowSCzST3IxZRTqPbZXpUC+GTgQYGCoBQhVW2MTeazLPCHULC0c2aOno+UEA3TB4/3m92iUhQPampX7AUrpsMLdHPIegcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533135; c=relaxed/simple;
	bh=Ty3tl6DwZMXaLu228b7+91HZQ42Gjl03IlpTNOGQSVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4ER3AXgzaDigrUXa+BkEXF1QW1N16jlCaJgCCM2OMF1lmtd8UX+A6eQQN7/pNLenbw5Pixlj5qVxYS2DrR+02ad25dhn8doMbMRhw11LBzP4kqcegGkkvAbuo18lnIOm0e/r+QoFcLaQPcDDavQckPRw3JsAfMoRGfIDlWTQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8a/Ncas; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8a/Ncas"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so7763195e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533132; x=1787137932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HnziYhdT7UChl1G7MKYkZ/8e/rooUTVlGFzd76e4LeU=;
        b=h8a/NcasdlogzzOjC+UZbXFUTGEcqGjHlyMLD9MG86cgxbtb3lU+YQh/cVXtAipXnL
         evp5PyPDdroXVPbBnVtVAtIV4drEqQlrjIDH6hus9/89pPoAot1BxO9eRwUPzdcLcbJz
         PPiRARL4jSDRBS8z/lVuXvia6oLGSFqqTrt1uLhU7QAZ6e5vc4pfoJhhe8gSnyeZoxHq
         KQT7wFV5TGPCcWb0mEMh1v79RDhX+XNBDW8qjO/cmNuPqV7Xvli2NLIl7yqzKFqDRcgw
         Wc7EHDol2M4HZikrT5R1vqG0amcWNQQ21TjAL1pgRBxgl8S9C5VQr7Yrrm6c1t5agtLu
         gWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533132; x=1787137932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HnziYhdT7UChl1G7MKYkZ/8e/rooUTVlGFzd76e4LeU=;
        b=mpwwNhQheXvolaEYtKi/lwtqapx7/l+SY2FamrQ2ZL6JbHQ0nilRQSgPndzGyYwaM1
         d+onMPUQdzly/Kg7teSBiDQ56IIqR9F1g+PwlymKVXDAHLTrLbkDb3XQNJ9RkmDBFaF4
         LaJ558R3JvGpVhTdB1hXU/g7Ambu/DUvx8LN7SUckCPcQMyx6z9WMspV4Q080hfcXxPp
         an3NR36HD888+glkSb5Fxy1ZEd6IdHo8il0R1Lt38IzXnCOtNEmngjeWo9JrufWNZ6B6
         DTA1xcnLCAXr1gH6Rzrn90AvQ+0U1CBbMFObCG9CIY1xgBYn9USgzB7EuhpKl2ZzLorj
         tWxg==
X-Forwarded-Encrypted: i=1; AHgh+Rpu6t86hwsf+ldWtNRe2zFdOqZFVrLRXoehA1mN9b0sXOHwP56UYQr7oYdThJrirLvu3n+a3c//Z1atp4Cn@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLjAi+RQlw2yb6kKgGm/yLwPbI+ShpO24INZ1ChZW4MamXPNa
	d5OzJnibhWqnsPdPruLxY5jqTWxFN3+F7rZKIPLdsPQqEV32WfheDjwF
X-Gm-Gg: AR+sD10U7CDSVZX1r5qWmV8/kZ7v7r9UN+EzazYyScRTLR7xfqVCdJ9ZgU+G13PP5c5
	LjpOF/846ytKpZTZoZKw00DZGppFG76LImls8fcUr979Wwzmg1zWWcfjURCCIuOnh12c7u2ShEo
	7hTaq061IECzWdHHkEvLG1epBpgx89CQzHqovMc+mMR6/TxdK9yJ4kttR1RuNLc5CWZZg32xDP4
	zsQKu/Y8MEddKxik1SLQtmn2iTFO+IHU1T+ed4RrjNpBD5WpomELwqbg2m9t9tBHYIQi6PHy0mY
	Td9PsZXUcrdE0stk2enDRBn7YMG/7LwtPabJ9og7qDQlc/Jl7MVMyZr7QGLBDL7O8e+n3IhyADx
	hFM7zExilpfnyC0dhzzp7W/dOySAZl/rbuu3JEvWYVBY35qOz3QJe5mj740nl+v76yEiIqD5tfY
	MrB0SyxiJH+XHk8qQi/j9yU5KJ215OHyWExjyvG+j72ydoTz+AUmSb6cNG2AO/7nqpyLh6P0Efo
	Ntu
X-Received: by 2002:a05:600c:4690:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-4997c0fe67cmr52327655e9.3.1786533131316;
        Wed, 12 Aug 2026 04:12:11 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c9417bcsm54830855e9.4.2026.08.12.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:12:10 -0700 (PDT)
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
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 1/3] mm: Add copy_remote_mm_str()
Date: Wed, 12 Aug 2026 14:11:38 +0300
Message-ID: <20260812111140.7762-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
References: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
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
 mm/memory.c        | 25 ++++++++++++++++++++++++-
 mm/nommu.c         | 25 ++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 2 deletions(-)

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
index 6b8280cfc1db..a70c43d9b17e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7218,6 +7218,29 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return buf - old_buf;
 }
 
+/**
+ * copy_remote_mm_str - copy a string from a remote address space.
+ * @mm:	the remote address space
+ * @addr:	start address to read from
+ * @buf:	destination buffer
+ * @len:	number of bytes to copy
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. Always guarantees a NUL-terminated buffer.
+ * On any error, return -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	if (unlikely(len == 0))
+		return 0;
+
+	return __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -7247,7 +7270,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index ed3934bc2de4..8fbe6306d074 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1752,6 +1752,29 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
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
+ * not including the trailing NUL. Always guarantees a NUL-terminated buffer.
+ * On any error, return -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	if (unlikely(len == 0))
+		return 0;
+
+	return __copy_remote_vm_str(mm, addr, buf, len);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -1781,7 +1804,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
-- 
2.55.0

