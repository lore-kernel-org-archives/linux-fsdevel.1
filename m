Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578426;
	b=fl+df79mY80C5Nm8L1uZNUWJocSgLcgmQRJk01P+Slz6DOSPRwR3SXrv/AFrm3Tw96JW
	 QiD4AzM/EZEVyhDgGOKfoWyBzkhOhCjvF8FpNAQxfQxChhMADS3ANLJfmWmyrUOBNIbNi
	 zzAuJCKhOEj/FQ/olLe+synzTDSoYVveklDrhgIVVpzn5lns0c4NcmAzcpx7VQuvzKmko
	 YiwLNVR0QcDe53HDTfUGAnmvaQ5ftiw/Ud5zBmII+uXbdBMkSulU4dx6Hukgx/QnPJYlG
	 blMf8MWmqN6H8UN2YumXEOGuLa1kQ887qZ3pEw+TuyUriAjU4+0YaQ0A9mlY8SXUJhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578426;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=7GW90Xebke1BO6VVD+3Eb+D/Pr8y2bvy00kHZFBZIWY=;
	b=YIEqDiSb+ynsQxt1GD8yDl1Eu0XlDWX8583R69vsBtuqAN2093RXFttwM23za0uS5uyY
	 FhY/mxHOTuU3r0Yii2XmdUXsgzYZdE+KKQhYOPAMvXVVySgi9raWqKR1/ET20lPwpaUHs
	 f+YkGRq6wm5u4vMdabGH4y0Rysw9rWftuxsOuRoMtPRj0OkbxWHHK+zhc8edIDT9BCP03
	 DqRE3n0fPK1MFRJ63eKYHCsSC9vcAXUebOMlKtI+yPREFCn0Ox/LjQVudeirWtYdeN7yj
	 d0CQ9FrqQkKO+jYlwE5BxyYFYz4a+gBKo5o1MWnqxhsfYCE6yyf1RmwEqDZl4Ezc/AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=MrF6e9+Z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TiS5M1sX;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7C606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB7C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=MrF6e9+Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TiS5M1sX
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E31EE1400369
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:47:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 22:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578424;
	 x=1795664824; bh=7GW90Xebke1BO6VVD+3Eb+D/Pr8y2bvy00kHZFBZIWY=; b=
	MrF6e9+ZMBTZn/E8MbMazi5xiWgag5leKJkWRE3yJiRs3KF0cDsEu8CLxxqy4du+
	B5SPDpYwQkJZdR4omxRqKsYznywT9axCihKe2BmV3UuArLInERHrvbdwh1LIGEI7
	FBbWtRhIzFq51gfx1aubPoAFYLa8GrVUymBFV7SX2O8QY3Q2TwNEajuCriDn16Vm
	UeA9IxU9PFJB2hgx2vOzDp9vpKyTvfQ3VXpsbZUN6fLFySDSR+cs9McAUZQlZYOo
	0mxbpH9b8rugf0nvbmZzd874I7vEeSdbyAg51DQc3oyK/bKCnn6oAcy0ar4iL0nF
	OeKDVR44R14Fz8zRZ7/W/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578424; x=1795664824; bh=7
	GW90Xebke1BO6VVD+3Eb+D/Pr8y2bvy00kHZFBZIWY=; b=TiS5M1sXCm2z71YAv
	Rdi4q4SlJ7G6TVuL0xFGepax6Nb2Mh9/d1bErQT4vC7QKmW6PbPvWERrwDxPob8V
	I0VKLE+YhaZVRaPsm4VqUSynbziVM/qtO2knxlakeOqvP5HyXMUzsp5bkH8fh26C
	IqCFItT8+GG08H2NLrdwBui15uXc/neWHa55XkiIaJGmjj6Cn5xkK+A27mTk3TuM
	s5T8Zo1de3O1JIN1tL6cqV4ElIdm73nRmd8DmcrFwuNp0niSRL/XdpkzpLgyAdAP
	1bWIHFgZc9peeQEj7amO2Dr7pyNHPEOui66ykO/7/Fg4X/LS+719EYToLSbxXgHl
	R+x2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578424; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:VIyqpEQkuQmz6NFbO5Lj97SyD/ZWu66KzxMzm8T0IJxzm0r
	aJPdOJmY3Qj4lg3iS+SFeV5sqe6WyZulEuZjSq2WK7Tu/1glIy42/xrgcPB731wN
	RXnxRjb2hmxufrksvGMMWdMB6oQ2CkSt/XxLzTHcGMtmGIimFxhxQnjM8YoWLkOs
	98FrNPXMuGbdc05Se/1rimEdO64+N2aijiN43JwNeOmA6o/WI6le0sj9kOX3Wshx
	yF8OensHKIXM4tOtEPsy5WKZGQrMMhHu5Yj+UXf4RDrx+19iWD+MFrOubcnBW6JG
	myT+DIyrZBVZm5L/4DG9jBBAHnxBiXzjHehSyJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:pLgtTQtuzOUYUx84zLKxXDCEnsf79PIXIsM+V8REFpk=:rKFIY2igCQNYJ/8KN9XbK5tFVEJagzy3L1EzWAznAQk=;
