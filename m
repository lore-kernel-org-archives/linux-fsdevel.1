Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF5279DB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602853; cv=none; b=OcLYx+E51weLKC/1CvmIBW25qka7iu1rH3irA2W0wu+TX45wyZSK0iX7EnacypmNsTWWfl+TjZBz7Fx0hz4dEIT8rDVRqx6RDVnsOzUOFPBMtlvsoAwDoNNr/NOofbmJ6/C2VE4J87l3SptMWoyqCydtkGX8veOtxrazOAM9yMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602853; c=relaxed/simple;
	bh=EOAf8HOSRNcNSHDIRUyNn2BGqVePzIWd4FiTn/NJp78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhLcZSmSJrRUHxTtWgH44nbzmjOBQGoNkIbZ8zdjulPpWLkq6n4bkHFLaGrhp7hpTEpQ4/LvsaYgr+AWY+1DIMzEhX9DF4y57s32xjz2ugOcLfpBA0l2OuktlQuPR9pH1+2h67s/KmXnPwyU10F6XchD9WHk14USbzOYAmyyvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRfb/iji; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRfb/iji"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so485422a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786602851; x=1787207651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VydE882aeZh4C0XeyZVTmtWlDmuPadzLk+Mgv6C7/A=;
        b=gRfb/ijiKf4oTTUbuclpvIyXNEkonOE/domQSJATfdUOfiWFZct6niN1GcgLl83I75
         UqkyPWtPLZX+odjb4cYMzSqlYFbAtTT7DiC5mayg8miZy1NrzdVbyM0wKrjrvaRlKfLa
         TutLfRsv9oOfkrehnVyBXvM8aa/YeimAo6ked0rD8t9bDIFapfnt1rSUyxEQ7T2NDy79
         CB171TdZEVJPQ/s4wHuHE6m2UShc2oBGXX3Ge+gr9Pv2oRcd/or1VCgd/mPFCj+cPhQ+
         1JWIqPDItkNdn7knNOVZqm7eM/VIsVu1ZEYEUblMljoxWG5aRKZIYByd709MfXl7Tmvr
         cUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786602851; x=1787207651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VydE882aeZh4C0XeyZVTmtWlDmuPadzLk+Mgv6C7/A=;
        b=Q/zsue0f4O/6LxVHh8nQxl3UopqA5+pNSOTUwHh06uV/oj6q41u/Z9uQaVcWjFjv51
         b05w2BWlHK+L1JMfj58SEnkQrlADYSyg+hIFCAZ4k8djZ2iSD+qcxb18HLo7sLd+JAva
         /dbHWWCh9e+/19oYUWS9eQCBxKGZEwj335eBVGRKGItR427NVXKvtBLvjUa1ALA2HwcL
         kGZACXbn/E+0OE7o4PokX1U2PczIPNmjhX3GiCyKow1lAvzR4Itrz3vZ6mt+P9JAJ/zR
         3/RpBGtLJKmQoFUOxTLQcx6+9PhLZcnhxdqarXBTq6agAmQP8UZDSvDSh4Xwfky/CYv1
         u6Bw==
X-Forwarded-Encrypted: i=1; AHgh+RpSTOF9awAk/lzONQ7UJ5C11bQu/AQcyW/rPSl5OanwpxgaGAeSrTgXqgfA3IC0biTDRnodepL1zFuStDas@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0ioEkozV4ctg64PZKh51IpgWSdUizAntA/eh6iBg0y4VRxd6
	Yl0cPojmUyuugXHQNWMMKCHSPtRR+L+itwPc5CqZQ7/tyKBKGA56q3BS
