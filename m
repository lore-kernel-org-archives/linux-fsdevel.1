Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057225;
	b=4bN+B2JrdZ62Ws0j9GNdKHfsX/gT5OZkyxj3EXB0NAbayKyTtwkdTa9KfcBDOqjdVdQp
	 aKQKuqKt7zTSB7ASxml2v3Jwyef3/Yw2szEcvZE/OunOhvaKFZOqmg7DL3IvcYivkiTVz
	 A7mEgqV9PG4x/gmPo5Sf/9x3b5Sz4XG1SW43LX0B6O8GZG0U2fVHMeh8+8jRGlOc3ozTY
	 fz63HgY2Bp3mFOW4OkUllqV/RYziyN/Tau1sYzbdl6g4lKQKLPrg4vXtP9WOtwdBuN0cn
	 CnacfPUDn2PgL+gtjqSTEam5qnKX+67YUvWoNud2FxluUfTuzyzh3orpmp7ffqtYyVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057225;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=d6+SiGbmf4j99ttYX6WtXOMxg4KR2+5qRzkcAFndvOU=;
	b=tNJum5vysxU2UoW8KQrHGqeVl/jYBa0CVp4J25inpd/2hCdevc5bTb+iUnGjHGSKtBzd
	 IHn5I9AwWQjld6eiXkNXDgZ2X41SdQursQea2zJ5CqjNHFBu2Uvpx+uun6J7kIal4AMJM
	 N1NGsqm2EW6/B5GiwAMJBwjd8220vg/af4AtZL6lUBeAaiGbKrgQEDuBI/TS6tYH5H+3P
	 o2QX3U7oiNV3gOdtLKsbywhBqcBG9usI7XeG0Ki7s6Ez47qu3CTPb+AZ9EB4gnncn72yf
	 fYPtPJ4hpZ6iPricdxOUy+gEnr3L5/N0AGnqwNzcj6Ndpg5sCYU8X7UAh1lGBM+ihQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=NfPf05rO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z3HFzhTc;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD4606A334
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDD4606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=NfPf05rO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z3HFzhTc
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E0135EC0587
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:00:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 22:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795057223;
	 x=1795143623; bh=d6+SiGbmf4j99ttYX6WtXOMxg4KR2+5qRzkcAFndvOU=; b=
	NfPf05rOs+JY66PDpqj706dMhhQreGRNavHaA1IyxRIo+LCDm80IturVlJA5RV1k
	fs0aQuru3Bb1n44AKazcgmskuFMCpYWmTzAOeHp5to3lAI7eln7fNGQ7nAoXwBLG
	d/S1UnWUIgg/gJOXzNqpRkGzHUC6OCZ3Wf6bXRfXFTn3b5DcKnE2UEutxd0EOe4F
	k9Ji3vrNTTYLsUGrr3/XYZKCdmTdHeyhWHiKcShmEK3X9kIBgP60UvSSG74bk/xT
	Z5EhqmOc1lnJEAVXZrThxBLJnbEwE5dqCQ9XxXa1C03Lc9QFJ0V00jkJO8ghuIbl
	bn7CgG3fV4hNoM9NxmlAlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795057223; x=1795143623; bh=d
	6+SiGbmf4j99ttYX6WtXOMxg4KR2+5qRzkcAFndvOU=; b=z3HFzhTcgmNOEdCix
	Rw3ngcvcFeJPu0Ft1lBJjkSbZbsccQsN+1SpvsF7RSfEU4b2tN+sLKuEwu1QNMZk
	1uvAmJm/dqJEI/20gMev2QKQCU1I6tvW0WcXHiZITSPxuhtLFlFQa0FetKqrcBDc
	lYAXmN7P6CX4itX2PwHYd3BTqM9nUmL4yVA6vWSSAFSn+4/crE5PXkGa9Asv1UFd
	LGML0j/JMTpbVeORO8Qiq/E/bdxXQULGvfQDSc1S1XN5c9tMT5qTVOirIxdmv8di
	QpZ4jz2Gr/koaasRLJGQUdv8Cm2dQyRCvgfUxCGWsR91f0V7cgV8gp+tegf5wrJv
	F4wNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795057223; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:zl2Hf4FGUiHR/Wqspce++3lDOIxxM4EgZQDc3H68a0aqFDH
	aV53WIeXE/LswbX33mYCJaXHPhTdtoi0h6ARPLFXCbmdOR0yv6rtzDD2CIBw7Go2
	8AXLZt/qj9axJGlMn5HfPIXQVDXtTEULcJASHu9u9MMLZ8+sj3WFGXN7CpJQ2noA
	bEGYU4h69Pu/2n/t0oecMRGMycg3RI6GV4+b4eJfJlLmig15Ongf0cAxz2vV4Vpg
	AkgWw5zHXOKfFEyMELkhgaUbMzIgZgQJeEJQRao8UBNYbL6uNpbcSXV2KxtMQcjD
	6ZRVuxUWsgM8BuhFEr21zIn984Rv3EX11MZF/Kw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:pntBIrVDvArFt1PGz6ZtmGwt1Qof/Kc+tlUFABmcNWU=:emMHznvwRdqD2spFsW+XgRtx22Yu6t1JgDMwwuks/gU=;
