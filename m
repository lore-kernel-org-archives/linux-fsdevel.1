Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472079;
	b=aLyEcmHJsb5wN+JjNDjlYIMfve4JpaMEfVUazGoFcjtvc8MC+e9Jhx7MgE0kFXTNOWI5
	 BcLblAJfaAIHLdYcyx94IKbKS7mI6pHa8oF/6bKiAXbKN1WSh7DzormF24QnOX5SdQEne
	 d1lChZa23hzRKg5L+xG6TrfIIQAb9nujcSk/vF4J8KYZw5yKei685VWB7D1SQ94+7TCFU
	 WzbNDZHWJDEAGWeB1iA8aGrx0mHEpP/5tgwCLvKxyoqtKQI/Vsj9+Q7AgQq0xNOjsREbX
	 bmnFwYW3F/ciofmY4uYFqfuh2t/DwflVQI0V5C0ylTZf/DzAZMjeF17wkYp9Q6aGyuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472079;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=axu4NhpAbAHSQzsFIZa7XWjTqg7HIr5RJucx1ETsiAM=;
	b=rEUxKLNCtztM4UdwFqyxL3r2GL+S7bI1GNeacEnV5slDnfQbTHqVcizo0UeTQUgcAdr5
	 k5af9lC0IdGIJQy58357mAwfeXeawkgqp3PcMtG2m2U64JiAVITDsRsz0o6IR0FMWkCNR
	 moZt6khP0+nPZlePIbFBZYcH6tQcQdxu509kM+t8D7xkK1zwWc+owOlQ0N4YqdakdvJXp
	 7tLoOvzoVcyONSxKSQZGmE7KQFP8H/u8AdBuNBZzSOGKt2qmyNg85vHB0pcyRFtjuCE+o
	 xQpc4sC+kbGLUDiAa17Vibz+G7lkH0DWvsNlBncM28mMAJ8g5Rn9hzlBwNla8rGHZbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=EIhEunO+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xXuWPpJ3;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE3606A688
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCE3606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=EIhEunO+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xXuWPpJ3
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11CD81400331
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:14:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 17:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795472078;
	 x=1795558478; bh=axu4NhpAbAHSQzsFIZa7XWjTqg7HIr5RJucx1ETsiAM=; b=
	EIhEunO+ZAAdRHVZiHApSkspdVLuftPVad3NepPtn48msk9UcbnPXfLmkQSMVfhV
	KpGitpAupv37rBOOolPtC1gDw3eI9BkL7RaT518F/hwFIQdUm9Ntv9xgHzgeh/uo
	I+Pyx10ddhyFv07TyaLDHHMnVe7LgSQdQv7y2l/vVusFf1W+5S1tW2ELhK0zt4HM
	Tik7Ywh4Vt7Fy97yjsrSU87Bms+E6r3Mo6dWccn1QJt63Sw+iS4Shr56iDJEo39p
	RLFZ4Oc0XqtMvU7Ad7ICcK1v6tTfklXWRZUKwbRJKWc6gRw2w827qeQyEaZc33bG
	rmwnv70SikcZuQ0YHdm90A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795472078; x=1795558478; bh=a
	xu4NhpAbAHSQzsFIZa7XWjTqg7HIr5RJucx1ETsiAM=; b=xXuWPpJ3SwbYNGkHK
	+m8hGh+dYr5I8nYmd3EGuvpAjIOHoEyt1m78yzrXj5fBcgepQ2tggkm/oFmXDMKW
	2dteKJMSb+TbNtosfkE9qHC58rf0Jl8q9317Hl7468XlJ1Rh23lF0dUUvyMYggsV
	ZphBVhL+M82BBGYbMkpIApwfNehVhO6rEEt6YLvyyjNKFArx2pxYjC2ShYKnbU0S
	ScVxrchSCpdqTdhesBYvsOuw9OX2kNM1LRd2VCMKeWoNCmWtoEzqOmMMEqW+Yv8u
	q1uYEH55X5j5ChtLvAB/icv8pgr7H85kVQvL/29l2cQNwL200+2bPiKL+HXT5Vrw
	s5wYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795472078; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:L+mAGoQL19bnaWezv+NhmTWqpXdnS7xWUx9KO5MTwU2iM2e
	zgyHfZYeqDcbKsG+Eb4qKB3vav3mTbf04Pif9S5sJSgFmLK2+edpce2R5m3HmWp4
	pRKwys6ggBL1QWvhcq5M5Zc0U/hE/+HkdcmSxyFebBsQ6F5yCwTkeYwjUBi7VqS1
	Xcwmz1DbUF9Ww4bdhX8Pa3TDAcAZPK8PSuUGHhgokrNeIl0BSBSaD3VSl7SFiA9b
	TIAn80iXnISKXsqTamXM99t20kFwFDUaaW5CfZ5H8gR8S/U7GDUesz+Qp6Ophugt
	Pr+f1B4oaEOZoqD3zTHTjxAMIep3bPn5ayixFgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:gSDyBVNVdzQJjq25yJe/Zbt0uStlw6r99EgqDNsy/N4=:qA+h1JAr6sTCmgF5ZTWE9gcliziF2aqrqd46R/tV3sg=;
