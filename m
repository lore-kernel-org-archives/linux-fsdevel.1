Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6F4A0933;
	Wed,  7 Oct 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386466; cv=none; b=eJ7GReVUxq5UhxwYCrYeHMUgVh00JU1zMYL9mhab92b9+PV6+8KyQswz9o0uR4xey1Yb9MqQCp/TLtPz+m9gkRKMe/Qpy0VFAHTSb7i1aNO58Wk0I6ZLaNezkbJrWBNIo+LZ6/AuHY45PpHnsgjI6lgmb7RCjN07ZHENrpb07oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386466; c=relaxed/simple;
	bh=ffr6FY/fiDj4yZ4S295ey07jYhD3riV+Ik7hZ160mJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t92/bdOKDaZbeVoetsNDWcEXQHBGKxsoB4p6/3yQWn4jbMdmMoS9i/UXUlFMiGaZ/iwQxmKFVtcoUO8GwSa0GEjjUp6SO1pXHIDkbMP0JehQiIf9xWTltX169VCFNb3w1skMY+1cocTBhWslCpRtsaJ3m53SPog0ec8WyOMVLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GgpQTMj8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GgpQTMj8"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697DfmJq2443614;
	Wed, 7 Oct 2026 15:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zrWUP
	eXxgoW0KPs598zzsBNJ6uB06zhhytqVHPyjvoE=; b=GgpQTMj8a3XX9x0w/+v+B
	QRGDDqwnvHd7W626ePKHPFk/IBk4lxn+EnEbFFUkFICOghLA6gYuCLoS/3l8Dl3x
	tzTrdoffzcI4UkhBFjHpGtlqbnbo7Kq6MnNAYp9h4KJnQJGLyZuTmrL8rY6EPXrU
	syoKTOi8CXTYGcHcSw+NtexTvUzYoCBVWcuj7fjgso/vyZVzvUTDz4GACisHJmbV
	ngjy1bK5h7Jvn9SwOjzM8dG5nuMxfo1bzjFhQOGThzjLMmSPIqPvEcEWUV092O2I
	tOFa+NE9+hz9mAjTyNZmjYeUgRSV2EDyPmKJt9vn/6xvZChVK9iIO37ae81AirB2
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2r4be83v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Oct 2026 15:20:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 697F6fR6024605;
	Wed, 7 Oct 2026 15:20:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h4d103vt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Oct 2026 15:20:54 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 697FDs0A008268;
	Wed, 7 Oct 2026 15:20:53 GMT
