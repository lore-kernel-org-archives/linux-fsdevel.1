Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE45439916;
	Fri,  4 Sep 2026 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558819; cv=none; b=G7f9VQuhj7mU+ftWmFnUgLUx1T4ljtUePz+dr+a7HX56SvrJpRZl1KdtDWHwRet67ulJ5WT3KZAaASxsJcxTu294Cbk4oWFwtIgMDexjzLlqDEPyr43EVKDtP0VEuGyS3gHgsHqOALqHLsiiWMT72wfMNXmIfIizmM6rOQ3FL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558819; c=relaxed/simple;
	bh=litQKQpxq4Wvyjuf2fzuVAMeubOciQd5GfzX88tQytw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ae4CL7hoRdDBLpLiFjuktdUz9aKsZRSU/rHkeWRSniNfkD93VKffGZ7E1IovHSgx1nSORFsbrJlfyhS2TPnnfUDwpdWtOHK7t2Cv7lOk8e65Q15jvKacHMSLxZb8f3Wa8orqKgQYQSXgBUnrzvlf/VTUV771T5ZggChBAwKA3N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WqODwf97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVxdUNRD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WqODwf97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVxdUNRD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F844EC0148;
	Fri,  4 Sep 2026 17:53:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 17:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788558815;
	 x=1788645215; bh=Kt2NwALlbn71BGQUotT5OMUi/Oh7eR7WXE5EosRsD0I=; b=
	WqODwf97e7In19o8nIsInTM6H+z5cECf4JUj9J68ccbgIm4l2qp1RqImoCMZ22O8
	0DfkIEGVrvxL8QfQ1AHHmAvZj/OPpZJ2YHr4QjHZHfXvFO5ZAEWaU0i7pumB1FI6
	aDV/Z73QdILOyPp+iNiOCJ7dr5uwOrRYv07Y1iiRD5kzwdCRlQZDLNVvrrIZG6VE
	P4Hx4Uw7Y6evdt4wESeuAPa4sbLe84qEi6KVHqnkGgeWPKILB4bUFmyLHAZ6cigZ
	9mwK8k4nnIaf6lgVYxp7FXV2ck79py9DxukBXI78vs4Hg7lnG+Vfp77ePtSTwCvl
	4LvtlMghU6MkHqwoznsxBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788558815; x=1788645215; bh=K
	t2NwALlbn71BGQUotT5OMUi/Oh7eR7WXE5EosRsD0I=; b=fVxdUNRDFDNTkKUZV
	yolBALOlXorVh5oO8ibPITH4/3P0fu3f7lyYxXEBOG4ljLNOCf0Z1FH+ws3xpdjg
	98noa1vdmW8ezNuxgwtbub4vDyCutv/qPyg3tY2UtPS9NMjV/HFTXmAf3f6lRxHe
	Rfhr9P8xhmWRn5qaNL0tdjDTh7/zkCbgoKou3xygu/JmmcZ4qFwyVQNixGKhUh3z
	ogBs/CGQdfoEc9m7VfTlDamaUOx+IkS5CtJI2mBOuIAAOFEm8syvvnbx7XMkj8u3
	lBhNtRvHjl2sjxvMsqGPDJiaMs9tDrakeFluFug/9cz3HnnYtyrYJqCOgcCrejgd
	60BrA==
X-ME-Sender: <xms:3z2bas23obeTlBRdVhGY0Aj4WJCRs5J39OHeaK6F0uDZarP4B6CMxw>
    <xme:3z2bappQreQjIuGQzSYvNwTy1Wn_XsQAb-EhxbTxwRwQaJFIBy00S49oKBRzr6gqc
    ypNyJnd7dLx3-1M3ukpAW5PIhdRRpyRdWYHIzOucg7-1ejlmLg>
X-ME-Received: <xmr:3z2baoiCS3UCj-ZTPs7bzeAl36R2tvWfGkq6eb9n-Fgl1vdNIA49Hp3pfroUB2BM7fE-xUhAO3sXyOEI5sK6_uETMngk1Eg>
X-ME-Proxy-Cause: dmFkZTFDVljjZPAYZ1l/aqq4nrL+3Kba1UGdgNzRbLHxNyZsBntb6givVbdJfo5BU3j95t
    +UQU7WjR6Go54RULzYYdNoUTzLStmDkBzIg7iAUMGGPyun7cXaJ/tB+RDeFqAMJs98sAqA
    8UTNhC/OQM/aHTCEgRGMWo/qNqW4Cm4ZpbUAGc1yB/wYZCmyUFIFjHNO+nBl6KHnpd3kh5
    kJGEMNZuUD6j2jJVpJ5tURud5waXhGOgIEZWqqHFhojd6ln7NIlrB7SgqCD/laD7h+xaRU
    I5R2WpSXAH/sDdSGVPXGsuUa9Zu1lOQJK4tOelP1k+iwmt4tCWllwcYTI4lONAt5xo76Pq
    hlGh/72u4tuQRb17E5/sphiIlu48OG6JGAc3TOBAspDQXILE49eS1TSd6nMc8l97o++gQ2
    Aiv0yLPpk+6R4pEpIjVQG8pKEN/R0nvb8n9kRsybpC0b6TvGf/3VxXKMmkSqccUSkMu6vz
    +TsTG3GDYGcCSKRN3Sa+LCCEQPEECHCnEibyH+vPHwjigVTYTLra81K3BlwWaVmo+8C5bo
    go3tDOOZzok7BSTz9JCqFW8eRxOcqeiOFW16c7aXJS3VtxpE8Eex/f8Ifd4/5NErDlxpG3
    UEEEpUsYXCMV5jM+c+Ak6GLQPOMisiFS5aGcva/YsqIKGXeYmgCvpGbjByKA
