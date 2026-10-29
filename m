Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297421;
	b=i1/3gepvC/txwYLqI8TtmIZI5+S4QdkkCbQIBicday51vVPirnEI7o0uUxI2lZ4VJWpz
	 8iYGKX8IPVabxLOeEvM0V+L7U0WXlNhLSNE10zcfwXjd6Ou6A9h23rdozhWkFH+gZxi9U
	 QPHBEFHqqCU2nsJScm4GM6s1XNqu3BNfs6nxacCCbYIPui9jx43lf23jLiMw/CFoj1ZWk
	 xxp711o3CB0T7ky2B7r5wplqaTYEm90B3dsfe5jUpsAXXHXt8xdFd7H/DF/WCkrAJi1yg
	 B9MfTYsC2I+/nVPh1oyq+Kehw1kHbTFn7W9AzD2jNK/1N1E+5oLvyFuAnd9L16AkSGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dgDYcOW/jCAQEvwY8NBNP2pASb7BMmxqcS2FbIf9bZo=;
	b=l4JcRX12U6u9tZMEkKAaofa6+Ke2JR6OfBzTe3uZ/sTKLKH/zMFb33MbOzs/aIuxHcgG
	 gEyNTBXm2ZIEcHuIBcZ8iROFTC70rvhrwOUpAw6tAT8LHcJ/Fv244NC4Qd6Z7uWFKejfN
	 Km8I3j9fu6QnPEAXDy64N9phKxIhUHYmjNiatc4jUOi4TwqniR9Tkb4tjAnoMuTzNAGgP
	 jhRj/CsV0HSnp4cLHbsKDZRtfmEv0FDiVfyqDQOA5Pn4cdP62Z4NhxXeZWaFNvQNW6JWI
	 4OSM1aMM9WmHPIgr88uvV4Z3vC4K+ldSsFcLvudtYUNrMc/KAVnM2IrufnGhHrrTcxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=lFibtdcF;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFA606AB69
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FFA606AB69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=lFibtdcF
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso1855506eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297420; x=1793902220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dgDYcOW/jCAQEvwY8NBNP2pASb7BMmxqcS2FbIf9bZo=;
        b=lFibtdcFnO6KOqq8bSRxHk0Ur98BYC9nkkggQQjWcH5Ron4jwFF2ZXs8MhZCx8vBCm
         OskDTwXg65lR8vhrYqaexkRul6btl1l5BsJRhn9pM/uoufUoWouvVgaysGA4RbxAhhkt
         NVA45FoGbpTgCQ9sCymd46tpUq6BcMjFm3ocxdoXXwVK2E5LPKLYFTErhRmOGlFvnzpb
         obJhgn3ctJVM88C0IFZeS7gdetAbAqhzKL4jfMtuaH6d9O4zyUz2KQaya67ro94HGJtN
         2nHlBTN9mQsKjuRVQZFpXsdK3GTZNK0ROaJFkmqaf4/SZcA3blKolhRb+9DFEFLGryJU
         GyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297420; x=1793902220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dgDYcOW/jCAQEvwY8NBNP2pASb7BMmxqcS2FbIf9bZo=;
        b=lN/Xy9dzb4TaFAkBwM9fvVSJxigoMO7F57KIoi5vxB56gu+Nlm6MMxQX2s7OLVEyFz
         tQXYwYaD8akyqsMi+CsI5fXeC25n4z4lbGqEY4jy/qUderGXIp7mJyu53mr833qgVW0F
         vse0FNZXAHEu1eLIKsNzJCuhzaoefyFUFr7L054PW3l0P7e/w9SNhoZWvMfSEtafXV9E
         EBOwgwSeApqZJ2i3gBODS25pRslD8YgZUmkFOgOmOrx22XfExo1/Y0GttrTsHvBP8r05
         JEgEIv8UzdBco8RRaZwG9Bp0zNoz5iHv6bG6VGR7SMboAIaxOfj3vH9pK/ndjvDyeEzW
         y6bg==
X-Forwarded-Encrypted: i=1; AKwUvBwrEgmAOW8+7ReHozMEUngQ8hOvsBKvYS70RpQOisNYD60nLs+CTpGO+erYibXJGQjoFAxxvXolFhGXnt0j@vger.kernel.org
X-Gm-Message-State: AFq9FYIqf7kNL/yZ7PQG88YK9Xu69J1EhhHuNKrg8K4MB9tf1/K7twhZ
	aOotGbNuZXlEpqkIbf42/L3YZLAuLY8E+NdVI4fQIhnY145vc3MDTKMudYnoJoNmdDozQovCz4l
	+7dJ3hIQ=
