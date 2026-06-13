Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0B311968;
	Sat, 13 Jun 2026 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327400; cv=none; b=MTM4dZuy5mzmHcIYEe+1SIIuk0QwpeB5IC6ulKFOmk10C+b73F5rfDp4fRFW5VZyEoLktSfnpbrsIpYhBeJyMcxTs3/YlA1WR6BpDUK8XBySKrq0g9hSB+DejiBJ7P/gd4twEghwbiC1mDWhIx2OHhtkYZKtUmKNTaBDNky6rkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327400; c=relaxed/simple;
	bh=/78RXpgl8TlT0xU+DxO9fTkLja+qHCr4eJjakRnkz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olmk1vnedMm4yj0XujTHNzW4Mgl/DQkbW45Ym8Kq1lTUOoCYgmDkxbWwq5zknwweRqa7SMAp0v0OeSA2TKQd9kWbwAzyqq5x7YIDTEqrcDSAZiH5hwUoe5imNG3NmIozq0Vuvi2tcR9FZfI2o7reFA1HaKQ8hvcmR+/HBaBCSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aRvaNWfA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aRvaNWfA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=etwwk+UBNIMopirHMNGCuTJ8WFzK9o2sDlIbkCU/y/E=; b=aRvaNWfAS6g+gDAu0XKjGNB84n
	YQ7IMDvOKksVJWTEAv76k8pTrA4D156NGn11ZgheSAgqSLPwSDwCbGi5obQxZGjJXY9Jp4i9zZQLl
	ghTZNGVjsmvNK5OWdJlivo4zTyQc+8thOQhStor56IpK/fc5XKmWVE1JXbVhTsTYw59LuR5i5aQmj
	IBvRDL0FJVgoEToceNPxDPeUOgrw+bh2PrByHPYwRO+t/e4mD43ia4CKWtDtRFaAxx2X4oaGSTbU6
	zwWMtzUYp1gWNxy/Bv9IS29m1Ff9KfJ9AqniJw/eVfEVwhuZQl6CKOCK87xE48Cs+urvrpz3cEqhe
	ak9Ps3Vg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYGcx-00000003aSr-3soc;
	Sat, 13 Jun 2026 05:09:51 +0000
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
Subject: [RFC PATCH v3 01/10] static kmem_cache instances for core caches: infrastructure
Date: Sat, 13 Jun 2026 06:09:42 +0100
Message-ID: <20260613050951.855141-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613050951.855141-1-viro@zeniv.linux.org.uk>
References: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
 <20260613050951.855141-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

        kmem_cache_create() and friends create new instances of
struct kmem_cache and return pointers to those.  Quite a few things in
core kernel are allocated from such caches; each allocation involves
dereferencing an assign-once pointer and for sufficiently hot ones that
dereferencing does show in profiles.

        There had been patches floating around switching some of those
to runtime_const infrastructure.  Unfortunately, it's arch-specific
and most of the architectures lack it.

        There's an alternative approach applicable at least to the caches
that are never destroyed, which covers a lot of them.  No matter what,
runtime_const for pointers is not going to be faster than plain &,
so if we had struct kmem_cache instances with static storage duration, we
would be at least no worse off than we are with runtime_const variants.

        There are obstacles to doing that, but they turn out to be easy
to deal with.

	First of all, struct kmem_cache is opaque for anything outside
