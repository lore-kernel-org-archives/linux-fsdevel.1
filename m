Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DA37F010
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357779; cv=none; b=d1cMi20IwgIFh8VWgTk+giU9mTWEaZa5kCupYSRKCj3DPnXXZunWOA+hIlDCkI1cwl/RN7UltYhiFOAmPIxyHSoNJ0CAV2FbEAS7wJA48689yNKO1wLYmQe7Awdv+xBqFrRDnqMGOIdAglEs4+QNTN6keQEbmosYT8onBMPACEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357779; c=relaxed/simple;
	bh=K5ODYb+lCZr9CsKAh8f2lBd2ovJulBoqmGCKQwOvMUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGHi2E+YlqoXr9BUGamhKkMv64rZInWO917s7jruZO1cUPV3i+M5t5g403/mzfEwfBE94dheTOrnHu5v2LnP6Xkd4KkGA9NLT11PBqM4mahqaISrgvxP6MRDLUAUSn6JYmDo0g6pf1vjPgj19uSoeC0AWEyQmH44rst4OnR8JeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Y2eTJF1v; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Y2eTJF1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779357774; h=from : subject
 : to : message-id : date;
 bh=gvhlhWo0fj/91Xw4zvBxPEpT76wIaP1E9xbcLqWvsE0=;
 b=Y2eTJF1vHSv1FG6leMQZx9K6Kqo0veFwXLfl+dx8OOpuezDot+FUzPc+K17TpmD/ECEke
 bKigt+Fnbxkey2vNcBDLAdgXQM4lgA2Dyghy+rYhfNUbmd4uhHsVfemsebeJGM7G8O1zqyJ
 EiDs4ICWN3JrGlqicOgTZzmXQcLedZxjaC0b6rfEJy+9+PgjqYWm0y9rIz+lu4Cd2Rvf35D
 OkKh4FY3odKc5LU0ow4i+g0iRwsWg5Agz6jq2APNyPPa7JhU6fBcmTEJCXeKHAmIAehSsCp
 GPAIGs6p2/GIZKZqefItZmPb7dTG38C9+a55BKTit1tW2A8bN/pd/AQ7m6TA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2)
	(envelope-from <repk@triplefau.lt>)
	id 1wQ0Em-AIkwcC8nohd-IeXf;
	Thu, 21 May 2026 10:02:44 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v7 1/4] 9p: Cache negative dentries for lookup performance
Date: Thu, 21 May 2026 11:40:29 +0200
Message-ID: <e542317dd03bbadb5249abd3ea6aecfdca692c19.1779355927.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779355927.git.repk@triplefau.lt>
References: <cover.1779355927.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sVfXmlqY_y
X-smtpcorp-track: dMxgm-C_33CV.M6fojFCeehAw.UqV4YwZQaq1

Not caching negative dentries can result in poor performance for
workloads that repeatedly look up non-existent paths. Each such
lookup triggers a full 9P transaction with the server, adding
unnecessary overhead.

A typical example is source compilation, where multiple cc1 processes
are spawned and repeatedly search for the same missing header files
over and over again.

This change enables caching of negative dentries, so that lookups for
known non-existent paths do not require a full 9P transaction. The
cached negative dentries are retained for a configurable duration
(expressed in milliseconds), as specified by the ndentry_timeout
field in struct v9fs_session_info. If set to -1, negative dentries
are cached indefinitely.

This optimization reduces lookup overhead and improves performance for
workloads involving frequent access to non-existent paths.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/fid.c             |  11 +++--
 fs/9p/v9fs.c            |   1 +
 fs/9p/v9fs.h            |   5 ++
 fs/9p/v9fs_vfs.h        |  15 ++++++
 fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c       |  12 +++--
 fs/9p/vfs_super.c       |   1 +
 include/net/9p/client.h |   2 +
 8 files changed, 128 insertions(+), 24 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index f84412290a30..76242d450aa7 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -20,7 +20,9 @@
 
 static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
 {
-	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	hlist_add_head(&fid->dlist, &v9fs_dentry->head);
 }
 
 
@@ -112,6 +114,7 @@ void v9fs_open_fid_add(struct inode *inode, struct p9_fid **pfid)
 
 static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 {
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
 	struct p9_fid *fid, *ret;
 
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p) uid %d any %d\n",
@@ -119,11 +122,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		 any);
 	ret = NULL;
 	/* we'll recheck under lock if there's anything to look in */
