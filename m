Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2547F3D6;
	Fri, 11 Sep 2026 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131571; cv=none; b=RNX3mZQyy+JWceHPvNAxAaa8YmNu+IEyEPspaw8gWhqAATE+N0sTGJPbfwPvL1rkoG9hUbamr1qz+sGFnO5StYPWKVx9NFsfhoh8bN2xCMCkC3pFBx77v1dWMN9pPuYrKgtw4L9okUnbZwmd+yqdqdyM2lcPdzueiNIdy8bpvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131571; c=relaxed/simple;
	bh=xEn+1KmHvgwcvwLDp55o8qGNQ+pzBN9FzuJ9r3Qg5hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwCMLOQ1thuES7ZUrOW+gsUqSRg0fvwJy5M+2aPlpJ1ncyNE+iW7Qr2iybKaNe3i2sTZESMFyTFw+QF0YdgUQk+2sUcpLf+7UwQArWALTb6y8XXgfsD1Q3Zd769yrCaSY+1Nh2uIdpvfSPoPCJF6f6DibkehWYxuFxsp5g4chqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5xKRBZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5xKRBZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6E91F00893;
	Fri, 11 Sep 2026 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131551;
	bh=NYCIHeh5DhnGPPEq065Nh6RT+JRkS3Mi9MtQkuCoF4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T5xKRBZWn66moZ2pVyq6ejSQ80jnfylmmKq1j4YBdyagKAmZBtCQJLZYIz3S3AfYL
	 7FBkwPzt2i/TmOSikWEEyabKrYn8GsivwT2FidhhSHayABbDG4e5S0KHnBJx+zvfvV
	 ZVGYURqrfGRCfE+sBFOTS6SbxgGYOSajeCoVBNBB6ECCuspFdOTHvAXEvqaghSy6Wt
	 xAEvv7VUKYAhX/gdHxdo/KiDIbRZ3z0LdlUDxVulYIgxozrKDEcOLcTwP7CvZT8KOA
	 URieKVixaHE7m1STnwjpVnnkoHgtfvvhnZa4W4rGvF6HxUX/enN5taCmNsjdBKFmvu
	 htQ8+szXEFaaA==
From: Christian Brauner <brauner@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	kernel test robot <lkp@intel.com>,
	codemender-patching+linux@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/2] userns: rename insert_extent() and sort_idmaps()
Date: Fri, 11 Sep 2026 14:58:39 +0200
Message-ID: <20260911-suggerieren-suchaktion-fliehen-87b9cdf1d169@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5478; i=brauner@kernel.org; h=from:subject:message-id; bh=xEn+1KmHvgwcvwLDp55o8qGNQ+pzBN9FzuJ9r3Qg5hs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQt/s2q2jzp2zubs5pa06eFCd4XkrdN0Wb9WSxka+Xx7 6+K6RzejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4KDP897/NsSNdosc0cctC 9yNWxbaVEnO/PbFpZA3+JCXjc06/lJFhzeENh27Xet4L79xq/G15wL4pmvN3S9tZVtefODkj4fw xDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The KUnit test suite turned insert_extent() and sort_idmaps() into global
symbols and declared them in include/linux/user_namespace.h. That header
is pulled in nearly everywhere through linux/cgroup.h and the btrfs
self-tests carry a static insert_extent() of their own, so any config
with both test suites enabled fails to build:

  fs/btrfs/tests/inode-tests.c:16:13: error: conflicting types for 'insert_extent'
  include/linux/user_namespace.h:212:12: note: previous declaration of 'insert_extent'

A global symbol needs a prefix. Rename them to
uid_gid_map_insert_extent() and uid_gid_map_sort(). It's the better name
anyway.

No functional changes.

Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609110843.okbPe7GM-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609110937.zHKPPXJk-lkp@intel.com/
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/user_namespace.h   |  5 +++--
 kernel/tests/user_ns_map_kunit.c |  6 +++---
 kernel/user_namespace.c          | 19 ++++++++++---------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 633157781edc..637cd7e91a45 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -209,8 +209,9 @@ extern bool current_in_userns(const struct user_namespace *target_ns);
 struct ns_common *ns_get_owner(struct ns_common *ns);
 
 #if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