X-ME-Proxy: <xmx:3z2bal95WRt7pF1cy-kclo3Au03xX2ufq554GL_cX5g8Hv-vymb-vQ>
    <xmx:3z2bakU3OM-dAhOjf_cotBqiISpj3ME3-F22wPFvQ8nzax1RDMeD0w>
    <xmx:3z2bapA81ZfWiElrZ6JmjFUY2fneBOna_bCE_GUyoyFomgOMbBYg0g>
    <xmx:3z2bapEl-7dxPXjHvudvUHff3u0jjjBXBOvjkwPWeCVRXqgn9bX7JA>
    <xmx:3z2bameieGd3dSq4R4eg21-HpNnsv8UUPoC3KSN4NZiJ53qiWOTvNDGU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] VFS: introduce d_alloc_trylock()
Date: Sat,  5 Sep 2026 07:48:12 +1000
Message-ID: <20260904215142.1060510-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260904215142.1060510-1-neilb@ownmail.net>
References: <20260904215142.1060510-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Several filesystems use the results of readdir to prime the dcache.
These filesystems use d_alloc_parallel() which can block if there is a
concurrent lookup.  Blocking in that case is pointless as the lookup
will add info to the dcache and there is no value in the readdir waiting
to see if it should add the info too.

Also these calls to d_alloc_parallel() are made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So this patch introduces d_alloc_trylock() which doesn't block but
instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
dcache (smb/client, nfs, fuse, cephfs) can now use that and ignore
-EWOULDBLOCK errors as harmless.

Unlike d_alloc_parallel(), d_alloc_trylock() calculates the hash and
performs a lookup before an allocation, as that is what all callers
want.  This is done using try_lookup_noperm(), necessitating the
inclusion of namei.h in dcache.c.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 81 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index fd74753e7715..43149c7849d9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -2756,8 +2757,16 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name)
+/* What to do when __d_alloc_parallel finds a d_in_lookup dentry */
+enum alloc_para {
+	ALLOC_PARA_WAIT,
+	ALLOC_PARA_FAIL,
+};
+
+static inline
+struct dentry *__d_alloc_parallel(struct dentry *parent,
+				  const struct qstr *name,
+				  enum alloc_para how)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2830,6 +2839,12 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			spin_unlock(&dentry->d_lock);
 			goto retry;
 		}
+		if (unlikely(how == ALLOC_PARA_FAIL)) {
+			/* mustn't wait for concurrent lookup to complete */
+			spin_unlock(&dentry->d_lock);
+			dput(new);
+			return ERR_PTR(-EWOULDBLOCK);
+		}
 		/*
 		 * somebody is likely to be still doing lookup for it;
 		 * pin it and wait for them to finish
@@ -2863,8 +2878,70 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
+
+/**
+ * d_alloc_parallel() - allocate a new dentry and ensure uniqueness
+ * @parent: dentry of the parent
+ * @name:   name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup(), then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_parallel() waits for
+ * that lookup to complete before returning the dentry and then ensures the
+ * match is still valid.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error %-ENOMEM.
+ */
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
+}
 EXPORT_SYMBOL(d_alloc_parallel);
 
+/**
+ * d_alloc_trylock() - find or allocate a new dentry
+ * @parent: dentry of the parent
+ * @name:   name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_trylock()
+ * returns with error %-EWOULDBLOCK.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name need not already have ->hash set.
+ *
+ * Returns: the dentry, whether found or allocated, or an error
+ *    %-ENOMEM, %-EWOULDBLOCK, %-EACCES (for a bad name) or
+ *    anything returned by ->d_hash().
+ */
+struct dentry *d_alloc_trylock(struct dentry *parent,
+			       struct qstr *name)
+{
+	struct dentry *de;
+
+	de = try_lookup_noperm(name, parent);
+	if (!de)
+		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+	return de;
+}
+EXPORT_SYMBOL(d_alloc_trylock);
+
 /*
  * Move dentry from in-lookup state to busy-negative one.
  *
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4b1ff99608e0..7afe16d4664d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -257,6 +257,7 @@ extern void d_delete(struct dentry *);
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_trylock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
-- 
2.50.0.107.gf914562f5916.dirty

