Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257533;
	b=oAzyg4wXDVjWDWnEfTtvnEdQQOdIetjJ6yT06QVUEHRvVRhpuzAmS50CyoqTT7MMoXP5
	 5e8g9W3g5DjP8vxFCG9YE2ixIxKK7pyU7QO4Itd54qCzlcfLX/iXQICc59cJPZ0KXacM/
	 cCHbISSgVRORTxtw7S6jwc/Bd6DSPsOic00Xb5h+jOfzLLjWeQ3gwnpgUnVhX9ZkTH3Jv
	 m5CPDmbHiew/oTiwJRUb9t7GBGog6Ume5qFMxh2xCIwsNLFoh57a+ieBeASmuPySwzxBk
	 f1W8u/8fbUSR8D7vYQnsFxnrmoFYQeRSqHExaiZbWjV0vyuE3QryUnrtMTggosiMOOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257533;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=lFnDvIIf15wWJEk/NJrkflWxoq4d1zyNbWPBVLGhFIc=;
	b=rzkYCrjqJFjgQMfkNg5vBBW+CtZ7R+KADxzQV+DBrLErXjdj2mGsACzg86+w5gRHM5OB
	 YuhFTt+/BW84BVz7Lp167qFC5HpwoRiXCCzRnf4Kfz+PtWCbXe5p8h2UEuyRbIMWH3i6E
	 daOZ/t+KjXeqCImZQb4frF1lV+kYRXv7q5CBVwnCBfMgfpSEsHQOqotdtu5qGF0dxqDr7
	 0oTVOk+e87S2df+IVgQ/jkXV6ok5Go02+mUNLckjzmksEvzt/UGtvpXi9LbiGKWoQUiU6
	 cQvpM0bqaLIvlgUXKs5HroesrYHkWWZBSp1QO5z/z5LCJTJtSQ8xbvnAKC8SPjwyAEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=f+SpbeBR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pmT3Liaj;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F45606A32A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 20:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F45606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=f+SpbeBR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pmT3Liaj
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BEA5140015F
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 15:52:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 15:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794257532;
	 x=1794343932; bh=lFnDvIIf15wWJEk/NJrkflWxoq4d1zyNbWPBVLGhFIc=; b=
	f+SpbeBRNxVjrIV+p+zTUQ4wSam/Z2ZEpKStqEKoQF8L6XD5qdzoy2AFnuMaH21t
	8j8Ile05CQKM1PZIXJ77PkxX783kbHysXNOQ3ax57gfkmhBn260IXrrFFTQTXaEu
	VNXfs7bddLcfJOk916ARd8V15BIZ6Tgms8soIF11t3oh3XuKW0ZbebIQ7NuGaybs
	MgPawS/lRV0stb9J5Rl2tyynq1nCYRLzjiV2Tc+PukmC4uaE+/uYJkKK3Aw/GOGx
	GHjVzyuyBY77rpJXRl/hbYRAMYF+2vonBg04+Qg1cjKFvQlD5PqA9TRkn1h0gea1
	aQJUPhs6Fr3Na7rPHmWkAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794257532; x=1794343932; bh=l
	FnDvIIf15wWJEk/NJrkflWxoq4d1zyNbWPBVLGhFIc=; b=pmT3LiajADTgT5jsc
	SHkM1iqNsUrxSUNAc6ZsR4G3JItLKTE3gAVAU4mYiGyilcHewmat+kb8wp8t7GK6
	T66nJG0SVgktEQaR/aSxfDVZOwZbwJO38XHSPFYRul59W/yeuXT4+rBlLCmOZxZd
	6bRnwCvcIsCI0ztBffQsAxGbEr9fFcaBl77NNGgVl/kDqBU64J8KiKQC0v3uibp5
	Bj37aMxz8CdoKN4xwk2l1FlPN98m9X7d8PglprwcWb8rwHBDF1bN2XJhSmEvHlLt
	xvKi94bCQOsab0VtRQwv4BojmoS4U7u+rok8xjuhUHyfZ2DjU/SSK9JBURpVhAV7
	4GSQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257532; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:EzcSiOWqhw/1kRrARtj04dhnsVMSWDXJO0zBKcvOBWMVKI4
	N2y4wvPqzSX6ArC+FTj10tW7fTvimkxtxhRixHKaSOFCE9mL29FFmNbAusm3THBD
	bh+9LD3jfjzuaUInYu7hCu/7U1gTXc35Nqtqd6uJJ4D0RUlH0ugWk6sUnrx+Mfxq
	tymti7fqC+BHE2Pp1qVslkTp/huaZHc89HV69Po9kvF5SLOj88tAhPC1oSOS7mzH
	WDUoauSxWE+LALy30gHeQ/ZYmN7bD8PkNhz9RJSaG1vVBz34H7B5VucEEm0oyUUT
	xlfEi/QnA6OkhErDuOCywqsVXLkK2e+f01bzv4w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:wIDaHjgaHc5xEadbnXB6Na6mEianXIgqCOILa97zh1w=:90hJjMXsm556f1HSrGBwO5c4/5MV3a+u9QFLaZ3WH+g=;
