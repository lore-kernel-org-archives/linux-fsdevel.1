Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C193C0A1C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624130; cv=none; b=DU5EJN60h93S0E0a9gmHSEoTEZTpAgRzClDvVTUTmIrsysbZCL2ucTr9hOmK56oTgJkAnhlyf7TMexAN8/JN76oD3j826TNUUzbUOhxwpnvSM17fxBNunt18jbkFB1G8hVhz3znsmndV0yuF0kVjidvpDqq1PKBGp5N6OBn1ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624130; c=relaxed/simple;
	bh=cIlzFVV17lhGmQM6KKNBYyZ6eM2SQ2wSCLVQHjUmyeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMN3idAJp+N1Axm3555EZWit9hliSUwwUEwWZyjBlfoD6+WZi38befyNvbSbNWCZlwHWnIjMJ15Cs6ZEesfW+8lC3PtyeyARZjieA49jSTtGqcK0hh9rdT5V8sjOTQ4Sxwja1qYkkAjVSB1ijU7F8/+v9PUwr8YQ7kgxeZvRK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWwsX4fs; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWwsX4fs"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso4743833a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784624126; x=1785228926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MxEpS/0A/gZfqZZ27KAKwTrZ3NisDcQ5A3nZ7NEcBpE=;
        b=OWwsX4fsiV3cImDlWRcNRoToiC/SYxrFTOMbDgg9Vv2svuDdRa++UFUFS5Vvm0fcO9
         o8m9nxV740/an8QpEMmzhFLhakwGabXI7OkkvuWW/vJPOHH9eWiuz4JyJM4myjDYhNt5
         Px9Ie9XTMDmCq0xvGy/fc7NXkPnNAobnE7UkS+R9aZrkyHOmbJY1xtlVAvhnf8+tSJ6H
         jbrq8MGZ6BWcS/X7+sKPpr9NJNHLPmD8Vf6c8pCwD4feE0HdIOpBMo33sp1QoFvCl24g
         LFRKuxc1OfeAeFuorzqNzjxSDI9vQdOVqHQ9N+DyvmPcuw2D/HcdLm+HhZVzc64Hl4H4
         h0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624126; x=1785228926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MxEpS/0A/gZfqZZ27KAKwTrZ3NisDcQ5A3nZ7NEcBpE=;
        b=deE+1YnFKbdJodzWJ+F3CFT1nC/iUVHW9D/uGp1iRToT8TBOb4g80TfYYrZ6i8h8IJ
         XwzkFEMmZqkQfZcOxQ3aVdvEL8QYFJp/F1XPWMoPnRPXw0nav6tZwfG8lbIfXDgQcjhk
         jBnxvhFk7zlB4iCGmIx0lzaPHx3Vh/rPJY2L2aQKRIhqAi4Uk7/be3jyvnir/5qIvy8D
         XUoBJ8GTLcfxPut3JAt0FmXI328KI/XznwajsAB+P/PUbawht/OsVAg4GIfn7WP1qoG9
         2eXtvuoEBkQtHS+5nTPCj+6ihX8OeKuoakZrH/ZgbCwjUaL17HUbRsAdmFDFCuyO/J8+
         dhqg==
X-Forwarded-Encrypted: i=1; AHgh+RoNHML1ix+aAp3He15OIHEdFqEVWjUtPO6+zW29OgMnJJnZtbeaj09axJ3TQYBPflsSgekvKzcykGkKO83b@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDoni15Dc0FJ4OMgmAVutTucHsegCXtCputfMjuBFR7iCocTb
	cjbEcq49y/azFexgiF5lrCGhkIPTWw3OQT+FR253kKGsJ/kCM+6TAe8T
