Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE73115BC
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636156; cv=none; b=WeVOnMIgXJa/kQxplHzAR/oSYav6G0GB2Gs7DfodE6+u/BuWeUp4rIqgaXe1lA7I/y+1k9LSNQOMFihLSG1ZRyWpJXV2/4Cer4JbKPV1xd0toKd0prO/EC0H+el5bqYXvzVgFkWjCg5Z66TiR7C9MzFeNQNJ/WFUPt7j5RtXPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636156; c=relaxed/simple;
	bh=catt38koKowWdjSCWaNzsExHOq5ZN+UBqRpbc5XO5Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfuQpqkcOSSkt0Lf1fN9vNRRCp4kwzM1Omfm4eCJ0xh05VMOssKvRhsNYOrjbTjXbSUS0E72S583ACeswGBmaSknz63Sud2gHXaT4KCPW2mkB4b4Itx4LYJQHQGamX3/XQzRw7bNO+1yy4bi6hSIusZq7lTgovrVT6uPhaBJlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HqfCeJPc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HqfCeJPc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CVnzPutZuTQDYE9O9U66x4k7XAcCFmwSoZTzJBlEswM=; b=HqfCeJPczdTKgupJ6jlf6PhsPm
	Zk0zKcafZktVnuLG58ts6eaCiYOj6B944qcxv0wPMtmApmVTd66vxmYWPwu16LC+C/mhyfzijIPCM
	vuJdulT1S3bQp/seihgATBKaOpxo7QBcV5abrjtkMlhTBkDxuWq21JyKxOZw6bIQUmjq/L/+ZWrPN
	ZPFDY9/y6K0O++pm/0M5kUPIicHEyYzy2SHaBfD6G4BcwQ15K0K9yVoqKHRt/Br3ownh0qlr5AavI
	Zgs9KeLCIB4SShT8rcmkoiV7gZO0dk8SyAvAblabBVKCcxsoFNL+0viyVBwsZSk1+j592OQ6QnGUF
	zfH94bnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnv-00000005Ts6-44C3;
	Fri, 05 Jun 2026 05:09:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 04/22] find_acceptable_alias(): skip NORCU aliases with zero refcount
Date: Fri,  5 Jun 2026 06:08:52 +0100
Message-ID: <20260605050910.1306432-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

similar to d_find_any_alias() situation

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exportfs/expfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index fbd45e7ae706..eafd99507afe 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -53,10 +53,10 @@ find_acceptable_alias(struct dentry *result,
 	inode = result->d_inode;
 	spin_lock(&inode->i_lock);
 	for_each_alias(dentry, inode) {
-		dget(dentry);
+		if (!dget_alias_ilocked(dentry))
+			continue;
 		spin_unlock(&inode->i_lock);
-		if (toput)
-			dput(toput);
+		dput(toput);
 		if (dentry != result && acceptable(context, dentry)) {
 			dput(result);
 			return dentry;
@@ -66,8 +66,7 @@ find_acceptable_alias(struct dentry *result,
 	}
 	spin_unlock(&inode->i_lock);
 
-	if (toput)
-		dput(toput);
+	dput(toput);
 	return NULL;
 }
 
-- 
2.47.3

