Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE964CA283
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859327; cv=none; b=FJkKS6lEt+OMAqT9BGVSFJF5pCwq9Eu6N09pps0kkpJo2dhH47A0LqrIL+c9lfGWDd2bLjim+hb/uhyyjTx/sYkjhllVJ2B5jX/fLfMboOJKaiuXRz17bP/p7eQR5M1i+cc4cMSeHJbZY75GB42kPAeXNgFvmRBZlzuic0jMZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859327; c=relaxed/simple;
	bh=loRo0FJCWslULYyycOZGQNnamz469o2FNuUiDLIhtdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz7L31gyd5p7GnFTD8kX5sIV1EJkPdWbycGJucupL+hhDHgyvAsYBU7dt6h8GweQZ1KZmdXcOS93uRxvWvqvV3cNC2bFjY6ywSswG0660RdlJLUpMD3k863rEYA+4dS/B9P0VSNPFEj5VyhjGRrDhEl4qdXDY1y5YgeHfKpSvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slyjCUUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slyjCUUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802CBC2BCC7;
	Fri, 15 May 2026 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859326;
	bh=loRo0FJCWslULYyycOZGQNnamz469o2FNuUiDLIhtdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slyjCUUe90vA1MdKAPW3qTQwgYTLXE3mT4Z5hGJetj4nWxr1L63vgaWgWYAYSqESm
	 MWaozrHZUUWXc3oSXjLpHyg48UmDIfkUcrNETNMjo9+tmXfwFrQqrnjDsTryuA8boV
	 94yU/AdiHNv01/rUw4yaLYZFF2JRmQ1SLY52+7cQPeucr8njiY/nhks5MMPihZ04GB
	 +W3Zu2GorduGUOatB3WW8ubbJKbndOhryRV1zB8RTuo5OnNjoD6SdBwrV37CytYZoZ
	 ZZ4GOI8G6xcjhKc67kXct5GmUO6Gw5mcHwWyqLqwj6L4KdUGvTnNgtiCs4acsPYiwo
	 /itc1HkKeR77Q==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 7/7] nfsd: Cap case-folding probe cost across READDIR entries
Date: Fri, 15 May 2026 11:35:15 -0400
Message-ID: <20260515153515.362266-8-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515153515.362266-1-cel@kernel.org>
References: <20260515153515.362266-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSv4 READDIR carries a per-entry attrmask. When the attrmask
includes FATTR4_CASE_INSENSITIVE or FATTR4_CASE_PRESERVING,
nfsd4_encode_fattr4() resolves each non-directory child's case
attributes by calling nfsd_get_case_info(), which dget_parent()s
back to the directory being read and re-runs the cred swap and LSM
probe per child. The encoder amplifies a single answer into one
prepare_kernel_cred() allocation, two LSM hooks, and one put_cred()
RCU callback for every non-directory entry.

No mainstream NFSv4 client has been observed to populate a READDIR
attrmask with these attributes; the Linux client queries them only
via SERVER_CAPS at mount time. The exposure is therefore to test
clients exploring corner cases and to hostile clients that submit
an attrmask designed to multiply server work by rd_dircount.

Probe the directory being read once and cache the result on
struct nfsd4_readdir for use by every non-directory child. The
probe targets the readdir filehandle's dentry, which is held for
the duration of the request, rather than dget_parent() of a
child's locklessly-acquired dentry; the latter could be moved out
of the directory by a concurrent rename and report attributes
from an unrelated parent. Directory entries continue to be
queried individually, because casefold-capable filesystems (ext4,
f2fs) report case state per directory. The other callers of
nfsd4_encode_fattr4() (single GETATTR, the buffer wrapper) pass
NULL for the cache pointer and behave as before.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com?part=14
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/xdr4.h    | 14 ++++++++++++
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 319007b79d49..20355dc3f1d1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3883,13 +3883,16 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
- * ourselves.
+ * ourselves. @case_cache is NULL for callers that encode a single dentry
+ * (GETATTR, the buffer wrapper); READDIR passes a per-request cache so
+ * non-directory children share the parent's case-folding probe result.
  */
 static __be32
 nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    struct svc_fh *fhp, struct svc_export *exp,
 		    struct dentry *dentry, const u32 *bmval,