X-Gm-Gg: AfdE7clbwSCjOK64w5m7m0lM5APKiGkCJNXyoVyUj5EHUKi6HlrkOKC1pQzqW7rQVDT
	SyzAims4X1djOgGEx8zGDhmiJHwnpQTbXO6gPtptOcHsYJd7zMgm4wkWT60Q5wlXmmpNSpUGZPd
	DWBe784B+m3HkeegMWWsY22tVbjgYtZsiS080IUcWtocwj+RitwN3fCeAQxpcPfcw8WuCzR2fNC
	TrF0biePzop01CPmgZDqE34wQOowIIisTfWZWfxA5iuMPbHm0Om//zd6RMYYtXB9R9HvI0BkIal
	Q4fw+1BDTYsCYG62OxamtkEN8LHRQY69toF1riz6tpMHfUs44U7DzqRn3VbmTGjrWOYbRg/3+Md
	76+gEgUUZC4erZOnRjqeraGPuPvvcFm2JxdLLDevcEdGzrNmg/rTzkAvyVhwy1Zm5bjgE9wl3i4
	lFpuieQYd8J7tmxDUW8aZVEC79qTmhyXRGJ99aoCLaxrCHfoyW9vgDubyZsRBZylvi+6SOypo8V
	4UeC7KeNkA4zlUhpJeKFsGdJaW81iUuW6ATdHnwJVdyjv06jnK1Sd1Uc/TYAxV9I9Sm+2B0Bzuw
	SAdhkYXeMg==
X-Received: by 2002:a05:6a20:734b:b0:3bf:9e25:1a18 with SMTP id adf61e73a8af0-3c3ada905ecmr19143488637.52.1784624126350;
        Tue, 21 Jul 2026 01:55:26 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-b.c.z168d0f9edf9bc766-tp.internal (8.99.126.34.bc.googleusercontent.com. [34.126.99.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429cf22b3sm45463137eec.0.2026.07.21.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:55:25 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v2 1/2] fs: make file_listxattr and file_removexattr helpers non-static
Date: Tue, 21 Jul 2026 08:54:57 +0000
Message-ID: <20260721085458.2716-2-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085458.2716-1-aditya.ansh182@gmail.com>
References: <20260721085458.2716-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding IORING_OP_FREMOVEXATTR and
IORING_OP_FLISTXATTR support in io_uring, we need to invoke the VFS-layer
helpers from within io_uring.

Make the following helpers non-static and declare them in fs/internal.h:
- file_listxattr()
- file_removexattr()

No functional change is introduced.

Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/internal.h |  2 ++
 fs/xattr.c    | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 355d93f92208..ee86b24db79a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -297,6 +297,8 @@ int filename_setxattr(int dfd, struct filename *filename,
 		      unsigned int lookup_flags, struct kernel_xattr_ctx *ctx);
 int setxattr_copy(const char __user *name, struct kernel_xattr_ctx *ctx);
 int import_xattr_name(struct xattr_name *kname, const char __user *name);
+ssize_t file_listxattr(struct file *f, char __user *list, size_t size);
+int file_removexattr(struct file *f, struct xattr_name *kname);
 
 int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode);
 
diff --git a/fs/xattr.c b/fs/xattr.c
index d58979115200..a3a7241846c3 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -953,17 +953,15 @@ listxattr(struct dentry *d, char __user *list, size_t size)
 	return error;
 }
 
-static
 ssize_t file_listxattr(struct file *f, char __user *list, size_t size)
 {
 	audit_file(f);
 	return listxattr(f->f_path.dentry, list, size);
 }
 
-static
-ssize_t filename_listxattr(int dfd, struct filename *filename,
-			   unsigned int lookup_flags,
-			   char __user *list, size_t size)
+static ssize_t filename_listxattr(int dfd, struct filename *filename,
+				  unsigned int lookup_flags,
+				  char __user *list, size_t size)
 {
 	struct path path;
 	ssize_t error;
@@ -1036,7 +1034,7 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
 	return vfs_removexattr(idmap, d, name);
 }
 
-static int file_removexattr(struct file *f, struct xattr_name *kname)
+int file_removexattr(struct file *f, struct xattr_name *kname)
 {
 	int error = mnt_want_write_file(f);
 
-- 
2.47.3

