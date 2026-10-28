Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793160683;
	b=cpSn2y5v5e/Zj1sPscVFBKgJtEjAwIqztgWhUHi4kZMzb6l49Ba4ICzcSuCrMOp6y7ha
	 FnVWMnIcyR4ZenC92MitRyJNuGCVa9ROed3JS8HSpvuM+hs8FEYMzhcR3fxnueuZxt8fB
	 SC0oW2M+BBrohDX9HikgBkrnyrRn4zMNlu5FkktZN4EREFtUlBwRM1JIun9DLxWUAlHfX
	 +RLxk2MHOaNWJcgcJU5yRNg9gy4xVOQLP9MLI1lkT86sgFudLKbueThjvI21mfN7xEzJ9
	 B5+bIBtNZMZj9TMThhZE+dZbGnbx8+SqN/TfPOmLsat93+ws4mNoBaAf6R6sFXBfHxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=vy50YZukeurIGdPYV71Ddq4nXzwY+w9F1a9seNwhI44=;
	b=ZjjyixtUQXzpUYmnWMFJiFj/NljPUlmhD4Th97WbG/FH1or2qxow8CmXwGEV170y6YCK
	 NLpA8H42SK+8xQVafQU0FuEQid3L++rFmAC18gqEIO/yMoE8LTHEYeX1+I+yKX/spmUP9
	 YVz5m6DoRvIJ7fsJs5W1Dv9v2GbQjoFgZ3ICVbxriQ9ElpKRNpisneMyZXr3clQztYyDV
	 yJ1bQ/VwPp+pmboc4RPz3l8w3NBFZTS39uIHG8B9ASkD8iUJhxJjSOBDDWOAp8bXg5I0u
	 Xb2/cp8XJlQYXNYhR+JSklm8rYsb3quohuk1GE6y8FDV6ubTCODD/BuMpyyKRVNLFbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b="l/kcqITp";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tJ94kHwl;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80B606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 04:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E80B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=l/kcqITp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tJ94kHwl
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACDA67A00DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 00:11:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 28 Oct 2026 00:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1793160681;
	 x=1793247081; bh=vy50YZukeurIGdPYV71Ddq4nXzwY+w9F1a9seNwhI44=; b=
	l/kcqITp0YbrBxk+EXoRjuDNYHBhFV6bh5j32ARCfvdrB6lNNeSTT5iUVXOX1Qlf
	qyj4YtBaKiLId4YwUZnwKPw4ADBhdOsCg0OtoQCrHlQt77/m35suA/CeKOhTN0M7
	KbqP8v0lx0NFDK++5p4G6kctzJ5r4xw3JLJaxgbdEYpE19l/vzA4AN/TulASBJWE
	Q/VOpDfP/PQ60/kAJ+uT/27I1jN0UZfF9QqfxCOMUGuU1YxhDQQYqc0PiC6FeAwW
	qAd7W5twlklEjSE777i3JMrDqHIE4HUO5M8cgJdyiT1KPew7uFQdURa5/8j4oTt2
	jt15btTEmteLNDc+vD8EKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793160681; x=1793247081; bh=v
	y50YZukeurIGdPYV71Ddq4nXzwY+w9F1a9seNwhI44=; b=tJ94kHwldaAyKiltj
	ItXGBC9K1VFFdcftSV3jw82eqJqtOWharkE3AzHZGeazSHcwSD2VhYdeyouoKGtI
	jN/nMVyKRJ6t3PLLmBEGDip0/Dpz5U/wj5clL5b3P/ajUWybeUM6JkmoCKhhxYmo
	aG22ESpdi+jZNto1NouPFTOoOr0woDMl6SOqtg1hg7Cnr5nATWCP2uvINlQIX1OK
	LGb7fWJlvdbQEBQHxJgoPrLX4HImBKMW32W+KcjUkLQi9J6KWLmNOUvKYTobXrOK
	MNbMxQUSj4MTaMdvEhP5S/2crxE/B5psVEsrs9BmfPmw5phIDwI9YS9WXWpQlRZF
	TQckw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793160681; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:erYM1rkkZmOLSrD946O1fE88knpt4AF2n3oTq7nmhBh827Q
	9ZvS4ayXJ9p+3MHBRnOuauXOLJE9L3QFg8VqihtUH6HNnXwUsNnUNzL90m1u+f2j
	27dOs5dbUCldXPYsgpzweRd0iT+6H/a0Adcz1sQmUhk0BQy/zYt+qDv/CuhBrd4V
	a91PuTNdyGHgxIA03wBY517k2lArWVLfu5uVSSS4KWL+aPPU9SV5wpyG3koPuRQC
	v0VK0GeTTsK3Gp1eq+XKxqRJ9U9/sXyKgHIug0HIcQYJUVTCJHVBcVdvwEfZKidt
	jNDt3dGgaL9y/I2dnUT4eKmqD3Eezgmttv+Atnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:EXXoYaHz3IuIBE+UGYiWQhHByDoheXJ6ajAny7LgWo0=:wgtbfXSkqcqXtjY4KtjgXKv7WUALEtLbEPuN9h/L3ek=;
