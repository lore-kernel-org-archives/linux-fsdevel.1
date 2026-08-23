Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC37315785
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501239; cv=none; b=LhYqGTkgh9AMs+gtX/qCcP7ntqYytu8qn0UxPW3IxXxmGPSxSxi/gT0N8ClslECjv9u2eYvBYPzwpT7V2ZzbJXFotKtiSPaJoHCMLu4OjjhTIJJ2eD0BSBYM19ziizPBWFmy+MIyLX/S5d6ICjpjqSJrQwzOPvS2V6t1AHtVR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501239; c=relaxed/simple;
	bh=DenZvGPHyO13gxRxhTT+l0jfZ14awd/jX35HccXOnRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inY6FVyAddi935gbovSKyZsxSk/47USmHs3q8KDBGtXqd3wds15D/K6rNhfirIz3EGKmw84cjaKSkI4qz4QW3NuMed8UJLwb9PF3fyDJ+p5ZLPv7zBrOEaOZc8Q43tEbAXRkMLQTOHvZMcc+FvMS4E6T9z6WGwIrcX182UjjNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=PsaW7jLE; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="PsaW7jLE"
X-KPN-MessageId: 8bce24c4-9f0c-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8bce24c4-9f0c-11f1-bfbb-00505699b430;
	Sun, 23 Aug 2026 18:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=cPPN17Vt5blltHnoRmL4pqMxURJAQRAmUbIE0xyBclc=;
	b=PsaW7jLEkduhrtD66DEMaV9Bi9VOWyecm/Va/ohbjNuKtmgFt4GuUACshUXG4Z2L7MLcTYFQkgJja
	 jDe91m3tNjVNGmjsBJ+K0ZgisqnwvKtj+hOD5NWsd6LCltoieeT/7sQuc5THiMzGsmO7YZeg7MH+Kh
	 AxrdWfUMBCdppRkKwX1tITQQ/Zz6Tyld+6KbnPjgzGrI91pHhCZhW7a82Lygs57OopovHUn/AHaXbB
	 Bt0HBh8WO7IKazGs1CZ/tFkn2VLJ4xECHj+vkj/A98jhhFVddfq2XsxOvDbSbdt++BD9inBFfHYVEC
	 NNkg7QBEoMpxbdbgpkvQ2TauTN2XMWA==
X-KPN-MID: 33|ubHhYK5RryFvsy0bZe5j1Cg9dkvDRUDQdcR+oNQ6VYL1TyEcI6pTis5WWaXUyvx
 fEM792AurXDNjL952s2lggvDxnLmilGVyaEQjeshaKCw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|J2AfV2v4Ile4U7Hkm81He3YYbYGKqgFZj59d4L3hqlvjKiBlFMlqAYhcJ6Tf7p8
 Ycwwt5orKg5JbPp+kWwIV4Q==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8b91fc56-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:06:05 +0200 (CEST)
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
Subject: [PATCH v5 05/10] vfs: lookup_open(): use vfs_create_no_perm()
Date: Sun, 23 Aug 2026 18:07:01 +0200
Message-ID: <20260823160706.358293-6-jkoolstra@xs4all.nl>
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

We can replace the code in the no create_error/negative dentry found
from lookup case in lookup_open() with the vfs_create_no_perm() helper.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 55ba23f95c5b..3afae6e87825 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4430,8 +4430,14 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 		}
 		dput(dentry);
 		dentry = ERR_PTR(error);
+	} else {
+		if (file->f_mode & FMODE_CREATED)
+			fsnotify_create(dir_inode, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
 	}
 
+
 	return dentry;
 }
 
@@ -4581,22 +4587,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
-	if (error)
-		goto out_dput;
-
-	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
-	if (error)
-		goto out_dput;
+	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
 
 	file->f_mode |= FMODE_CREATED;
 out:
-	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
-	}
 	if ((open_flag & O_CREAT) || create_error)
 		inode_unlock(dir_inode);
 	else
-- 
2.55.0

