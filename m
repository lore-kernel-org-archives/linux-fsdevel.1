Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578433;
	b=bfXJa80KJEPpRK/zil+7YJQntBNgbLiHNOlpoBVQb0w7qNJCJcAAoiaDfsHpHT2DhmPv
	 rJtEUhM+l/2yEhZRgPwYqYe5+CaSrpmDgcQ2DZDTUEGcsogfG5wctsxrrAHFCn0wVl2kK
	 zBn6OfNcuIerJRgInaBXlYVoTvRJROB0Bcvouuwy6xSTlzy6m3yW68oiwHy0FaAU3/wBi
	 KfvDh/E3D+Sn0MeHrs3F4NsFjA7ovvcGjqg7QTs6XGq5vi5EWKK2tpt9zqXyNcTFuXTb7
	 cix0POFtn06bU4ERNJ3W+creR4eCYnYli5NVk5hfNACRLpTMD6gm42zwxnxxTGQj7SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578433;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=AzPOlMVHZqiqc4/SgqzoQdQv5n3zt50otXb6Pd/4k7k=;
	b=MjI4qgjAO6JzyuhS5lWIWWC8if/W4qBe2nDYs5qQpzmc13kIk5bCs3k8hq4ZENyv9fz+
	 xHBmslID6mLzg6Co+yokK7AqdFRGurVbN6kyfwrHj3o/+VMGjpaB7/TTFedP5P20uIP0I
	 be9xCjdD8gYhBNwiirv3PSgySQpmLvphwD1/U+HcZ7EH12jUdFs1CcJ445/Bqr6lRo9CP
	 0Za0ZhvcvVK1+aztit2xz+IAxb7pjAJzmsrQ33BaY1AzVQLuqvcvwilVSAkKj/0bR+XtL
	 gk1J79Fi1bFu4bUvhK82TCQBQGnAdFoW8C7rfpBWB3j5ZwgcnqdSRxxN7H7KCYFH45w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=gy8gyfZ4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=02i952YD;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C775606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C775606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=gy8gyfZ4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=02i952YD
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3676EEC0A10
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:47:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 22:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578432;
	 x=1795664832; bh=AzPOlMVHZqiqc4/SgqzoQdQv5n3zt50otXb6Pd/4k7k=; b=
	gy8gyfZ4IsAyiyhdZpu+AAcnon6FxbvcKZAH67uCOhevq4EBx6ingwn1NFNduwmB
	lSFGlF9S8zDmX+nl3BAOSmcbp1rv9+1ZwX4zwAmjHvHwcmId6xUxACMW8QjaNVRz
	33CaP6hqh6G2dCESZAgi5UcKgQZL1W61thRUHjPbHI5dmqmmvoswKs/8GAMvAFyk
	67xu6GcRNT09oADMoLLRhfolZxxOggjXmYRQATAON2UfWD1qyWywqdHkkN0j6WTJ
	F45weesc8BJGHBBIpzkoAr0dF2ceCRibOCFiw9f3leIwjCep4Lm3nQs0NkKUltrm
	FoFGQGYf9UG3yBVkCp0Nzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578432; x=1795664832; bh=A
	zPOlMVHZqiqc4/SgqzoQdQv5n3zt50otXb6Pd/4k7k=; b=02i952YDBlWC7Y20J
	6z0OnWAX/5jCN8q8R9n4UNhS4e1Ilpr1mK5AU9nJyRpLBxdbVTYFIc3dYn1mS5HY
	2hlMa66OcgOevp6LW1metaJTkhW30boHrjmS47M8XLT/VSRwFvHr+m4QP9Im/cQ3
	Byvk4nn3Xy9XBlmwTF1PQ/7ksGxDSIAhbfFioSeLLPkVpTQ2ByHSOqe18K1VrDPP
	+N2eeDl14iOT3sK8AFeu7Psx3SqrB9hf1k2Gg+Tpkxiug4ZFCLLJWW2VVidlSKNc
	9zHjh85zUHUkXrUExA8q+2PkzG912OS6+LVO0Twsepg3qI9P0wwhhTQqBAQAjpyL
	7ay+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578432; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:Y46WdGTL9GXHjINYSh4aLTRwSws6qsKiHnyR8QMWuJ+1vU5
	3xejvhoVAWyY09FRjXZO/hnHJHD+wm1lU7nwfoqWiGMUrCMU1ZHVROx0AF5Od7IR
	v8Zp9kJTl4NQ9gZmUQPeJBluzYTyzWXytlQrIHa1Acklw6mW3pCU1x+WHNqJapO7
	p/a2Go2p8YhwBDeyYzjFQBMaJI5EWmn32LjSKQG9BW57ZqnZHoTHSOJj10VawPLL
	2u+ERcq1cxBBS8grZdBYJWBdq4qwMPReMJ3byu/3onis/3awqBsV9PFjtNHjmJT2
	b/aLJ8nRTR38d8ZhW+5VwT3HOjxWT6v6VRvg50A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:RD0FEtnSzWfH+vKgEHpbzbmLQC/tAjD/w3+E25bb39s=:7URP8i6yCyfjAojTIW7hW0N69jYbi2sSG0eZznjZ5rs=;
