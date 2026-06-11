Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601883FADED;
	Thu, 11 Jun 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198071; cv=none; b=PnNT8l3ltvnjYC+QDwOsHzv13IB2Dko7qVhkH7TbiVsihT8yxiUkrOtIMPMzrWAZW9Tp8bLYE+Rl/wUnm9oqsnuKq4oYB41CeARyppVGPzkXIQufFVQMq37b/UWegubOYMKvusqqYgRQpOpob06MBifNdnSYh2+8u7CZJ1ycqXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198071; c=relaxed/simple;
	bh=UF2qSRY+IuRHzZU7OoQIc1QZzkeH1ip6bx9g1sIY4kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/R+PbubtwTRZQ2cMMigeQpCwp1sQOfQ/e/fv/v2/fKSveCMJ1FY/wcu5TzQswkhvuEKWWURo66ypzEDfmYT7IkIFcczXAKXsC1t8JIlU6qijrbCUHEs8mJurTqrgCzxOVP0/SZoYmxJsHEgtOURIieLR/pLXNTDg4B72cAldd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oe1NSfZ3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oe1NSfZ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PgiBt+cXBNmLBpECoGiXITUCwoLXcLuCPMDzB/akGTA=; b=oe1NSfZ3c+G4ykkyxz2q+gOtZc
	vb/b/uKDXQgCp0dGzusCJoNwZgPAvMdA6+W9CnUC2vTANwymVYxEikEDm0E7NWESmqd7U1zHNRIJt
	WEnFxbN4JAxpYxZPq4LqJyBWI7Py51m0JBZU3/obNvVx9QokJwHen0fd1Tkx/RX4PQFnFXF2vlX6+
	iuYed1t8EdabPHm93Am5IUmHZOOI7zJsMLhRTltgoa1GSF11TztSdTVUYCzoDb8mi+ENSaInlz2Pz
	jLSx8LWhX4/nK5zH619TKsnEL+LZG8BmcSLVsRYFLzLsalwXps9281pF/YhLN/v/qidNlQji87Emu
	n//s+QpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz4-000000070nH-2ftQ;
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
Subject: [PATCH v2 8/9] make thread component caches (fs_cachep, files_cachep, etc.) statically allocated
Date: Thu, 11 Jun 2026 18:14:23 +0100
Message-ID: <20260611171425.1671254-9-viro@zeniv.linux.org.uk>
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

All of them are created in kernel/fork.c, might as well convert all
at once...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/fdtable.h   |  3 ++-
 include/linux/fs_struct.h |  3 ++-
 include/linux/signal.h    |  3 ++-
 kernel/fork.c             | 37 +++++++++++++++++++++----------------
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..f2d553f99c58 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -113,6 +113,7 @@ int iterate_fd(struct files_struct *, unsigned,
 extern int close_fd(unsigned int fd);
 extern struct file *file_close_fd(unsigned int fd);
 
-extern struct kmem_cache *files_cachep;
+extern struct kmem_cache_opaque files_cache;
+#define files_cachep to_kmem_cache(&files_cache)
 
 #endif /* __LINUX_FDTABLE_H */
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..e8c9fac5b7b7 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -15,7 +15,8 @@ struct fs_struct {
 	struct path root, pwd;
 } __randomize_layout;
 
-extern struct kmem_cache *fs_cachep;
+extern struct kmem_cache_opaque fs_struct_cache;
+#define fs_cachep to_kmem_cache(&fs_struct_cache)
 
 extern void exit_fs(struct task_struct *);
 extern void set_fs_root(struct fs_struct *, const struct path *);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index f19816832f05..a0c7fee8b22a 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -323,7 +323,8 @@ static inline void disallow_signal(int sig)
 	kernel_sigaction(sig, SIG_IGN);
 }
 
-extern struct kmem_cache *sighand_cachep;
+extern struct kmem_cache_opaque sighand_cache;
+#define sighand_cachep to_kmem_cache(&sighand_cache)
 
 extern bool unhandled_signal(struct task_struct *tsk, int sig);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 8ac38beae360..618f19bb482a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -111,6 +111,7 @@
 #include <linux/unwind_deferred.h>
 #include <linux/pgalloc.h>
 #include <linux/uaccess.h>
