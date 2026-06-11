Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFA481221;
	Thu, 11 Jun 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198072; cv=none; b=eFjblzPMwLT1l3EH07vJPRBsUK8RcFUkQn04P9E7WgzTgNfdvRiOeVjJEoyO2KujbBVYVVgbCOWT9iRKybflnX0+0I/vCF7T3NuOFnCwviyZsKDgmZEm84uAFeS6Dpmy+wzjnsUPo1lhQNoua3uNeJNjVobgQJRSzb3YUoMYYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198072; c=relaxed/simple;
	bh=fsq7sYqNrg5Xchh2jP1OCYf6iS0uwe7D1hh5mBFcLLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cxq0TY/uLVfKB883nu4acYmn+eaJqVhbU8KjnmZ7RKfXkC04rPIFLg6Bgpfqzy2P8556E3+xtRg9/1Q1c6Yue0CDXO5AToAO97xBu/9TEGd5pstLKmPNhpTJcM13Hk6GepkTOjU/CzRyK3wQwlhiOhh9p0owDhgZ2fPuBOMEMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NqLwRLOx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NqLwRLOx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EzvbF5HTZw8rtZp2UxE62P6k3wtQyEZGIlI0Ut85+es=; b=NqLwRLOxhwYJ0kIixBfbUirfJr
	sTruhEldRI+Yf6DCAgRIC+AiJfB1T6znrDA4dWSQL1VgMyZGhXxmTRHLKEBrMdvi4nsleJoD7fzlN
	HDVc4Ze/L3emjA094R1oypOH/EFuAqvw5Cr7ZmRDd4tSodz+p/L35qr5jsqEVIS3Hb4XhgD2BGHpo
	Kp7gYA0I8qN2UEqnFnMDTlMFeiCrnWKNNa7p/FdRnB36deUUTADxiPPfXPjIBQbxkQZqLT7Zy76fE
	Zi/KZiX0qhJ3CUP/MANUGajgOEO7E2lQfFNeyWAg9ysazZ+mC3qhx8dVCg11ey3Ow7uLlXTSFlEh5
	ybONb8LQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz4-000000070mL-06vw;
	Thu, 11 Jun 2026 17:14:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] VFS caches: switch from runtime_const() machinery to slab-static.h
Date: Thu, 11 Jun 2026 18:14:18 +0100
Message-ID: <20260611171425.1671254-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
References: <20260611171309.GN2636677@ZenIV>
 <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Four VFS caches are currently playing games with runtime_const() to
reduce the overhead of pointer traversals - dentry, file, backing_file
and filename.  All of these kmem_cache instances can be allocated
statically now, getting rid of runtime_const() games.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c                       |  8 +++----
 fs/file_table.c                   | 40 ++++++++++++++-----------------
 fs/namei.c                        | 16 ++++++-------
 include/asm-generic/vmlinux.lds.h |  6 +----
 4 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2c61aeea41f4..e2feea82682a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/slab-static.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -86,8 +87,8 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
 
-static struct kmem_cache *__dentry_cache __ro_after_init;
-#define dentry_cache runtime_const_ptr(__dentry_cache)
+static struct kmem_cache_opaque __dentry_cache;
+#define dentry_cache to_kmem_cache(&__dentry_cache)
 
 const struct qstr empty_name = QSTR_INIT("", 0);
 EXPORT_SYMBOL(empty_name);
@@ -3362,10 +3363,9 @@ static void __init dcache_init(void)
 	 * but it is probably not worth it because of the cache nature
 	 * of the dcache.
 	 */
-	__dentry_cache = KMEM_CACHE_USERCOPY(dentry,
+	KMEM_CACHE_SETUP_USERCOPY(dentry_cache, dentry,
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_shortname.string);
-	runtime_const_init(ptr, __dentry_cache);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/fs/file_table.c b/fs/file_table.c
index 16e52e7fc2ac..3844bc9f0e0a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -27,11 +27,10 @@
 #include <linux/task_work.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
+#include <linux/slab-static.h>
 
 #include <linux/atomic.h>
 
-#include <asm/runtime-const.h>
-
 #include "internal.h"
 
 /* sysctl tunables... */
@@ -40,10 +39,10 @@ static struct files_stat_struct files_stat = {
 };
 
 /* SLAB cache for file structures */
-static struct kmem_cache *__filp_cache __ro_after_init;
-#define filp_cache runtime_const_ptr(__filp_cache)
-static struct kmem_cache *__bfilp_cache __ro_after_init;
-#define bfilp_cache runtime_const_ptr(__bfilp_cache)
+static struct kmem_cache_opaque file_cache;
+static struct kmem_cache_opaque backing_file_cache;
+#define filp_cache to_kmem_cache(&file_cache)
+#define bfilp_cache to_kmem_cache(&backing_file_cache)
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
@@ -629,22 +628,19 @@ void fput_close(struct file *file)
 
 void __init files_init(void)
 {
-	struct kmem_cache_args args = {
-		.use_freeptr_offset = true,
-		.freeptr_offset = offsetof(struct file, f_freeptr),
-	};
-
-	__filp_cache = kmem_cache_create("filp", sizeof(struct file), &args,
-				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
-	runtime_const_init(ptr, __filp_cache);
-
-	args.freeptr_offset = offsetof(struct backing_file, bf_freeptr);
-	__bfilp_cache = kmem_cache_create("bfilp", sizeof(struct backing_file),
-				&args, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
-	runtime_const_init(ptr, __bfilp_cache);
-
+	__KMEM_CACHE_SETUP(filp_cache, "filp", sizeof(struct file),
+			   SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+			   SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
+			   .use_freeptr_offset = true,
+			   .freeptr_offset = offsetof(struct file,
+						      f_freeptr));
+
+	__KMEM_CACHE_SETUP(bfilp_cache, "bfilp", sizeof(struct backing_file),
+			   SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+			   SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
+			   .use_freeptr_offset = true,
+			   .freeptr_offset = offsetof(struct backing_file,
+						      bf_freeptr));
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..7dd7edfa3a02 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -40,8 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
-
-#include <asm/runtime-const.h>
+#include <linux/slab-static.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -126,15 +125,16 @@
  */
 
 /* SLAB cache for struct filename instances */
-static struct kmem_cache *__names_cache __ro_after_init;
-#define names_cache	runtime_const_ptr(__names_cache)
+static struct kmem_cache_opaque __names_cache;
+#define names_cache	to_kmem_cache(&__names_cache)
 
 void __init filename_init(void)
 {
-	__names_cache = kmem_cache_create_usercopy("names_cache", sizeof(struct filename), 0,
-			 SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct filename, iname),
-			 EMBEDDED_NAME_MAX, NULL);
-	runtime_const_init(ptr, __names_cache);
+	kmem_cache_setup_usercopy(names_cache, "names_cache",
+				  sizeof(struct filename), 0,
+				  SLAB_HWCACHE_ALIGN|SLAB_PANIC,
+				  offsetof(struct filename, iname),
+				  EMBEDDED_NAME_MAX, NULL);
 }
 
 static inline struct filename *alloc_filename(void)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e4..4719269086c7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -966,11 +966,7 @@
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)			\
-		RUNTIME_CONST(ptr, __dentry_cache)			\
-		RUNTIME_CONST(ptr, __names_cache)			\
-		RUNTIME_CONST(ptr, __filp_cache)			\
-		RUNTIME_CONST(ptr, __bfilp_cache)
+		RUNTIME_CONST(ptr, dentry_hashtable)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-- 
2.47.3

