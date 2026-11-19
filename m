Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057214;
	b=nzjcUBB7GeAn06YiB00b+8HejZWAVKaXA/TFCd3dO+/RMB+47abdn5wVw5XpNjxMBicP
	 txODAphDAjFhLRCa039oxneCDEs2ZhPbS6zN4h0fNMXjYohKXHrqgIIGzntZMZcdrnLt+
	 +dUlTULJXXqLEmAcraf6quPxtFsl6I/Jjel45hFcWW3ehEjh7/0bYusfmK3mN76vnQfti
	 urtUAq26EwlZlEAssdXn0bhBLiCafa+322kv0syOTTY8PXXM4e8IXrGX+QTfMgEUtS3Rk
	 JlaDY27Ffqr/4b+rAbxScsydFr8mBLP35BRapfXaD3Go8Z+JimT0/+AUwz/TQYK34+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057214;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=aptDJ9CN289s9UyX+NLKCkgvxT8WHlhg0ZhHbgXSIYk=;
	b=wvKgXj4xMDZVqpYIdtuc4C+2HLsBC1Qw+nzQpyOUf7B8gN7IxyTrZ963/p3FSBAMo8kA
	 keF415dGysWRIfneM4yrS4CJagcbdj94mpE/MgvQPGawmkGsPzySVUbz/EmxuYCtNE9DB
	 CRxUmBHRnC37UKxHUhgyiCk6sywC4kRpAaANYHlrFvgngvLQW4Ahc8dxdLXpNfC829BQz
	 g/VVVhsl+7XPFRyV41vQKfVsC1MSjyyfynAs0LMNpurXAc8yGbTZDlFNckrMRIuAfy2Ur
	 8TP/LIy/udXaX6B6OfOpLm/2OaHFf3cF/l9UIWPLQcwLC7mxM5NqAQy+ewLjCm/trzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=aNZFINiO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iN2Q9TRt;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A618606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A618606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=aNZFINiO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iN2Q9TRt
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A24ECEC058F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:00:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 22:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795057213;
	 x=1795143613; bh=aptDJ9CN289s9UyX+NLKCkgvxT8WHlhg0ZhHbgXSIYk=; b=
	aNZFINiOVUwUbdy52+cin1CRNJZqze29djDePQUGrlQvxPJPui6fFZ419QdeX/rU
	31l6ohI+rzgQ3f5fzF8EeGzpp+UNZRRHOL2hgPctotmydullGC6+hd6fE3o5n191
	gHKObxUr8Rvs+l4/mBCUIaLZ7U01lQ33fZfeIRPRAiXCDMnx5QuuxVz67mGrupez
	CWzWWlVkGjp1gWX/27v0aF3XqSXU4ipNpCZe/E82jRerMb4Bq+k8qXpP30XK1+hn
	/JRww2wvubw1QwIgiuymHZBseZWEgLffuZyviZ2kXcTQt2f2pSTcwmi6zv1WUHas
	M8xi4a3bQ3U7TInhF8TjWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795057213; x=1795143613; bh=a
	ptDJ9CN289s9UyX+NLKCkgvxT8WHlhg0ZhHbgXSIYk=; b=iN2Q9TRtgpnFiqr5c
	tHhUmWU8QjV7Q2+kCoVeWoQnmHqn07XFIn91HjHfDxJyukk1vCrQoE0nd1X6Q20I
	UIzV9OsvuykCzIp1uBVOalopDfbKmqi70aHxkVxTRtNmvjeRyK2orKNq3BXrrvod
	vh3oZjOMCi+pUQPOcDoUxu2gLW6ENqDcXfNNHyREjhlonGxHXw9D+f8mG3An/zTA
	hOdVlVdTQ6mxloKDD8HswoaSjdP321ExL0cl51qARcjY8SlPLEycLhebvAuZsBgX
	Qz9He8Eu5+gUlO2Xx4wSq7AsjLM9LJWJFuVno1+TF5zsO5dylDapcD35F8NztZMY
	w0dWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795057213; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:HmU+5ie2hwbT68hOAZwR5pXCBn9ICRAmGyivIL4LWVAc4rv
	laKWuHSTe5IrX8LYnVUcyhdEEf0bK4ORGYPqfjdmnTnwyignwJCNn2hLpCeB26dw
	FvxVmTthRG15N7tNQ9U3Wx8DPu61DJiX/FliaoZTHUAxa3H2qOS4p8SHCujvl+St
	c+A4rhHLyDjkvCMSa33xbEFH4OeVg8sFsj+74LBICYzMiY49zwS2lnOiLEp2Ohz9
	VvNdU5bgQ57x4MXNvQ302PO+RSBJULZ/IzDOlciq69SkIzyxq24Btiq6oHGXgp8S
	12N/aOOywR7h8seeqs75ry1WRi3/ecOFvHUbukw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:wuAvYhF207gr659CSSkoa6oy4KcrRhj3oSKVa38C6pI=:T74tirV5N856DSltH7wPoBwmoTLSOw1MU6M9BsFYoxQ=;
X-ME-Sender: <xms:PWb-amP3vduz-T4rOQ51iP05-XKbQ9U34OksvnuVS4qCR7UgwhPD9g>
    <xme:PWb-angnHVgdGoYRG5VqXD0qQ4Rp9wMqNvSffdkWrvewaCWwTcIOn6GihSJHuLTL1
    rHI1GTWo61YHxKLyr2xNCzvE0IFDK4ZPcj27IlR1k8AcuNbuaE>
