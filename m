Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E83D0BE4;
	Fri,  9 Oct 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566246; cv=none; b=qgaxtaUx7CdeHOFIsGam+XAfVPgmxxHhJMPPwale3eSeusY2l8DTl3QNABuP8oCWkjwb2g1iijEh6k44ydMPxkvMQ4URvVD/lWCWR4J5pB/IgfCi5IqPaSJTt7Gr7uUzzMurq3GdvD2idCCmtrUQoqrSKskMzBDSi6nxQ1sxbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566246; c=relaxed/simple;
	bh=eLKh7lb81evRGE8EaOv+k0NsiCr9pJbDLcPC1n1J8OI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYI9TZw8AZghpz5fRD8CcvudKwjwdMunul9b06psS9gdXgUjfr9JjGGlKT6J1oKXwqo0j+fADHuCseoJAZbKYl7V0puWfuOqWyrfRx84X7pT3BjVwhSq7Xt8gmcJpjUUpr6ppjaFmcg22QOf0tNpR2jwiodYY7uxI5IyC1K0ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Vwju4Bpl; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Vwju4Bpl"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 56E8D1D6E;
	Fri,  9 Oct 2026 17:18:09 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=Vwju4Bpl;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1EE3921AD;
	Fri,  9 Oct 2026 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566238;
	bh=+yIufJ90z+DaKYOdKOmG7+DJ0uguXLEOuAHrg6gxfj4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Vwju4BplQlqyIe5gy1ywDlu1eBS4spztXJ83awBzzOyewt6wCzJb8tzLQsyfE3piC
	 SocQEKHhZOGr1HYJ4kXKNi7r20gOxJr3S22matn61HS6CiXh7vx89VPcN+QkQYiH/b
	 yrQlKl84vYoWPRuaxr5ZSjcpvE8eg/i8oHWbFUOE=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:16 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 01/11] fs/ntfs3: show supported options when an unknown one is given
Date: Fri, 9 Oct 2026 19:16:54 +0200
Message-ID: <20261009171704.11379-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
References: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
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

When an unrecognised mount option is passed, fs_parse() returns
-ENOPARAM. Print the list of supported options alongside the key, so the
correct spelling can be found directly.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d3093f72ea38..7fd83027007b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -339,6 +339,17 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	int opt;
 
 	opt = fs_parse(fc, ntfs_fs_parameters, param, &result);
+
+	if (opt == -ENOPARAM && strcmp(param->key, "source")) {
+		/* Show mini help. */
+		pr_err("ntfs3: unknown option \"%s\". Use uid,gid,umask,"
+		       "dmask,fmask,sys_immutable,discard,force,sparse,"
+		       "nohidden,hide_dot_files,windows_names,showmeta,acl,"
+		       "iocharset,prealloc,nocase,delalloc,ads",
+		       param->key);
+		return -ENOPARAM;
+	}
+
 	if (opt < 0)
 		return opt;
 
-- 
2.43.0

