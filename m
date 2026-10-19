Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB31A9F83
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368541; cv=none; b=Dqkeeou1TRP5VFji/XxAJW8n9wUCCrA1wviKYFYOsiWS/fDWGRqWey7ymzCcVklcW8eKlfbLqWN6ZiRHHEhsC8N66nq/JwUHcbeuyVhMnyevBiFYTR0Z+3+dvOlCmZ8cMDJAMVSL9FCVWF0JF7fd0Z5j5byu6fKtIikdlZxYngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368541; c=relaxed/simple;
	bh=RFW87R5dw/mszrzxMIj0a3M79SZ0YguyYh2H1EHOHiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4euiycMFpp0Ppv6YP+znb6ipAD37AE7uRHktvE9I3xPZkGPNl4rfdKD/zs8k59c3K86LrYpmh2ax0TRD0qVefbpG8QhOqs27EwRj3Ou004Rdt3apOhpNlfbNWBB9qlTlULlYaPJpZ88L0AbvV19h/6It8V2wAHvdbwx+D+n4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OW+d4dlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xlASMkQO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OW+d4dlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xlASMkQO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 16D7C1D0013C
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 20:08:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 18 Oct 2026 20:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1792368536;
	 x=1792454936; bh=586ERG5Nu3+sDqploYR+LkAOQWGo3bAALpOiVCSwXZc=; b=
	OW+d4dlht6gBptMUyFFqpVR3Yp20O+mw9/0uFAPAjxM16qr0Qf1dduxui1Z5A8ZD
	ffwJMzNnIfJaWd3hr6NKumuVh92w0gfEVUcSVTn2Mo1HXHixz20B+OsPFE4Nksd3
	Zy3isofj08PJC7FjR1ajnFB7YYuR5Tl4ltjourRkpvXHpVp3Lv5nnQNqhwO78Kw9
	3YrONhcCoIfGWHQI5dOVKKYIpI5PHs7Y8LBIould4aQP+xQNjU+gAicC1UnE75hx
	9x1SNir68q4U+SP1iKPWUCywVwRFMF9viS0ie5mHMeZ1fwzq5iJ4EMj83jazI8UR
	NoKYCZnxDnteApoKFa0Uhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792368536; x=1792454936; bh=5
	86ERG5Nu3+sDqploYR+LkAOQWGo3bAALpOiVCSwXZc=; b=xlASMkQOo7HOeUFTz
	zM70Onx7527mTr9wiRwFLNq0nV+lgmDyImG6L4dcG/6yfOyQAmYTWjEKxzu9oXhd
	LUYEc0bMti/N9KwTye4ZR6xd2f8Y66wQJM+PUGOciF9Hk+4sdEAKU/qXk4zUXDIB
	oF0nFJ2dvmemJVHZf8EzimEvSlvahp7i5GX0c/6E9RNd8Eu1CpJIym5xbIAB4gUk
	9+ytHhNIUiD5GpZAO3IDKsRQFKCQjz7n+2FfRCw/FG5VKpFDLQAjro/5wsASPJuC
	8jPQocBvUl/6RaMpaZiZ5C/FtOc4HuzSfXABuu/HeRjpQ79fc+4NPPYJ9ySSQWlP
	pQbZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792368536; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:eNegKAle/5US6q3uz4A63tYgx/X5Uv9Q4+CzJtP/5tOao3z
	KmiZPtOwQo+F8jF0BQJVc4MQbSXTZDrD5wpyKLqOkP/wpLjAdtZ5RD5TeOlLvpg6
	esa5nINCh5THrZWURIanNxcuwg8Wm7wh7np78YD3/MEZ2snEVzS+ftPhX/cMbcs4
	g613vga/mpbK3CYK3522b4h9pyCZTLxq7RQhmwOr4YDcE3Toz3t8wtU8Z+Ymx4dM
	yUO4O3HDTqNRlqvIKM5eclJ2BgGMqeJrrOzjLbeR9VPZH3cwk1MGFbFsTkv1ZJyD
	UcLb5KYkBwdSi9mIWcY0vHKDhrzVUyUM5fhpugw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:kEPrgiQwr3vrCqnhyIyFATEgfN4BIJuJhA3+ICMEYC0=:RFW87R5dw/mszrzxMIj0a3M79SZ0YguyYh2H1EHOHiM=;