X-ME-Sender: <xms:OFoGazXKdCSkKTZCsM8ZxbCxn2aCGdRdB7YJyh8W5pRsfUgf7LlgwQ>
    <xme:OFoGaygUJefB43KaU-rklI6ZcAdwUwN_Gbryx1-aXrRNCf5EbxYtCpo0fPnsNGS8l
    ECqO8P7UoehIyDgUrhqQ3cm2Ma601Qm8f2oouzxA5VrgwimbFo>
X-ME-Received: <xmr:OFoGa0fXtLGdWr3KOYl32QJS10vao9AriisE_RaekH0wMFiJcTWhQLp7NIE13nZgyuMMe3Tv94YPXajkXFdHXvx4bh5CXO4>
X-ME-Proxy-Cause: dmFkZTE4HtNMS82oETeKxjFsMonchsNmutSXRF8P4Wz/gL5NuR+PmnhI7BdBjNpxinbAbR
    gE9fr8C0GNc0SnxE2B+IXDaaoddndfcEJfJtcWeI4ytNiRF08hWb9RlxFjA1qgM4oFyoJi
    /AdIhJNfEVO0oVTJtQVCvv+X67aNRews2LQwnM5uAbOmmoGahsFhP1aXSbisfk+ds7cJJ0
    OsFbDOPt7ZICh4tniydbOvMlt1+f+7jVXUCHPaOJHWPFgfTUvPivbmMoJSDdfil0VmV1q/
    2QMjPNE1ltm0/CAvjxy3k0MqWfenoOEUWjyOM0HmgbohwH+N/2hScfzSSITnIBzePDS5oC
    YFHOQAnyEuAqnfgBtSnnYtOgAjzsJ1IwaGTozxClzxjIqWdOYHSG2ZsI/tZG4wAeX3eMfc
    uJ/8/Rcsdctsd3B45F/OegSCjYq/aOokBPrWswWQE/p5+P4uAExV5ufFMfgf2APnWeThom
    amUcpiyHxktVYgGYGNuRcWn2NXITXMXNo13y5gmT2jl+YvZrz9VOZhwDLVNHmWqit/cdsW
    G1FIxC2vMuUI2zWvy702UXXJotPnVh2hCwxYjLg69wHIC4s3wx67DJLjXEbBdBMAgkBthE
    aatYGNh8qBvSofBxsnjcg2GXutvcXGcrdWMNPpZ9x1pgi3lPC8HzTx5+SqWg
X-ME-Proxy: <xmx:OFoGa1erk08EpG2rvWQ3wIGT0wqicS8EncSh-h9jOyVDL1Ev9JdPqw>
    <xmx:OFoGa4USYw4TfrasH9puRXJqVgeY6IXH-lkUaC8OBX01xZI2sGA-8Q>
    <xmx:OFoGaxc4QAjUwuRuwLfus1jabxKEz_RHTScQLHv0zR5MxJJtTYk1uA>
    <xmx:OFoGa0_UPBBMM0zzmwKx4HTMp1zc26gS_liWppS6ET0YJtUo7CTbdA>
    <xmx:OFoGawBS7Sk13OXr7cbbeXnA7xi6jSxiyyhN7gKhcJ-Hn1tN5KNfdg8j>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:47:00 -0500 (EST)
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
Subject: [PATCH v3 09/11] VFS: drop parent lock across d_alloc_parallel() in d_add_ci()
Date: Wed, 25 Nov 2026 14:16:47 +1100
Message-ID: <20261125034543.4084039-10-neilb@ownmail.net>
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

A proposed change will invert the lock ordering between
d_alloc_parallel() and inode_lock() on the parent.
When that happens it will not be safe to call d_alloc_parallel() while
holding the parent lock - even shared.

It is already *safe* to call d_alloc_parallel() without holding the
parent lock - providing any filesystem that does so doesn't d_drop or
d_hash in the middle of an operation.  Those filesystems which use
d_add_ci() don't d_drop().

We don't need to keep the parent lock held when d_add_ci() is run - the
VFS doesn't need it as dentry is exclusively held due to
DCACHE_PAR_LOOKUP and the filesystem has finished its work.

So drop and reclaim the lock to avoid future deadlock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2ad39c1515b7..ed957f090247 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2472,17 +2472,30 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
+	/*
+	 * We are holding parent lock and mustn't wait
+	 * for a d_in_lookup() dentry.  We can safely drop the
+	 * parent lock and reclaim it as we have exclusive
+	 * access to dentry as it is d_in_lookup() (so
+	 * ->d_parent is stable) and we are near the end
+	 * ->lookup() and will shortly drop the lock anyway.
+	 * We cannot retake the lock while the new dentry is in-lookup
+	 */
+	inode_unlock_shared(d_inode(dentry->d_parent));
 	found = d_alloc_parallel(dentry->d_parent, name);
 	if (IS_ERR(found) || !d_in_lookup(found)) {
 		iput(inode);
-		return found;
+		goto out_relock;
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
 		d_lookup_done(found);
 		dput(found);
-		return res;
+		found = res;
 	}
+out_relock:
+	d_lookup_done(dentry);
+	inode_lock_shared(d_inode(dentry->d_parent));
 	return found;
 }
 EXPORT_SYMBOL(d_add_ci);
-- 
2.50.0.107.gf914562f5916.dirty

