Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578382;
	b=a1Zna6WME+xapWIGRx+mfFjR7z/0CrkR1f/Nmx5zluPapYsxd3jjKC0YNUXr6WtcsrMv
	 XuWdesyAXIctYNyxSNY+0McUyeDXGMTWQtDcNlZ/MoIycGQzc1a5GWAR4WYT/Ky6qtRvO
	 77SaVsZKnSewBUYOMIzVDIIBG2UTeDxE8K0UBuQaxze/vGeDGvfsHuGYL3dRwyFQ87Upg
	 CpFceMmrt4MREccuPPHv13WCIh0vtF5BNIjkpun9ncYGNy9Za7WS0x2EbD8Xn37gQ8f7J
	 M/AL4bYN8/9+dwWoKHnAkzU7VjX1ypoWAy4+1SSb9qN65W0S2HeyUYP5HNG+TbfU4Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578382;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=ON28AAe9H8PaSRxrPfcOUI1NHdsDwnr339Ed+VJebnM=;
	b=DEHohCyPOG46P78SSDo9JccPxK2EHT7FZD92asn5BTXhdXb3cmmbUFz5tfB/c+7ijDUT
	 rZDRBe+LOkA9wQHwUIlwkxnt23tgszo8uLvzR8/D6zWp6YyuyOO0gGQX/b14QIomnQwZn
	 PMysH3AsF9R06pqUPne2kUGwLJYpdhO1HX02uzMsyE3bAX0HWluVmYLPz08SK2WXVlCQ7
	 DpmuxbLzp8WEitWLf6TlyC/EVCt3vg/osKdlh4WAKW5KqgLjssPxM38kSeQL9yCKjbO09
	 PIZib71DvlrAqF5IBiVnwtCDpIoGS2sCGBC3p4EQ9V44yO5B51zmAAnuZ/mhx3PAD9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=hwxd9BmG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="QGXD/in/";
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC92606A329
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC92606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=hwxd9BmG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QGXD/in/
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BD501400295
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:46:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 22:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578381;
	 x=1795664781; bh=ON28AAe9H8PaSRxrPfcOUI1NHdsDwnr339Ed+VJebnM=; b=
	hwxd9BmG/7q+wfRpCFdyf9l9arB06R/OXrSEHNyyijWCfmylWdqqmlOL+7AolKtD
	hvnJjHhmag1zbkjjTUhFLLZ+dYwiqo0RRsAo0OY9Ee1hGE9MDHKLbb9HgSIRa2Xx
	gX4fyffBqMIMcTcVfoOOLluAL72vWfAX28kQ48r4hnB/GTNJBEQZlwK+WtRYrYz3
	PIM+Ruc02ouVqhqiCwHEGDm3seSsABXmYY+IwriWVg85WqJFUakVq54MnZMhe0to
	H31/tx5lKihJcStRhpQmQbWG4xItjBVsAAZ1OWrAi5LACU9oIQtlOLqkIUB5GlVY
	K4o1BDOWBh8Zd2fayh16Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578381; x=1795664781; bh=O
	N28AAe9H8PaSRxrPfcOUI1NHdsDwnr339Ed+VJebnM=; b=QGXD/in/q7sjjY6bv
	RA+hk5CfLb12Cd7lHSK7Qkqzds5tIJkkhw27Q6podxdtiVKDtIVkktuo6Q8RaC4L
	BIqhfjeBVuoEShSejQsifqxsqO6Fb/pjpil31nnPIcXKDKMVFPHzVDakQkkxSb3+
	f9058rQn7SSd+fcdN2kAfaQCnxPtUDRhbH+0Yc0VuVJ2IIGBH8OTopJqZ7EMDcdH
	S8VPzLoAORh0EUaTir/5Ifadu/kMdNgfgbs2dB4tlV8WhAHBb8exblNsKVvfT0M1
	DhJZcUU5KI7wSBlFT9BeFhsM7+JdJtt8U7fhJj3kVzrhXAZz6g205oNi6rXsCBoL
	lpXmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578381; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:tm9QvOZFUoxmksIVj1hFYaShetjJbgFCKKSAQcMxz5v0Ck0
	2rsw9nCktCxSIVMadpF0dj+Yo7BYhGrs3LBxFf/86gNR0ZmcP7FZkxJMlEKp+AAl
	ohImGOjmn+lSzVYPfBWEEbhMC4UzQfPha2951VPCFYPYKWuTEutzUWaWvfK2lMam
	6I2Js6WSElktk6xL++Oje61w+wNdgesYxvg4XYb2Gs1avdfL+UhARR+LQSKip+4M
	cRb8S4kPK7OeX4i3kVk6YmiC5IJXmImmd6qmhwWK89C+I9qZpDK5lUsRen/qzfO/
	m+PSXWyUyks2DSXZyKT8CMWVV7Umm8ksfMjcf+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:eguHeZTnAMAD0UBnEhXypByfDg6uTNAh6GEvAdMk53A=:XMRrqEBn5PnoqCUWKBChnhuV1h4oUYsKwei+sLthGYU=;
