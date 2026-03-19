Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB82E7164;
	Thu, 19 Mar 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929277; cv=none; b=O5+vNo5zUhmmfzwsLizSfVEhTndZ6541NE6jNZqyj2uWzQ1cjr5eFjgONkl/LT6tOHDJoiKrZw3By/IiG3BHvNGBO4rqMefC/22x5pu2Z1/8W+BA9+L2+ZGjzWzBbs4T1sIRL91+cADWh10WnRQnEpTDHygrW6hj2pgBrcF51mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929277; c=relaxed/simple;
	bh=GIlqRDj3jTslmSk+QRQafDggiayP8O7TDUbCp29+m6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FhAfacMRjmWr4v01m0qQwQc04zIddroXaiAas/FwPXLS48TiBL8EM+RzAkflFPZHjAx5wGH6/wLOymLDIhICCl7AiVueV+D2e6CIoheVItqnhMILXdvpeaLi086mJ04+soh5DMJXwa2veRcTyDh+trysytqKtsvCNxncE14w+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=PM1U5JQb; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="PM1U5JQb"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 12C901D37;
	Thu, 19 Mar 2026 13:59:13 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=PM1U5JQb;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C432E216B;
	Thu, 19 Mar 2026 13:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1773928744;
	bh=eePanov41PmpHR5AAfIKW439LTHdn45KmgC7QNz2rd8=;
	h=From:To:CC:Subject:Date;
	b=PM1U5JQbQle8maqG7BavSGmb3oLxt2yvj1g/T6PZ2umXaVNrs0QDTlm9ZFCFT5bXB
	 x3eTR63Go8pUCrPCmhYs1ekUDFi2zzuhCyTzwRgr3p/SjEdE5d8gAnaUTtplx3XtPI
	 hc2LQ584iXaRPbI3SFGZAFGY8lCUocZxVl0JZXZ4=
Received: from localhost.localdomain (172.30.20.152) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 19 Mar 2026 16:59:03 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<rtm@csail.mit.edu>
Subject: [PATCH] fs/ntfs3: increase CLIENT_REC name field size
Date: Thu, 19 Mar 2026 14:58:55 +0100
Message-ID: <20260319135855.15200-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

This patch increases the size of the CLIENT_REC name field from 32 utf-16
chars to 64 utf-16 chars. It fixes the buffer overflow problem in
log_replay() reported by Robbert Morris.

Reported-by: <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fslog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 272e45276143..10dbe9922bf1 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -45,10 +45,10 @@ struct CLIENT_REC {
 	__le16 seq_num;     // 0x14:
 	u8 align[6];        // 0x16:
 	__le32 name_bytes;  // 0x1C: In bytes.
-	__le16 name[32];    // 0x20: Name of client.
+	__le16 name[64];    // 0x20: Name of client.
 };
 
-static_assert(sizeof(struct CLIENT_REC) == 0x60);
+static_assert(sizeof(struct CLIENT_REC) == 0xa0);
 
 /* Two copies of these will exist at the beginning of the log file */
 struct RESTART_AREA {
-- 
2.43.0

