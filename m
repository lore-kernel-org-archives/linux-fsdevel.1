Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7B481651;
	Thu, 11 Jun 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198074; cv=none; b=on0SzlUBjl5ZzYbnI+1N5ZRWKoCq2ZM3rJzQ/pQeWgOa71etToN2wXBSAhdpTqYPGQumEFHRccS7X3VWqAaObLgdzFzkvjzvElNoKgopoo3LAhFz7MqEMIj56Nl/eOd52m3gIaFhSe/bADcP1nduKQ2zYRbmZ7/JSCLLWLNqTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198074; c=relaxed/simple;
	bh=I+P1GSTYST71v4epIndX0AfwO1/MVGjID9UU8+TRcI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBkwDaxUR3b7zrI2SlsDGfGWgv6L+5WgYtGy+4gxV6L7NhKE16f3Qb2ITdyVR4OC51KZN02RDgZ5z29GxcYlD0UGkfirUDVWFohkJ9aPXVHyizrOewIxqU1UxNHYzZ1K0KXjWk/hwQfbFL+5+9BI6noScxvk/t1z9Q8nkWr4k7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oBGxjT9C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oBGxjT9C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MxJht1/v+tMh9CkAooJgN+z3AWBrmdU8Oh7WKsy29Bw=; b=oBGxjT9CzjTGO3icATLcjH4W27
	OMCnPArujlVOXEqdjagI5lHfnFsDwf+4/GXk89SKh9+atRFb8BVjzBC55ljshrPY4MvZ7mccWLhvN
	cnrbQ0SC6NhPK/lf4H+nB7++DqxDQHflS9vPW1JtZK0SjY97ZKlID07Q2wj5IimmDQ0TV1puQSh3w
	EDHg5j4Q6yG5WXeHoSKRE5MVSAPEu01K164tATk4e2Pa61Ai5K6Fqi8jCWdEy0C9PUVNrMobAwp5i
	xt/i59Qe7k6avXXLBpQQNLdO0jp0nwWfB8vcPmeVUvRau7zD5LsUBsMIId+ELksn+UBSBxqHd+2Pl
	oEDrcvLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz3-000000070mE-3Pge;
	Thu, 11 Jun 2026 17:14:25 +0000
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
Subject: [PATCH v2 2/9] allow static-duration kmem_cache in modules
Date: Thu, 11 Jun 2026 18:14:17 +0100
Message-ID: <20260611171425.1671254-3-viro@zeniv.linux.org.uk>
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

	We need to make sure that instance in a module will get to
slab_kmem_cache_release() before the module data gets freed.  That's only
a problem on sysfs setups - otherwise it'll definitely be finished before
kmem_cache_destroy() returns.

	Note that modules themselves have sysfs-exposed attributes,
so a similar problem already exists there.  That's dealt with by
having mod_sysfs_teardown() wait for refcount of module->mkobj.kobj
reaching zero.  Let's make use of that - have static-duration-in-module
kmem_cache instances grab a reference to that kobject upon setup and
drop it in the end of slab_kmem_cache_release().

	Let setup helpers store the kobjetct to be pinned in
