Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297412;
	b=5ZHyYrvT9O3TU77kyuY5ThxJnzuLf5lwgCMQiSb2+MraB3zHioqYSmNExZBU9CnyD960
	 8RYw1FeHOWdmycp/Sf0d0u2RUSv4DqkGO6LVhKYNp6qatLtjCgUCtBrVzE/fWZIpeBzX7
	 XlsfT8pwsEmRwZYRFGtm3SQcN3TqH5YDwPFL4BsTlEX9bGtsF9pfXP0C23ySwtcjJ4cmw
	 4oAjo39a01qHoPI56H59kR8cXaOktoRjppaRfYFSIaghdrepWZDehPYz/ILWgrUgJCSug
	 bvmY6ZihxYGi7cwLmnN70zFOE0Fr7KDOTMUU9t/5YgGR4vbPjvNEhtpJBdt9SVGVLPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6srhSFQb8DmFE8wkLCn6Pe2hDExtbspFlVvcZhcm5RQ=;
	b=KJLunv2aFcBllXpaq144SQxxcjajsKVjvUsaPuKGDSmKYeeFT9//bNSV+DifJ4w6y0HW
	 vMmQ/B3mqCjP9Och1NcnjzGxsRLAGGRae4388oVfMRE7aDefrDE70v6HdKlRlSzCXnSGS
	 MjdRSshomitHizCn8FDtEOSHsEnFJjptQS8CeYhSHz6oB4ZDDPcdJUR5LNJlJWaftyL5Y
	 qZ8U6j1US8GSO7ZSyPpsQ+RMSnf4604gL1jV+A3iTZbvXCcZQqvONUJR0BkC27sfSWgto
	 Q8Kv6YrALn/XQDhbXArZjlD/7ERPDSi5THrFz4WHFx7htucaL1Ig9a9Wio1iNBhsqAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=RzBvTVw4;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48461606BD66
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48461606BD66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=RzBvTVw4
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f84a55e31aso1510382a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297411; x=1793902211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6srhSFQb8DmFE8wkLCn6Pe2hDExtbspFlVvcZhcm5RQ=;
        b=RzBvTVw4LZVp1Zokk6NgJqq5DscKAtq+Bqn0IormqkwGocUFbD+RAsVrpZfFAFk0b3
         euCC5XAdREKe0YHx0bX0s42tkmIjYqsBLbhIbR++ZGdZveSkUIdNyA+SXhRgzPE7a9YV
         w1t7FgzXufScJjcpynG/PGuxz4pnAL3XbMFr2OmSxkkjDxwZ9i1eheKG2y5mzTt6jtyF
         ri9zjYJAJfiSBctWTHyF7iwwu9L7n2l74US5ZNKYRRyFZ5t2pj/qG2kjJVwUZZjhmH9I
         k3oQ6mL0SaUuV2FqwVKbHMf9ctBZuxepkeuqO/7Wojjpdph7xIK7pIwcSZsOrcr0S+26
         TwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297411; x=1793902211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6srhSFQb8DmFE8wkLCn6Pe2hDExtbspFlVvcZhcm5RQ=;
        b=f6o6v1WGmvuQpcPXO3QWf+iyoP6C+PNNnci4GX+SIKlKYczLrS58p6CvNu3c+mbP2e
         5ywsMn+Ky/B/f6EYAQqA6VDXWsM7XnkldpYtjXKYDQgUDsv1te1PggFMiK+RkbtML3vk
         Rm1cckg5OkKnt93ufFeskRIeprZbFqFcERnk4KotfVki7o0m5+cj/axfCDMD8qwo3BpI
         ONZhBHDT+PCGvtAbbXGLIJ8wj0pgGpKYqXEVBtNSTvf4g+RBVEhNrIzJXfnjj8myMw3X
         3JHtN0petyXwrhS1qNN6/Sma1ibFHvw8Imu81XDJ3zMmLeqqzQRe/+da9ZtTOc58FeR/
         WZrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCiwYm2NLRgbJwBb8uM+WrVS6LPdjwhmyBiFPo6G05wRbbTdlbREYovr/45y+PzAH/SHE5HAop+6dRIbuq@vger.kernel.org