X-Gm-Gg: AR+sD12ECRVkW0pYFvupe4ZehEyi6B5lApcIXr4ROFaYmKSiq6vU9dlKRuuV+az2SV8
	pOvSHRy76vFEdA+oLZ2PUZ2MsNfNGma21Bq8SLI/aLfP/H/TWBHSD8bCnzKMp/F/1m+JfA5VR2Z
	oypc7UOFodUN7f4SlAMxWqxu4pj3+heo1gAXrw4eK9sBCU4SnLJ8720BNpRMSkyL6bAdBGiTAsl
	2NT3n8kCMHNDGopGsJbgyLavlecnWV003Tlg6kZ8ddX09CZPaRfanzAB5Aw6kMRYo+xaCGzI1aq
	h7fMmRiKvxh0IRtpOIGhQIVPJjSSmNGmbzAV7W9mgg3s4qtAS/hj3aV4AZm3BfgXGeJxPKdTJDn
	r2KLu4FpqAooa253m8eLs+7g0/GFSIBD6WDtEbLlP3W87KXdR331Cr/aIevUU2GbF7VWf+aAD/u
	ytcttXr2kl+Flfw54EcfbqpRXqjT7HUWrnfrCOIh0MA0mkImmne5n4k/aRLBH0lJySW5NzWTc1g
	U7GAaig6SQc366UpjcjRc/TQlSMy2ztf8UG8DVQhuCuVzuGgbH3fTCG+17hXwn4izRHi//mLWPI
X-Received: by 2002:a17:90b:3c8d:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-3931e05c56dmr4216541a91.5.1786602850753;
        Wed, 12 Aug 2026 23:34:10 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f41cd2fsm1576275a91.12.2026.08.12.23.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:34:10 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E79AA15B042F; Thu, 13 Aug 2026 15:34:08 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-mm@kvack.org
Cc: geert@linux-m68k.org,
	daniel@thingy.jp,
	Hajime Tazaki <thehajime@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
Date: Thu, 13 Aug 2026 15:33:58 +0900
Message-ID: <20260813063401.1786548-4-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813063401.1786548-1-thehajime@gmail.com>
References: <20260813063401.1786548-1-thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon a private file mapping request to /dev/zero, it calls
kernel_read() in do_mmap_private(), getting a failure with the message
like: "kernel reads not supported for file /dev/zero", which is because
zero_fops defined in drivers/char/mem.c has both .read and .read_iter
definitions.

Even fixing this issue, the map request to /dev/zero works fine without
errors but the allocated vma isn't marked with anonymous because
mmap_zero_prepare() isn't called under nommu platform, resulting
vma_desc_set_anonymous() isn't called either.

This commit fixes those issues by:
1) use vfs_iter_read() instead to avoid failure at kernel_read()
2) calls .mmap_prepare on private mapping in do_mmap() so that required
   preparations are done even in private mapping.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org (open list:PAGE CACHE)
