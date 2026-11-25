Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578404;
	b=SP4K4iWVYzNqYaVQ+1uyy1Ql4lFVlnqs92lxcsXfJwgP6CJmhs+0VTjzUNqfDwt5AvyR
	 7nfBdOoGCxEgnU17pOqhhcrtBNIrYeS/4yi+IltB1QqTAsa32xsG0mJUp1O3Bc2mE0Lp8
	 IOW1S+PVD5d982w/IZE2UtXCLWtReI4YAI70UXptQSBgyTgrp9cN2Lxv1C0+pyOEPONEF
	 hdNlTzpMfdOqyLygqwEmhv0k+5uERU/XKri+SuYUIINfg0DnoaD3Fh++ESlXV0cBAlEv+
	 aJKHAdCo0LcoLP+Dp9i3nFn+xTcJtm9VGW4ApkM+ZEN/rvB1N+zqMxxaH8zs69ktBVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578404;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=A+0PFuwkqqPencm2Jt4IcFZklnJtpqqJm/NUrmwEwvU=;
	b=kTzH/1mCcTPeUXTWXDhNqNghzQlNUtjMlRFsqMW5myQvTcMHt1FZpF9GZ/wA7mcGuOPr
	 Cu78Hglv2O8VJDbsHjnAFuP9xeJfVM227eMQ/5Pe0Ef6BJTnM73MucXvPh2b/tj9oqaGK
	 o0wo56mMv3Mn5r7V4IwZbuxo70Te6F3PYh6tzlSosNri4SWTZQsoXy8CMxd76P8zVWI+k
	 cHjLujwpvPI4mnYclTmazjb6gXQfo+qbDC8V8m6AGvsoODd/RrWLGbU1qUeJHwNlMgC+W
	 KlY72PUO0ENCE+fzUzDj3s7ASgyYVA9UaXsV5A2rPiyFLAa6litOW9DDggbcasZMpyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b="BtwNj/hh";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xP6G8+wN;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7033606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7033606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=BtwNj/hh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xP6G8+wN
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1965CEC0A08
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:46:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 24 Nov 2026 22:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578403;
	 x=1795664803; bh=A+0PFuwkqqPencm2Jt4IcFZklnJtpqqJm/NUrmwEwvU=; b=
	BtwNj/hh2MlaZjgdppKO3bdR55bK5HB/BK0JQQAE/lBAPGbJnL7/GWGAi5isu7k1
	60uWwkYNTQsL4z2eyeFOPYdvD8pZZinpbziXSFchxNnr5S0QFPdhJbmrLvq64dl5
	kH8XT2abW2rp4TxwCrioOljMA993AAtre8XTGUPwGxVYyJ2c64bpI0dqxoLr2oGj
	agyrAmD+kwdT3vuPaksX32S5UIHu4XuZdS1EJ1Bb/FjqcLceyWTqvceihwmUvn09
	AFdKBu0p9DlvATbxVn7Y5az+CpjCmbweD2y1g3G5svEfNzYKSTyOGcKjWP32e2Mv
	1g+ktL0b3wqOhAgVDJ+oUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578403; x=1795664803; bh=A
	+0PFuwkqqPencm2Jt4IcFZklnJtpqqJm/NUrmwEwvU=; b=xP6G8+wN6Xxne3+cn
	c4iTtUi8ToNZD8P3gAn6ygQXx2b5axXyBnwcYU91FeWbjx+N9OAZhUZQP83KJvzP
	kyG8oH3D3nGpjayLDu4niwdf3GOY27qpZQ1IgxvF0WEtxHY9kMYL0JrdYyufCEeL
	WBF4PobOonbZAbFfmid03wDwXIFzZIEcxqsowBi73jZChgM+Rryi5DINmrVptQ42
	2lsCxSCUXSx9ly9vxEYnph1BzRXpihEM6Vq7413CooxDe+UyVU5RM3HyvCf9YOQU
	K/ljCpYtbqC13X3VSzDlGe6qUOMAGbmssWIxsoegN2d7PAySxPZ2izLdnpUQzMDf
	Cussg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578403; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:jZjWyB0jX8dCP9zMtFOmUAF0jdXdsCmuMkF8eK7Y298R34e
	dGs2Chi/dDhlhFz7CsRue7yh93H72OeDC7wleGpmjUBgefmCde2epRS2/tP7DFih
	iIK5JJIKiNX1qoaTAF43kj4l97c1dHRKW6sG3TLUnF8u6/gfxLdenpW6eNiL6Cll
	HwC/31j5vSxSWSMrX7fKkhEZ8twFwKYGmL/DPwkrwPd0d1jWSGWOCcP/hQC2BRyZ
	cKRX2zCOAHJ0Krh0sO1NP8oNt4rmMuzzaqFpPFtdOfFopbqN9Oyc7vnCRr982S0Y
	vha/s5cy/Bv2U9vGzK2tOT9SnF3+oGVD/LOvatQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:kZWkqxM0YzamoA/klqsXonuHvTXNCZymcsHe+eOx7rk=:IKMx6k9vO6LY/IhFGyD2yzimZSa28WztvdL6DQli46E=;