X-ME-Sender: <xms:fDLyak4VvE9MMNXCsfXLHYF_5SJAGEFOuCjAndvQiWf_h5fMAStl7g>
    <xme:fDLyakKsmZjXZ65hlGO_8ZBOBcqiLnQfVdxJYFv4XQbftOcY7Tj0BNXZ6yYCIx28c
    aqMxE7wBUPkYoI7hxNpYFy0gNN7Q_tSOqhviW-9L9JBSze9Aw>
X-ME-Received: <xmr:fDLyasznVwoKYQykWvEnRhqm7MvgSTyBVRTPHlTUmGsFO5Li9ah5WdgjcV-bH96PkBhBil7zHMQsFs-sDycokBhwWC22bkY>
X-ME-Proxy-Cause: dmFkZTGc6Wfopr3yByBODvVP+Oeb+FLkCIAHSHXx7lKy5HW2U1upI0iembimvsk8AEpSZE
    MvwARY+UFbjHd9YV6pYDviSr02W6QSVyDIHPRBaIeKkb1ynLuXblQeWa4vWXWMBoGY2ylR
    8MibvhVLpjf6RGg5myDdFApSiNfnMFCWLo2DKnZNkL1ttRA6R81HrKhVsSTnWD3U90M/g0
    eiWpkBEA+yo88el8kYtfl23LMEmQaTJAZ92kFH+xvZejbh4XlaDKRH2fIaheAZzuwljtfD
    vNWLVebH1mhryAUvGEemIVHPzuHDbGpFhYTwQXOwD7SZCf79zoP3iXyu1/YWAyCQeXFgGr
    6+LGQypJXjy1S4mf3Sh7pDTvKtz+v0Sg9PZRD8GIXgjyrUwLqyrAKlpFkcCCyyK20kNMRO
    OwNTvbb8z0qmtww75XwnUq9/QoDcUA+AhXByYUviEuCkf2YVDRNTNbVjMm8+/AvdMlQF6l
    Q9hZMZk6CX2dlJmdyfXqIv/MJPvIfhDgys1CDFU3h5+g+I3HizLLkMr7XNRME8PhAlRh2o
    kqf/OWRq+sY58IM5Ouy0mqNwtXnpvT3Wmell9w6jUAz764k79zWcmZApEndi+3pi2pE7Eq
    ZJ8a+iVCXCmyGI4lC3XEgug5yB6WX6EQS0kNcdYbOeP8uG4x0zHQ5EM9aZXg
