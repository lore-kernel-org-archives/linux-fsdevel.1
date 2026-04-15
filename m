Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E31313298;
	Wed, 15 Apr 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268467; cv=none; b=MnxARV/5sjSWxT2u7hIQLaLmF/DkzadFF3EapW+IRUZrvzgCf93xGlDRDs2uKiW8MMJoIBJJ3Ik1c0w8z/EFzZzCfKPjAxbA1eBoJfOf8yUVn+5H5XgutkjVwL8Ez9+cmSmOli2eZcpZF+2xz988HcNs2dOGuZc3U751IYKIfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268467; c=relaxed/simple;
	bh=4LcOyy+Dy32r9tTGGQVPrJ/QwfJh08tE4NvqsES4CTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NB4xcP6qECyOvh6oZjOfac+590ykhHIDgLGsm3GTp0IeBHQbzLN/PHRyqbxdD4hWAEqUgiHp1OBoth3TfSrI6Q7kh0VgHSa+jrlUkBQeoB+X6X6BCfbzTERief18VnQ1WU9dgVfFZFu0BmolatURZf9xfuhDCzU7B9NQu/OWsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=pXNgnwIG; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="pXNgnwIG"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3807C1D3B;
	Wed, 15 Apr 2026 15:54:35 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=pXNgnwIG;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7963E2135;
	Wed, 15 Apr 2026 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1776268464;
	bh=55L7X02Tgl5xAqbCWCvySge0a8hNf4nZfwmStH+GQVg=;
	h=From:To:CC:Subject:Date;
	b=pXNgnwIGI1bOP4Aw2MGQtMfOdloNQdvX/Ki8pyS2S8fVjyoLd88tIceZvdXJ6kBiY
	 OHLIft8rracUvscnEy5LKnK2h1EKzB8aK+iFGB+EDHzwgEcw8Vp/U1UpX38ifcViA3
	 OFCKXhO1de9NfZdS+ntcDFnhGwwO2tXRzJXM+Kg8=
Received: from localhost.localdomain (172.30.20.171) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Apr 2026 18:54:23 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Dan Carpenter
	<error27@gmail.com>
Subject: [PATCH] fs/ntfs3: fix Smatch warnings
Date: Wed, 15 Apr 2026 17:54:13 +0200
Message-ID: <20260415155413.26884-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

Initialize err in ni_allocate_da_blocks_locked() and correct the
pre_alloc condition in attr_allocate_clusters().

Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 2 +-
 fs/ntfs3/frecord.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 6b5b58ebbf85..e61c5bf7e27e 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -173,7 +173,7 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 
 		if (err == -ENOSPC && pre) {
 			pre = 0;
-			if (*pre_alloc)
+			if (pre_alloc)
 				*pre_alloc = 0;
 			continue;
 		}
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c0b9ca2426ab..7b035da63c12 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3267,7 +3267,7 @@ int ni_allocate_da_blocks(struct ntfs_inode *ni)
  */
 int ni_allocate_da_blocks_locked(struct ntfs_inode *ni)
 {
-	int err;
+	int err = 0;
 
 	if (!ni->file.run_da.count)
 		return 0;
-- 
2.43.0