-	if (dentry->d_fsdata) {
-		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
-
+	if (!hlist_empty(&v9fs_dentry->head)) {
 		spin_lock(&dentry->d_lock);
-		hlist_for_each_entry(fid, h, dlist) {
+		hlist_for_each_entry(fid, &v9fs_dentry->head, dlist) {
 			if (any || uid_eq(fid->uid, uid)) {
 				ret = fid;
 				p9_fid_get(ret);
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index acda42499ca9..be83744b75b2 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -426,6 +426,7 @@ static void v9fs_apply_options(struct v9fs_session_info *v9ses,
 	v9ses->cache = ctx->session_opts.cache;
 	v9ses->uid = ctx->session_opts.uid;
 	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
+	v9ses->ndentry_timeout_ms = ctx->session_opts.ndentry_timeout_ms;
 }
 
 /**
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 6a12445d3858..e630c5111d74 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -91,6 +91,7 @@ enum p9_cache_bits {
  * @debug: debug level
  * @afid: authentication handle
  * @cache: cache mode of type &p9_cache_bits
+ * @ndentry_timeout: Negative dentry lookup cache retention time in ms
  * @cachetag: the tag of the cache associated with this session
  * @fscache: session cookie associated with FS-Cache
  * @uname: string user name to mount hierarchy as
@@ -101,6 +102,7 @@ enum p9_cache_bits {
  * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
  * @clnt: reference to 9P network client instantiated for this session
  * @slist: reference to list of registered 9p sessions
+ * @ndentry_timeout_ms: Negative dentry caching retention time
  *
  * This structure holds state for each session instance established during
  * a sys_mount() .
@@ -116,6 +118,7 @@ struct v9fs_session_info {
 	unsigned short debug;
 	unsigned int afid;
 	unsigned int cache;
+	unsigned int ndentry_timeout_ms;
 #ifdef CONFIG_9P_FSCACHE
 	char *cachetag;
 	struct fscache_volume *fscache;
@@ -133,6 +136,8 @@ struct v9fs_session_info {
 	long session_lock_timeout; /* retry interval for blocking locks */
 };
 
+#define NDENTRY_TIMEOUT_NEVER (-1U)
+
 /* cache_validity flags */
 #define V9FS_INO_INVALID_ATTR 0x01
 
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 34c115d7c250..1856d91f8703 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -28,6 +28,19 @@
 /* flags for v9fs_stat2inode() & v9fs_stat2inode_dotl() */
 #define V9FS_STAT2INODE_KEEP_ISIZE 1
 
+/**
+ * struct v9fs_dentry - v9fs specific dentry data
+ * @head: List of fid associated with this dentry
+ * @expire_time: Lookup cache expiration time for negative dentries
+ * @rcu: used by kfree_rcu to schedule clean up job
+ */
+struct v9fs_dentry {
+	struct hlist_head head;
+	u64 expire_time;
+	struct rcu_head rcu;
+};
+#define to_v9fs_dentry(d) ((struct v9fs_dentry *)((d)->d_fsdata))
+
 extern struct file_system_type v9fs_fs_type;
 extern const struct address_space_operations v9fs_addr_operations;
 extern const struct file_operations v9fs_file_operations;
@@ -35,6 +48,8 @@ extern const struct file_operations v9fs_file_operations_dotl;
 extern const struct file_operations v9fs_dir_operations;
 extern const struct file_operations v9fs_dir_operations_dotl;
 extern const struct dentry_operations v9fs_dentry_operations;
+extern void v9fs_ndentry_refresh_timeout(struct dentry *dentry);
+extern void v9fs_dentry_fid_remove(struct dentry *dentry);
 extern const struct dentry_operations v9fs_cached_dentry_operations;
 extern struct kmem_cache *v9fs_inode_cache;
 
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index c5bf74d547e8..e549e222602e 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -23,6 +23,46 @@
 #include "v9fs_vfs.h"
 #include "fid.h"
 
+/**
+ * v9fs_ndentry_is_expired - Check if negative dentry lookup has expired
+ *
+ * This should be called to know if a negative dentry should be removed from
+ * cache.
+ *
+ * @dentry: dentry in question
+ *
+ */
+static bool v9fs_ndentry_is_expired(struct dentry const *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	if (v9ses->ndentry_timeout_ms == NDENTRY_TIMEOUT_NEVER)
+		return false;
+
+	return time_before_eq64(v9fs_dentry->expire_time, get_jiffies_64());
+}
+
+/**
+ * v9fs_ndentry_refresh_timeout - Refresh negative dentry lookup cache timeout
+ *
+ * This should be called when a look up yields a negative entry.
+ *
+ * @dentry: dentry in question
+ *
+ */
+void v9fs_ndentry_refresh_timeout(struct dentry *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	if (v9ses->ndentry_timeout_ms == NDENTRY_TIMEOUT_NEVER)
+		return;
+
+	v9fs_dentry->expire_time = get_jiffies_64() +
+				   msecs_to_jiffies(v9ses->ndentry_timeout_ms);
+}
+
 /**
  * v9fs_cached_dentry_delete - called when dentry refcount equals 0
  * @dentry:  dentry in question
@@ -33,20 +73,15 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
 		 dentry, dentry);
 
-	/* Don't cache negative dentries */
-	if (d_really_is_negative(dentry))
-		return 1;
-	return 0;
-}
+	if (!d_really_is_negative(dentry))
+		return 0;
 
-/**
- * v9fs_dentry_release - called when dentry is going to be freed
- * @dentry:  dentry that is being release
- *
- */
+	return v9fs_ndentry_is_expired(dentry);
+}
 
-static void v9fs_dentry_release(struct dentry *dentry)
+static void __v9fs_dentry_fid_remove(struct dentry *dentry)
 {
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
 	struct hlist_node *p, *n;
 	struct hlist_head head;
 
@@ -54,13 +89,54 @@ static void v9fs_dentry_release(struct dentry *dentry)
 		 dentry, dentry);
 
 	spin_lock(&dentry->d_lock);
-	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
+	hlist_move_list(&v9fs_dentry->head, &head);
 	spin_unlock(&dentry->d_lock);
 
 	hlist_for_each_safe(p, n, &head)
 		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
 }
 
+/**
+ * v9fs_dentry_fid_remove - Release all dentry's fids
+ * @dentry: dentry in question
+ *
+ */
+void v9fs_dentry_fid_remove(struct dentry *dentry)
+{
+	__v9fs_dentry_fid_remove(dentry);
+}
+
+/**
+ * v9fs_dentry_init - Initialize v9fs dentry data
+ * @dentry: dentry in question
+ *
+ */
+static int v9fs_dentry_init(struct dentry *dentry)
+{
+	struct v9fs_dentry *v9fs_dentry = kzalloc(sizeof(*v9fs_dentry),
+						  GFP_KERNEL);
+
+	if (!v9fs_dentry)
+		return -ENOMEM;
+
+	INIT_HLIST_HEAD(&v9fs_dentry->head);
+	dentry->d_fsdata = (void *)v9fs_dentry;
+	return 0;
+}
+
+/**
+ * v9fs_dentry_release - called when dentry is going to be freed
+ * @dentry:  dentry that is being released
+ *
+ */
+static void v9fs_dentry_release(struct dentry *dentry)
+{
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	__v9fs_dentry_fid_remove(dentry);
+	kfree_rcu(v9fs_dentry, rcu);
+}
+
 static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct p9_fid *fid;
@@ -72,7 +148,7 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 	inode = d_inode(dentry);
 	if (!inode)
-		goto out_valid;
+		return !v9fs_ndentry_is_expired(dentry);
 
 	v9inode = V9FS_I(inode);
 	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
@@ -112,7 +188,6 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 			return retval;
 		}
 	}
