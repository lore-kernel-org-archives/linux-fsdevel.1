Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF2369D56;
	Sat, 13 Jun 2026 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327401; cv=none; b=jjv1AURYfCOz7O+b+aOM/FFLNhApoqJLt/oR1MWX/xPTFJVg+pGRhgTYrxAE+4JSVJBK02EOqxKiFOxgxoiimcgvThSbQrdRnd775ztIUbHYfdHZ+KonV1Efq4NOjRJ92gp1DqOb/iTbiq1odF4T4JoVpThjAEJxkk7IV0W1CVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327401; c=relaxed/simple;
	bh=t2ustfZJko2VxR4EK6aBYqubTS+D9clSCtcK+yIT57c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7ZmmwBy0YoBIsNGAGdsLR4SOeFApCR23KfPk/BaF+Z4X5nyerq1oCPSfOp4WKfRKvXcg44aHJlcIK95UKvIar2ExKPeQUnMspMBUd9SYvXmR+BW0Fx095WGMyMJ5nl9s/5T1PmV5tzRETWaDov+lwQuV4SbRWZoOjhJwNkDCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r2gupMby; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r2gupMby"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v5eFW2g7W1dcJNtE4gdFektrsMjBmaMLK4+5JsIr98U=; b=r2gupMbySKmfWqHfZq5g0R3ZS2
	7W+4ibTEhfYBwKj2I+ajAicV076fh4vivRZ+uZEH6YvFWmJZSjlu7DaV7W8C1RaSYia07QdF0zdYj
	kLsgFib+h3Z67aodCxRYuO6EeZFXAwccbKa5jjt/1BnzCRTRO521+zppM73EuzLBJjATpifJl1GVZ
	msdUMEIffQxNn8EcSjWY0VKAdaOpmo6Hiq+nxpKdc4e7d9aaZ3bmPvs8qE7CgQT79fGvupEzevxH8
	oa2oae8BiJBuPf87hdGwp4HBHYYgIRQrOklBS39V///Q9ETpfA3DwUoTrE8eMdgzII1wAQTOFVJkq
	2yrgLPmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYGcy-00000003aT0-1Lre;
	Sat, 13 Jun 2026 05:09:52 +0000
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
Subject: [RFC PATCH v3 03/10] allow preallocated kmem_cache instances in modules
Date: Sat, 13 Jun 2026 06:09:44 +0100
Message-ID: <20260613050951.855141-4-viro@zeniv.linux.org.uk>
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

	Let setup helpers store the kobject to be pinned in
kmem_cache_args->owner (for preallocated; if somebody manually sets it
for non-preallocated case, it'll be ignored).  That would be
&THIS_MODULE->mkobj.kobj for a module and NULL in built-in.

	If sysfs is enabled and we are dealing with preallocated instance,
let create_cache() grab and stash that reference in kmem_cache->owner
and let slab_kmem_cache_release() drop it instead of freeing kmem_cache
instance.

	Preallocated kmem_cache instances in modules are forcibly made
non-mergable - any subsequent alias could outlive the module (and module's
.data) by arbitrary long time.  If you really want your (modular) cache
to be mergable, just have it dynamically allocated.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/slab-static.h | 11 +++++++----
 include/linux/slab.h        |  1 +
 mm/slab.h                   |  1 +
 mm/slab_common.c            | 19 +++++++++++++++++--
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab-static.h b/include/linux/slab-static.h
index 007fc0bd4e8c..16d1564b4a4b 100644
--- a/include/linux/slab-static.h
+++ b/include/linux/slab-static.h
@@ -5,18 +5,21 @@
 #include <linux/init.h>
 #include <generated/kmem_cache_size.h>
 
-#ifdef MODULE
-#error "can't use that in modules"
-#endif
-
 /* same size and alignment as struct kmem_cache: */
 struct kmem_cache_opaque {
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
index ec68aabf98df..c95ad771ece2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -382,6 +382,7 @@ struct kmem_cache_args {
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
index 5b6aaa96d68d..1717c79d92be 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -255,6 +255,12 @@ static struct kmem_cache *create_cache(const char *name,
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
@@ -366,8 +372,11 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
-	if (args->preallocated)
+	if (args->preallocated) {
 		flags |= SLAB_PREALLOCATED;
+		if (args->owner)
+			flags |= SLAB_NO_MERGE;
+	}
 
 	s = __kmem_cache_alias(name, object_size, flags, args);
 	if (s)
@@ -524,7 +533,13 @@ void slab_kmem_cache_release(struct kmem_cache *s)
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

