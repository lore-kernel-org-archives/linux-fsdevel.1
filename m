Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56038F954
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325373; cv=none; b=d6CyHkX8F3pywkGujqAlhDi+vZttFKZ+XUmyys4J15uepHVAIhoCWXPPDLcWHIrDe2F180UDBtZPl+GYUYUJb9+zN5Bx493F0McdXCR90wbf6ZhTcz39SVCnOZubHd1wjb1xg4xBULZk0MZsNq6xlCV9xOu71QTwM8mWUD0YJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325373; c=relaxed/simple;
	bh=7FryVKhEiffXzWSttHk8q6VLm4lqtV3X9GE9aGTs7FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fh9hoskDnOuNMeLAaqE/AUFjkk4Gm0lJA50zdKVPrE39k4LIctVST2YbKZrev/3iViNnuVel/W30uUE66Ynwil2NjxTVua1xb+80A43goM99r+ZQdPLwMVSXPmN15iuykz+pFXgD/YPkv64LUmmZT+0b74yfmYL158FXXoWDe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=XNTdPSj7; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="XNTdPSj7"
X-KPN-MessageId: d23e03a9-afa3-11f1-861e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d23e03a9-afa3-11f1-861e-005056aba152;
	Sun, 13 Sep 2026 20:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Wr1Me+VIRQw82r+Sv6eXG48kxSckOOl6pDcP79CXgdo=;
	b=XNTdPSj7bpZq03Te6vK7ceCtf5YAwnY1S6WJWNS+pP08j+MdNz66tmYec7+prXAFXJUmr2lO5bKpb
	 13gw2icAZu566IbqIUAagz/YS2wXHV3qF+BHZgQcUO+nVSh1jyPVEgBzrby3e77PFPGtOINNcyegYZ
	 hUjHbizdVUqijBFU/kANfnoH0iz8AJ16+njl55Yk9MQPZlw4QOG+0eG5IYC+a8Sv2Wzed5COXP9xwX
	 3SPqoGr7KSCYB/koV1q6Ik7kyCZaDy09tDf9mTNihFqN0TtILEXrPVkNj0MD0ngGgv6Mk2qANyQsEx
	 LQ56mL7EUcPOyOHnNEJnrJ4HuFJ/cVg==
X-KPN-MID: 33|/jz+1nw7Pnwn25NNNDD7yBbkrE4ZlPsKatZ27un8zQ7Xc35T0y8N58wIT9rOl4F
 TR7qHBHuLNEKdOvBFVsUml4T0PjL6vFEdodBVUDdLcGI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0C0heCk1lrUB+LKVl/C9TsvNFuvq1UVEHdYPWWx62jNsuyYPrO5Gkq2VCEAWPGr
 h3v+PJrjssDn0bdppVIoEsw==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d208387d-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:16 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 04/12] vfs: move ->create check in lookup_open() to before try_break_deleg()
Date: Sun, 13 Sep 2026 20:50:08 +0200
Message-ID: <20260913185016.523376-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i_op->create check in lookup_open() takes place after the
try_break_deleg() call. This does not match the order when doing a
regular file create via mknod(2). There the call order is:

	filename_mknodat()
	vfs_create()
	i_op->create check
	try_break_deleg()

Move the i_op->create check to before try_break_deleg() in
lookup_open().

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f1cc3ce979ef..e1cdece42c9b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4576,15 +4576,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
-	if (error)
-		goto out_dput;
-
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
+	if (error)
+		goto out_dput;
+
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
 	if (error)
 		goto out_dput;
-- 
2.55.0

