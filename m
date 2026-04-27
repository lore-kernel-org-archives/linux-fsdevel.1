Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8D37E2FF;
	Mon, 27 Apr 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288202; cv=none; b=cE5j3gvPoQN1GB17vbqbZWNBOidlSRHnfqnwGBnfnbjwBU/Ey+jLcQ7t1bOzyCC6XuacT7h8w7aEldhMkqpBSZYBAjvWvubWNidQANou/5aWcL93HJlLVY5fRVu0ylCsvLFKhntnYBxdMkXdRlnhEgVBIDGPE6hcm9vHf2VAZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288202; c=relaxed/simple;
	bh=8fXXEDM6Q9Zfo6VHrdcBAM1RHmR921QpzOhVVp2pVW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EmQ69W4EyeUKf2ztfPyWnHFqFKb1c7pmrARh0a04N8eFhZ3zBBxy+h0QEnYZYzuMHWEFLV+ECO0ZGOP3FhoehMJWqWy5V7P7sVucGy4Tw1dAhc1B6Dj7AiYxseSQr+FgX2hG1dNAdVoOwllNEcKb0GBCO7duy4EAZfqvTUPT6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Ockymm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Ockymm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F0C19425;
	Mon, 27 Apr 2026 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777288202;
	bh=8fXXEDM6Q9Zfo6VHrdcBAM1RHmR921QpzOhVVp2pVW4=;
	h=From:Date:Subject:To:Cc:From;
	b=c+OckymmgeKcN9Sb81TLpfXxrm6YvyH+TRG2IgKkVb9vpALpk/v5EGUd3lDp7Sljn
	 R8wVg7+VRhno4SAnq2PRnMETBPjZCAyn2Jg7nl98oQ0lkDWtIVXUMKrwpk9obHPZgk
	 XsFUnbblHehRF8p5D/zaNojIJ5GVK+MJGu1/VYoaMnXpfn0VEfpA7kmHd/y5XoP2GN
	 U+U8fTSqeh0ssdREvs9lbeiVGUZBCbq2W3x9oDWOM9Fb/4YVynmwYp0JibSALMtqQP
	 uQ8n2KUyCTKGe56oyGGYJDCQs0yAARTTml+PxZ3q4NrIOVQsRgSvIb43CyseeeddsS
	 WYxfScfJyJmtw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 27 Apr 2026 13:09:57 +0200
Subject: [PATCH] rhashtable: give each instance its own lockdep class
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAARE72kC/yWMyw6CMBBFf4V0bc3Q2hb8FeNipgy2gkBafCSEf
 xd0eW7uOYvInCJncS4WkfgVcxyHDcpDIXzA4cYyNhsLBcrCSTn5HlMnU8AcZqSeZT/6ruFJegJ
 trLYOnBabPSVu4+dXvlz/nJ90Zz/vuf1BmFlSwsGHfXpgnjkdraktgiIFrqos1wxABKUtvWsbU
 7eMRnuoSrGuX+GPjzO9AAAA
X-Change-ID: 20260427-work-rhashtable-lockdep-cb0356367073
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 David Hildenbrand <david@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, 
 syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5833; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8fXXEDM6Q9Zfo6VHrdcBAM1RHmR921QpzOhVVp2pVW4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+d2E3Mj2+ZOdfVbvPmUeTNnZaJS/TNp3o4V21tfuN1
 5qD8u93dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkdzMjw9vqn+v2vl13fsNk
 rc7vf1WbCqubX91l0lzSpcKwnb/1aCXDX4EStRn+R5ZtCdph8v+LyJ0P7ot2f7VvU/B1SNlq9fb
 nbGYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

syzbot reported a possible circular locking dependency between
&ht->mutex and fs_reclaim:

  CPU0 (kswapd0)                    CPU1 (kworker)
  --------------                    --------------
  fs_reclaim                        ht->mutex
    shmem_evict_inode                 rhashtable_rehash_alloc
      simple_xattrs_free                bucket_table_alloc(GFP_KERNEL)
        rhashtable_free_and_destroy       __kvmalloc_node
          mutex_lock(&ht->mutex)            might_alloc -> fs_reclaim

The two halves of the splat refer to two different events on
&ht->mutex.

The kswapd0 path is unambiguous: shmem_evict_inode at mm/shmem.c:1429
calls simple_xattrs_free(), which calls rhashtable_free_and_destroy()
on the per-inode simple_xattrs rhashtable being torn down with the
inode.

The previously-recorded ht->mutex -> fs_reclaim edge comes from
rht_deferred_worker -> rhashtable_rehash_alloc ->
bucket_table_alloc(GFP_KERNEL) -> __kvmalloc_node ->
might_alloc -> fs_reclaim. That stack stops at generic library code:
there is no subsystem-specific frame above rht_deferred_worker, so
the splat does not identify which rhashtable's worker recorded the
edge -- only that some rhashtable in the system did.

