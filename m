Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0731F98E
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304147; cv=none; b=BwRyDNFUU2A7sKe+L6kBkEpO7qXmUwQXhIX1Zggnl51xc5yGOng6hx7ogHm67dFrp/d2UlC9h94d1Ibo4ARm7ear3iLmUKYkuGlilObP2a2xiTZ+2Gp247PGOBaqNownly0hXUFZe6AghYfW6QNPr2/0ZFfFJH3fpwENIopwVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304147; c=relaxed/simple;
	bh=UV7IAB9xw0IT0Y0c5rqonZ3tZvtOYfqWYwTSukX+A4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLlcxzkaW/efiDWa5i36c2LI+Ed7HnR4TSf9vOQVfAbwgYDY/Cg3s0lNSeMYNK4i58yh5u/K+0M9nm8xKgwsWZxONXy2byvCsyI4IIKuupYQlx2/u7IuQqwup6Ya5G51Icgd+kxF4iFa5oPzd4Tlr+K95w/HXSVfpZMy8rQx+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=jIwv5foX; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="jIwv5foX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779303840; h=from : subject
 : to : message-id : date;
 bh=ql7nWTfzUIDStj06O1nkeiwwAtG7EpyS9ahPlx1cxpc=;
 b=jIwv5foXcyutZSKPxhNLnpALguRdeelilZcCb2bsn9YLG+OTrb3fK8ksD2m53PYxgkp1X
 yTuWj9VQlajry9YpqhaKEhVIL+EU8WUD3tbJv+B+z0l+6QMBmJylqVBQglAY9ausJ7Bn+rb
 2w3PUVHb/O2Pk0h4q3VQAlCEkP/TMuCiKmh2Wvelr6rc01o3SbADeJ52vZkv38Z/F7u/QOf
 9vWcjyc1il8/0rUX+7vwO0ubr0J2lq9rDcysu7BPEpBYyRLzxONtMX54tJzB3za3xqk6HdM
 J3nerlA/zSy7Ie5Jn0uEnyp1jES7VbcOoph1emphX6r/ScytnoOUkQPinnrA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1wPmCy-FnQW0hPyp0D-nFNU;
	Wed, 20 May 2026 19:03:56 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v6 4/4] 9p: Enable symlink caching in page cache
Date: Wed, 20 May 2026 20:41:40 +0200
Message-ID: <0044c3cbf5c3f1b4734e8b98992e17b54e9044b4.1779302002.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779302002.git.repk@triplefau.lt>
References: <cover.1779302002.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sydEGVA3J3
X-smtpcorp-track: pI-ab7NEIKfO.B_cGo7-MJofW.Qn632g0bVFj

Currently, when cache=loose is enabled, file reads are cached in the
page cache, but symlink reads are not. This patch allows the results
of p9_client_readlink() to be stored in the page cache, eliminating
the need for repeated 9P transactions on subsequent symlink accesses.

This change improves performance for workloads that involve frequent
symlink resolution.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/vfs_addr.c       | 47 ++++++++++++++++++++++++++++++---
 fs/9p/vfs_inode.c      |  6 +++--
 fs/9p/vfs_inode_dotl.c | 60 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index c21d33830f5f..bc840614bfaf 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -70,11 +70,43 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
+	char *target;
 	unsigned long long pos = subreq->start + subreq->transferred;
-	int total, err;
-
-	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	int total = 0, err, len, n;
+
+	if (S_ISLNK(rreq->inode->i_mode)) {
+		/* p9_client_readlink() must not be called for legacy protocols
+		 * 9p2000 or 9p2000.u.
+		 */
+		BUG_ON(!p9_is_proto_dotl(fid->clnt));
+		if (WARN_ON_ONCE(pos)) {
+			/* reading a link at a non null offset should
+			 * not happen
+			 */
+			err = -EIO;
+			goto fill_subreq;
+		}
+		err = p9_client_readlink(fid, &target);
+		if (err != 0)
+			goto fill_subreq;
+		len = strlen(target);
+		if (len != i_size_read(rreq->inode)) {
+			kfree(target);
+			err = -EIO;
+			goto fill_subreq;
+		}
+		n = copy_to_iter(target, len, &subreq->io_iter);
+		kfree(target);
+		if (n != len) {
+			err = -EFAULT;
+			goto fill_subreq;
+		}
+		total = n;
+	} else {
+		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	}
 