Received: from pssatapa-ol8-test.osdevelopmeniad.oraclevcn.com (pssatapa-ol8-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h4d103vr8-2;
	Wed, 07 Oct 2026 15:20:53 +0000 (GMT)
From: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
To: partha.satapathy@oracle.com, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fsnotify: Check parent watches without child dentry flags
Date: Wed,  7 Oct 2026 15:20:51 +0000
Message-ID: <ed17a697adc545092953480924432f1a198d181b.1791373689.git.partha.satapathy@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1791373689.git.partha.satapathy@oracle.com>
References: <cover.1791373689.git.partha.satapathy@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610070060
X-Proofpoint-GUID: yNRniVfbTaIXLREUDHcyAJyRCTtSE9S3
X-Proofpoint-ORIG-GUID: yNRniVfbTaIXLREUDHcyAJyRCTtSE9S3
X-Authority-Analysis: v=2.4 cv=BIQmP1QG c=1 sm=1 tr=0 ts=6ac66357 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=m4KqQiPejkQCM-_P_icA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfX4Qw1AaAN0ver
 ulgZBtlaOVyojgAXn4Yh1b/U7S68vfORJzS8HNltEpx9X4n27mkJ2Lzj4twDJ3esXFKt0NUTEF9
 dt8HuIZw3fLFegNvgYcQnAWqbeG1i88Ta2nf1AphubulTTE7mww4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfX8oMsEbJvteKT
 oViOvSPf0UBeS2rcPW9MWZAwvHIWmH1+7oQZ5iNUbbJ75QCvoTMLGvxtXtwBMY64HVAIOdvtfB3
 1CRTdpude5GMzDACwwXAd70gzze3o+Dp/lkygHN0+8OSk56UY4UrUiBOBN5cDuKPw0z5dZCFgGe
 Z4dA4IwuPfmfFAl+KcqX3d+MDrdcbfCa99ksrAL7j5WQ978loahEE8yaiSDthOxMOA24UFEQRtJ
 XDjR3zSb9rU13OoseMuBHUDaZTpSeEGaWn267OWLKnGm3kRtmN4B4qjs2Kpj/9OUSlS4lrvKBTd
 Xn70fHh6vZzrpXxZvtDNibMpjTSpI6nSBl2CMjl/lf8JfmMB1As2bJ1WkjDk/dDSbkgprVxOD7p
 v2ogoVbOFiBVG+RtZSkMSKAFLzExB2vWJJ+liQKxSgGZkXWNyHDAIESLeI/tciFypLiAYWvr8z7
 JdsWJSiqo6F6xMPzDQw==

Enabling child watches currently walks all cached children of a
directory to set DCACHE_FSNOTIFY_PARENT_WATCHED. This makes watch
installation proportional to the number of cached dentries and takes
each child's d_lock.

Instead, obtain a referenced parent and read its child-watch mask in
__fsnotify_parent() when deciding whether to include parent and name
information. Check the parent directly in
fsnotify_open_perm_and_set_mode() so permission events are handled
before the normal open notification.

Remove the bulk walk, the dentry flag, and its dcache updates. This
moves work from watch installation to events: events on a superblock
with watchers now acquire and release a parent dentry reference.

Signed-off-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
---

Tested on a 12-million-file directory with eight mutation workers and 100
watch-add cycles: the two before/after average watch-add latencies were
107.420/0.004 ms and 125.433/0.004 ms. Inotify functional tests passed on
both kernels; the fanotify permission test skipped with EPERM. See the cover
letter for event-path measurements and their single-run limitation.

 fs/dcache.c                      |  4 --
 fs/notify/fsnotify.c             | 99 ++++++++------------------------
 fs/notify/fsnotify.h             |  6 --
 fs/notify/mark.c                 | 35 -----------
 include/linux/dcache.h           |  1 -
 include/linux/fsnotify.h         |  7 +--
 include/linux/fsnotify_backend.h | 29 ++--------
 7 files changed, 29 insertions(+), 152 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 66dd1bb830d1..2262620e49f3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1984,7 +1984,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
 	raw_write_seqcount_end(&dentry->d_seq);
-	fsnotify_update_flags(dentry);
 }
 
 /**
@@ -2764,7 +2763,6 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		raw_write_seqcount_begin(&dentry->d_seq);
 		__d_set_inode_and_type(dentry, inode, add_flags);
 		raw_write_seqcount_end(&dentry->d_seq);
-		fsnotify_update_flags(dentry);
 	}
 	__d_rehash(dentry);
 	if (dir)
@@ -2939,13 +2937,11 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 			__hlist_del(&target->d_sib);
 		hlist_add_head(&target->d_sib, &target->d_parent->d_children);
 		__d_rehash(target);
-		fsnotify_update_flags(target);
 	}
 	if (!hlist_unhashed(&dentry->d_sib))
 		__hlist_del(&dentry->d_sib);
 	hlist_add_head(&dentry->d_sib, &dentry->d_parent->d_children);
 	__d_rehash(dentry);
-	fsnotify_update_flags(dentry);
 	fscrypt_handle_d_move(dentry);
 
 	write_seqcount_end(&target->d_seq);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 71bd44e5ab6d..88ea931148c9 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -115,61 +115,6 @@ void fsnotify_sb_free(struct super_block *sb)
 	kfree(sb->s_fsnotify_info);
 }
 
-/*
- * Given an inode, first check if we care what happens to our children.  Inotify
- * and dnotify both tell their parents about events.  If we care about any event
- * on a child we run all of our children and set a dentry flag saying that the
- * parent cares.  Thus when an event happens on a child it can quickly tell
- * if there is a need to find a parent and send the event to the parent.
- */
-void fsnotify_set_children_dentry_flags(struct inode *inode)
-{
-	struct dentry *alias;
-
-	if (!S_ISDIR(inode->i_mode))
-		return;
-
-	spin_lock(&inode->i_lock);
-	/* run all of the dentries associated with this inode.  Since this is a
-	 * directory, there damn well better only be one item on this list */
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		struct dentry *child;
-
-		/* run all of the children of the original inode and fix their
-		 * d_flags to indicate parental interest (their parent is the
-		 * original inode) */
-		spin_lock(&alias->d_lock);
-		hlist_for_each_entry(child, &alias->d_children, d_sib) {
-			if (!child->d_inode)
-				continue;
-
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			spin_unlock(&child->d_lock);
-		}
-		spin_unlock(&alias->d_lock);
-	}
-	spin_unlock(&inode->i_lock);
-}
-
-/*
- * Lazily clear false positive PARENT_WATCHED flag for child whose parent had
- * stopped watching children.
- */
-static void fsnotify_clear_child_dentry_flag(struct inode *pinode,
-					     struct dentry *dentry)
-{
-	spin_lock(&dentry->d_lock);
-	/*
-	 * d_lock is a sufficient barrier to prevent observing a non-watched
-	 * parent state from before the fsnotify_set_children_dentry_flags()
-	 * or fsnotify_update_flags() call that had set PARENT_WATCHED.
-	 */
-	if (!fsnotify_inode_watches_children(pinode))
-		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
-	spin_unlock(&dentry->d_lock);
-}
-
 /* Are inode/sb/mount interested in parent and name info with this event? */
 static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 					__u32 mask)