+#include <linux/slab-static.h>
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -180,7 +181,8 @@ void __weak arch_release_task_struct(struct task_struct *tsk)
 {
 }
 
-static struct kmem_cache *task_struct_cachep;
+static struct kmem_cache_opaque task_struct_cache;
+#define task_struct_cachep to_kmem_cache(&task_struct_cache)
 
 static inline struct task_struct *alloc_task_struct_node(int node)
 {
@@ -425,7 +427,8 @@ static void free_thread_stack(struct task_struct *tsk)
 
 #else /* !(THREAD_SIZE >= PAGE_SIZE) */
 
-static struct kmem_cache *thread_stack_cache;
+static struct kmem_cache_opaque __thread_stack_cache;
+#define thread_stack_cache to_kmem_cache(&__thread_stack_cache)
 
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
@@ -456,29 +459,31 @@ static void free_thread_stack(struct task_struct *tsk)
 
 void thread_stack_cache_init(void)
 {
-	thread_stack_cache = kmem_cache_create_usercopy("thread_stack",
-					THREAD_SIZE, THREAD_SIZE, 0, 0,
+	kmem_cache_setup_usercopy(thread_stack_cache, "thread_stack",
+					THREAD_SIZE, THREAD_SIZE,
+					SLAB_PANIC, 0,
 					THREAD_SIZE, NULL);
-	BUG_ON(thread_stack_cache == NULL);
 }
 
 #endif /* THREAD_SIZE >= PAGE_SIZE */
 #endif /* CONFIG_VMAP_STACK */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
-static struct kmem_cache *signal_cachep;
+static struct kmem_cache_opaque signal_cache;
+#define signal_cachep to_kmem_cache(&signal_cache)
 
 /* SLAB cache for sighand_struct structures (tsk->sighand) */
-struct kmem_cache *sighand_cachep;
+struct kmem_cache_opaque sighand_cache;
 
 /* SLAB cache for files_struct structures (tsk->files) */
-struct kmem_cache *files_cachep;
+struct kmem_cache_opaque files_cache;
 
 /* SLAB cache for fs_struct structures (tsk->fs) */
-struct kmem_cache *fs_cachep;
+struct kmem_cache_opaque fs_struct_cache;
 
 /* SLAB cache for mm_struct structures (tsk->mm) */
-static struct kmem_cache *mm_cachep;
+static struct kmem_cache_opaque mm_cache;
+#define mm_cachep to_kmem_cache(&mm_cache)
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
@@ -859,7 +864,7 @@ void __init fork_init(void)
 
 	/* create a slab on which task_structs can be allocated */
 	task_struct_whitelist(&useroffset, &usersize);
-	task_struct_cachep = kmem_cache_create_usercopy("task_struct",
+	kmem_cache_setup_usercopy(task_struct_cachep, "task_struct",
 			arch_task_struct_size, align,
 			SLAB_PANIC|SLAB_ACCOUNT,
 			useroffset, usersize, NULL);
@@ -3079,7 +3084,7 @@ void __init mm_cache_init(void)
 	 */
 	mm_size = sizeof(struct mm_struct) + cpumask_size() + mm_cid_size();
 
-	mm_cachep = kmem_cache_create_usercopy("mm_struct",
+	kmem_cache_setup_usercopy(mm_cachep, "mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			offsetof(struct mm_struct, saved_auxv),
@@ -3089,19 +3094,19 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
-	sighand_cachep = kmem_cache_create("sighand_cache",
+	kmem_cache_setup(sighand_cachep, "sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
 			SLAB_ACCOUNT, sighand_ctor);
-	signal_cachep = kmem_cache_create("signal_cache",
+	kmem_cache_setup(signal_cachep, "signal_cache",
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	files_cachep = kmem_cache_create("files_cache",
+	kmem_cache_setup(files_cachep, "files_cache",
 			sizeof(struct files_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	fs_cachep = kmem_cache_create("fs_cache",
+	kmem_cache_setup(fs_cachep, "fs_cache",
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-- 
2.47.3