X-Gm-Gg: AYBFou20b4l0di1KXS+33JivMUPockRnGA53cX708DBG1pBQVJvLsZ7eHgwoh2GvKDT
	VfSZZXZUbVMOw7lf1lgOOqZnrrfyMpT/af9c9E910CEp0O0TUxrPHPl9PPCMEHmeroCf6G2dBri
	a9tSaiuBRyy4tjVUwIQJV1z+3iEdYcy+uMiH1Y9xqk7PuYjC6t/QjVJcr2tK0ER4eHPvV+YieWB
	5ItTUOMh3Hqh0Xi51adn+6UfLT/B29oBMEriT4KLfBZ/JbbbkrknJWNFIoOIimy9/AKlD+WLLuV
	W7W4X2YMF2fF8T040V7sJfEi/lIJDnsDRpjyvM8oF64x0DplvGkpjuLFVJOmBdxrpCZhKWjrLUd
	PyHvgy7+1ZdajChXmGPpRJY9ussGIq1ZSMVHlvBvNkWwK0F6fvqAGohsbCBzhOMbr/2QkUcJFpm
	Void7pzGKzpl4LmCNE39PhEHkKmbqTxUwQPe5x0VCgs4IXjaWrzwTLqwNM6EJg4eEMOjyHcxg3+
	1WMc3JUCRDUthX7FVaV/UgWi5nOxOAWM56cGNsA7Ys/CeXPxSuoU8sr9UU/5VWiVrMAOdQ8sY72
	flPZtF+zPUFaPFlDri181IF2a9Y0kBjUtwl/pNU6/NvGY4kmPEpq7R3n/f4AAd2IiDWKQ8lv
X-Received: by 2002:a05:6820:a504:20b0:6dc:6e90:f650 with SMTP id 006d021491bc7-714f2947ed7mr33452eaf.15.1793297419439;
        Thu, 29 Oct 2026 11:10:19 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b89asm189856a34.6.2026.10.29.11.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:16 -0700 (PDT)
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
Subject: [PATCH RFC 09/12] nfs: do not cache a name from a listing that a removal overlapped
Date: Thu, 29 Oct 2026 12:09:54 -0600
Message-ID: <20261029180957.387138-10-jonathan.flynn@hammerspace.com>
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

With a removal holding the directory lock shared, a directory listing,
which holds it shared too, can run beside it, and the server can build
the listing before the removal while the client reads it after.  The
client would then put the removed name back in its cache as a valid
entry, and keep it for as long as it trusts its cached view of the
directory.

Count, per directory, the removals made with the directory locked shared:
those waiting for the server's answer, and those that have had it.  A
listing notes the second count before it is requested, and adds no new
name to the cache while a removal is waiting or once one has been
answered since.  Positive entries already in the cache are covered by
"nfs: keep the dentry of a shared-parent removal hashed".

Nothing counts a removal yet, so nothing changes.  NFSv2 and NFSv3
listings note the count too, and NFSv3 listings that return attributes
make the same check; the behavior of both is unchanged.

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/dir.c           | 16 +++++++++--
 fs/nfs/inode.c         |  2 ++
 fs/nfs/internal.h      | 63 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs.h |  8 ++++++
 4 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2a4c059064..d9ba3cb1d7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -165,6 +165,7 @@ struct nfs_readdir_descriptor {
 
 	__be32		verf[NFS_DIR_VERIFIER_SIZE];
 	unsigned long	dir_verifier;
+	unsigned long	shared_removal_seq;
 	unsigned long	timestamp;
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
@@ -603,6 +604,7 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 	timestamp = jiffies;
 	gencount = nfs_inc_attr_generation_counter();
 	desc->dir_verifier = nfs_save_change_attribute(inode);
+	desc->shared_removal_seq = nfs_dir_shared_removal_seq(inode);
 	error = NFS_PROTO(inode)->readdir(&arg, &res);
 	if (error < 0) {
 		/* We requested READDIRPLUS, but the server doesn't grok it */
@@ -723,7 +725,7 @@ static void nfs_lookup_advise_force_readdirplus(struct inode *dir,
 
 static
 void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
-		unsigned long dir_verifier)
+		      unsigned long dir_verifier, unsigned long removal_seq)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
 	struct dentry *dentry;
@@ -825,6 +827,15 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		d_lookup_done(dentry);
 		goto out;
 	}
+	/*
+	 * Make no dentry for a name that a removal under a shared parent may
+	 * have taken away after the server built this listing; see
+	 * nfs_dir_shared_removal_since().
+	 */
+	if (nfs_dir_shared_removal_since(d_inode(parent), removal_seq)) {
+		d_lookup_done(dentry);
+		goto out;
+	}
 
 	nfs_set_verifier(dentry, dir_verifier);
 	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr);