@@ -237,35 +182,37 @@ int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
 int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		      int data_type)
 {
-	const struct path *path = fsnotify_data_path(data, data_type);
-	__u32 mnt_mask = path ?
-		READ_ONCE(real_mount(path->mnt)->mnt_fsnotify_mask) : 0;
 	struct inode *inode = d_inode(dentry);
-	struct dentry *parent;
-	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
+	struct dentry *parent = dget_parent(dentry);
+	struct inode *p_inode = d_inode(parent);
+	__u32 parent_mask = fsnotify_inode_watches_children(p_inode);
+	const struct path *path;
+	__u32 mnt_mask;
 	bool parent_needed, parent_interested;
-	__u32 p_mask;
-	struct inode *p_inode = NULL;
 	struct name_snapshot name;
 	struct qstr *file_name = NULL;
 	int ret = 0;
 
+	/* sb/mount marks are not interested in the name of a directory. */
+	if (S_ISDIR(inode->i_mode) && !parent_mask) {
+		ret = fsnotify(mask, data, data_type, NULL, NULL, inode, 0);
+		goto out;
+	}
+
+	path = fsnotify_data_path(data, data_type);
+	mnt_mask = path ?
+		READ_ONCE(real_mount(path->mnt)->mnt_fsnotify_mask) : 0;
+
 	/* Optimize the likely case of nobody watching this path */
-	if (likely(!parent_watched &&
+	if (likely(!parent_mask &&
 		   !fsnotify_object_watched(inode, mnt_mask, mask)))
-		return 0;
+		goto out;
 
-	parent = NULL;
 	parent_needed = fsnotify_event_needs_parent(inode, mnt_mask, mask);
-	if (!parent_watched && !parent_needed)
+	if (!parent_mask && !parent_needed) {
+		p_inode = NULL;
 		goto notify;
-
-	/* Does parent inode care about events on children? */
-	parent = dget_parent(dentry);
-	p_inode = parent->d_inode;
-	p_mask = fsnotify_inode_watches_children(p_inode);
-	if (unlikely(parent_watched && !p_mask))
-		fsnotify_clear_child_dentry_flag(p_inode, dentry);
+	}
 
 	/*
 	 * Include parent/name in notification either if some notification
@@ -275,7 +222,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	 * events can provide an undesirable side-channel for information
 	 * exfiltration.
 	 */
-	parent_interested = mask & p_mask & ALL_FSNOTIFY_EVENTS &&
+	parent_interested = mask & parent_mask & ALL_FSNOTIFY_EVENTS &&
 			    !(data_type == FSNOTIFY_EVENT_PATH &&
 			      d_is_special(dentry) &&
 			      (mask & (FS_ACCESS | FS_MODIFY)));
@@ -295,8 +242,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 
 	if (file_name)
 		release_dentry_name_snapshot(&name);
+out:
 	dput(parent);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__fsnotify_parent);
@@ -696,7 +643,7 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
 	p_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
 					 ALL_FSNOTIFY_PERM_EVENTS);
-	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
+	if (!IS_ROOT(dentry)) {
 		parent = dget_parent(dentry);
 		p_mask |= fsnotify_inode_watches_children(d_inode(parent));
 		dput(parent);
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 5950c7a67f41..5bdf37bc97f2 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -100,12 +100,6 @@ static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
 	fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
 }
 
-/*
- * update the dentry->d_flags of all of inode's children to indicate if inode cares
- * about events that happen to its children.
- */
-extern void fsnotify_set_children_dentry_flags(struct inode *inode);
-
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
 #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 55a03bb05aa1..3fe71cfd4fe9 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -264,24 +264,6 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	return fsnotify_update_iref(conn, want_iref);
 }
 
