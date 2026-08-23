Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B32264DB
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501233; cv=none; b=erINJCG2Esi+K2lDEx2Yjmfu+olC52wG2fHLpUAJloFzthn61oIwIBpsNf5oghcNv2eObuNCdhUGDZ/gB0U3z/Blrt9KOIFvryGVEEnK6ame/cngylTDWK0J6+n1kRlEi32r9yDnPhIEIxjzzZXEnJMhpjHpiw0huL7K6X+J6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501233; c=relaxed/simple;
	bh=VZ/4WHNbzM6xNGhIe35vCBWGLs9hrCLQFLL+ZkyZtJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOIbvS5qv/lSYVVGOixmv6kFgQ05ZSNVoR02qyB58c3clUSqBLc0GSZc+ul80AD1mf0bC8TeaPgpLlNtDDKtQpJz3H0MEUMBenscLnhq4DVP5esc6gWA3nN1sX/rbQS/Wo9HIH5gfxD8uYzIaStcqkJGGSzgcIe5D4IHa669Hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=nnjAp6Nk; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nnjAp6Nk"
X-KPN-MessageId: 892d0393-9f0c-11f1-a5a2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 892d0393-9f0c-11f1-a5a2-005056994fde;
	Sun, 23 Aug 2026 18:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=QRYHuTVinpWCYh5YAfIpvY+f806/zbpBDKQkZPXhsa4=;
	b=nnjAp6Nkb3yzsBZK9nf3x7DQmnsr/wXRhmEsvzyuIRNZ0KGA8e6x1EPO/CHESmucAcOEWoV2l/xgU
	 E84fbOp1N6kBe8suF3x9QIoFbqf9pTyjLEA/tQDB+xoEqNyLy2/0p9eyrFuuXNpmsXCCzGMu8tTnav
	 txgPMOmQd/Sq9nJ78dhf4lZjSwX91j1+mh4fBv2Lp3xbGZZ1EY6wc5jLgj/2dvcHcmJU9IJdEJy24Z
	 e3/I/F4SmeVtmCjPFyEtiJBrLOxCV5YcRiwinaQ/xWF3yrUOEkaCu86zPJu7xRpzHil0oUEFpDQFbz
	 OC0te4KnSY3C8F4eyIvrNqt/YF/bYDw==
X-KPN-MID: 33|cplPyGLLuVHVshPjedRKXwZq9Ikmg0mf8u/u8LepF5X1ygskgEZUghCFC5I6zUm
 arTWnyNLTzPXS/d8lMJB4Cg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|v+DNFZ7RyBU0G7mNvhY30nL70zcDicIcFZ/jMGv4Ll0wm5a/qw/S+EVEAl6hh6I
 OhUFJX/FxeoyC6e9rreMatw==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 88f29b37-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:06:01 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v5 03/10] vfs: lookup_open(): move setting FMODE_CREATED down
Date: Sun, 23 Aug 2026 18:06:59 +0200
Message-ID: <20260823160706.358293-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823160706.358293-1-jkoolstra@xs4all.nl>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using vfs_create_no_perm() in lookup_open() we need
to move setting FMODE_CREATED on the file mode to either before or after
that call, as currently it is in the middle. If try_break_deleg() fails
it is currently not set, but vfs_create_no_perm() includes a
try_break_deleg().

Going up the call chain of lookup_open() we see that it is only used in
open_last_lookups() if no error is returned from lookup_open(), so we
can safely move it to after the filesystem create() call. This also
makes more sense when reading the code as you don't have to wonder what
the implications are of setting FMODE_CREATED before the create() call.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 229a5f7329f0..2aa18efa4e04 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4580,7 +4580,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (error)
 		goto out_dput;
 
-	file->f_mode |= FMODE_CREATED;
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
@@ -4589,6 +4588,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
 	if (error)
 		goto out_dput;
+
+	file->f_mode |= FMODE_CREATED;
 out:
 	if (!IS_ERR(dentry)) {
 		if (file->f_mode & FMODE_CREATED)
-- 
2.55.0

