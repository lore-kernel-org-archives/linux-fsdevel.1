Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565467;
	b=Mmb/vnNe9jMqFdEGHikYxRZymcds7sGWjpZFWANgDsn+Sv9z6hnLrhfWaXZCCpu7iuOg
	 WQ+ugI/bcNhf7XmAsLTfbEgbf6E16CGOOCUkNtBzw/Rx8dihZ+cFxZqGVqpQfyxMqsSG9
	 xLsSStdt6SPMmOt4fI0k9Oz4XG7cLKtx1PP7XA1qLZmCz0KMZLn3+StBZPFatGDey1wIi
	 kYdYVB1VsnkhZ0oARw1G8jmRwewuvQ7pJdZwHEvL8bS9gvKauWub5TvsVompnbvPXgmsp
	 k603nu1W8/jKQqLHVd6oU0ErTAVi4giWHoNW7VIrfd1J2F//mxbEX73O530K3YKcunw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565467;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=axu4NhpAbAHSQzsFIZa7XWjTqg7HIr5RJucx1ETsiAM=;
	b=11rlLOp/RCjoFgh0JnztSjatR8OUyhCFMzZLZXGCFAYL+CgkjqMLg9iChvg7UwKG8kbt
	 7QrKmH8WO7VfsowkhMZ5zPX48aaHy99Lkl5pC1Gf2LmiyFf0TG85n0caJK+LJKH9vp+Hw
	 r5Rk+fK3zQAbXvifDwE511Vyn7EjjC92TcnyBJzGcgiCaarw93XnNyXmkXS03aNrs9E+4
	 x4IpICtYqpIKcMUqMnK5hYHnlaX1NdDMo8ScEwdroIIGAJQIUeWEF5ODRUtQgZFLhCkmo
	 UBYw+wG0L8ZPAxLxz0YI7BI9t9YdU59o240gJm0hjVMo76KAvHJvHRQPXvO2lycRoOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=P9pdkJFz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o5pNZyEq;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71913606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 00:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71913606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=P9pdkJFz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o5pNZyEq
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E6B31400341
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:11:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Nov 2026 19:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795565465;
	 x=1795651865; bh=axu4NhpAbAHSQzsFIZa7XWjTqg7HIr5RJucx1ETsiAM=; b=
	P9pdkJFzDyxjwKBLuS+x7sJLAq/CwDZtRsgFxV8NEOJR+9PXiCfFRniriopQaWxL
	PQoJ2kCgAoREmD4XwITiFj5auPnGJYep1h01hqIKkzrz4USlDsnSO/4L/uAL8/Ed
	mHLWOEBwcK737oQJpeZrgaSaNiCNls3OhTQbxOnRExhg9mm1YxVpGCxImLrqixvO
	kOh8dHLwuErHnu2B/Uv9aWCwNb6HSsXicNjPh14BZ66w5UyQBjYOu0Ii34GAq3Cj
	fHShv/SXm3bGWYmNpZq1tcRpS478dnWGw7PQnoTGG2cWZVFieUcqneqYC5VZnARM
	7xHEMiSMW08QtWOfdlgD1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795565465; x=1795651865; bh=a
	xu4NhpAbAHSQzsFIZa7XWjTqg7HIr5RJucx1ETsiAM=; b=o5pNZyEqwU+uRMWPE
	riKBBhIiLrBMTTT47LYvKR8LdYMFj4R/luLyGjlmfKy+Tb4nDztQ2J4ZnI+HOL6Z
	7bQwZqHne7uBAmX93KJ7rWUax5W0niBfGBzSZic9+sTGbJnR6UtTosdbMbRVNFPe
	WRRYL9NI6/O8OF+75jpidEv/qQ4a6G1U7WX5gZpiIhKbYhVedbbuf16QwiTqztmB
	69KQhrElS15XH3CMc4ikVXSccAH8TKUHPBhUE9Rsnd6A+NO1PuZQkb7TUwNe2Enp
	u7rs9oec0mzlm7eXyZ2H/1q1fnbxZCUzoCiVAWoMB8msANUtMEjiRWhiW6hFKp/+
	YGL/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795565465; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:aPErTGcoa9gCgRxVPIN32HMdvLsilm1ItMy8afivIaHCrk0
	I9svMu7pMhDK7g0nmU7xLYkHm8KuMV71FipiNBvy7daQc8JTg09MMa45ps9eu4YE
	mAWg9/zOD75F620gZhiDVixt02oGM9wJzo2PV/b54u56x/6YIuQzi4lQccCBBp5d
	HQdpq2O304+LLqadXKLrakeVEmYDCs1eZ+xmzgJmHLTUbTde8FtXxAqsBCLND4K1
	TR9dPWf3WIsBH5LaQLrVIMLFBopMFU2iK2kuoWgGB1aUtC/f7pDlwoQTd+n7Uf1f
	xay7QqWoE02pwIfq9n9tYSF5r6tzZ66qDb0ipqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:j2FAahr4rocOh7VK0kCYQAOezvqQqbIinf+5Ji7erE0=:qA+h1JAr6sTCmgF5ZTWE9gcliziF2aqrqd46R/tV3sg=;