-extern int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent);
-extern int sort_idmaps(struct uid_gid_map *map);
+extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
+				     struct uid_gid_extent *extent);
+extern int uid_gid_map_sort(struct uid_gid_map *map);
 #endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
 
 #else
diff --git a/kernel/tests/user_ns_map_kunit.c b/kernel/tests/user_ns_map_kunit.c
index 24c21e43a36c..033dccc6a535 100644
--- a/kernel/tests/user_ns_map_kunit.c
+++ b/kernel/tests/user_ns_map_kunit.c
@@ -24,7 +24,7 @@ static void user_ns_map_insert(struct kunit *test)
 		extent.lower_first = i * 100;
 		extent.count = 5;
 
-		ret = insert_extent(&map, &extent);
+		ret = uid_gid_map_insert_extent(&map, &extent);
 		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
@@ -54,14 +54,14 @@ static void user_ns_map_insert_extended(struct kunit *test)
 		extent.lower_first = value * 100;
 		extent.count = 5;
 
-		ret = insert_extent(&map, &extent);
+		ret = uid_gid_map_insert_extent(&map, &extent);
 		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	KUNIT_EXPECT_EQ(test, map.nr_extents, NR_EXTENTS);
 
 	/* Now sort the map to set up reverse mapping */
-	ret = sort_idmaps(&map);
+	ret = uid_gid_map_sort(&map);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index f9cbb4b92b48..98b0279b6cc6 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -780,12 +780,13 @@ static bool mappings_overlap(struct uid_gid_map *new_map,
 }
 
 /*
- * insert_extent - Safely insert a new idmap extent into struct uid_gid_map.
+ * uid_gid_map_insert_extent - Safely insert a new idmap extent into
+ * struct uid_gid_map.
  * Takes care to allocate a 4K block of memory if the number of mappings exceeds
  * UID_GID_MAP_MAX_BASE_EXTENTS.
  */
-VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
-				   struct uid_gid_extent *extent)
+VISIBLE_IF_KUNIT int uid_gid_map_insert_extent(struct uid_gid_map *map,
+					       struct uid_gid_extent *extent)
 {
 	struct uid_gid_extent *dest;
 
@@ -821,7 +822,7 @@ VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
 	*dest = *extent;
 	return 0;
 }
-EXPORT_SYMBOL_IF_KUNIT(insert_extent);
+EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_insert_extent);
 
 /* cmp function to sort() forward mappings */
 static int cmp_extents_forward(const void *a, const void *b)
@@ -854,10 +855,10 @@ static int cmp_extents_reverse(const void *a, const void *b)
 }
 
 /*
- * sort_idmaps - Sorts an array of idmap entries.
+ * uid_gid_map_sort - Sorts an array of idmap entries.
  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
  */
-VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
+VISIBLE_IF_KUNIT int uid_gid_map_sort(struct uid_gid_map *map)
 {
 	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
 		return 0;
@@ -878,7 +879,7 @@ VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
 
 	return 0;
 }
-EXPORT_SYMBOL_IF_KUNIT(sort_idmaps);
+EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
 
 /**
  * verify_root_map() - check the uid 0 mapping
@@ -1047,7 +1048,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 		    (next_line != NULL))
 			goto out;
 
-		ret = insert_extent(&new_map, &extent);
+		ret = uid_gid_map_insert_extent(&new_map, &extent);
 		if (ret < 0)
 			goto out;
 		ret = -EINVAL;
@@ -1091,7 +1092,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	 * If we want to use binary search for lookup, this clones the extent
 	 * array and sorts both copies.
 	 */
-	ret = sort_idmaps(&new_map);
+	ret = uid_gid_map_sort(&new_map);
 	if (ret < 0)
 		goto out;
 
-- 
2.53.0