X-ME-Sender: <xms:P1oGa1e34C6GE5-NHRQ4AwTmMKL7d9mYUYfbV2h_dmf6DHDcRTagkA>
    <xme:P1oGa6KXfWU2FmqYEUTCkVa3vxWnPp7R3QwpsB8Ei5RkjNr2u0aGl7BD7i2snNldX
    _MCXIChMFJ0DVc5bcnAdgW2ttMNzkctU0PyO9KlEvDsNjuUYQ>
X-ME-Received: <xmr:P1oGazlu_AOoySPq_CRSc2atF7B7Ug9ePM4OJNZyBaekp592NpcR9YemYWjZXAsAYQDcHmXgilxLfVkLw8pglVK_eIVrNys>
X-ME-Proxy-Cause: dmFkZTEgJWZqpeB1G6uHGGBU6x40PrNG27hQ+jt9Lh/fFZDifRYVox/yFszE97r/YEtkaJ
    KRb3hWZBDeHiP3IXgYpP+sgktOTZkGMiRowoA6X7MFDbKSIb68Rj8vtaZPNrSaRg/gDxs/
    F+sW5WPeitMItRuWH5tRIxy1ko0NkBH3Bq8qy6P20upVNgxiUUYO3j/DJmI0CsQEpHI0Gv
    TKZrQCtr784YSLr69vVucN5VgKQBLOyKB5D7OOwSjEXCKn5Tq+GGsGCcZ9yvfN2rh8H3HL
    ajpmllZ0Cec+MdVbVECc+rKqe0c63zkgsLFEqTKRY2xmzJRQct9vlP6JYIKJxxkuZBYTWH
    lL24OS8tOC0qeAI5D0MTTzKjVM7zBArhkmFht6NnRRRxjR2tMG/d5eWLX5Q5q0lQh1Zhzy
    KXSkRYBIbeActZsP7jvWZPtO270txyn2QCoDrNo8UPjkc10jFcp8EEGU77OlmKYO3ZdCbe
    Ft4oCvJJKEiNTLHxVL521nEGlrNcrNobB/v3AhD3dsj0tDNXIOoA0ufhpcJMRXS/AE0wQ6
    QYnMk8TpDAbDtHk1SvdB4kFE6sMT96/zIHH/pa0Z7eQWF3TEYkwc22vHADye66DCmM51ra
    HA4FVnlTeLq74pf3IkduO16ncf6wp5qxlq2c0QrKrAlz1nhrac8yIloAaU8w
X-ME-Proxy: <xmx:P1oGa2FcxKy82SCEbXl88bPVsd5mze1QbhUxL9cftauw0ZRIt0agVw>
    <xmx:P1oGa8dvZVwblR6zPFjnUdp943JSM5rP2GRMeUXc4I9RWqXwqAL3XQ>
    <xmx:P1oGazE545O8xgJKUHbipJKA4aiLUqwy-k-Ycj11UTqnngsJsNRJqg>
    <xmx:P1oGa2GomYevlOQVyGEpQ3OEJT2wRGUpqWap4G7MB_rCPq9UdET8lQ>
    <xmx:QFoGa3o436QseuGE6ze2itzssSFUBgbAgmEt_jmRO1R3eERDa3hfL0PI>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:47:07 -0500 (EST)
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
Subject: [PATCH v3 10/11] procfs: drop parent lock for d_alloc_parallel() in iterate_shared()
Date: Wed, 25 Nov 2026 14:16:48 +1100
Message-ID: <20261125034543.4084039-11-neilb@ownmail.net>
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

When procfs finds a name in iterate_shared() that isn't in the dcache it
*must* add it so that it can have a stable inode number to report
(inodes are only accessible from the dcache in procfs).

It uses d_alloc_parallel().  A planned change to locking will make it
unsafe to call d_alloc_parallel() while holding the directory lock.

Other filesystems which prime the dcache in iterate_shared() use
d_alloc_trylock() which is safe but can fail if it races with ->lookup.
As procfs cannot handle failure we need something better.

procfs doesn't *need* the parent to be locked.  There are no shared data
structures accessed that don't have their own locking.  So it is safe to
drop and re-take the parent lock.  We could do this around the whole
iteration, but as failure of d_alloc_trylock() is rare it is more
efficient to drop and retake it just around a call of d_alloc_parallel()
when d_alloc_trylock does fail.