X-ME-Sender: <xms:mF_Vaoy-sSmsidHbfRd3kPFsG72LD2C0__bRki3rNAJxV4Q8snmowg>
    <xme:mF_Vau3Jo7W9h0C2m6W3Z0DPVAqhX9aiOk6fjN37flAUH9hfTFDVXlAaP0qsr7IoN
    090Y6Gl8XMFSb0JsEo1IB0aCiWd0sHNOGdIRE9O9pEjXCrjans>
X-ME-Received: <xmr:mF_Vat-8wbHxYzVwUysApRD8lchOWWLwNpGlwiUtUa9HKOXqGo_DDwYFLZ8DPkm1XOKWC-394xN2p4ID0ZkifGlPiDNx4Oc>
X-ME-Proxy-Cause: dmFkZTEmfjL/1j8/RJVrDkaGn2qXXXwdNB/HtpQhwM2uJ+97CaUQdwH4pAakO0evvPrt18
    lka3EubG7ALdfMN4k1HeDp/5DncAix0mIOpwezkOfO8SOZuNY0IPOxpxifXZHa25KVz4T+
    lHW8gJrb9DrCLDUUaOB2I0Mt2SWNoTnxXFDrg4YFUqBL8qlgMm6vE8AH3icBfKl01P/XEk
    qHVF1uq30MKJ0eGnvI9sdEQvvDWRguanRHLZLTslkTzwfhpaCCagrDF//xIlhc8hTEQiH1
    rtv67l8xYEIJZJriidsgjlxNfPrlIk2cidQmNaqLPlMWdWUtgR7e1czJELBIFc7L3nRVhD
    6teFwr2POjoc7HMQbOsPnKfEOXA9EtGZ2rPu3wCtfEbMk9REBAhPY7HjOEH+Cegglnam8G
    WQSyDmoFWGFain2+sUZRwIXfSu5rGIsFN4Pc8oSurIfJW4iPqmfWz8kxHbwAnc8J8iW/2z
    oaW5VULk1BNsf82TlR1hVkDj9UZYdGfTd54ShJAmktUWjGpV7O8oi4gas7P7yAfH5dVmOI
    f8nJet9NXMrF+0n/jlkfd4Kr3nxUQ7X6j12vqrEqf/F+Ph+ZA+o0EBUAviWNOtNbPx3MRT
    9cNPeywxCZhBQGZCyW/Da8412fa3RG/atO4v+8umm7+hoQUp2QfDrHbsfAuQ
X-ME-Proxy: <xmx:mF_Vamp6TkyzSvQCLGn-gZKRdkrI4VFf17HkCdkgiWC9NnjlwCu1eQ>
    <xmx:mF_VavSKnUZwc1JVWaP7EczI0tQMU0DVTFWzuGZaMKQBSp8O9JgFOg>
    <xmx:mF_VahMYfV7rQ4Zex-C5yLLu9mJ5KwUGAAv34aZd4U_d4DPjcoeSSg>
    <xmx:mF_ValhObxOwyBRFALJ8U7beiEqlNDbSkpVW8rdoJBWFGaYEXMIL9w>
    <xmx:mF_VavDoUmBl-S16AF4aXBNMWjlOdCT2VM_Priny8Urr0_rJ_UzV6uzB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 20:08:53 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v4 5/5] Use d_for_each_positive_child() in fsnotify.
Date: Mon, 19 Oct 2026 11:00:43 +1100
Message-ID: <20261019000810.1837917-6-neilb@ownmail.net>
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

fsnotify has been reported as source of soft-lockups when iterating a
long ->d_children list.  Change it to use d_for_each_positive_child()
which will call cond_resched() as needed to avoid soft-lockups.

Link https://lwn.net/Articles/1079407/
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/notify/fsnotify.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 465e875dec57..62c17e4e4798 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -86,16 +86,12 @@ void fsnotify_set_children_dentry_flags(struct inode *inode)
 	 * d_flags to indicate parental interest (their parent is the
 	 * original inode)
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