-static bool fsnotify_conn_watches_children(
-					struct fsnotify_mark_connector *conn)
-{
-	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
-		return false;
-
-	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
-}
-
-static void fsnotify_conn_set_children_dentry_flags(
-					struct fsnotify_mark_connector *conn)
-{
-	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
-		return;
-
-	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
-}
-
 /*
  * Calculate mask of events for a list of marks. The caller must make sure
  * connector and connector->obj cannot disappear under us.  Callers achieve
@@ -290,23 +272,12 @@ static void fsnotify_conn_set_children_dentry_flags(
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
-	bool update_children;
-
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
-	update_children = !fsnotify_conn_watches_children(conn);
 	__fsnotify_recalc_mask(conn);
-	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	/*
-	 * Set children's PARENT_WATCHED flags only if parent started watching.
-	 * When parent stops watching, we clear false positive PARENT_WATCHED
-	 * flags lazily in __fsnotify_parent().
-	 */
-	if (update_children)
-		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
@@ -430,12 +401,6 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		spin_unlock(&destroy_lock);
 		queue_work(system_dfl_wq, &connector_reaper_work);
 	}
-	/*
-	 * Note that we didn't update flags telling whether inode cares about
-	 * what's happening with children. We update these flags from
-	 * __fsnotify_parent() lazily when next event happens on one of our
-	 * children.
-	 */
 	spin_lock(&destroy_lock);
 	list_add(&mark->g_list, &destroy_list);
 	spin_unlock(&destroy_lock);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 898c60d21c92..cd23b819cca9 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -205,7 +205,6 @@ enum dentry_flags {
 	 * last dput()
 	 */
 	DCACHE_NFSFS_RENAMED		= BIT(12),
-	DCACHE_FSNOTIFY_PARENT_WATCHED	= BIT(13),	/* Parent inode is watched by some fsnotify listener */
 	DCACHE_DENTRY_KILLED		= BIT(14),
 	DCACHE_MOUNTED			= BIT(15),	/* is a mountpoint */
 	DCACHE_NEED_AUTOMOUNT		= BIT(16),	/* handle automount on this dir */
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 28a9cb13fbfa..a664c2f8f4a5 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -81,14 +81,9 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 	if (!fsnotify_sb_has_watchers(inode->i_sb))
 		return 0;
 
-	if (S_ISDIR(inode->i_mode)) {
+	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-		/* sb/mount marks are not interested in name of directory */
-		if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
-			goto notify_child;
-	}
-
 	/* disconnected dentry cannot notify parent */
 	if (IS_ROOT(dentry))
 		goto notify_child;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0d954ea7b179..faa7f3818491 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -680,27 +680,6 @@ static inline int fsnotify_inode_watches_children(struct inode *inode)
 	return parent_mask & FS_EVENTS_POSS_ON_CHILD;
 }
 
-/*
- * Update the dentry with a flag indicating the interest of its parent to receive
- * filesystem events when those events happens to this dentry->d_inode.
- */
-static inline void fsnotify_update_flags(struct dentry *dentry)
-{
-	assert_spin_locked(&dentry->d_lock);
-
-	/*
-	 * Serialisation of setting PARENT_WATCHED on the dentries is provided
-	 * by d_lock. If inotify_inode_watched changes after we have taken
-	 * d_lock, the following fsnotify_set_children_dentry_flags call will
-	 * find our entry, so it will spin until we complete here, and update
-	 * us with the new state.
-	 */
-	if (fsnotify_inode_watches_children(dentry->d_parent->d_inode))
-		dentry->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-	else
-		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
-}
-
 /* called from fsnotify listeners, such as fanotify or dnotify */
 
 /* create a new group */
@@ -943,6 +922,11 @@ static inline int __fsnotify_parent(struct dentry *dentry, __u32 mask,
 	return 0;
 }
 
+static inline int fsnotify_inode_watches_children(struct inode *inode)
+{
+	return 0;
+}
+
 static inline void __fsnotify_inode_delete(struct inode *inode)
 {}
 
@@ -958,9 +942,6 @@ static inline void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
 static inline void fsnotify_sb_free(struct super_block *sb)
 {}
 
-static inline void fsnotify_update_flags(struct dentry *dentry)
-{}
-
 static inline u32 fsnotify_get_cookie(void)
 {
 	return 0;