X-ME-Proxy: <xmx:fDLyasLMo_By_MPTuzxqeK1M9Uo5fXxgzUF1bnxljU7o89vInLbHgw>
    <xmx:fDLyarWVV26oZdarSHBULIsuzEe7TjmgPJOUkag2EfPIbkHTYlIICA>
    <xmx:fDLyavbG2GFcPnNr85DAQNtBir3gJlU1XrhR9U5yubJd3FYzkebtjw>
    <xmx:fDLyaiz0JvMDnSOfozghCqKBHfKE3EWHfY2HqxpDnQb96kjEMvTRKg>
    <xmx:fDLyah1fKz61tSt34A8Df3vAVbfpljDeX5gRQ2-_tqrVKqa5AR9uFSab>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:52:09 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org,
	"Jonathan Flynn" <jonathan.flynn@hammerspace.com>
Subject: [PATCH v3 2/5] afs: use d_splice_alias() in afs_vnode_new_inode()
Date: Tue, 10 Nov 2026 07:48:24 +1100
Message-ID: <20261109205132.1561271-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261109205132.1561271-1-neilb@ownmail.net>
References: <20261109205132.1561271-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
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

From: NeilBrown <neil@brown.name>

As afs supports the fhandle interfaces there is a theoretical possibility
that the inode created for mkdir could be found by open_by_handle_at()
and given a dentry before d_instantiate() is called.  This would result
in two dentries for the one directory inode, which is not permitted.

So this patch changes afs_mkdir() to use d_splice_alias() and to
return the alternate dentry from ->mkdir() if appropriate.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c      | 13 ++++++++-----
 fs/afs/internal.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 10420c4ba2b3..20c68a8b3028 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1257,7 +1257,7 @@ void afs_check_for_remote_deletion(struct afs_operation *op)
 /*
  * Create a new inode for create/mkdir/symlink
  */
-static void afs_vnode_new_inode(struct afs_operation *op)
+static struct dentry *afs_vnode_new_inode(struct afs_operation *op)
 {
 	struct afs_vnode_param *dvp = &op->file[0];
 	struct afs_vnode_param *vp = &op->file[1];
@@ -1274,7 +1274,7 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 		 * the new directory on the server.
 		 */
 		afs_op_accumulate_error(op, PTR_ERR(inode), 0);
-		return;
+		return NULL;
 	}
 
 	vnode = AFS_FS_I(inode);
@@ -1285,7 +1285,7 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 		afs_init_new_symlink(vnode, op);
 	if (!afs_op_error(op))
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
-	d_instantiate(op->dentry, inode);
+	return d_splice_alias(inode, op->dentry);
 }
 
 static void afs_create_success(struct afs_operation *op)
@@ -1294,7 +1294,7 @@ static void afs_create_success(struct afs_operation *op)
 	op->ctime = op->file[0].scb.status.mtime_client;
 	afs_vnode_commit_status(op, &op->file[0]);
 	afs_update_dentry_version(op, &op->file[0], op->dentry);
-	afs_vnode_new_inode(op);
+	op->create.ret = afs_vnode_new_inode(op);
 }
 
 static void afs_create_edit_dir(struct afs_operation *op)
@@ -1365,7 +1365,10 @@ static struct dentry *afs_mkdir(const struct mnt_idmap *idmap, struct inode *dir
 	op->ops		= &afs_mkdir_operation;
 	ret = afs_do_sync_operation(op);
 	afs_dir_unuse_cookie(dvnode, ret);
-	return ERR_PTR(ret);
+	if (ret)
+		return ERR_PTR(ret);
+	else
+		return op->create.ret;
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 578fe7d35ab4..1542b53e2cd8 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -899,6 +899,7 @@ struct afs_operation {
 			int	reason;		/* enum afs_edit_dir_reason */
 			mode_t	mode;
 			struct afs_symlink *symlink;
+			struct dentry *ret;
 		} create;
 		struct {
 			struct dentry	*unblock;
-- 
2.50.0.107.gf914562f5916.dirty

