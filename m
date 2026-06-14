Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA7383C8F
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455493; cv=none; b=PL3IE8ANszyqXMQvC5UkrBDqA/ftzpDw4/GLCJWJv/nkXYsjABFr+JrggGjr1yHxX6arQL+codRvNib0+ymTflLRzy2nxckkzNooSBox2/ACVEG2r0/jveMYFZpc9UWh6gy9E3L/aiuwjVMxdTXYTq+iBpIUq5tyasAlnV4n9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455493; c=relaxed/simple;
	bh=/DrTLS9/sx+O7F1Mh/BJLvj7Q0YT5/EvVh6dGVCtu7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS5Rw+Tf30y6Alu9pHXVOwX7cbFiFMKwYzTxRur+04kiu+YEX1OdhkTP4jXrizLFLTmx98+3skGE20so10Kuutg0JpcDg3nyz/eykhZuFzQY/0dQJ7dDyImS8Vw27vwRiidU2CZ654FwAZbkgaokmPdA5zEX6LrwtP4mcWasCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Z1YV/hyw; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Z1YV/hyw"
X-KPN-MessageId: 349a79f0-6810-11f1-8aa6-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 349a79f0-6810-11f1-8aa6-005056ab378f;
	Sun, 14 Jun 2026 18:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=WQT9EGmxpFIGOuk6z5wNDkrMpreLYnb4Z1iAQsTrYAA=;
	b=Z1YV/hywaPCtzs07OBrJxzIK/k4177mu2ZrSrR3TMutwQXe0bricQBcCWtv3HTd1jvzY8LiwPtR7k
	 +TAnK/WBQqRpzfUdhBjmw75qyqTRZIKL3V1SslmkSGZh5Nu43CoDK5THlTr1ckAqxfzfdzmZOK5XWm
	 s7RwWs36cZ7/ScLd0T/CTWdf3Xcvt9HUxmHMXg0raqsVRh+0tHPG7n4U0+WOTeVgIZANwSJwK8Atv1
	 JZrFiZ1zQaEJHUArP9MSK1gXdDnQudj/vIdtIK55O4Dn6v5BkDYlX6SIgD5IJnL/dc+krOczd6Jdm9
	 OpxHmcBPJaw100dXE0T4NJV+evSWIcQ==
X-KPN-MID: 33|qo7ODyZepHTSoK9/Hai0Zh9iEUFgRpdlFujZOhXrRyqrIVvHtMEejAC77XgZfVU
 RS3WTm8zd8dDYeyjk5LBk2o7pWTbx5UI5eY05TPgpZ4M=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|H/PQlEQHePDUfU1phKPUgVN/O+MnDVKLhzWLLZjPV72zYNZGl0pzMpvQnJK1nEJ
 I1HWHaL1PJ8Eq1UJfOxpnZw==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3464b930-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:43 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 02/12] fs/namei.c: move create error && negative dentry case in lookup_open up
Date: Sun, 14 Jun 2026 18:44:28 +0200
Message-ID: <20260614164438.2980769-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

O_CREAT is stripped when create_error is set in lookup_open(), so when
lookup does not return an inode, the case

	if (!dentry->d_inode && (open_flag & O_CREAT))

is always skipped. We can get rid of this cognitive step by handling the
error case first.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 64b91ed9efb7..f169d1123b17 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4499,6 +4499,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		}
 	}
 
+	if (unlikely(create_error) && !dentry->d_inode) {
+		error = create_error;
+		goto out_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
@@ -4518,10 +4523,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 	}
-	if (unlikely(create_error) && !dentry->d_inode) {
-		error = create_error;
-		goto out_dput;
-	}
+
 	return dentry;
 
 out_dput:
-- 
2.54.0