+fill_subreq:
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
 	if (subreq->rreq->origin != NETFS_UNBUFFERED_READ &&
@@ -99,6 +131,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid;
+	struct dentry *dentry;
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
 			rreq->origin == NETFS_WRITETHROUGH ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
@@ -115,6 +148,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 		if (!fid)
 			goto no_fid;
 		p9_fid_get(fid);
+	} else if (S_ISLNK(rreq->inode->i_mode)) {
+		dentry = d_find_any_alias(rreq->inode);
+		if (!dentry)
+			goto no_fid;
+		fid = v9fs_fid_lookup(dentry);
+		dput(dentry);
+		if (IS_ERR(fid))
+			goto no_fid;
 	} else {
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
 		if (!fid)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5cbbebafc24e..d29df0b2e89c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			goto error;
 		}
 
-		if (v9fs_proto_dotl(v9ses))
+		if (v9fs_proto_dotl(v9ses)) {
 			inode->i_op = &v9fs_symlink_inode_operations_dotl;
-		else
+			inode_nohighmem(inode);
+		} else {
 			inode->i_op = &v9fs_symlink_inode_operations;
+		}
 
 		break;
 	case S_IFDIR:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 141fb54db65d..19260de64a1d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -690,9 +690,11 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	kgid_t gid;
 	const unsigned char *name;
+	struct v9fs_session_info *v9ses;
 	struct p9_qid qid;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
+	struct inode *inode;
 
 	name = dentry->d_name.name;
 	p9_debug(P9_DEBUG_VFS, "%llu,%s,%s\n", dir->i_ino, name, symname);
@@ -716,6 +718,26 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
 	v9fs_invalidate_inode_attr(dir);
 
+	/* instantiate inode and assign the unopened fid to the dentry */
+	fid = p9_client_walk(dfid, 1, &name, 1);
+	if (IS_ERR(fid)) {
+		err = PTR_ERR(fid);
+		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
+			 err);
+		goto error;
+	}
+
+	v9ses = v9fs_inode2v9ses(dir);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
+			 err);
+		goto error;
+	}
+	v9fs_fid_add(dentry, &fid);
+	d_instantiate(dentry, inode);
+	err = 0;
 error:
 	p9_fid_put(fid);
 	p9_fid_put(dfid);
@@ -857,24 +879,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /**
- * v9fs_vfs_get_link_dotl - follow a symlink path
+ * v9fs_vfs_get_link_nocache_dotl - Resolve a symlink directly.
+ *
+ * To be used when symlink caching is not enabled.
+ *
  * @dentry: dentry for symlink
  * @inode: inode for symlink
  * @done: destructor for return value
  */
-
 static const char *
-v9fs_vfs_get_link_dotl(struct dentry *dentry,
-		       struct inode *inode,
-		       struct delayed_call *done)
+v9fs_vfs_get_link_nocache_dotl(struct dentry *dentry,
+			       struct inode *inode,
+			       struct delayed_call *done)
 {
 	struct p9_fid *fid;
 	char *target;
 	int retval;
 
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
-
 	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
 
 	fid = v9fs_fid_lookup(dentry);
@@ -888,6 +909,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
 	return target;
 }
 
+/**
+ * v9fs_vfs_get_link_dotl - follow a symlink path
+ * @dentry: dentry for symlink
+ * @inode: inode for symlink
+ * @done: destructor for return value
+ */
+static const char *
+v9fs_vfs_get_link_dotl(struct dentry *dentry,
+		       struct inode *inode,
+		       struct delayed_call *done)
+{
+	struct v9fs_session_info *v9ses;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	v9ses = v9fs_inode2v9ses(inode);
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+		return page_get_link(dentry, inode, done);
+
+	return v9fs_vfs_get_link_nocache_dotl(dentry, inode, done);
+}
+
 int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 {
 	struct p9_stat_dotl *st;
-- 
2.52.0