X-ME-Sender: <xms:mScGaxUHX-sH_CDvUMnE0uuUNqnHUN7UnTAtqkJDgJyXvjs9_kw8rg>
    <xme:mScGa0LC4oeeWUV-SwFRKv19OIhODznD5-G-pfQx4vFcJy26Ey_uZbeTCpUI5I6Sm
    GtxlWmY14ljEkV_8Wi82jjZR_DCyF-6uuZ_5wIPfcvT1vh0sg>
X-ME-Received: <xmr:mScGaxDXCW5pgRPmykWjbzxk1RzW0wsTzbWQhHMsqUSdI4biuPVv7xEUCCGP49FRgVcDDAIel5JxMtY-FoCoNjrqiSHS88k>
X-ME-Proxy-Cause: dmFkZTFtvvtjo3TiqnwievywHT6UMcqs4LNW0jtUBl4WBqV/m7gd8GJpLHqrSgN8SWLSUZ
    VJzM9Mehgr8GzWto4KXYhuPfb2KYnCUl5uLncNNiprl4L2/H+RTJ/fuYTB9lhxGbbLKMYD
    M/6CxXIb3E/XyzdymtH1FBzd5e8L2Po01VMPRPLL5C3Io0AwFZ8dbU3XydszypkkZokBqR
    /jGhZrNqXiUxGkRCo3/x2DTJGeMaThLWGacM5+cfNvEWgcAm40zlBt5kA6JjfFB6gF3nMg
    YcWsKjzsifnV88vQpUOFazoiPMwVgCfmSGKauqcf58vaHaqH0uQcfMVcybu2xlmAKlOrmZ
    Rx68hgvTPXE1rOSA6nYH0YShOfamEToqpvzMceQXnfJtkD2nyWvTO8OiJW0zia26YiRElQ
    zBbRSx3rU4ZfwlSQlT2IvzrDVmhnqtu1r8oGhJ5UIZFPLczbuNjDxNZSddp+jqSSojaVWx
    7lwh8BkZADySo8GKZ3nRT3AhhjmA9dDVFiadfRvFtQ8/4fBoBYum0IJCoMVJVulXRpi/IK
    d4HMBDvTLehZRlO2cmWVXzibgk4Q7i8YXY5DX6xk2+n//I/NaK/rOzvguhfOWSjpFrpbX9
    yu7J+58d3N7h/i7GisOvbPQp6iX0tJdpzNUkPcizPBXPMT7kfwhIFMn84UqQ
X-ME-Proxy: <xmx:mScGa0enteFpDzongZS65ov-JzrF-l5UzRBd682-8BrFpwQcZcWJuw>
    <xmx:mScGaw0zlpc3Lh9MLlvLM-cGPFUyK6nJ7bLKK2pG1q1fH3_bA3YbHg>
    <xmx:mScGa7ggb-SuCVVJ7RW2t_Q1V5pv7z0Vo0MnwNHCC69lmTNd9-Oe5A>
    <xmx:mScGa5k6XZ0hrOtzglTh2SeMkRoO3bySry8Uf4l3FD4_nmNH-DYtEA>
    <xmx:mScGayE1lDZk6AZGJ5cesnQ3Mz6YkYO5kdTT4tZC9x3J136s6OLNRPV_>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:11:02 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v7 3/5] fsnotify: don't hold i_lock while walking d_children in  fsnotify_set_children_dentry_flags()
Date: Wed, 25 Nov 2026 11:03:40 +1100
Message-ID: <20261125000836.3984402-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125000836.3984402-1-neilb@ownmail.net>
References: <20261125000836.3984402-1-neilb@ownmail.net>
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

Reviewed-by: Jan Kara <jack@suse.cz>
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

