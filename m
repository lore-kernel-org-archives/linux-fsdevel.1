Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4D3F44C5
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814832; cv=none; b=tctugHg2m9wPVCRmOCWE83Y3cRx+qZfcFW0K8Frj7rJqgwC6EmrfJ+CvBq9SpUcNcUdukqffruwOkB7z/z5HYPCq+GlO/XsjxjahYzoKj9xo5TVGjfwmrn8jfpKpiqezWpz4L4TXH0BivZrUupYgJkQdh8RET0Djj1QomCu6iSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814832; c=relaxed/simple;
	bh=dFQPLUrKSushQVlRIfa3+RqE2BxwwVdKHC0sBsQHxRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kU/HfMFzDS7kacllJk5A5aair5Cr3//6yd7DbPZOg8IvVmFlf6BbgaDQevZ15TfiTTNgYakeOA38ANbYUk4J5a4KDmiDOO4cpSh+vsEhXJPONyGImg/eN7oQONC7RVrNP7T7JUagt1ad8L06XVZiB7UYmTggKpCHoI0pfbCNoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKoZCaph; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKoZCaph"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b5e50eb70so63215e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814829; x=1789419629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opljs6/yePkUAePwO+BlsImVeSdvbWETq0V3zNfopXk=;
        b=wKoZCaphLV/cZ02+tkj9DteP39Cl3IVuB9fT8hbWbD7ExyfEibO0vSmjlQYW2wzSpQ
         0SApbcAqKPQKkxweO7M0f5jThw/tmqCXst4IFwXgoYGkYAAuwWCyvDC4ZTecY2GrXFSG
         WTJXAhziiqnj6xAtVmfXp+1mKqd0VVDOao8muYwY9ILHbYGBFa3tqZNyWE5QWKOKZL9e
         rFVin9tfzaghScWVCivIjF6fqt9ErqBSXrYg1nXyqvZNysxMpcm+OjxKGKS357xDeHk0
         ZK6Yy76O9YwhcNPkKgR1ZrHUxZWKWPBSz5Ig/XEpb36pSJJTz4D3z/SHdU+1dRPeOVdw
         DWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814829; x=1789419629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opljs6/yePkUAePwO+BlsImVeSdvbWETq0V3zNfopXk=;
        b=By3CY3KPcTJIOyyUqcrANngmdymEdqeDrw/KdmZFLj/+5yyhhbuToAzZRAJH5bgIej
         390Of6OWaImUAtKIXMnXk389/49dD/l76v+TXuThZFndWUubRA6g2pS3J481bMQZwW/5
         eS8+wPK7eTXOU6E8iNZIcXTxL2+dVSbGdqH5IXmU0xBabaDjNQFO2v8Q5zCcDg9Q+Cup
         0QzSVPEHdnSp3Pk2Ae8S1e2H+UKD6+SpnZRpcCWZwXUR9f/BHQn3yiH5ZHGqIN+Cr73R
         jrCyR5+550mrqEY1E0jI4gcGiwajgp/TWcBpjiaIEilyjpkAv31sjIJGd3mWF/B3Eyn/
         67Pw==
X-Forwarded-Encrypted: i=1; AKwUvBwY1IhU75mszrJ9KoKdDBh5FwMasEx7QJ1FI5YMtXby8HbswWqqDuf34SKFZEOskT8Glp81fT1ZcS5W00kr@vger.kernel.org
X-Gm-Message-State: AFuF++kXgCai1jqpjYsATvsKxXspdZIsZcDV3iIqhWEUhhpMaw5WQx6S
	RkuF6JTBdG8mZyT5MlF0mqu5J0K1xjz2KVxRHHjdsuT3151wYbCuaNQgtyT8nqCv5Q==
X-Gm-Gg: AYBFou2aLGbcZao5Sj7BgH1M4M9l0IzHv8yZtF30O4oRPq7LQD09C0gMJssO+4FR4md
	ovDRWl9/EeBtKu76O8N0/KeI1+HCZi4jL7EfTu6QshdCnxgStz2BfpwVCd8P/alhkdDZDHzkgNC
	wFkHZZvfRvru8pLhMD4m7gmKm1QC1CqJv48YlRF88fmZB9hdApQWNLsJ0bHtylNRQLdhit92ykY
	fenT7haRkguatuypFdCFXC7t3VFDSqt856sBjzidL42x0bIgPKi+DVatPMdL2rFaEZu1STgerkp
	H12/FscseD+FXtU4jUoNmtjOaQDyrU4SQJjqA12JmJtS5TLHp5PXlFm3jGdmTzCVQ/JM9xV3UYT
	NhpWPdqdEPZZlBHUQB+LN9tNP6MqgPXWIpbZCnT8mf1W4fiU0VPm96h+HJ3lcPphQBBMl6KAAH3
	dI76sVmtSpw/lOBU9dGcw3z8eu8OMTt053ayXo2Bv4whbXb5v4rghh9JkZRv8mnwjGpWNf5WiCM
	TPa9ARGZqLNztvTXe3zCqi7WxFm2G7ZY9nU8Vz2nSZfmXw7