@@ -853,7 +864,8 @@ static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
 	ret = xdr_decode(desc, entry, stream);
 	if (ret || !desc->plus)
 		return ret;
-	nfs_prime_dcache(file_dentry(desc->file), entry, desc->dir_verifier);
+	nfs_prime_dcache(file_dentry(desc->file), entry, desc->dir_verifier,
+			 desc->shared_removal_seq);
 	return 0;
 }
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e0a2e92952..7885216a48 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -426,6 +426,8 @@ static void nfs_inode_init_dir(struct nfs_inode *nfsi)
 	nfsi->cache_change_attribute = 0;
 	memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 	init_rwsem(&nfsi->rmdir_sem);
+	nfsi->shared_removal_seq = 0;
+	nfsi->shared_removals = 0;
 }
 
 /*
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 907ea27ea2..9cd8e5e808 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -152,6 +152,69 @@ static inline void nfs_d_drop_unless_anchored(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 }
 
+/*
+ * readdir holds the directory shared, so a listing can run beside a removal
+ * made under a shared parent, and the server can build the listing before
+ * the REMOVE while the client decodes it after.  Once the removal is done
+ * its anchor no longer stands in the way - the remover's d_delete() leaves
+ * the dentry unhashed or negative - and priming the dcache from such a
+ * listing would put the removed name back, as a positive dentry with a
+ * valid verifier.
+ *
+ * So a remover counts itself in ->shared_removals from before it sends its
+ * REMOVE until the reply is in, and then advances ->shared_removal_seq,
+ * before anything it does can unhash the anchor.  readdir samples the
+ * sequence before it sends the READDIR, and makes no new dentry from the
+ * listing while a removal is counted or once the sequence has moved.  A
+ * listing whose sample is the advanced value was sent after the server had
+ * answered the REMOVE.  The count makes priming stand aside even if the
+ * anchor were to be lost while the REMOVE is in flight.  A dentry that
+ * priming finds hashed is left to the test in nfs_prime_dcache(), which
+ * leaves it alone while it is anchored and once it has been unhashed;
+ * one that the removal left negative is dropped there, and its name
+ * then gets no new dentry from such a listing either.
+ *
+ * Both fields change under the directory's ->i_lock, and the test reads
+ * them under it.  The sample is taken without the lock.
+ */
+static inline unsigned long nfs_dir_shared_removal_seq(struct inode *dir)
+{
+	return READ_ONCE(NFS_I(dir)->shared_removal_seq);
+}
+
+/*
+ * Has a removal under a shared parent been in flight in @dir since @seq was
+ * sampled, or is one in flight now?
+ */
+static inline bool nfs_dir_shared_removal_since(struct inode *dir,
+						unsigned long seq)
+{
+	struct nfs_inode *nfsi = NFS_I(dir);
+	bool since;
+
+	spin_lock(&dir->i_lock);
+	since = nfsi->shared_removals || nfsi->shared_removal_seq != seq;
+	spin_unlock(&dir->i_lock);
+	return since;
+}
+
+static inline void nfs_dir_start_shared_removal(struct inode *dir)
+{
+	spin_lock(&dir->i_lock);
+	NFS_I(dir)->shared_removals++;
+	spin_unlock(&dir->i_lock);
+}
+
+static inline void nfs_dir_end_shared_removal(struct inode *dir)
+{
+	struct nfs_inode *nfsi = NFS_I(dir);
+
+	spin_lock(&dir->i_lock);
+	nfsi->shared_removals--;
+	WRITE_ONCE(nfsi->shared_removal_seq, nfsi->shared_removal_seq + 1);
+	spin_unlock(&dir->i_lock);
+}
+
 static inline fmode_t flags_to_mode(int flags)
 {
 	fmode_t res = (__force fmode_t)flags & FMODE_EXEC;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b45952727c..3e86449485 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -205,6 +205,14 @@ struct nfs_inode {
 			/* Readers: in-flight sillydelete RPC calls */
 			/* Writers: rmdir */
 			struct rw_semaphore	rmdir_sem;
+			/*
+			 * Removals made with i_rwsem held shared: how many
+			 * have finished, and how many are waiting for the
+			 * reply to their REMOVE.  Both change under
+			 * ->i_lock; see fs/nfs/internal.h.
+			 */
+			unsigned long	shared_removal_seq;
+			unsigned int	shared_removals;
 		};
 		/* Regular file */
 		struct {
-- 
2.43.0

