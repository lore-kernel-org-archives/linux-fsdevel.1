Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A42383339;
	Thu,  3 Sep 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460573; cv=none; b=mDPjkWch6G6drrmF8EXbc/8s4gQaIC+Wo2Tkvi5C3AJdWdcHJz9DlweQ0q0hia2LKfeFwHBjDH1MrsKBbUvNW/Z27s0Gn6PCqIZVFHYKDog+s6pPe2JC2nMHJh7Sw2Q+urRR5TL59IH+vFDPDlbX97TbjO7OpCU956KB85cgT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460573; c=relaxed/simple;
	bh=cm7H8nQffoaULUq6JIRlP8F1vvH9RE1k/PAlBbYBuW0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hch0YdXGINDfWJooqLQmKCCki91J5DI4HcZSH1Y0EBjPCE3cgK/uKqoaSLLjYVc9+YCPZ4lrNxHOE9dzeLYFK/7YVgMl6yQXD5ixuIz4FsjU/5mRz8LC0SDzsAtrAJJ39eExexzy/aA1Nv61X90xcYCniqbNM7RKQAdbLBznz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=phl9Qt5K; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="phl9Qt5K"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C2ABE42C;
	Thu,  3 Sep 2026 18:30:39 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=phl9Qt5K;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6B2A421DC;
	Thu,  3 Sep 2026 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1788460181;
	bh=Wgo+qK1kTqee7nbzW4w8ARLLIrio7iKxUzwBL+4N7rI=;
	h=From:To:CC:Subject:Date;
	b=phl9Qt5Kv7e+9JFR5DFp04G8CWqCH2+uHiMZTpsWuQeVEZe9Qj5id4RgAH793tapy
	 I+XbcaAYIlEFzGXY1AHw45BFr6iklXhsYLXqYTyWPPV9DE2egh0UZGslVHlAAJ7fyC
	 OoGMft+YqGQU/4aco6kV1k50opNoC6kmdPAh8Ako=
Received: from localhost.localdomain (172.30.20.155) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 3 Sep 2026 21:29:40 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: convert to non-resident when the new size exceeds the record size
Date: Thu, 3 Sep 2026 20:29:31 +0200
Message-ID: <20260903182931.4871-1-almaz.alexandrovich@paragon-software.com>
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

attr_set_size_res() only checked whether the attribute still fits when
the attribute was growing (dsize > 0), and only against
sbi->max_bytes_per_attr. A resident attribute could therefore be
resized to a value larger than a single MFT record can hold.

Move the check ahead of the memmove() paths and also reject a new size
larger than sbi->record_size, falling back to attr_make_nonresident()
in both cases.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index b1c315206ffa..833731d799a4 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -394,13 +394,15 @@ static int attr_set_size_res(struct ntfs_inode *ni, struct ATTRIB *attr,
 	char *next = Add2Ptr(attr, asize);
 	s64 dsize = ALIGN(new_size, 8) - ALIGN(rsize, 8);
 
+	if (new_size > sbi->record_size ||
+	    (dsize > 0 && used + dsize > sbi->max_bytes_per_attr)) {
+		return attr_make_nonresident(ni, attr, le, mi, new_size, run,
+					     ins_attr, NULL);
+	}
+
 	if (dsize < 0) {
 		memmove(next + dsize, next, tail);
 	} else if (dsize > 0) {
-		if (used + dsize > sbi->max_bytes_per_attr)
-			return attr_make_nonresident(ni, attr, le, mi, new_size,
-						     run, ins_attr, NULL);
-
 		memmove(next + dsize, next, tail);
 		memset(next, 0, dsize);
 	}
-- 
2.43.0