X-ME-Sender: <xms:6XXhan-fBsBpJAHAMjNK1srsgHC2SQxhDZ7iS--B_8S4wztO3KXtBw>
    <xme:6XXhah-JqkPxJ0zc5-HcLQsy04iEHE9uA4q3hqwIi181LmECBjC73osaxU5GKqSYZ
    h7QlMAq9kREHjwYQvt6fLfohIotNuomz9fgVdHZOJq0JNhi1wA>
X-ME-Received: <xmr:6XXhauV_sEijf9U1WprWZ8oZD5fHsPf7BquAHbIHpKAuY11kfwyESkwSDlXyLZ40-WMaLvWTaP0ZlYONRv89z1Te4zNacMY>
X-ME-Proxy-Cause: dmFkZTEtaaJo3zhk6q8YHjcrAGFhzjZGx7kav9mjn36dhiCDz1sQNUcnPXqPMC3VqBUdUM
    QC/BqNrn6VDtoNvGfXsPC6PtPC8Yf5vcT7dSqr4OQVWjbDjoqPju2ao8WKvEVWn6qwQJpD
    4CN6jGUHDBUbMwADgY1eHpCxVa8gj9W+FVkilH/Bf9wmvEra1caZDRUZmQcG/Ro3xW8rsx
    nbEpGLXA1HN5mBuF45EijzjRcn/0zOhqfoHROonBfk2oQm2kGy7PxZcAZk+GCvIPn4bVTg
    3udSvT9vlUjceFzrt+IHSgKFct3qykKWsSJoK8kyGUhtj7khaHZlaj5tXb3YwgPRJ+b+Ic
    UpccTECglmc6YAeJLDdiYAvDIc0sVrN4KhLvjqmUWaP8+5/4fHa+Z/lcvQAbDCJJa8Hsad
    J3GbntRZuUw/m1VC63gNxaeKBxpdUv8YIUkcNEbU9ZVcx54Zu6CLytLQQJVxD8eqDXEfq3
    oysrUR6HwZf58RFLcxm2VqOG9cVxd98T9hpyO3r5QuQmItHq29kF42Fuoju+zy8cdvr06z
    RQgxr/uy3b8BK78Hlgy2BmafTHuK04WnLnR1CoQdL6Cetf3GDrvYpeo4B2oD68RNIMIKkj
    gaeLGfoYcaoftv4UK046/ZjvYQZksvJnxgZ8wVs4JrO32i/fYt8UIRl4oY2A
X-ME-Proxy: <xmx:6XXhamcFD_qu2b644aq8q9-YUfGkjWmpSfMuGHOXaR6p0mcW9SZurA>
    <xmx:6XXhavbx_hN7mN5c4MZtr5LePm-rQw1qQVzJ7FwFzUCzzP1_nZDbAw>
    <xmx:6XXhaqN06bDKetgQgxx-3eD3TyVNEokBPip4JJmKkyYwb2wfnt88OQ>
    <xmx:6XXhatVUxrrOTALtx_O1LQnukwCqwChp6GrdGJ6CEpaTOGxAIKEY5g>
    <xmx:6XXhahiTfkvtN6iMsfRorH2p27FG8uarVvgvlqewr-zKxtbBM2BT5GyO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 00:11:17 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jonathan Flynn <jonathan.flynn@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] nfs: don't d_drop() before d_splice_alias() in atomic_create.
Date: Wed, 28 Oct 2026 15:06:34 +1100
Message-ID: <20261028041023.3738553-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261028041023.3738553-1-neilb@ownmail.net>
References: <20261028041023.3738553-1-neilb@ownmail.net>
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

When atomic_create fails with -ENOENT we currently d_drop() the dentry
and then re-add it (d_splice_alias()) with a NULL inode.
This drop-and-re-add will not work with proposed locking changes.

As d_splice_alias() now supports hashed dentries, we don't need the
d_drop() until it is determined that some other error has occurred.

Acked-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b29dc1260d91..b296d90c8e14 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2196,7 +2196,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		err = PTR_ERR(inode);
 		trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 		put_nfs_open_context(ctx);
-		d_drop(dentry);
 		switch (err) {
 		case -ENOENT:
 			if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
@@ -2205,7 +2204,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 				dir_verifier = nfs_save_change_attribute(dir);
 			nfs_set_verifier(dentry, dir_verifier);
 			d_splice_alias(NULL, dentry);
-			break;
+			goto out;
 		case -EISDIR:
 		case -ENOTDIR:
 			if (open_flags & __O_REGULAR) {
@@ -2221,6 +2220,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		default:
 			break;
 		}
+		d_drop(dentry);
 		goto out;
 	}
 	file->f_mode |= FMODE_CAN_ODIRECT;
@@ -2254,7 +2254,8 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			dput(res);
 			res = ERR_PTR(-EOPENSTALE);
 		}
-	}
+	} else
+		d_drop(dentry);
 	return finish_no_open(file, res);
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
-- 
2.50.0.107.gf914562f5916.dirty

