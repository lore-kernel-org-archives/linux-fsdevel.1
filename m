Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A9372698
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021627; cv=none; b=X3UtuTWgUkpe8+UOTvlPXnvPhzwlFobaugFa69wvM2gALs9oJTSGBPqD1FN6nNVlA7tn+j3eDHV0quCw0/+b5D+VPOfPE2nEZEQ6pyZSbTOWFQaVPqpyRYAAKEORtjCSAoMtM7h/fw8+Ez964JWmpceJ3PokwK2isL+0i6SzXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021627; c=relaxed/simple;
	bh=7jaURETtLtFcHeVwaJSIAJ76CiNIfv4Ct+qN4bIYrOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTKj30MTQWV0qbLqfE68O8iq3kgZBI89NBZpRa9GOT+9PDxWW5olJgzz9EfHTY9SZj5FnmjVcXpY0bddNEpZLEr7Y+nGOxqCa3kOt4Fmo8wgGOA2ZcyOO3QL+zIwGyEQfI3iRrqBVWO73RDiaBwbBJVKasjZRBc3JI+pLVWB/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZdfiXloR; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZdfiXloR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777021620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v5MHwtakqSyJO/3s/86DCgyAMl1f/M28OmbHQ7iCKV4=;
	b=ZdfiXloRvG7Ogp0/lLtfgPqqgkVaElVepybdJI7gBlTKpwKazbFyQE2CBL5+jz8ggBnEhu
	sVC4fzafkLTFT7RvaDYZEFg3TwLHVt2rUCI04a7d5E4BmphXohrXzv2dHRvWUyT5s2pceH
	Otu4yLhtCKv+jcoDvx3etn3biN9oZow=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: replace unbounded sprintf() in hfsplus_{lookup,link,unlink}
Date: Fri, 24 Apr 2026 11:06:34 +0200
Message-ID: <20260424090633.307300-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=thorsten.blum@linux.dev; h=from:subject; bh=7jaURETtLtFcHeVwaJSIAJ76CiNIfv4Ct+qN4bIYrOE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvjWZO2/W13+VPY/7EWHuBMIdN96yy/a+tUF9WtUJ55 8QD29/nd5SyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEjhkw/M+OK2j0zvmbM3PB M21NtV+nD4QwKDhfTf50wfSc6OkHy8IZGb4u3+X+zuOcwgVp660NPa851vP+3TS/hp17zmdP2SW buJgB
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While the current code works correctly, replace unbounded sprintf()
calls with the safer scnprintf() in hfsplus_lookup(), hfsplus_link(),
and hfsplus_unlink() to follow secure coding best practices.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/hfsplus/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 47194370c2c5..ff976995ef58 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -98,7 +98,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 				dentry->d_fsdata = (void *)(unsigned long)cnid;
 				linkid =
 					be32_to_cpu(entry.file.permissions.dev);
-				str.len = sprintf(name, "iNode%d", linkid);
+				str.len = scnprintf(name, sizeof(name), "iNode%d", linkid);
 				str.name = name;
 				err = hfsplus_cat_build_key(sb, fd.search_key,
 					HFSPLUS_SB(sb)->hidden_dir->i_ino,
@@ -322,7 +322,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 			get_random_bytes(&id, sizeof(cnid));
 			id &= 0x3fffffff;
 			str.name = name;
-			str.len = sprintf(name, "iNode%d", id);
+			str.len = scnprintf(name, sizeof(name), "iNode%d", id);
 			res = hfsplus_rename_cat(inode->i_ino,
 						 src_dir, &src_dentry->d_name,
 						 sbi->hidden_dir, &str);
@@ -393,7 +393,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_ino == cnid &&
 	    atomic_read(&HFSPLUS_I(inode)->opencnt)) {
 		str.name = name;
-		str.len = sprintf(name, "temp%llu", inode->i_ino);
+		str.len = scnprintf(name, sizeof(name), "temp%llu", inode->i_ino);
 		res = hfsplus_rename_cat(inode->i_ino,
 					 dir, &dentry->d_name,
 					 sbi->hidden_dir, &str);