X-ME-Sender: <xms:DVoGa2jyC_ubQyimHpiGQuxNB8br7SY6o95P6vvVeQ-zZ51PEVCsKg>
    <xme:DVoGa98Do1xHAaTzZHZgqMK2x-pqmg2Z9BbTXK1fi_VaXkUolihXX3FeLWwxmVdM8
    62sDZ-7xBpR6Pm0t0o7qs7_g7398EqiEp8_82dmoIdXY6FDrBI>
X-ME-Received: <xmr:DVoGazJSZoyiVaGY0ixAGJeG3Rsuo2nJSszb01mkg-t5SiaTGmNNxR6tUSsitECMeb9hE68b7QCrS3EsmgzcDmWSsox19sk>
X-ME-Proxy-Cause: dmFkZTEynqFP7J5CyP864zJ/XBXUDXSwXypje4KQHx8Td74dpnR0VUtokV1VIo6Vx6RvWY
    OwcUpg/bo5jA9DF1nhHbEWSmkeBRQExzYYNm6zYQ4OlhmT8++hv04QLhCP77UTRa+ts0Zn
    emG1u4CBc9EwIQZMHpuGtkFzNaPM0COhHCVGi+vUdiGKTo3oTFKBSdfX5nxIKQZvHQpAoR
    JpPaJpl8D3VaaEmf1HZfBeZUeFh1WggTkTCrotD4I8diURcXOaSBUF/YM1mWjxdOr0yho5
    GSRzb/bSajGZoPtTNw69mn1JgOv5z8FPk55EPMBJOvn4tHIN4QhGRcsvm9DrK4aqK7NvOd
    Q4rZy33l8YShvFNJHuyhKLejrNcIU+o/kT3IWwqy7xl+p8veOkh6bKbR3TO8bqkig7EcPX
    8P6tcwDnsSCoKj+SAmd5wj28S7XugR70HfDVYW04sbvGLzMLk/fof0zJKmFfuEAICtP7BB
    V0Eb/1lgl0d7/LdXPeAMNpZDnDRrm97wc33ro/jubLnCPLs2k239d1NVTWfY3SHi+zSeQt
    6DmSvTk7yGcMcK3g+57aPqEYODavRb3HmDgKmYQbDT/Bd8Hx9/VOo3DFfTwhFUFeauVqaZ
    cqE2DGCkXQVQQMejXMVL2saPNjl14KtN//vJZvIIxTG7zeMF4rKMrQGVzldg
X-ME-Proxy: <xmx:DVoGa2YjOPw8teucHE9HrUYFTJKE6xcZw75oXeAhyDcTJSSBR_wPrg>
    <xmx:DVoGa-iqGwSOYDjnMXTe3yvtAQsoSvCenNVbkzd_GC46ND24BIPcrA>
    <xmx:DVoGaz4MBtYexQYDyxXozaIwTuCtKcQQ0_kf2PJt9U0zwMEqGcb9SA>
    <xmx:DVoGa-oyB9BllMdPvIM-n3ZgPk26VXbmbRTPtjqsMxdZ5MCtQSlHCQ>
    <xmx:DVoGazcWRAIUcxaVq-3TVvVVTYFjng9EQ-vATTeadmoVjG-YOQ8peWx7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:16 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 03/11] afs: don't unhash/rehash dentries during unlink/rename
Date: Wed, 25 Nov 2026 14:16:41 +1100
Message-ID: <20261125034543.4084039-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
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

afs needs to block lookup of dentries during unlink and rename.
There are two reasons:
1/ If the target is to be removed, not silly-renamed, the subsequent
   opens cannot be allowed as the file won't exist on the server,
   but they shouldn't fail until the unlink/rename completes.
2/ If the rename source is being moved between directories a lookup,
   particularly d_revalidate, might change ->d_time asynchronously
   with rename changing ->d_time with possible incorrect results.

afs currently unhashes the dentry to force a lookup which will wait on the
directory lock, and rehashes afterwards.  This is incompatible with
proposed changed to directory locking which will require a dentry to
remain hashed throughout rename/unlink/etc operations.

This patch copies a mechanism developed for NFS but uses the new
DCACHE_PRIVATE flag rather then ->d_fsdata.  DCACHE_PRIVATE is given
the private name DCACHE_BLOCKED within afs.

