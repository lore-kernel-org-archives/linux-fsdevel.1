Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578389;
	b=uBt/NXJ2PRknbrKzZEwDjRAMk60kQh5/BW96/Q0tRDEOUUUrxMZ/ED2neyBAn15BVNoW
	 X5JJkClitaUJTrV91TEFbLCjQM8Qz/JhSQK9iKVqB/1+C1Cbmi0cGi+0kEEjHLX/GmuU1
	 3lMJTXgA5v8LcvJUf4lUf2BO16ogDyaueAaB57Pebr2l1M7AaUDITKPy5CTFaxylB9oMZ
	 rtz9aVcfBmWkEzpUhAUs10HAxmnS9XAU7MXEvWnxiPlMb7alPHtsdQj7ibXY5uumlcRZb
	 I6OvVWPdGtdCZmxt1XJq3cKv8FregCi9k/ptuRsxV6RXgAJWlbIQ6I1yGOKsTBbMqZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578389;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=RMeZMU/T+oOJDghIJZuLF6JDmEVOGnEipsoXhi6CAAQ=;
	b=S/NLKqm0eTJtz9VHsRa6O0V1PWjEzflqArJDxKlm/2zoAGCa3b+fKflqtWV+NQzjFeri
	 JvLb+fWbc3ZoCG6mFbFVrsjsOC4DVv/1AEzVXreQc08iYfjUAH2jRMpM37ZpoeWI/IzMK
	 PvmH31fcal5rjG4J32jmVw8Ce2xvZAQ7a00ZppH9WdMLxvcwQojryOfVLNgpKab1lNWox
	 TbOqJPOceZzyU22eDGH0tUkcDub+Q9HSXLuqQNGSUkOm/PblmI8HjMm47kNbh4JI/GCAK
	 PPlifAdrtIIeI1Lxr1AEU3F8cK0MpUXX/Y77BWA0R5E1wQ9kZo4qk8tnAyOUPnekT9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=BQ+UcH1b;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VGcG6UyV;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79F606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E79F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=BQ+UcH1b;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VGcG6UyV
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D9751400349
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:46:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 22:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578388;
	 x=1795664788; bh=RMeZMU/T+oOJDghIJZuLF6JDmEVOGnEipsoXhi6CAAQ=; b=
	BQ+UcH1b6ZB7G4ne33Y8kqusFS2EdQSAdRi2RPaUfQCBDEIFemwE26zFxSbOfWqI
	WchO53kdrq8/h+RrJTTD96dHu3NQoMbxxXHqHvlFswkWHv1a7D0OSxjysHsGhiIm
	a+OD7KNiQmsBFDRppbH0uE31DTOfnIqpxh4FPi96FMmLLIwt2heqPnsj33Ce9svp
	QkwnjCdPaaT+Nbj+XgRiKxy/KBqJpwb8/pAbOmgVlRUY6CqbXKOPY/ZY3XQrfZBJ
	66eLAypOKhNuUhyuSqAZrN4IGFiKeAWP7FF3xUAmbN3pjg4+uQ2HDeh9Th4LGznl
	mUyLVbUzA3u4t2SJoK/7hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578388; x=1795664788; bh=R
	MeZMU/T+oOJDghIJZuLF6JDmEVOGnEipsoXhi6CAAQ=; b=VGcG6UyV82uM1Du2v
	BnJTsME/MBEG6hS43WIhzlpGkUD+Xi50wuUp+Oii7akZ1L0BungFnLoi80VNHLmN
	PDpEJHISWmSrzSGYzQn6/p8pUY63jF4oJ/0uJldD5K2GfvB4zWuHFMMm4pa0Xl9Q
	iNz6qfudKLEBFelYtBGiDNFOUcl9DudSVMpdBJvzP/+mbuEap8xh0WSH0oVZng/S
	Q9geejl8DzssznIjVMdA2lN0D9nE+wRelPokc9m0x4vwoYTQURup/DKIBOD9v1QG
	CqxM0QN0Si5nKfAA8wcAle09ixfIlIXvhxwQ5p37l1R1WM1J2P/ggv5FhwT36+Xa
	h0G7w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578388; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:pWaNbzewsQa9jyzW5V2yXL2GA/gpcpMECL4pzVd3japctBd
	JlMkTJXoFeLIgOxI/x0gVNZumugGxUXgCRabxkF05eEoXgD3g+T981g2ydthe2Bl
	B6ng/BjPAmPM904O1fR9TvKdwuhGe9yPrFAZJ8udE8icih83bYbWgDJ1REDDk6j+
	ckHJI5ItBMG1LXVIePy07sVo5uyWxO2JNrWUohG+P1Tz4tNkVU3gyyCDRZ4bbuPg
	5Aw5jRq8eDP5Os4QNgRA0qAZYJCwc/Iv/mwcMhGsSWxxerBJGEdT/nf8Kd0tdA0I
	la8UChuY0ZQFkvVwXHAo1GMfwwYvZOg4WGGnjGw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:jnhvRtuK0jHZq/TS79FdQ3jHe5iTO0hxGr2p7sf7tuY=:Vm20BqbhCTAWdV9WKIZ9Y6qZqlW8g3/bKFFUEHMTwGI=;