X-Received: by 2002:a05:600c:2e56:b0:499:c46c:adc7 with SMTP id 5b1f17b1804b1-49d17a6bf78mr222815e9.2.1788814828327;
        Mon, 07 Sep 2026 14:00:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bc74298sm27752481f8f.6.2026.09.07.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:27 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 07 Sep 2026 23:00:17 +0200
Subject: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
In-Reply-To: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=6147;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=dFQPLUrKSushQVlRIfa3+RqE2BxwwVdKHC0sBsQHxRE=;
 b=bGUXccOwcnRIhUpKEynLue6/VH0ISEjKrC+KubetQgYKUv6i7R6h/X7out5N5Yn9is7rXXonE
 38A9kIG8FRAB8evQRsnCLY8MGW1KQbFnMcLRddZZ8sHGqBcSRsMN0G9
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
good opportunity to block a process from overwriting read-only code in its
own address space through FOLL_FORCE writes via /proc/self/mem.
The security_ptrace_access_check() LSM hook is bypassed when a process
opens /proc/self/mem because this is considered "introspection".

This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
that a process cannot create executable anonymous pages.

PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
accesses are only possible when the LSM allows ptrace() attachment; but it
is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
environments running lots of third-party code, such as Android.

So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
such "introspective" accesses.

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c                | 14 ++++++++++++--
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  7 +++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index bec6197329dc..295b21203c7f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 /* private_data for proc_mem_operations */
 struct mem_private {
 	struct mm_struct *mm;
+	/*
+	 * Was the ptrace access check on open bypassed because the opener used
+	 * the same MM (introspection)?
+	 */
+	bool opened_by_owner;
 };
 
 static int mem_open(struct inode *inode, struct file *file)
@@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct file *file)
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
 	if (IS_ERR_OR_NULL(priv->mm))
 		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->opened_by_owner = priv->mm == current->mm;
 	file->private_data = no_free_ptr(priv);
 	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 {
+	struct mem_private *priv = file->private_data;
 	struct task_struct *task;
 	bool ptrace_active = false;
 
@@ -884,10 +891,13 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 					READ_ONCE(task->parent) == current;
 			put_task_struct(task);
 		}
-		return ptrace_active;
+		if (!ptrace_active)
+			return false;
+		break;
 	default:
-		return true;
+		break;
 	}
+	return security_mem_foll_force(file->f_cred, priv->opened_by_owner) == 0;
 }
 
 static ssize_t mem_rw(struct file *file, char __user *buf,
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..12f84a1e6fab 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
+LSM_HOOK(int, 0, mem_foll_force, const struct cred *subject, bool opened_by_owner)
 LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
 	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
 LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..e8bc2e644241 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
+int security_mem_foll_force(const struct cred *subject, bool opened_by_owner);
 int security_capget(const struct task_struct *target,
 		    kernel_cap_t *effective,
 		    kernel_cap_t *inheritable,
@@ -676,6 +677,12 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
 	return cap_ptrace_traceme(parent);
 }
 
+static inline int security_mem_foll_force(const struct cred *subject,
+					  bool opened_by_owner)
+{
+	return 0;
+}
+
 static inline int security_capget(const struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..2cde1efdb7a6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -595,6 +595,31 @@ int security_ptrace_traceme(struct task_struct *parent)
 	return call_int_hook(ptrace_traceme, parent);
 }
 
+/**
+ * security_mem_foll_force() - Check if FOLL_FORCE is allowed
+ * @subject: credentials using which /proc/$pid/mem was opened
+ * @opened_by_owner: whether checks on open() were bypassed because the opener
+ *                   has the same MM as the target
+ *
+ * Check if FOLL_FORCE is allowed for accessing process memory through
+ * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was the same
+ * as the target MM, meaning the security_ptrace_access_check() hook was
+ * bypassed on open().
+ * (Current current->mm does not matter for this; for example, if write() is
+ * called on an FD that was received from another process which obtained it with
+ * open("/proc/self/mem"), @opened_by_owner is still true.)
+ *
+ * Note that this hook is only designed to be useful in the opened_by_owner
+ * case, where the subject credentials effectively also describe the object.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mem_foll_force(const struct cred *subject,
+					    bool opened_by_owner)
+{
+	return call_int_hook(mem_foll_force, subject, opened_by_owner);
+}
+
 /**
  * security_capget() - Get the capability sets for a process
  * @target: target process

-- 
2.55.0.1003.g10538fe699-goog