X-ME-Received: <xmr:PWb-ag5zna9XSpia3SYkslc0_A5C-bvOqba4DX8rKHDGRXw5e7gHnEHHPiI-sF2Hs1LISE4N7X3erbLY0wibocvf1sVOGdk>
X-ME-Proxy-Cause: dmFkZTGjL0o1QOXyK9X2ADiNAj3QeShgWWOAChQ8ZuS0aezgqsh+YXIxL6ELkwPJM37GZy
    ozKdIZncc0vfLq9yKLiTOVMC6qEkJx0MX3h2outDKO4iqI5zyLzd0SiFSrPzCa5cU8n/f/
    4tV5d7/VMQu+ZNiUrHBqG4a2WVJWvSjqriegRqA/48q5+YgIq4aCaxzU2ZB+dEnbAhFdkc
    Z8kC71J5QFlep0kz9dWFvPcrad0j4sgxrJSoHkDHfSLtmVogYWJWy0BqeoeSDXx4B2hGyh
    nzqpj+QZ1w3Yzvu9j/tKPC7aofbiqs0S+W71RvWrNsE8pxTPndIBhgzFnOP+TBU1pIj7Fn
    dBz3St0h4DvEeXemAQPMiuZwabNTUcnl3HbATpbWx1HhdOIfYpEsvZ01by5h6AqRy/W9nJ
    BYCjfA8qu/cvsNqEBDfLJ0iTXa4RFcuch1aoGV8x7djyJVjCkR8BznYls8QWgm9SAgco9T
    mZ1ILzVT9bhXvY1Icxpvo9ORpN8QMIhC8ge+AF+rhCcnLR4SQoWw000Wg25Vq09kvdKWQJ
    aP2lmSXYswAOQXzPvC23k+Ta/tWeXS3d3zbBRCOwu0ubkq+s1FBZcupsksKLK5UpgulnjO
    tx2SKHntmbr/PTafPEbZbl56gAOh8uacy4I9cPFW/ABZFfbR0EODMZ8nG9Jw
X-ME-Proxy: <xmx:PWb-am1G3X2uWx-gBvOk2kZbDITfIIeW9XS_92UOfi9-YZ-hDji9DQ>
    <xmx:PWb-ajsaeVjg99e5-ZJiUwqA1rYp0yqnSs6U67AgMnkRQbyjelnpHQ>
    <xmx:PWb-ak7jJuPFIUw0h23vR64YGPbHm4LvnFW-j1_kTbt6EPOOp1BkVg>
    <xmx:PWb-anfYtaA-vxWIczymdDSByfYlMJ0pT_vITBnoIUiv3j4hu-EAZQ>
    <xmx:PWb-ah8tBDoWi87ITQbMMbSrOIJFtwqHikNwV9Egoku_9SgV1JxKBRzE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 22:00:10 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v5 3/5] fsnotify: don't hold i_lock while walking d_children in  fsnotify_set_children_dentry_flags()
Date: Thu, 19 Nov 2026 13:57:03 +1100
Message-ID: <20261119025942.2848130-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261119025942.2848130-1-neilb@ownmail.net>
References: <20261119025942.2848130-1-neilb@ownmail.net>
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

Rather than hold i_lock across a d_children walk, dget() a reference to
the dentry and drop the i_lock before the walk.  This is easily done
with d_find_alias().

This requires that we dput() which can sleep.  Now that no locks are
held across calls to fsnotify_set_children_dentry_flags(), this is safe.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/notify/fsnotify.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8657bb94dfa8..58566e6b9679 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -71,32 +71,32 @@ void fsnotify_sb_free(struct super_block *sb)
  */
 void fsnotify_set_children_dentry_flags(struct inode *inode)
 {
-	struct dentry *alias;
+	struct dentry *alias, *child;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	spin_lock(&inode->i_lock);
-	/* run all of the dentries associated with this inode.  Since this is a
-	 * directory, there damn well better only be one item on this list */
-	for_each_alias(alias, inode) {
-		struct dentry *child;
-
-		/* run all of the children of the original inode and fix their
-		 * d_flags to indicate parental interest (their parent is the
-		 * original inode) */
-		spin_lock(&alias->d_lock);
-		hlist_for_each_entry(child, &alias->d_children, d_sib) {
-			if (!child->d_inode)
-				continue;
+	/* Find the dentry for inode - there can only be one */
+	alias = d_find_alias(inode);
+	if (!alias)
+		return;
 
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			spin_unlock(&child->d_lock);
-		}
-		spin_unlock(&alias->d_lock);
+	/*
+	 * run through all of the children of the original inode and fix
+	 * their d_flags to indicate parental interest (their parent is
+	 * the original inode)
+	 */
+	spin_lock(&alias->d_lock);
+	hlist_for_each_entry(child, &alias->d_children, d_sib) {
+		if (!child->d_inode)
+			continue;
+
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
+		spin_unlock(&child->d_lock);
 	}
-	spin_unlock(&inode->i_lock);
+	spin_unlock(&alias->d_lock);
+	dput(alias);
 }
 
 /*
-- 
2.50.0.107.gf914562f5916.dirty

