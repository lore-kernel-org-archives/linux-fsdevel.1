Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DEE37CD29
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683174; cv=none; b=FRZsUDdHoRYWX8SNeQdMmBzAMwWMYZhrih2OrG/orEA1flILieWdM+ioOJFMR/b+clFxabxR/r1iHlKamwe/SAnuIHcJWHbQ7INhWrQy3sbw21DrcIUXIXEFSSPnZLHeLd+JsHlx0uxAS+dVjz9IgM0ZFZy6YxgthdtHicPbljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683174; c=relaxed/simple;
	bh=cMZpfmy5y60iCBgOY8zKfRDT8aXfoJ3FsT1GEaT5qgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO8WvNspCLEp4KdKjzd6JXHKGDX9q7NEnyeFpPfuwuJZbC0h6x3jzrR0OnId1LEkjNU4q/6FqaQ/x8m4wQRD+iQFPPRfDe4R81+nfPyZD9Y7LCrtdMoIOrxWdaTkhh029zdy2jSiVC8cqWuUqEmV3btle7gr+qUbwpd5ctpvmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzNhsjoo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzNhsjoo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso1718a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683171; x=1788287971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDanl1d4pFlCVpfToYIsXIfzb7i9JlEtociyRendWt4=;
        b=tzNhsjooTe031QUmSXR820hYC2b+oTzglcWqV1dElHG4uqYvSHKSB+HobBfpRwVEwB
         9G5PJB0BizVEDVo6HBVNKjtCkceGnHfEUc3e81hiNjsiwUNqCGcOO7eJ65k9ueLbGTZo
         qTytBVEUkxFZtzrd1dHF1COEOTXn8qsgHRY/En6NMfyWNFkYJNv+5XptXmuVV3kAWVvz
         UHNzZmjdMIjkTC2v1htpwZm7J1xHQcviRQXE3sPkaqMOIeHzpTk3/TMKXwiTt6knz94r
         rn5qJ6OPKqKCo1BYN60V9ZZKf/eV09eGkmfxmVOrKptAPu9Qr57nOY8gtW/swDlLmw8g
         DyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683171; x=1788287971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDanl1d4pFlCVpfToYIsXIfzb7i9JlEtociyRendWt4=;
        b=BPNapV7xngQJd3i2TQ5wdXB95aFocSqstFIfojiHICWBPcRddCu/6VXKfIMHss2nMW
         PEmc2Zmjwnfoby3CR5Sx5Ng0zFzf57LuG9pxa85sBAIsimtqwIREd5wHUaumFKaHMC6M
         EJdYIwUofVzW3GY+FWaZ2aozsw8Rn/TMgo4Ips0vYU4+yvSMej9ksF1/DV224ucSOMO+
         vUEDThW56vfGL1b6cU1w03I7L4FtfxKcwx1chUZnQjrYMK3km3yMHQvkYWvkrNQBMT0s
         T99Itv4Vd5TW292UxA0Cazo9vlig9jhrv1DXYyZcImB+85o4NXCJXaElySYxMnkgP5zR
         0QDg==
X-Forwarded-Encrypted: i=1; AHgh+RqgFiQIx7qThqr4i2KDeqX+zzHxBjlatYalH5sNyCS3ABKEKnVUfeLqYpPucHiRQ6M2kVmuew/V9k2Xvvj0@vger.kernel.org
X-Gm-Message-State: AFuF++l65//FZxE+m6PzfPnh8AlNqCXtkaxANsla24/A83HAh0Pn3rTK
	31bS8wFy8ZBLykDZDgtKF4URb4d4EfwkSNPSmM0sOUVqAYVQajsEqWV0LkqRcl38bQ==
X-Gm-Gg: AR+sD13gc3ajLCmlsDlR7R0BNcwURrRzaaCpU+g7+81s+OQc4Okdd7Z/qpIHn7v8BqI
	YIx4Z+Il3LgUlO6NU+rx2l3Sx5qPWCAOrewGFq3DLIlZNaf6q+o0QZq00GNkmIOkIUjhCX5Ccm+
	F+iIt0hGvrd2inkTFZYfbCQCn4N+YWWZxiMwQYX8RpZbaCoNy9T4iYAWUinStL5RpLy998LBrC5
	KrgMcVme20jbHRUlK+29LxF0oBnGklkzOtL5JvBwKhl5Su9fBhzQBsBz5sRxMsM/xqBy+5LopY3
	wB+z0TJpO3VfDuNIGGFsiDJ6BDBZ3PQww3BXpHndvcRlMzexXeyAoGiLY11YtSklhiP07ZclYJ8
	JY4Is4bm/kDYBxCiLq0Za8EMIuIMEi5/MJfSWxWVHKfy6fsVUwR5gcJ8Rky4pTTNMn7vAzXFt/u
	KvGyERRe1aNfSrxUI2Pl874Msc7gwZxkViB40Xh0nhLSyBjHO/04Bs+5UHf/c8OYJKODAapHbU7
	GikAJHDBsCva/xGrlj6Sjqf0IuhLleOFramaD+1/XeGd+s=
X-Received: by 2002:a05:6402:1503:b0:68a:e1ba:9cc0 with SMTP id 4fb4d7f45d1cf-6a5c4a438c1mr79208a12.8.1787683170518;
        Tue, 25 Aug 2026 11:39:30 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:980a:b43:2df6:51f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a704e55sm77188266b.21.2026.08.25.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:29 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 20:39:17 +0200
Subject: [PATCH v2 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-selinux-pokemem-v2-1-b46bc64916d8@google.com>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787683163; l=2508;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=cMZpfmy5y60iCBgOY8zKfRDT8aXfoJ3FsT1GEaT5qgg=;
 b=etcdXt6YJPtLzJ6NsslFUvgTrScKbEiz++YkD+u7YgmV0etE8NJizSEaw4u8B+QgHDC0OYnkX
 3FNCYVeg1SkCai4r7vUI2wYlcZQZ8x+LEATW601w5uzuzrhWwsKDhRj
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Refactor the handlers for proc_mem_operations to use the new struct
mem_private as ->private_data, rather than directly storing an mm_struct*
in ->private_data.

This is in preparation for adding more state in mem_private in the next
commit.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 780f81259052..bec6197329dc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -848,11 +848,24 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 	return 0;
 }
 
+/* private_data for proc_mem_operations */
+struct mem_private {
+	struct mm_struct *mm;
+};
+
 static int mem_open(struct inode *inode, struct file *file)
 {
+	struct mem_private *priv __free(kfree) = kmalloc_obj(struct mem_private);
+
+	if (!priv)
+		return -ENOMEM;
 	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
 		return -EINVAL;
-	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
+	if (IS_ERR_OR_NULL(priv->mm))
+		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	file->private_data = no_free_ptr(priv);
+	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
@@ -880,7 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
-	struct mm_struct *mm = file->private_data;
+	struct mem_private *priv = file->private_data;
+	struct mm_struct *mm = priv->mm;
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
@@ -970,12 +984,21 @@ static int mem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int mem_release_with_private(struct inode *inode, struct file *file)
+{
+	struct mem_private *priv = file->private_data;
+
+	mmdrop(priv->mm);
+	kfree(priv);
+	return 0;
+}
+
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
 	.write		= mem_write,
 	.open		= mem_open,
-	.release	= mem_release,
+	.release	= mem_release_with_private,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 

-- 
2.55.0.860.g4b6b3295ed-goog

