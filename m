Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42619CCF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368525; cv=none; b=cIfnItCNbv6vHbJhXKlnBksqivmfW4AiB4JVfO/Sd5YcjyTIDjH0719NxGl3odtdF5fdZWcZNzae6dN9jkKIh50AAIl+zOUKfKObVZ4q5qHUSue4XtNAlIK5fVa40CqBBtcL0bR+o/5I8T1XE5TvnQ9NwoDL+gLPNdw2+1WUw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368525; c=relaxed/simple;
	bh=3hrq0h2EPXNgd7SEQ7ixKAVXnqoFOCJSfuGRdJb9S2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhD5qVf1cv95/+EIVEfJ7cn4xPqr2XDMIqES8epkzhrpkVDd9ajxl2tYgNJt48pDcPhw4k+MbrR/DygGsffJmZDGB4R2IRdpq4e9ND6PHti6gPMR81RQ6NPoBuHbt4bUdivQco5yuXxYS1QKWqChUwexh7dKwVMcGMJK3p84O2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gvQzdAM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9OL3kFP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gvQzdAM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9OL3kFP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D17711D00143
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 20:08:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 18 Oct 2026 20:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1792368523;
	 x=1792454923; bh=EHZLlES1DH7qLU78RnXRblLo3oGo6G3AdRu9IaMadXE=; b=
	gvQzdAM3EvuI3bBLRKlcaKvxi2xIuSdXjjcVzGzDyUATDwc7kNCjg9UkVl6zgnFN
	mQUia6G9HhG7nHvZnrmJI6bOVefDxREquWooEtlC2ikhe1JYvEy/irE1XiuO8WJy
	YrrrNpp1rFA7++noDILO5v3wDXWgAKU/l44viVN3IWEuiVDDrpQvV/IDPKQcNNZy
	TVfvMavPy1N0dlyEaDrUT67JhZ5bf9NfcB2r1aQn6W3KyOJFpukeNVJK9vHOaG5R
	+2DQdxKKSGZJc+tfmWWMWfN1zsP1lxDV/NdUvo9zbsHDEOfLm+19pLtuezNOvB/Z
	EBVyf7Y45N8kttUz4QaSZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792368523; x=1792454923; bh=E
	HZLlES1DH7qLU78RnXRblLo3oGo6G3AdRu9IaMadXE=; b=Z9OL3kFPZZSvzmLow
	StJBY145dfH0vKPICgD6MtJ3H3LkngGFlmrWYyNxnd9wf54H/f5p7ojSM7qVn3by
	3ieBESEFJQsTglD3eT8V4YTU1TRp87s0j37QPgRZN/nBLdTtg3Udl2fx6bHfatGs
	Oj+kOZ03cNT41ipWjH8pv9pIcYocH0Kn6twaTAgL6po/qaGpGckzDJBpXM+H2nDv
	tPokJvKfApFBmmO/h1HjXCh3V4BVdwtmWdeWbQ8ahNPcHZ39U+4mvguLrAwtA/vL
	9QVyjMQ/d3RuTiWGQiSQpqNy3LDsDSVY2i1iy6r1nr6DNnc0MqsuPOa1LCJoE32Y
	bZHqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792368523; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:DJOyDgywkVgscPqmXaCo+xVUCfUPipCcG6K+tkCf88G+gnd
	3JwTVcS55IDzWcbr9x+oQxm2c4P1ISTC5YR68oHaKDIS3Z52dp+lOudWRfZ5ROYB
	zFjpBrLo/kZE3w6p3A/ojZWujK05mTtCUwqOBRHM715EgQjsF1Em6gnAI5EnCGTY
	8AfiexGe2zO9tnOkq7UlvZnqZFuWCrPhckFyiHeXQd1v6a/R/uydEUoFnNPfl1OY
	dSilnOVoJaM9cnN4XkkGZ389YDJKYdHbGv3AKHTG0ZrLoG/WZ8lmUkautWCej4xX
	XXpsV7SXy6XFJAlS65SychzcTZroiicFoprLHyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:dACJpwKHFFSKHTmRApdjx1B1RCX9+OWeOcUTwZeUAEY=:3hrq0h2EPXNgd7SEQ7ixKAVXnqoFOCJSfuGRdJb9S2M=;