X-ME-Sender: <xms:FFoGa3-wykgzqpLFtWkJVTOrUBlDoXyVhTBsuWmpkowc902_oYCO_g>
    <xme:FFoGa6qd1gT0iR4oI_v_gRCgtOItFOPBDjMhziUKUH8N3MkniNah8IGw41lW_rNEx
    4B3KpjvjFKAz8XV9YPLDZkoQzkrWTy1kHp8DPu2iohKYD158yM>
X-ME-Received: <xmr:FFoGa6Evr1cBg77j5no7Mn2UnK6T3vRi5-X-9WyjSydluZkG9RZobCAKfIaLQOW6oLIFOaFjIERWFtSC7THNF2w84MUxVXE>
X-ME-Proxy-Cause: dmFkZTEgJWZqpeB1G6uHGGBU6x40PrNG27hQ+jt9Lh/fFZDifRYVox/yFszE97r/YEtkaJ
    KRb3hWZBDeHiP3IXgYpP+sgktOTZkGMiRowoA6X7MFDbKSIb68Rj8vtaZPNrSaRg/gDxs/
    F+sW5WPeitMItRuWH5tRIxy1ko0NkBH3Bq8qy6P20upVNgxiUUYO3j/DJmI0CsQEpHI0Gv
    TKZrQCtr784YSLr69vVucN5VgKQBLOyKB5D7OOwSjEXCKn5Tq+GGsGCcZ9yvfN2rh8H3HL
    ajpmllZ0Cec+MdVbVECc+rKqe0c63zkgsLFEqTKRY2xmzJRQct9vlP6JYIKJxxkuZBYTVH
    kdJB6IcTbfcCH+iOTZVeOVVD+XgT2ZOj0YXYwiDfa/xTcMY98l5dgAd3HcE1tK1CPHhsXo
    /nmNLxZUd+Sr9Wysyh7vjI3aZjBTSZWGOWTXlw9s5BBtQjqZcgzVDWSur1ftEzHpxu626Q
    n4srQN/7iXhIGGgks7Z8yxPYxZeLXDPOraknHc79HFrqNzusE5ywfy7+BDpp/jz/KI1iIl
    P9RuP0i9uH68GOtHElKbR1cIYrMIi/xnyU5ieYNpqv55tyFi/GnEIygkJMcmRiRNQdRdBC
    OvxIYqdzj+2b0ZXCQTMj1cbXLNzi6b1ZztgIdNMI38MTYbRJYM/Tav/8MaUQ
X-ME-Proxy: <xmx:FFoGa6klhGUHmU2JUznrI05da1LI2neR58UAraDxMqEuHS2IECPhKA>
    <xmx:FFoGa2_TRFNBQUOtDIs7-HZTnt-2a3YrOT-xn7Bfsen9TX8vg9K5xg>
    <xmx:FFoGa7mXafPYMkvgch6QuQJzOtSNrN-7xpdF_w3GaB_mLrUkcF8edQ>
    <xmx:FFoGa0kYHgLSLFO87GfXAfwwTq6Pyjulfr1hIUP2skyVU4-mBMmw2g>
    <xmx:FFoGa39SD1Yr6bXlt_BCW-oA-lIPft0uYHOnPjSIMIfJoZH8_5LhGGJq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:23 -0500 (EST)
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
Subject: [PATCH v3 04/11] afs: use d_splice_alias() in afs_vnode_new_inode()
Date: Wed, 25 Nov 2026 14:16:42 +1100
Message-ID: <20261125034543.4084039-5-neilb@ownmail.net>
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
index fbe2a3eb56b0..32b05aa8e208 100644
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