-out_valid:
 	p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) is valid\n", dentry, dentry);
 	return 1;
 }
@@ -139,12 +214,14 @@ const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
 	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
+	.d_init = v9fs_dentry_init,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
+	.d_init = v9fs_dentry_init,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index f468acb8ee7d..5cbbebafc24e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -549,7 +549,7 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 
 		/* invalidate all fids associated with dentry */
 		/* NOTE: This will not include open fids */
-		dentry->d_op->d_release(dentry);
+		v9fs_dentry_fid_remove(dentry);
 	}
 	return retval;
 }
@@ -732,14 +732,16 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	name = dentry->d_name.name;
 	fid = p9_client_walk(dfid, 1, &name, 1);
 	p9_fid_put(dfid);
-	if (fid == ERR_PTR(-ENOENT))
+	if (fid == ERR_PTR(-ENOENT)) {
 		inode = NULL;
-	else if (IS_ERR(fid))
+		v9fs_ndentry_refresh_timeout(dentry);
+	} else if (IS_ERR(fid)) {
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	} else if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
-	else
+	} else {
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	}
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 431f24938a1d..94d6b02c221b 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -330,6 +330,7 @@ static int v9fs_init_fs_context(struct fs_context *fc)
 	ctx->session_opts.uid = INVALID_UID;
 	ctx->session_opts.dfltuid = V9FS_DEFUID;
 	ctx->session_opts.dfltgid = V9FS_DEFGID;
+	ctx->session_opts.ndentry_timeout_ms = 0;
 
 	/* initialize client options */
 	ctx->client_opts.proto_version = p9_proto_2000L;
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 838a94218b59..55c6cb54bd25 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -192,6 +192,7 @@ struct p9_rdma_opts {
  * @dfltgid: default numeric groupid to mount hierarchy as
  * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
  * @session_lock_timeout: retry interval for blocking locks
+ * @ndentry_timeout_ms: Negative dentry lookup cache retention time in ms
  *
  * This strucure holds options which are parsed and will be transferred
  * to the v9fs_session_info structure when mounted, and therefore largely
@@ -203,6 +204,7 @@ struct p9_session_opts {
 	unsigned short debug;
 	unsigned int afid;
 	unsigned int cache;
+	unsigned int ndentry_timeout_ms;
 #ifdef CONFIG_9P_FSCACHE
 	char *cachetag;
 #endif
-- 
2.52.0