X-ME-Sender: <xms:IloGa-hz6kW1riDRZlWPsvc-VQjWm1N4YBntEIjvw0Mo02vzAsLErA>
    <xme:IloGawccxSQHvD_nMo06BmODN1lzs8a_nf-UUWlO4mFqT5OIxmDzbwjCodrX_q-5o
    5V_5MSExe7Q_cS12KVDZSY9JJZIT89zFrM61T2Ast0LstNsYw>
X-ME-Received: <xmr:IloGaxdxRcwHnTL0mAv-Z4tL05J2K3-REyopkrUBw1sD7w3oDoZERnpnn0i0MTi6F-SlQMjXACI02GmbZ-Mik8lgQwYDG8U>
X-ME-Proxy-Cause: dmFkZTFR427OSMpMhBUq2c/PRD6RmqRpXHsHavEQEoZib45veoj0ON4Fee0fFpAMf6IRZD
    7ioshD0AaEWr7quPZ3VJk4MkgPxfK4VajmEfAasmF1N4QuQ1Nx4fAT27aU1zZmPYaReDqx
    rfP5UHReFgze/pUM1YUaeJAgJLGWSi2iJU/qcqRk+B4M1TsPMqQDofdX/Jn7SjcVJvCtNm
    zdB65WAuETFQQDYBDZIOHXvboBphMIm2vyy1TKs+e7zZqPSqTzzCVyEWo2arAfhj68hGFx
    kBzHUYnaQIV/eTYhsd/MgvSt0+AvaXUSwYNCdWWq7bBlwHpxfTlmsOfayzrTTRF9w5P7Qw
    0NrG9O0v3tN2Xh0lMTSQeVHonl1+7ZwSbnD4kBDyPus1/+yxGd1GZ3kB8GMxyV/4cErIle
    ZSvxxtsz4HlnyRFV8QtlLpH6bnYTRYY2id+lW7mCK/x9tsrSygRQZzMy20mBpcV1/0m012
    BXPkjFw7zOPv1qouh6iG6tKHz35wrCsIwR447EFWOQSvuPi5s6DlWdR7IuT+yK39NCkfJe
    gqhWAQBh7kE9a0cUXRSMevkQjrjZ2edpU61U8BJnZO4kx07an5eRga1Y7oxeNY+IzPBwu5
    0eiLDM5blqzLpgGYjKO6YufP2dkaKge+h8Sf+WESzTPkvq6Sx1xmxFfMEvdg
X-ME-Proxy: <xmx:IloGa0XFvqrxgNVDGd015Fty-pLbT2PLvdU-j7nbSXVs-XOzEVvIbg>
    <xmx:IloGa9fT40ZUJNjyybqJFCncEOsrJuyRtOQMiVTS55pn4rmNm2ViXw>
    <xmx:IloGaw-l1M7Bwt1J0LcHtTwlQowJH4-5dtZooiz4GNXA5HuO7E4urw>
    <xmx:IloGa0kQrSRv_h8fXYTzwhb_bJQ4TmEmjKPpJGipg1XX0veOcem-cg>
    <xmx:I1oGayK2Z0ZpVC6kxKN0jjlgvtzO_hFMOQmnpJqhokI4p4rYqAAU0jDp>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:37 -0500 (EST)
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
Subject: [PATCH v3 06/11] afs: use d_duplicate()
Date: Wed, 25 Nov 2026 14:16:44 +1100
Message-ID: <20261125034543.4084039-7-neilb@ownmail.net>
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

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to perform a
silly-rename.  This creates on in-lookup dentry which will contine to block
concurrent lookups after the original dentry is silly-renamed, and until
the final rename happens.

As the resulting dentry is in-lookup, we need to call d_lookup_done()
before d_put().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 672bd83ff112..bc90b30d8b57 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2060,7 +2060,10 @@ static void afs_rename_put(struct afs_operation *op)
 	store_release_wake_up(&op->dentry->d_flags,
 			      op->dentry->d_flags &~ DCACHE_BLOCKED);
 	spin_unlock(&op->dentry->d_lock);
-	dput(op->rename.tmp);
+	if (op->rename.tmp) {
+		d_lookup_done(op->rename.tmp);
+		dput(op->rename.tmp);
+	}
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2190,8 +2193,7 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 			if (d_count(new_dentry) > 2) {
 				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
-				op->rename.tmp = d_alloc(new_dentry->d_parent,
-							 &new_dentry->d_name);
+				op->rename.tmp = d_duplicate(new_dentry);
 				if (!op->rename.tmp) {
 					afs_op_nomem(op);
 					goto error;
-- 
2.50.0.107.gf914562f5916.dirty