-		    int ignore_crossmnt)
+		    int ignore_crossmnt,
+		    struct nfsd_case_attrs_cache *case_cache)
 {
 	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
 	struct nfs4_delegation *dp = NULL;
@@ -3999,9 +4002,17 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = fhp;
 	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
 			   FATTR4_WORD0_CASE_PRESERVING)) {
-		err = nfsd_get_case_info(dentry, &args.case_insensitive,
-					 &args.case_preserving);
 		/*
+		 * In a batched encoder (READDIR) every non-directory
+		 * child shares the same case-folding answer, so the
+		 * directory being read is probed once and the result is
+		 * cached. The probe targets case_cache->dir, the held
+		 * readdir filehandle's dentry, instead of the child's
+		 * locklessly-acquired dentry, which a concurrent rename
+		 * could move under an unrelated parent. Directory
+		 * entries are queried directly because casefold-capable
+		 * filesystems answer per directory.
+		 *
 		 * Per RFC 8881 Section 18.7.3, an attribute advertised
 		 * in SUPPORTED_ATTRS must come back with a value or the
 		 * GETATTR must fail. nfsd_get_case_info() fills POSIX
@@ -4011,8 +4022,24 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		 * advertises. Other errors fail the operation as the
 		 * spec requires.
 		 */
-		if (err && err != -EOPNOTSUPP)
-			goto out_nfserr;
+		if (case_cache && !d_is_dir(dentry)) {
+			if (!case_cache->valid) {
+				err = nfsd_get_case_info(case_cache->dir,
+							 &case_cache->insensitive,
+							 &case_cache->preserving);
+				if (err && err != -EOPNOTSUPP)
+					goto out_nfserr;
+				case_cache->valid = true;
+			}
+			args.case_insensitive = case_cache->insensitive;
+			args.case_preserving = case_cache->preserving;
+		} else {
+			err = nfsd_get_case_info(dentry,
+						 &args.case_insensitive,
+						 &args.case_preserving);
+			if (err && err != -EOPNOTSUPP)
+				goto out_nfserr;
+		}
 	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
@@ -4170,7 +4197,7 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 
 	svcxdr_init_encode_from_buffer(&xdr, &dummy, *p, words << 2);
 	ret = nfsd4_encode_fattr4(rqstp, &xdr, fhp, exp, dentry, bmval,
-				  ignore_crossmnt);
+				  ignore_crossmnt, NULL);
 	*p = xdr.p;
 	return ret;
 }
@@ -4208,6 +4235,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 	struct dentry *dentry;
 	__be32 nfserr;
 	int ignore_crossmnt = 0;
+	bool crossed = false;
 
 	dentry = lookup_one_positive_unlocked(&nop_mnt_idmap,
 					      &QSTR_LEN(name, namlen),
@@ -4244,11 +4272,18 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
 		if (nfserr)
 			goto out_put;
+		crossed = true;
 
 	}
 out_encode:
+	/*
+	 * A crossed entry no longer shares a parent with the directory
+	 * being read, so it must neither consume nor populate the
+	 * per-readdir case-folding cache.
+	 */
 	nfserr = nfsd4_encode_fattr4(cd->rd_rqstp, cd->xdr, NULL, exp, dentry,
-				     cd->rd_bmval, ignore_crossmnt);
+				     cd->rd_bmval, ignore_crossmnt,
+				     crossed ? NULL : &cd->rd_case_cache);
 out_put:
 	dput(dentry);
 	exp_put(exp);
@@ -4495,7 +4530,7 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	/* obj_attributes */
 	return nfsd4_encode_fattr4(resp->rqstp, xdr, fhp, fhp->fh_export,
-				   fhp->fh_dentry, getattr->ga_bmval, 0);
+				   fhp->fh_dentry, getattr->ga_bmval, 0, NULL);
 }
 
 static __be32
@@ -5022,6 +5057,8 @@ static __be32 nfsd4_encode_dirlist4(struct xdr_stream *xdr,
 	readdir->rd_maxcount = maxcount;
 	readdir->common.err = 0;
 	readdir->cookie_offset = 0;
+	readdir->rd_case_cache.dir = readdir->rd_fhp->fh_dentry;
+	readdir->rd_case_cache.valid = false;
 	offset = readdir->rd_cookie;
 	status = nfsd_readdir(readdir->rd_rqstp, readdir->rd_fhp, &offset,
 			      &readdir->common, nfsd4_encode_entry4);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 417e9ad9fbb3..615797df218f 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -432,6 +432,19 @@ struct nfsd4_read {
 	u32			rd_eof;             /* response */
 };
 
+/*
+ * Cache the case-folding properties of @dir so a batched encoder
+ * (e.g., READDIR) does not re-probe per child. @dir is the
+ * directory being read, held by the request, so it is stable
+ * against rename for the duration of the cache's lifetime.
+ */
+struct nfsd_case_attrs_cache {
+	struct dentry	*dir;
+	bool		valid;
+	bool		insensitive;
+	bool		preserving;
+};
+
 struct nfsd4_readdir {
 	u64		rd_cookie;          /* request */
 	nfs4_verifier	rd_verf;            /* request */
@@ -444,6 +457,7 @@ struct nfsd4_readdir {
 	struct readdir_cd	common;
 	struct xdr_stream	*xdr;
 	int			cookie_offset;
+	struct nfsd_case_attrs_cache rd_case_cache;
 };
 
 struct nfsd4_release_lockowner {
-- 
2.54.0