X-Gm-Message-State: AFq9FYKhxLqC0YYiYYWkCgHAVFBMPyMBX7YcMxIOUz0NjqOxRUdnHGed
	kEHtrsBPPDvC77giRAb5fWPtrrRCBSgqg17UqtkT3G+uLwbNm0aH9nkUizH/BkPBtOY=
X-Gm-Gg: AYBFou1rOtMmRcyp9+2yT0w2WZcsX5X18DguRmjeAeOYHwGg9gBzT7f2A/OCYz4IPEW
	rPzHK9tgU2MMsyzILT13sEunoh7f5rt5G9vqNyF/4hTeXbOH3TdMbJZj908a7R6+eNYTjcQmmJV
	9R1rS8z1N0Aviy87xfJ+Dy69DSMUSa5JXxerPaChtjC30BboRgr+2cKoa0j460KVL3LZ88MZWNL
	nmSx0DzOkBtpJ52WJyL3gtuNADcxEFXvKQaJUDIoRf6rUb6DWAyNv9ykod0ylKsEO6xbVBK3yJm
	HwkTfBKwu8kOde4SX5a5OSZYMKiJbnIM6qO13AuyW8oOlwqGGjY+JlUOLx6T/wSU422uDD0cr0B
	zHvaFyZC2HgaiUX/4lOpsVpJnf/lb/Ejnl/ZQTT85pzM3ByPdJUYOMQbR3soAmIwbjljkcA2ErT
	+mLiLfvq//T1Sx5CnAiAXa5is335x0aKfetBy5jQKIj7xQ0cakqCmBZVxMpkr8mGBaosLEOaMT5
	HT5EjNW06PTFpmVcwpKadPXmq4td2PfXK7gTb5J9hZGLoNDeaY3e+gMKZv8FGkOR8GhUiz9acVV
	xSXDp70MkoRKF/tctAefJ7hzDCCSLYEfjterM0PSaPQ2Slmh9AwOEKPZlzpYkSq73lIHDtel36e
	bQk05qMrP5L5JtMmlknA=
X-Received: by 2002:a05:6830:2649:b0:81d:2120:d5bb with SMTP id 46e09a7af769-85ac198556amr5281780a34.30.1793297410892;
        Thu, 29 Oct 2026 11:10:10 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3549a2b4sm156956a34.13.2026.10.29.11.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:10 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 07/12] nfs: add a second mark for a removal made with the parent locked shared
Date: Thu, 29 Oct 2026 12:09:52 -0600
Message-ID: <20261029180957.387138-8-jonathan.flynn@hammerspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
References: <20261028041023.3738553-1-neilb@ownmail.net>
 <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare the client to remove a file while its directory is locked
shared.  While a REMOVE of a cached name, or a RENAME onto it, is in
flight, the client stores NFS_FSDATA_BLOCKED in the dentry's
->d_fsdata, and ->d_revalidate() waits for it to clear.  Add a second
mark, NFS_FSDATA_BLOCKED_SHARED, for a removal made with the directory
locked shared.  ->d_revalidate() waits on either, and nfs_call_unlink()
does not hand a pending silly-delete to a dentry carrying either.  The
WARN_ON()s in nfs_unlink() and nfs_rename() still test for
NFS_FSDATA_BLOCKED alone: they run with the directory locked exclusive,
where the new mark cannot be present.  Document every value ->d_fsdata
can hold.