X-ME-Sender: <xms:R2b-arThj6N5lW-kHp6mrHry1MNtrA89TFB6jJIAj89BFBapvXvjBg>
    <xme:R2b-avWxrkVV2-pP1TDG3BGzj23mfQw16XEw3q7l8KIo4Fvqne9LHmjBR4ladOTs2
    76eCK55gCa488ZTAbpkobRvAQ2mPveW3hfZ3r0vRa1FOA7vc2E>
X-ME-Received: <xmr:R2b-ake4PaqwnBM60w18qYfvBAfk5xmKYc54M1akI4EmLVhPRW_dkQJU7MgtuxsEhKKU-2iI0YI3Ajp3PAyOQO-BVgy__gY>
X-ME-Proxy-Cause: dmFkZTF5aNm3vmmontyyrT2O6rUztv8ppj0IeipASNV+CPcjRRA9YZoQDvTUrYLUlj3z+U
    d7nmqFT3cZ8iRlUAOQ7nwTQqZ8GU4/YJ5eLlR2pHJnzymEhfKraaOQL02uwwHm/YpeUTwa
    Je/H/f5H8Ga3rQMfDfkvAV/C/0CVEqypHYXea/xfgt8GPv1IajFXzA5ONcgGcJNZBshF0l
    tqbzCUDiR3KvVAsoXUb8O1nfFOPW0O6W9cjnkgQKL0KzUxEdSr5StwyWpsVrKRtDYVnSvM
    leOXff0VZ4f8+RJSrXHrJk8G8/9MgY/9OofkHwo3sJvC8O2UlTHNid9yGNwLYYlB31BbiJ
    QnqLxzoV6IPlgXzfdyQ9omtf6jFu5CgWB5yQ7Ugnv3UAvC3l+vi37RThEd87tbgqt8mSGe
    b/c7Igd8cXbwdqWaGZGzYthhpbQpYd6OIsyqU6uRNsKu6tYYHTrg7xMZxOo54BcI3CMnLT
    k5WEPDzofNytK78yy02DiNxthfb8jKcOXQlvc5flLHVETU2aBPa23JdHAcKHdq3hbgrzAh
    cYNUt5BaEdfWhmdUnfoNicv26GQ6H0YK20lTTC685SWJlbzDqPOTRRvcazvNIw57H9XDPC
    KwWREdFYsOe5BfisnsdYsiavt/NlesvUoNW2o9TTrgmaByDXyOjSCEpSBsvw
X-ME-Proxy: <xmx:R2b-arL113C44hIPgIFeZrlCM4omnp9rDxk8tdd8ulqNB84PpWeW1w>
    <xmx:R2b-apy4SXDaDQDcMmxrZDIR1zsLwFgQ0gteTaYFbmvYkDslHv8heA>
    <xmx:R2b-apt4sZQ0s5jhrvyvRhcsga-BUxmYrzAHvtY3X5kH4zEPcQnoKA>
    <xmx:R2b-akCY1iP8bGr98H_Hvdod1_w4pqgcQJAO0TJSDUTZyd7BbrOkIw>
    <xmx:R2b-alg0UtGtqMd4SBxhqfjeEtBbAdyfWd_Bkn0tdlo_T-O8sAEiiRX5>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 22:00:21 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v5 5/5] Use d_for_each_positive_child() in fsnotify.
Date: Thu, 19 Nov 2026 13:57:05 +1100
Message-ID: <20261119025942.2848130-6-neilb@ownmail.net>
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

fsnotify has been reported as source of soft-lockups when iterating a
long ->d_children list.  Change it to use d_for_each_positive_child()
which will call cond_resched() as needed to avoid soft-lockups.

Link https://lwn.net/Articles/1079407/
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/notify/fsnotify.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 58566e6b9679..33c5d10f78ba 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -86,16 +86,12 @@ void fsnotify_set_children_dentry_flags(struct inode *inode)
 	 * their d_flags to indicate parental interest (their parent is
 	 * the original inode)
 	 */
-	spin_lock(&alias->d_lock);
-	hlist_for_each_entry(child, &alias->d_children, d_sib) {
-		if (!child->d_inode)
-			continue;
 
+	d_for_each_positive_child(child, alias) {
 		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 		child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
 		spin_unlock(&child->d_lock);
 	}
-	spin_unlock(&alias->d_lock);
 	dput(alias);
 }
 
-- 
2.50.0.107.gf914562f5916.dirty