X-ME-Sender: <xms:i1_VagJy3JaQHLvMfTY-yheMEfnMgELuD2SOsMHvmUApWq1LehA-jw>
    <xme:i1_Vais31lIZ-wHjMqMviLliLOdKkPG3HqvngcqskNoIToT5pEUZ9Ys8fP959LuM7
    T-Dhu7bQewnJL3xiM9MTNKPqEUFvs5nFR1t7EQUn_he0QxzXa8>
X-ME-Received: <xmr:i1_VakX0h2dyV2qcAmjOnG-mcBxk-sjvwA1T8bvan7G9O_pABc7w6QtrL4fExBEw-HuoFmtLNzEuxHbxBSt2IBY4iG4aTFQ>
X-ME-Proxy-Cause: dmFkZTEe3fcPhVx2gTP+ftggd/wY/JQy5xNjWGHXW2rNX39L2rwn2wAFMxKlvO6xFhk5+3
    VRPygcl0hA6vMUZBBRpDFjL1TdBKn/vHh4Z7FheuRDUF5aHo69aVWbNOpOOZlNO6EK+V66
    XymtvSLxtSfMdlu4e2MU7L2HgXe2G11RGZL/ufJ29pVCvzLTl1z31jWYsIWYqG0jGVzgQI
    ddAEhZrYwI6/MWXQpVfYJo6/LQKz20tVvTdjeS/9CmFl32hdxnRJUGOA+A04zCxo0UD8vO
    6iYjEpwOcuOBr4uZRPuNNeM+wPbQTIIAotNR9NtFRZmYIepaEF1J32Q9inKMkpBsNqbBqv
    XgvthiYr+U1gD2UGD77xLV2SH2J3PzglIx2gqI70yEjRZ5sbxPhZLQ17XF3ade6qECRJeF
    VMbmT8Z0ttQtkqY1+Yq8u4qYOwarx88VoqySfb3nBwViIPM7YRJl2X/HP1yNXKZXQgJJkp
    G+RK5m0uxcZ9tNIloicEkDaFZ4jmePsP1o2RtJ/RlCLIY/qzNRt9+B2YalFKiLZ5G3ujLN
    QhT+QAvr48Jfm8Ymp6g/19yWxDGsYZlVePMrFHw2Cbwf6ZGodidlRngX8jt+JV/yrXUWx+
    Lfir7LUWs8vg4SUVvg/pZ3VghQpwstqTaF9x+s82l7OolnFa7zZdl5s2p0rg
X-ME-Proxy: <xmx:i1_Vati0gU0-bjR4zFWoa7yoNNoYJRF7GyhkjKPNBdZoBqNm2cxANw>
    <xmx:i1_Vaso_VBFpllSaC2OzoWH_YPawelvo-tFHSqEpHuap0D32dBdEsA>
    <xmx:i1_VajFbCB4_X2VFTJruDpWycySbpbdkE_8p3cDPJ1xF5zkMYoCWig>
    <xmx:i1_Vah7Wr6PCeRHxwh3xUD2yMkh084Tk2ROqWHqEJ5JIDHi2MKa6fw>
    <xmx:i1_ValbMuD-X-WAl5GTvkySTMddQfwCMPA7yU_Dyw3yJEpYdRMSze6mv>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 20:08:40 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v4 3/5] fsnotify: don't hold i_lock while walking d_children in  fsnotify_set_children_dentry_flags()
Date: Mon, 19 Oct 2026 11:00:41 +1100
Message-ID: <20261019000810.1837917-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261019000810.1837917-1-neilb@ownmail.net>
References: <20261019000810.1837917-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
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
index 7e2f330fd283..465e875dec57 100644
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
+	 * run all of the children of the original inode and fix their
+	 * d_flags to indicate parental interest (their parent is the
+	 * original inode)
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