The flag is set when lookups and revalidates must be blocked.
d_revalidate checks for this flag and waits for it to become be cleared.

->d_lock is used to ensure d_revalidate never updates the time stamp in
->d_fsdata while DCACHE_BLOCKED is set.

For a ref-walk, ->d_lock provides all needed sequencing.  It is taken in
__d_lookup() to increment the refcount and is held by afs when checking
the refcount and setting DCACHE_BLOCKED.  d_revalidate() is called after
__d_lookup() so it will see DCACHE_BLOCKED if needed without any extra
barrier.

For RCU-walk, d_revalidate() is called before refcount is incremented,
so as well as setting DCACHE_BLOCKED we must
write_seqcount_invalidate(&dentry->d_seq).
If d_revalidate is called before that write_seqcount_invalidate(),
then the RCU-walk will be retried as ref-walk.  If it is called
after, then DCACHE_BLOCKED will be seen providing we use smp_load_acquire().

The unlocking in afs_rename_edit_dir() is not needed.  It was previously
needed because it would not be safe to d_rehash() after calling
d_move().  But now that we don't use d_rehash() that is not a concern.
afs_rename_put() is always called and is sufficient for all rename
unlocking.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c      | 101 +++++++++++++++++++++++++++++++++-------------
 fs/afs/internal.h |   5 +--
 2 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 75f8f70cfeff..fbe2a3eb56b0 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -49,6 +49,16 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 static int afs_dir_writepages(struct address_space *mapping,
 			      struct writeback_control *wbc);
 
+/*
+ * This is set to stop d_revalidate looking at, and possibly changing,
+ * ->d_fsdata (a timestamp) on a dentry which is being moved between
+ * directories, and to block lookup and possible open() for a dentry
+ * that is being removed without silly-rename.
+ * When set to block open()s, we also invalidate ->d_seq.
+ * When set only to protect ->d_fsdata, we don't need to invalidate ->d_seq.
+ */
+#define DCACHE_BLOCKED DCACHE_PRIVATE
+
 const struct file_operations afs_dir_file_operations = {
 	.open		= afs_dir_open,
 	.release	= afs_release,
@@ -1031,6 +1041,12 @@ static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 	if (!afs_check_validity(dvnode))
 		return -ECHILD;
 
+	/* Is a rename/unlink is pending? We must load d_flags *after*
+	 * ->d_seq was sampled in path_init() or similar so use "acquire".
+	 */
+	if (smp_load_acquire(&dentry->d_flags) & DCACHE_BLOCKED)
+		return -ECHILD;
+
 	/* We only need to invalidate a dentry if the server's copy changed
 	 * behind our back.  If we made the change, it's no problem.  Note that
 	 * on a 32-bit system, we only have 32 bits in the dentry to store the
@@ -1079,6 +1095,10 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	if (IS_ERR(key))
 		key = NULL;
 
+	/* Wait for rename/unlink to complete */
+wait_for_rename:
+	wait_var_event(&dentry->d_flags, !(dentry->d_flags & DCACHE_BLOCKED));
+
 	/* validate the parent directory */
 	ret = afs_validate(dir, key);
 	if (ret == -ERESTARTSYS) {
@@ -1158,7 +1178,13 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	}
 
 out_valid:
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_flags & DCACHE_BLOCKED) {
+		spin_unlock(&dentry->d_lock);
+		goto wait_for_rename;
+	}
 	dentry->d_fsdata = (void *)(unsigned long)dir_version;
+	spin_unlock(&dentry->d_lock);
 out_valid_noupdate:
 	key_put(key);
 	_leave(" = 1 [valid]");
@@ -1533,8 +1559,10 @@ static void afs_unlink_edit_dir(struct afs_operation *op)
 static void afs_unlink_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->unlink.need_rehash && afs_op_error(op) < 0 && afs_op_error(op) != -ENOENT)
-		d_rehash(op->dentry);
+	spin_lock(&op->dentry->d_lock);
+	store_release_wake_up(&op->dentry->d_flags,
+			      op->dentry->d_flags &~ DCACHE_BLOCKED);
+	spin_unlock(&op->dentry->d_lock);
 }
 
 static const struct afs_operation_ops afs_unlink_operation = {
@@ -1588,11 +1616,13 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 		afs_op_set_error(op, afs_sillyrename(dvnode, vnode, dentry, op->key));
 		goto error;
 	}