of a few files in mm/*; that avoids serious headache with header dependencies,
etc., and it's not something we want to lose.

	Solution: struct kmem_cache_opaque, with the size and alignment
identical to struct kmem_cache.  Calculation of size and alignment can be
done via the same mechanism we use for asm-offsets.h and rq-offsets.h,
with build-time check for mismatches.  With that done, we get an opaque type
defined in linux/slab-static.h that can be used for declaring those caches.
In linux/slab.h we add a forward declaration of kmem_cache_opaque +
helper (to_kmem_cache()) converting a pointer to kmem_cache_opaque
into the corresponding pointer to kmem_cache.

	At that point we can't actually *do* anything with those statically
allocated instances - the primitives for setting them up are going to be
added in the next commits.  Declarations of those primitives will also go
into linux/slab-static.h.

	Note that this header is needed only in places that define and
initialize statically allocated kmem_cache instances; users of such
instances need only slab.h.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Kbuild                      | 14 +++++++++++++-
 include/linux/slab-static.h | 13 +++++++++++++
 include/linux/slab.h        |  6 ++++++
 mm/kmem_cache_size.c        | 20 ++++++++++++++++++++
 mm/slub.c                   |  7 +++++++
 5 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/slab-static.h
 create mode 100644 mm/kmem_cache_size.c

diff --git a/Kbuild b/Kbuild
index a6a0192dea08..64f29f1f0e71 100644
--- a/Kbuild
+++ b/Kbuild
@@ -45,6 +45,17 @@ kernel/sched/rq-offsets.s: $(offsets-file)
 $(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
 	$(call filechk,offsets,__RQ_OFFSETS_H__)
 
+# generate kmem_cache_size.h
+
+kmem_cache_size-file := include/generated/kmem_cache_size.h
+
+targets += mm/kmem_cache_size.s
+
+mm/kmem_cache_size.s: $(rq-offsets-file)
+
+$(kmem_cache_size-file): mm/kmem_cache_size.s FORCE
+	$(call filechk,offsets,__KMEM_CACHE_SIZE_H__)
+
 # Check for missing system calls
 
 missing-syscalls-file := .tmp_missing-syscalls$(missing_syscalls_instance)
@@ -58,7 +69,8 @@ $(missing-syscalls-file): scripts/checksyscalls.sh $(rq-offsets-file) FORCE
 	$(call if_changed_dep,syscalls)
 
 PHONY += missing-syscalls
-missing-syscalls: $(missing-syscalls-file)
+missing-syscalls: $(missing-syscalls-file) $(kmem_cache_size-file)
+	$(call cmd,syscalls)
 
 # Check the manual modification of atomic headers
 
diff --git a/include/linux/slab-static.h b/include/linux/slab-static.h
new file mode 100644
index 000000000000..07aca67facee
--- /dev/null
+++ b/include/linux/slab-static.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SLAB_STATIC_H
+#define _LINUX_SLAB_STATIC_H
+
+#include <linux/init.h>
+#include <generated/kmem_cache_size.h>
+
+/* same size and alignment as struct kmem_cache: */
+struct kmem_cache_opaque {
+	unsigned char opaque[KMEM_CACHE_SIZE];
+} __aligned(KMEM_CACHE_ALIGN);
+
+#endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2b5ab488e96b..a43d31eec06c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -265,11 +265,17 @@ enum _slab_flag_bits {
 
 struct list_lru;
 struct mem_cgroup;
+struct kmem_cache_opaque;
 /*
  * struct kmem_cache related prototypes
  */
 bool slab_is_available(void);
 
+static inline struct kmem_cache *to_kmem_cache(struct kmem_cache_opaque *p)
+{
+	return (struct kmem_cache *)p;
+}
+
 /**
  * struct kmem_cache_args - Less common arguments for kmem_cache_create()
  *
diff --git a/mm/kmem_cache_size.c b/mm/kmem_cache_size.c
new file mode 100644
index 000000000000..1ddbfa41a507
--- /dev/null
+++ b/mm/kmem_cache_size.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generate definitions needed by the preprocessor.
+ * This code generates raw asm output which is post-processed
+ * to extract and format the required data.
+ */
+
+#define COMPILE_OFFSETS
+#include <linux/kbuild.h>
+#include "slab.h"
+
+int main(void)
+{
+	/* The constants to put into include/generated/kmem_cache_size.h */
+	DEFINE(KMEM_CACHE_SIZE, sizeof(struct kmem_cache));
+	DEFINE(KMEM_CACHE_ALIGN, __alignof(struct kmem_cache));
+	/* End of constants */
+
+	return 0;
+}
diff --git a/mm/slub.c b/mm/slub.c
index a2bf3756ca7d..c0765173911d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -50,6 +50,7 @@
 #include <linux/irq_work.h>
 #include <linux/kprobes.h>
 #include <linux/debugfs.h>
+#include <linux/slab-static.h>
 #include <trace/events/kmem.h>
 
 #include "internal.h"
@@ -8484,6 +8485,12 @@ void __init kmem_cache_init(void)
 		boot_kmem_cache_node;
 	int node;
 
+	/* verify that kmem_cache_opaque is correct */
+	BUILD_BUG_ON(sizeof(struct kmem_cache) !=
+		     sizeof(struct kmem_cache_opaque));
+	BUILD_BUG_ON(__alignof(struct kmem_cache) !=
+		     __alignof(struct kmem_cache_opaque));
+
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
 
-- 
2.47.3

