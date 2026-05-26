Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392C3BD64A;
	Tue, 26 May 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803369; cv=none; b=f1UcR/irZL5jlUxGsYTv3cK2fSB9gUWpZ4IATPFLfZHojfR9OOP8r733UtGpLjnoAyhH1YaYANszOhQrRPW+wJKetg85AZadZeVqiFGVMwm58byW5xPNYLzfNNUPEsvs23SWajw35xzL5kJgIfOsan8UhoSQv80NqqXbpgULVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803369; c=relaxed/simple;
	bh=BjYGjZ/HnsGo4HbIKCKjKOLElSF6P6xO6eCtL84xUk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foQi4jhRm2XOmw0uSD9sCPDFFY1oWz+8rKirKmshL7/pE8D72yHEmqEmR9WFi5TytrNiF/aVsJduKUWUISHdUwGcW+In1wisRsID1bC0HFsGqcIBhSagBgyhw5m7xvQ++ueLP+zdtoU+xJelHxFCrNQj6NK1XUGcRtFBtZvoERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=EWoM+Z31; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="EWoM+Z31"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0719A1D3B;
	Tue, 26 May 2026 13:49:29 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=EWoM+Z31;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 4236C1E07;
	Tue, 26 May 2026 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779803362;
	bh=I+OgGMIyFfChPVogbE0+wCj4JgHDmMFqX0Vr6/fsv4E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EWoM+Z31PXwkTWd1hYdNOSKdyupXXUd2sgqRyRnqlZZ5Kw1B4+Cee+gAziwNsJPOQ
	 gefYuohKXTSCdUTn+rZBqnWCzE2Ly80N+iDgOajaLy/sXm+wWT1YnSPBVvC+8KsRyc
	 QZCBap8lIWforz/0h5uZp5gjvF5zXOz0XMcQluE0=
Received: from localhost.localdomain (172.30.20.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 May 2026 16:49:21 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 2/6] fs/ntfs3: zero stale pagecache beyond valid data length
Date: Tue, 26 May 2026 15:49:03 +0200
Message-ID: <20260526134907.11402-3-almaz.alexandrovich@paragon-software.com>
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

Zero cached folios beyond the valid data length when closing a writable
mapping. This keeps cached data beyond initialized file contents zeroed
and prevents stale pagecache exposure after mmap-based writes.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index f421a36b1ed6..2d1de3739ffe 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -323,18 +323,44 @@ static int ntfs_extend_initialized_size(struct file *file,
 	return 0;
 }
 
+/* Zero pagecache after 'from'. */
+static void ntfs_zero_tail(struct address_space *mapping, loff_t from)
+{
+	struct folio_batch fbatch;
+	pgoff_t index = from >> PAGE_SHIFT;
+	unsigned nr, i;
+
+	folio_batch_init(&fbatch);
+
+	nr = filemap_get_folios(mapping, &index, -1, &fbatch);
+
+	for (i = 0; i < nr; i++) {
+		struct folio *folio = fbatch.folios[i];
+		u32 st = folio_pos(folio) < from ?
+				 offset_in_folio(folio, from) :
+				 0;
+
+		folio_lock(folio);
+		folio_zero_segment(folio, st, folio_size(folio));
+
+		folio_unlock(folio);
+	}
+	folio_batch_release(&fbatch);
+}
+
 static void ntfs_filemap_close(struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(vma->vm_file);
 	struct ntfs_inode *ni = ntfs_i(inode);
+	u64 i_size = i_size_read(inode);
 	u64 from = (u64)vma->vm_pgoff << PAGE_SHIFT;
-	u64 to = min_t(u64, i_size_read(inode),
-		       from + vma->vm_end - vma->vm_start);
+	u64 to = min(i_size, from + vma->vm_end - vma->vm_start);
 
 	if (ni->i_valid < to) {
 		ni->i_valid = to;
 		mark_inode_dirty(inode);
 	}
+	ntfs_zero_tail(inode->i_mapping, ni->i_valid);
 }
 
 /* Copy of generic_file_vm_ops. */
-- 
2.43.0