kmem_cache_args->owner (for preallocated; if somebody manually sets it
for non-preallocated case, it'll be ignored).  That would be
&THIS_MODULE->mkobj.kobj for a module and NULL in built-in.

	If sysfs is enabled and we are dealing with preallocated instance,
let create_cache() grab and stash that reference in kmem_cache->owner
and let slab_kmem_cache_release() drop it instead of freeing kmem_cache
instance.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/slab-static.h | 12 ++++++++----
 include/linux/slab.h        |  4 ++++
 mm/slab.h                   |  1 +
 mm/slab_common.c            | 25 ++++++++++++++++++++-----
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/slab-static.h b/include/linux/slab-static.h
index 47b2220b4988..16d1564b4a4b 100644
--- a/include/linux/slab-static.h
+++ b/include/linux/slab-static.h
@@ -2,10 +2,7 @@
 #ifndef _LINUX_SLAB_STATIC_H
 #define _LINUX_SLAB_STATIC_H
 
-#ifdef MODULE
-#error "can't use that in modules"
-#endif
-
+#include <linux/init.h>
 #include <generated/kmem_cache_size.h>
 
 /* same size and alignment as struct kmem_cache: */
@@ -13,9 +10,16 @@ struct kmem_cache_opaque {
 	unsigned char opaque[KMEM_CACHE_SIZE];
 } __aligned(KMEM_CACHE_ALIGN);
 
+#ifdef MODULE
+#define THIS_MODULE_KOBJ &THIS_MODULE->mkobj.kobj
+#else
+#define THIS_MODULE_KOBJ NULL
+#endif
+
 #define __KMEM_CACHE_SETUP(cache, name, size, flags, ...)	\
 		__kmem_cache_create_args((name), (size),	\
 			&(struct kmem_cache_args) {		\
+				.owner = THIS_MODULE_KOBJ,	\
 				.preallocated = (cache),	\
 				__VA_ARGS__}, (flags))
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index f63657d3cf81..c95ad771ece2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -62,6 +62,7 @@ enum _slab_flag_bits {
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
 	_SLAB_OBJ_EXT_IN_OBJ,
 #endif
+	_SLAB_PREALLOCATED,
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -248,6 +249,8 @@ enum _slab_flag_bits {
 #define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
 #endif
 
+#define SLAB_PREALLOCATED	__SLAB_FLAG_BIT(_SLAB_PREALLOCATED)
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
@@ -379,6 +382,7 @@ struct kmem_cache_args {
 	 */
 	unsigned int sheaf_capacity;
 	struct kmem_cache *preallocated;
+	struct kobject *owner;
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
diff --git a/mm/slab.h b/mm/slab.h
index bf2f87acf5e3..8b1db0d03226 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -219,6 +219,7 @@ struct kmem_cache {
 	struct list_head list;		/* List of slab caches */
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;		/* For sysfs */
+	struct kobject *owner;		/* keep that pinned while alive */
 #endif
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	unsigned long random;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 57de41c7f1aa..2567c1c19847 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -182,13 +182,10 @@ bool slab_args_unmergeable(struct kmem_cache_args *args, slab_flags_t flags)
 	if (args->ctor)
 		return true;
 
-	if (args->preallocated)
-		return true;
-
 	if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
 		return true;
 
-	if (flags & SLAB_NEVER_MERGE)
+	if (flags & (SLAB_PREALLOCATED | SLAB_NEVER_MERGE))
 		return true;
 
 	return false;
@@ -258,6 +255,12 @@ static struct kmem_cache *create_cache(const char *name,
 			kmem_cache_free(kmem_cache, s);
 		return ERR_PTR(err);
 	}
+#ifdef CONFIG_SYSFS
+	if (flags & SLAB_PREALLOCATED) {
+		s->owner = args->owner;
+		kobject_get(s->owner);
+	}
+#endif
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
 	return s;
@@ -366,6 +369,12 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
+	if (args->preallocated) {
+		flags |= SLAB_PREALLOCATED;
+		if (args->owner)
+			flags |= SLAB_NO_MERGE;
+	}
+
 	s = __kmem_cache_alias(name, object_size, flags, args);
 	if (s)
 		goto out_unlock;
@@ -521,7 +530,13 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
 	kfree_const(s->name);
-	kmem_cache_free(kmem_cache, s);
+	if (!(s->flags & SLAB_PREALLOCATED)) {
+		kmem_cache_free(kmem_cache, s);
+		return;
+	}
+#ifdef CONFIG_SYSFS
+	kobject_put(s->owner);
+#endif
 }
 
 void kmem_cache_destroy(struct kmem_cache *s)
-- 
2.47.3