-	if (!d_unhashed(dentry)) {
-		/* Prevent a race with RCU lookup. */
-		__d_drop(dentry);
-		op->unlink.need_rehash = true;
-	}
+	dentry->d_flags |= DCACHE_BLOCKED;
+	/*
+	 * As RCU-walk calls d_revalidate() before incrementing d_count
+	 * it may have already run.  We need to invalidate d_seq so
+	 * legitimize_path() will trigger a retry.
+	 */
+	write_seqcount_invalidate(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 
 	op->file[1].vnode = vnode;
@@ -1899,11 +1929,6 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 
 	_enter("op=%08x", op->debug_id);
 
-	if (op->rename.rehash) {
-		d_rehash(op->rename.rehash);
-		op->rename.rehash = NULL;
-	}
-
 	fscache_begin_write_operation(&orig_cres, afs_vnode_cache(orig_dvnode));
 	if (new_dvnode != orig_dvnode)
 		fscache_begin_write_operation(&new_cres, afs_vnode_cache(new_dvnode));
@@ -2023,11 +2048,18 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 static void afs_rename_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->rename.rehash)
-		d_rehash(op->rename.rehash);
+	if (op->rename.unblock) {
+		spin_lock(&op->rename.unblock->d_lock);
+		store_release_wake_up(&op->rename.unblock->d_flags,
+				      op->rename.unblock->d_flags &~ DCACHE_BLOCKED);
+		spin_unlock(&op->rename.unblock->d_lock);
+		op->rename.unblock = NULL;
+	}
+	spin_lock(&op->dentry->d_lock);
+	store_release_wake_up(&op->dentry->d_flags,
+			      op->dentry->d_flags &~ DCACHE_BLOCKED);
+	spin_unlock(&op->dentry->d_lock);
 	dput(op->rename.tmp);
-	if (afs_op_error(op))
-		d_rehash(op->dentry);
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2135,7 +2167,11 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 		op->ops		= &afs_rename_noreplace_operation;
 	} else if (flags & RENAME_EXCHANGE) {
 		op->ops		= &afs_rename_exchange_operation;
-		d_drop(new_dentry);
+		/* Block revalidate on new_dentry until rename completes */
+		spin_lock(&new_dentry->d_lock);
+		new_dentry->d_flags |= DCACHE_BLOCKED;
+		op->rename.unblock = new_dentry;
+		spin_unlock(&new_dentry->d_lock);
 	} else {
 		/* If we might displace the target, we might need to do silly
 		 * rename.
@@ -2148,15 +2184,10 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 		 * and becomes the new target.
 		 */
 		if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
-			/* To prevent any new references to the target during
-			 * the rename, we unhash the dentry in advance.
-			 */
-			if (!d_unhashed(new_dentry)) {
-				d_drop(new_dentry);
-				op->rename.rehash = new_dentry;
-			}
 
+			spin_lock(&new_dentry->d_lock);
 			if (d_count(new_dentry) > 2) {
+				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
 				op->rename.tmp = d_alloc(new_dentry->d_parent,
 							 &new_dentry->d_name);
@@ -2174,8 +2205,21 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 				}
 
 				op->dentry_2 = op->rename.tmp;
-				op->rename.rehash = NULL;
 				op->rename.new_negative = true;
+			} else {
+				/*
+				 * To prevent any new references to the
+				 * target during the rename, we set
+				 * DCACHE_BLOCKED which afs_d_revalidate
+				 * will wait for.  d_lock ensures
+				 * d_count() and DCACHE_BLOCKED are
+				 * consistent, and d_seq ensure RCU-walk
+				 * is retried.
+				 */
+				new_dentry->d_flags |= DCACHE_BLOCKED;
+				write_seqcount_invalidate(&new_dentry->d_seq);
+				op->rename.unblock = new_dentry;
+				spin_unlock(&new_dentry->d_lock);
 			}
 		}
 	}
@@ -2186,10 +2230,11 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 	 * d_revalidate may see old_dentry between the op having taken place
 	 * and the version being updated.
 	 *
-	 * So drop the old_dentry for now to make other threads go through
-	 * lookup instead - which we hold a lock against.
+	 * So block revalidate on the old_dentry until the rename completes.
 	 */
-	d_drop(old_dentry);
+	spin_lock(&old_dentry->d_lock);
+	old_dentry->d_flags |= DCACHE_BLOCKED;
+	spin_unlock(&old_dentry->d_lock);
 
 	ret = afs_do_sync_operation(op);
 	if (ret == -ENOTSUPP)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7cea5ba0d20d..578fe7d35ab4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -901,10 +901,7 @@ struct afs_operation {
 			struct afs_symlink *symlink;
 		} create;
 		struct {
-			bool	need_rehash;
-		} unlink;
-		struct {
-			struct dentry	*rehash;
+			struct dentry	*unblock;
 			struct dentry	*tmp;
 			unsigned int	rename_flags;
 			bool		new_negative;
-- 
2.50.0.107.gf914562f5916.dirty