Whether or not that recording happened on the same simple_xattrs ht
that is now being destroyed, the predicted deadlock cannot occur:
rhashtable_free_and_destroy() does cancel_work_sync(&ht->run_work)
before taking ht->mutex, so the deferred worker cannot be running on
the instance being torn down. If the recording was on a different
rhashtable instance, the two ht->mutex acquisitions are on distinct
mutex objects and cannot deadlock either.

Lockdep flags a cycle regardless because mutex_init(&ht->mutex) lives
on a single source line in rhashtable_init_noprof(), so every
ht->mutex in the kernel shares one static lockdep class. Lockdep
matches by class, not by instance, and collapses all of these into
one node.

Lift the lockdep key out of rhashtable_init_noprof() and into the
caller. The user-visible rhashtable_init_noprof() /
rhltable_init_noprof() identifiers become macros that declare a
per-call-site static lock_class_key.

Reported-by: syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/69e798fe.050a0220.24bfd3.0032.GAE@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/rhashtable-types.h | 22 ++++++++++++++++++----
 lib/rhashtable.c                 | 17 ++++++++++-------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 015c8298bebc..841021c67d3d 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -131,12 +131,26 @@ struct rhashtable_iter {
 	bool end_of_table;
 };
 
-int rhashtable_init_noprof(struct rhashtable *ht,
-		    const struct rhashtable_params *params);
+int __rhashtable_init_noprof(struct rhashtable *ht,
+		    const struct rhashtable_params *params,
+		    struct lock_class_key *key);
+#define rhashtable_init_noprof(ht, params)				\
+({									\
+	static struct lock_class_key __key;				\
+									\
+	__rhashtable_init_noprof(ht, params, &__key);			\
+})
 #define rhashtable_init(...)	alloc_hooks(rhashtable_init_noprof(__VA_ARGS__))
 
-int rhltable_init_noprof(struct rhltable *hlt,
-		  const struct rhashtable_params *params);
+int __rhltable_init_noprof(struct rhltable *hlt,
+		  const struct rhashtable_params *params,
+		  struct lock_class_key *key);
+#define rhltable_init_noprof(hlt, params)				\
+({									\
+	static struct lock_class_key __key;				\
+									\
+	__rhltable_init_noprof(hlt, params, &__key);			\
+})
 #define rhltable_init(...)	alloc_hooks(rhltable_init_noprof(__VA_ARGS__))
 
 #endif /* _LINUX_RHASHTABLE_TYPES_H */
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6074ed5f66f3..fb13749d824a 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1025,8 +1025,9 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
  *	.obj_hashfn = my_hash_fn,
  * };
  */
-int rhashtable_init_noprof(struct rhashtable *ht,
-		    const struct rhashtable_params *params)
+int __rhashtable_init_noprof(struct rhashtable *ht,
+		    const struct rhashtable_params *params,
+		    struct lock_class_key *key)
 {
 	struct bucket_table *tbl;
 	size_t size;
@@ -1036,7 +1037,7 @@ int rhashtable_init_noprof(struct rhashtable *ht,
 		return -EINVAL;
 
 	memset(ht, 0, sizeof(*ht));
-	mutex_init(&ht->mutex);
+	mutex_init_with_key(&ht->mutex, key);
 	spin_lock_init(&ht->lock);
 	memcpy(&ht->p, params, sizeof(*params));
 
@@ -1087,7 +1088,7 @@ int rhashtable_init_noprof(struct rhashtable *ht,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
+EXPORT_SYMBOL_GPL(__rhashtable_init_noprof);
 
 /**
  * rhltable_init - initialize a new hash list table
@@ -1098,15 +1099,17 @@ EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
  *
  * See documentation for rhashtable_init.
  */
-int rhltable_init_noprof(struct rhltable *hlt, const struct rhashtable_params *params)
+int __rhltable_init_noprof(struct rhltable *hlt,
+			   const struct rhashtable_params *params,
+			   struct lock_class_key *key)
 {
 	int err;
 
-	err = rhashtable_init_noprof(&hlt->ht, params);
+	err = __rhashtable_init_noprof(&hlt->ht, params, key);
 	hlt->ht.rhlist = true;
 	return err;
 }
-EXPORT_SYMBOL_GPL(rhltable_init_noprof);
+EXPORT_SYMBOL_GPL(__rhltable_init_noprof);
 
 static void rhashtable_free_one(struct rhashtable *ht, struct rhash_head *obj,
 				void (*free_fn)(void *ptr, void *arg),

---
base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
change-id: 20260427-work-rhashtable-lockdep-cb0356367073