Other code that drops and retakes the lock in iterate_shared needs to
be careful to check S_DEAD which could be set while the lock is
dropped.  This is not needed in procfs as the flag is never set.

As d_alloc_trylock() calls try_lookup_noperm(), we can skip that call
and simplify the code.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/base.c        | 41 +++++++++++++++++++------------
 fs/proc/proc_sysctl.c | 57 ++++++++++++++++++++++++++-----------------
 2 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7685660c3624..cdf0a869f26b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2104,26 +2104,33 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	struct qstr qname = QSTR_INIT(name, len);
 	struct inode *inode;
 	unsigned type = DT_UNKNOWN;
+	bool must_relock = false;
 	ino_t ino = 1;
 
-	child = try_lookup_noperm(&qname, dir);
-	if (IS_ERR(child))
-		goto end_instantiate;
+	child = d_alloc_trylock(dir, &qname);
 
-	if (!child) {
+	if (child == ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Need to drop directory lock, which isn't really
+		 * needed here anyway.  As rmdir never happens in procfs
+		 * we don't need to be concerned about S_DEAD being set
+		 * while unlocked.
+		 */
+		inode_unlock_shared(dir->d_inode);
+		must_relock = true;
 		child = d_alloc_parallel(dir, &qname);
-		if (IS_ERR(child))
-			goto end_instantiate;
-		if (d_in_lookup(child)) {
-			struct dentry *res;
-			res = instantiate(child, task, ptr);
-			d_lookup_done(child);
-			if (unlikely(res)) {
-				dput(child);
-				child = res;
-				if (IS_ERR(child))
-					goto end_instantiate;
-			}
+	}
+	if (IS_ERR(child))
+		goto end_instantiate;
+	if (d_in_lookup(child)) {
+		struct dentry *res;
+		res = instantiate(child, task, ptr);
+		d_lookup_done(child);
+		if (unlikely(res)) {
+			dput(child);
+			child = res;
+			if (IS_ERR(child))
+				goto end_instantiate;
 		}
 	}
 	inode = d_inode(child);
@@ -2131,6 +2138,8 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	type = inode->i_mode >> 12;
 	dput(child);
 end_instantiate:
+	if (must_relock)
+		inode_lock_shared(dir->d_inode);
 	return dir_emit(ctx, name, len, ino, type);
 }
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index eeebf813668e..ea3287ab9d21 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -687,38 +687,49 @@ static bool proc_sys_fill_cache(struct file *file,
 	struct inode *inode;
 	struct qstr qname;
 	ino_t ino = 0;
+	bool must_relock = false;
+	bool ret = false;
 	unsigned type = DT_UNKNOWN;
 
-	qname.name = table->procname;
-	qname.len  = strlen(table->procname);
-	qname.hash = full_name_hash(dir, qname.name, qname.len);
-
-	child = d_lookup(dir, &qname);
-	if (!child) {
+	qname = QSTR(table->procname);
+	child = d_alloc_trylock(dir, &qname);
+	if (child == ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Need to drop directory lock, which isn't really
+		 * needed here anyway.  As rmdir never happens in procfs
+		 * we don't need to be concerned about S_DEAD being set
+		 * while unlocked.
+		 */
+		inode_unlock_shared(dir->d_inode);
+		must_relock = true;
 		child = d_alloc_parallel(dir, &qname);
-		if (IS_ERR(child))
-			return false;
-		if (d_in_lookup(child)) {
-			struct dentry *res;
-			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			res = d_splice_alias_ops(inode, child,
-						 &proc_sys_dentry_operations);
-			d_lookup_done(child);
-			if (unlikely(res)) {
-				dput(child);
-
-				if (IS_ERR(res))
-					return false;
-
-				child = res;
-			}
+	}
+	if (IS_ERR(child))
+		goto out;
+	if (d_in_lookup(child)) {
+		struct dentry *res;
+		inode = proc_sys_make_inode(dir->d_sb, head, table);
+		res = d_splice_alias_ops(inode, child,
+					 &proc_sys_dentry_operations);
+		d_lookup_done(child);
+		if (unlikely(res)) {
+			dput(child);
+
+			if (IS_ERR(res))
+				goto out;
+
+			child = res;
 		}
 	}
 	inode = d_inode(child);
 	ino  = inode->i_ino;
 	type = inode->i_mode >> 12;
 	dput(child);
-	return dir_emit(ctx, qname.name, qname.len, ino, type);
+	ret = dir_emit(ctx, qname.name, qname.len, ino, type);
+out:
+	if (must_relock)
+		inode_lock_shared(dir->d_inode);
+	return ret;
 }
 
 static bool proc_sys_link_fill_cache(struct file *file,
-- 
2.50.0.107.gf914562f5916.dirty