X-ME-Sender: <xms:zboEa8Fl95azdpACC8tVxdI8fL7cpoQi7hIw9rWRuvb4BBsUKl85HA>
    <xme:zboEa36ZYesNXzmszFLl9mgHobkUdexPev8FdCXR1pcqECOadqBPSiwXJsoODP-Nv
    nD3UoFUUX6fVp2kdUUqjMAeRvM47u7QE-SURPqNVmiwrDUXJgE>
X-ME-Received: <xmr:zboEa5xjuzMj694sISoVOd1X4t9IlVfmS91qgDr53l1Av32vRBjZwzRQ6RCVfu2BroY7IDbukc13LK8HZjCFXd4rvP14hWE>
X-ME-Proxy-Cause: dmFkZTGttFfPwKsmFjKQRzL9pxFUG6QuC0CVDfqpysvgThy8eJxKJL7hWOg3EE86ufAGZQ
    6nnc8U4KhBAHlFOJnKSjCF/WIuMaZFNPa8szZixMnsFylovzrjHp3WhRptClIGFtdpoJKl
    xhgu0M+oVCmLMh6tXx/ugYpmDN1p4mPZw6qI8Qjq9VVjVX+lE8HNkhOv7c9eZLA92DNNsS
    16z3Qo61bIoVUtIj/KYV5uWb/+6EgCVZzfYa0XmhF3ERxddT9CRxrU/B4Gwf3E6u3P848m
    igz4DPi2oe6J9lrl7/rIxlmyDAycZB8s+s7uRN3a1dT1eAkapzcFhk8X/l/XTTpJNFZcaH
    REXmdPmt+ut/yq8SU0rhQqf3Z+OwRpu2A0wBfrKseQTIxZgUfhnGfQjTSlNRlvu+MMYmUL
    gdR7rO9xsEvlqaiT/avqjLFCNzoYeNqtBIEz95/a17eUSeZDGDY3jq5dr2pH6+zBxDzA2Y
    huYFRh0HAeaNUnzBnd3xbGnrbvuaUSqOHz8kDPbMt13Z+J46ZbGuj9jlch4pKUQPu5BDVy
    S/tkCtk9XQ9MXFHitU2CUf6MP3reGyPHJM8arnfjYlkUF55L2S/HMuiNuFR4rfyX6YExzH
    0BwZqJ5zloM2sSTFkCRFh28Jur6zoxEsaW8W/2OU2Il3KZDvzWXwdVBOTstA
X-ME-Proxy: <xmx:zboEa-NGpIuW_alIZr6gkEyGTmRkAdUMsvvQkRI4vPr8zmuOfqHwIw>
    <xmx:zboEa3lQZsH4T2K6FfpojjUk3j1wiefWWLhV066mgtMVC1q89eSlCw>
    <xmx:zboEa7SvCnROmPkIQ3BHysou-JF3gksO5uV7Tok0Y471vIPvgzP7cQ>
    <xmx:zboEa-WDX90yI2PyIuu1-_qqSPNObIUToNLlQ-YQNO8EgOqaFac6lQ>
    <xmx:zroEa62ZrER1MyUW9rmapnhgETAfpOrnG42iYSxBsNz8aSxB6fnGqDB9>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 17:14:35 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v6 3/5] fsnotify: don't hold i_lock while walking d_children in  fsnotify_set_children_dentry_flags()
Date: Tue, 24 Nov 2026 09:12:40 +1100
Message-ID: <20261123221410.3328780-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261123221410.3328780-1-neilb@ownmail.net>
References: <20261123221410.3328780-1-neilb@ownmail.net>
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