Nothing stores the new mark yet, so nothing changes.  The lookup check
is shared with NFSv2 and NFSv3, whose behavior is unchanged.

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/dir.c           | 11 +++++---
 fs/nfs/internal.h      | 58 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/unlink.c        | 16 ++++++------
 include/linux/nfs_fs.h | 21 +++++++++++++++
 4 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index dc7784b666..68a1e578e1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1839,17 +1839,20 @@ static int
 __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU) {
-		if (dentry->d_fsdata == NFS_FSDATA_BLOCKED)
+		/* One load: no lock is held and there are two values */
+		if (nfs_fsdata_blocked(READ_ONCE(dentry->d_fsdata)))
 			return -ECHILD;
 	} else {
+		void **fsdata = &dentry->d_fsdata;
+
 		/* Wait for unlink to complete - see unblock_revalidate().
 		 * smp_load_acquire() ensures ->d_fsdata is read after
 		 * ->d_seq was read, matching block_revalidate() which
 		 * sets ->d_fsdata before ->d_seq.
 		 */
-		wait_var_event(&dentry->d_fsdata,
-			       smp_load_acquire(&dentry->d_fsdata)
-			       != NFS_FSDATA_BLOCKED);
+		wait_var_event(fsdata,
+			       /* one load: there are two values to test */
+			       !nfs_fsdata_blocked(smp_load_acquire(fsdata)));
 	}
 	return 0;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 34b8aff4e0..7cda8b7b3f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -44,6 +44,64 @@ static inline bool nfs_lookup_is_soft_revalidate(const struct dentry *dentry)
 	return true;
 }
 
