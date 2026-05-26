Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384573FD130;
	Tue, 26 May 2026 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803371; cv=none; b=BdADkJpi16AKsQvTAJudO7WB8DWqe9orR3/eG/ifMgXuc7Amy8+0FLHoJPlOd+/tYLWtN0PJeFCTBDKiMWdlypN6amfzk9HZ/A068jS5PH6a3+gYjLaPCqvGhNJhhTdDs3TG1+eFXKQIDyYZltMYXN0shKfnlMAXqQzrbe60Ja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803371; c=relaxed/simple;
	bh=vf+GseZ/pJZVjDMPSDzYzToiTkPA75SS50G/1zqph0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqkmEhNnekwQWSAjuy4xAtHTLC8EqZwy0qZ6XWcF2hdw1BnvHx+eSr8HYBQO0ow23kUsQOirve0qXHSGSaEv+axgfIjqJCwpO5hucLNfy7r0BM7EQAkds9Cr0UR4qBXkcCHpAkF+lsytafyKekVB9ipwG4i3myj4qYjJz+YwTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SYJ5MQYR; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SYJ5MQYR"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4B83A1D60;
	Tue, 26 May 2026 13:49:31 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=SYJ5MQYR;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 92AB61E07;
	Tue, 26 May 2026 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779803368;
	bh=Kra1PonV8Y7fa98j1UGk7fEnmHNOowvevtZp10SzyAk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SYJ5MQYRzBMw0brV2y7FOcqAvqvfk0mrd+y6B/oqCwdXvhsTfbeDGLjOxDXuYZsu+
	 1nSRac+Vpsvo7JcyVDOQ9LFS70s2MtekVonJtVb1OT9VGZ+N8LleDqK3CcIwYZRxmB
	 fCAbwjEP0UdmuVa2xyMByufTVQtIR7ieQVxAwq+c=
Received: from localhost.localdomain (172.30.20.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 May 2026 16:49:27 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 4/6] fs/ntfs3: fold resident writeback into writepages loop
Date: Tue, 26 May 2026 15:49:05 +0200
Message-ID: <20260526134907.11402-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
References: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Remove the separate ntfs_resident_writepage() helper and handle resident
writeback directly from ntfs_writepages(). This simplifies the resident
writeback path and keeps the folio handling local to ntfs_writepages().

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 356fc94c5a18..9a75c2d832ca 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -992,31 +992,6 @@ static const struct iomap_writeback_ops ntfs_writeback_ops = {
 	.writeback_submit = iomap_ioend_writeback_submit,
 };
 
-static int ntfs_resident_writepage(struct folio *folio,
-				   struct writeback_control *wbc)
-{
-	struct address_space *mapping = folio->mapping;
-	struct inode *inode = mapping->host;
-	struct ntfs_inode *ni = ntfs_i(inode);
-	int ret;
-
-	/* Avoid any operation if inode is bad. */
-	if (unlikely(is_bad_ni(ni)))
-		return -EINVAL;
-
-	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
-		return -EIO;
-
-	ni_lock(ni);
-	ret = attr_data_write_resident(ni, folio);
-	ni_unlock(ni);
-
-	if (ret != E_NTFS_NONRESIDENT)
-		folio_unlock(folio);
-	mapping_set_error(mapping, ret);
-	return ret;
-}
-
 static int ntfs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
@@ -1038,9 +1013,22 @@ static int ntfs_writepages(struct address_space *mapping,
 
 	if (is_resident(ni)) {
 		struct folio *folio = NULL;
+		err = 0;
+
+		while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+			int err2;
+
+			ni_lock(ni);
+			err2 = attr_data_write_resident(ni, folio);
+			ni_unlock(ni);
 
-		while ((folio = writeback_iter(mapping, wbc, folio, &err)))
-			err = ntfs_resident_writepage(folio, wbc);
+			folio_unlock(folio);
+			if (err2) {
+				mapping_set_error(mapping, err2);
+				if (!err)
+					err = err2;
+			}
+		}
 
 		return err;
 	}
-- 
2.43.0