Fixes: 4d03e3cc5982 ("fs: don't allow kernel reads and writes without iter ops")
Assisted-by: cubic.dev:unspecified
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 drivers/char/mem.c |  5 ++-
 mm/filemap.c       |  6 ++--
 mm/nommu.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 63253d1de5d7..dba24d0a7b33 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -500,11 +500,10 @@ static ssize_t read_zero(struct file *file, char __user *buf,
 
 static int mmap_zero_prepare(struct vm_area_desc *desc)
 {
-#ifndef CONFIG_MMU
-	return -ENOSYS;
-#endif
+#ifdef CONFIG_MMU
 	if (vma_desc_test(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
+#endif
 
 	/*
 	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
diff --git a/mm/filemap.c b/mm/filemap.c
index d721986d5f46..cf02faad86aa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4077,7 +4077,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
 }
 int generic_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	return -ENOSYS;
+	return 0;
 }
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
@@ -4085,7 +4085,9 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 }
 int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
 {
-	return -ENOSYS;
+	if (is_shared_maywrite(&desc->vma_flags))
+		return -EINVAL;
+	return generic_file_mmap_prepare(desc);
 }
 #endif /* CONFIG_MMU */
 
diff --git a/mm/nommu.c b/mm/nommu.c
index e40990e15831..a29a53c1c80a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -37,6 +37,7 @@
 
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/major.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -856,6 +857,22 @@ static int validate_mmap_request(struct file *file,
 	return 0;
 }
 
+static int is_file_anonymous(struct file *file)
+{
+	if (!file)
+		return 1;
+
+	if (file->f_path.dentry && file->f_path.dentry->d_inode) {
+		struct inode *inode = file->f_path.dentry->d_inode;
+		/* if the device is /dev/zero */
+		if (S_ISCHR(inode->i_mode) &&
+		    imajor(inode) == MEM_MAJOR && iminor(inode) == 5)
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * we've determined that we can make the mapping, now translate what we
  * now know into VMA flags
@@ -869,7 +886,11 @@ static vm_flags_t determine_vm_flags(struct file *file,
 
 	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 
-	if (!file) {
+	/* private and file mapping will be marked anonymous later (do_mmap_private()).
+	 * and /dev/zero is marked by them at .mmap_prepare,
+	 * which should be _before_ this point.
+	 */
+	if (is_file_anonymous(file)) {
 		/*
 		 * MAP_ANONYMOUS. MAP_SHARED is mapped to MAP_PRIVATE, because
 		 * there is no fork().
@@ -923,6 +944,29 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 	return -ENODEV;
 }
 
+static ssize_t nommu_read_iter(struct file *file, void *buf,
+			       size_t count, loff_t *pos)
+{
+	struct iov_iter iter;
+	ssize_t ret;
+	size_t done = 0;
+
+	while (done < count) {
+		struct kvec iov = {
+			.iov_base = buf + done,
+			.iov_len = min_t(size_t, count - done, MAX_RW_COUNT),
+		};
+
+		iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
+		ret = vfs_iter_read(file, &iter, pos, 0);
+		if (ret <= 0)
+			return done ? done : ret;
+		done += ret;
+	}
+
+	return done;
+}
+
 /*
  * set up a private mapping or an anonymous shared mapping
  */
@@ -993,7 +1037,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 		fpos = vma->vm_pgoff;
 		fpos <<= PAGE_SHIFT;
 
-		ret = kernel_read(vma->vm_file, base, len, &fpos);
+		ret = nommu_read_iter(vma->vm_file, base, len, &fpos);
 		if (ret < 0)
 			goto error_free;
 
@@ -1080,6 +1124,28 @@ unsigned long do_mmap(struct file *file,
 		vma->vm_file = get_file(file);
 	}
 
+	/* call mmap_prepare function if any */
+	if (!(flags & MAP_SHARED) && !(capabilities & NOMMU_MAP_DIRECT) &&
+	    (vma->vm_file && vma->vm_file->f_op->mmap_prepare)) {
+		struct vm_area_desc desc;
+
+		vma->vm_start = addr;
+		vma->vm_end = addr + len;
+
+		compat_set_desc_from_vma(&desc, vma->vm_file, vma);
+		ret = vma->vm_file->f_op->mmap_prepare(&desc);
+		/* private ramfs/romfs mappings fails with -ENOSYS so,
+		 * fall back to copied mapping.
+		 */
+		if (ret && ret != -ENOSYS)
+			goto error_mmap_prepare;
+
+		ret = __compat_vma_mmap(&desc, vma);
+		if (ret)
+			goto error_mmap_prepare;
+	}
+
+
 	down_write(&nommu_region_sem);
 
 	/* if we want to share, we need to check for regions created by other
@@ -1196,7 +1262,7 @@ unsigned long do_mmap(struct file *file,
 	add_nommu_region(region);
 
 	/* clear anonymous mappings that don't ask for uninitialized data */
-	if (vma_is_anonymous(vma) &&
+	if (is_file_anonymous(vma->vm_file) &&
 	    (!IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) ||
 	     !(flags & MAP_UNINITIALIZED)))
 		memset((void *)region->vm_start, 0,
@@ -1247,6 +1313,18 @@ unsigned long do_mmap(struct file *file,
 	ret = -EINVAL;
 	goto error;
 
+error_mmap_prepare:
+	if (region->vm_file)
+		fput(region->vm_file);
+	kmem_cache_free(vm_region_jar, region);
+	if (vma->vm_file)
+		fput(vma->vm_file);
+	vm_area_free(vma);
+
+	pr_warn("mmap_prepare failed for %lu byte allocation from process %d\n",
+			len, current->pid);
+	return ret;
+
 error_getting_vma:
 	kmem_cache_free(vm_region_jar, region);
 	pr_warn("Allocation of vma for %lu byte allocation from process %d failed\n",
-- 
2.43.0