+/*
+ * ->d_fsdata holds NFS_FSDATA_BLOCKED or NFS_FSDATA_BLOCKED_SHARED while a
+ * removal of the dentry's name is in flight: the first when the remover
+ * holds the parent's i_rwsem exclusive, the second when it holds it shared,
+ * and the second until the VFS ends the removal, after any delete event for
+ * it (see the client's ->unlink_shared_done()).
+ * ->d_revalidate() waits for either to clear.  The two differ in what the
+ * dentry is to the removal.
+ *
+ * Under an exclusive parent no resolver of the name can make a new dentry
+ * for it, so a victim that gets unhashed is harmless.  (That holds while
+ * the VFS calls d_alloc_parallel() under the parent's i_rwsem, as it does
+ * today; a VFS that allocates in-lookup dentries before taking i_rwsem
+ * would end it.  nfs_call_unlink() calls it without i_rwsem, for a
+ * silly-renamed name, but the dentry it makes there is never hashed, and
+ * goes once its REMOVE is done.)  Under a shared parent the hashed dentry
+ * is what every resolver of the name is handed - d_alloc_parallel() looks
+ * in the hash before it creates in-lookup state - and so it is what routes
+ * a lookup or open of the name through ->d_revalidate(), where a resolver
+ * that consults it after the sentinel is stored waits.  Unhash it, and a
+ * lookup or open of the name allocates a fresh dentry, finds no removal in
+ * flight and can reach the server ahead of the REMOVE: an open then gets
+ * the file being removed, which the REMOVE goes on to delete while this
+ * client holds it open, without the silly-rename that would otherwise have
+ * kept it.  Such a dentry is the removal's anchor.  A path in the client
+ * that unhashes a dentry it does not own, or that reaches one without
+ * ->d_revalidate(), has to leave an anchor hashed or wait for its sentinel
+ * to clear.
+ *
+ * The shared sentinel is stored and cleared within one shared hold of the
+ * parent, so it is never present while the parent is held exclusive.  That
+ * is why the two tests made with the parent exclusive, the WARN_ON()s in
+ * nfs_unlink() and nfs_rename(), still compare against NFS_FSDATA_BLOCKED
+ * alone.  They are the only bare compares against a sentinel; every other
+ * test uses the helpers below.
+ */
+static inline bool nfs_fsdata_blocked(const void *fsdata)
+{
+	return fsdata == NFS_FSDATA_BLOCKED ||
+	       fsdata == NFS_FSDATA_BLOCKED_SHARED;
+}
+
+static inline bool nfs_fsdata_blocked_shared(const void *fsdata)
+{
+	return fsdata == NFS_FSDATA_BLOCKED_SHARED;
+}
+
+/*
+ * Is a removal of this name in flight?  The caller holds ->d_lock, which
+ * the sentinels are stored under but not cleared under:
+ * unblock_revalidate() clears them without it, hence READ_ONCE().
+ */
+static inline bool nfs_dentry_is_blocked(struct dentry *dentry)
+{
+	lockdep_assert_held(&dentry->d_lock);
+	return nfs_fsdata_blocked(READ_ONCE(dentry->d_fsdata));
+}
+
 static inline fmode_t flags_to_mode(int flags)
 {
 	fmode_t res = (__force fmode_t)flags & FMODE_EXEC;
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 679ef22637..a2845198d6 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -152,13 +152,13 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 		 */
 		spin_lock(&alias->d_lock);
 		/*
-		 * Not if a removal of this name already owns the alias:
-		 * ->d_fsdata == NFS_FSDATA_BLOCKED means nfs_unlink() has a
-		 * REMOVE of exactly this name, or nfs_rename() a RENAME onto
-		 * it, in flight and ->d_revalidate() is waiting on that field,
-		 * so storing over it would lift the block early and the later
-		 * unblock_revalidate() would store NULL over @data.  Tested
-		 * under the same ->d_lock block_revalidate() stores under.
+		 * Not if a removal of this name already owns the alias: a
+		 * sentinel in ->d_fsdata means that a REMOVE of exactly this
+		 * name, or a RENAME onto it, is in flight, whichever way its
+		 * parent is locked, and ->d_revalidate() is waiting on that
+		 * field, so storing over it would lift the block early and
+		 * the later unblock_revalidate() would store NULL over @data.
+		 * Tested under the same ->d_lock the sentinel is stored under.
 		 * Skip rather than wait: that removal makes this sillydelete
 		 * redundant if it succeeds, and a wait here would sleep in a
 		 * dput() path -- the nfsiod callback that releases a
@@ -170,7 +170,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 		if (d_really_is_positive(alias) &&
 		    !nfs_compare_fh(NFS_FH(inode), NFS_FH(d_inode(alias))) &&
 		    !(alias->d_flags & DCACHE_NFSFS_RENAMED) &&
-		    alias->d_fsdata != NFS_FSDATA_BLOCKED) {
+		    !nfs_dentry_is_blocked(alias)) {
 			devname_garbage = alias->d_fsdata;
 			alias->d_fsdata = data;
 			alias->d_flags |= DCACHE_NFSFS_RENAMED;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index d2c716322c..b45952727c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -678,8 +678,29 @@ static inline bool nfs_ooo_test(struct nfs_inode *nfsi)
  * but deleted on the server resulting in ESTALE.
  * So use ->d_fsdata to record when the unlink is happening
  * and block dentry revalidation while it is set.
+ *
+ * ->d_fsdata of an NFS dentry holds one of:
+ *  - NULL;
+ *  - a mount's device name, a string kept on the mount's root dentry.
+ *    Whatever stores over it frees it, and ->d_release() frees it
+ *    otherwise;
+ *  - a pending silly-delete, a struct nfs_unlinkdata, exactly while
+ *    DCACHE_NFSFS_RENAMED is set, which is what tells it apart;
+ *  - NFS_FSDATA_BLOCKED, while a REMOVE of the name, or a RENAME onto it,
+ *    is in flight with the parent's i_rwsem held exclusive.  It outlives
+ *    that hold only when a rename is killed, until its RENAME completes;
+ *  - NFS_FSDATA_BLOCKED_SHARED, from the store in the client's
+ *    ->unlink_shared(), with the parent's i_rwsem held shared, until its
+ *    ->unlink_shared_done(), which the VFS calls after any delete event
+ *    for the removal, whether or not it succeeded, and before it drops
+ *    that hold.  The dentry may be negative, or positive and unhashed,
+ *    by then.
+ * Both sentinels are stored under ->d_lock and cleared by
+ * unblock_revalidate(), and ->d_revalidate() waits while either is set.
+ * fs/nfs/internal.h says what else has to respect them.
  */
 #define NFS_FSDATA_BLOCKED ((void*)1)
+#define NFS_FSDATA_BLOCKED_SHARED ((void *)2)
 
 # undef ifdebug
 # ifdef NFS_DEBUG
-- 
2.43.0

