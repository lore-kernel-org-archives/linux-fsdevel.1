Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72293F20FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816882; cv=none; b=pBrNZk0ScBh9PNhOIv/N9cb7+240rjWCLnyiab5SCSNjnM2O1Dpee7VO2eWyfS26naH4TADpjJa4tQxGz+Q23GwcSdrraRIx7w4LlGDw3TFbN1qS5WcPbybii+BD6NOeCcSIL1q6aVkmZsylb6hOyM2UunEwY72L+YjBhJqYr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816882; c=relaxed/simple;
	bh=e8/Ytg6hN74+jpl4KlmP+fOL2D/VTZGe6xoQogVjfoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6OUw8K3ahEOeKs8IfQygydPTEoBCvhH54EJWI15qVafBl7sVbF1ACmQVENdBfq4maYUnFmDgou/Z5TkHvVN4gjaiySbp8YzJf+iPiRTUAiZKHYDkxU7oOPA8pIt4eWjwdOba0W9WC8deFCfOdVRIF94Wzd3Bkhirytp+F1j548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ujdHK0V/; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ujdHK0V/"
X-KPN-MessageId: 17a03f17-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 17a03f17-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=f649Glf8BeKLbt4PdTFmKZM1S2fBtcPo2Erl40w/JMM=;
	b=ujdHK0V/cj5STuNpErluBisIfE0uDzrd5q/VpweYOYSPSZxwze+qELER8io+cerceATXp9K1K8Mc7
	 VqsnqhAVWiN38VzMzFEKfTuvKK6w861k8gwW6IyD7YCoBbsn+aeQJZRz4FwXDMmPbQHBNxwaAvkWVM
	 SvJJhZvmCjhAGYF/I/wU8qnimxkOSFHCXRZGmr9ghEzSQ8aCEm0isKcF34Rw4o1bXhy+Fppht9BJLG
	 CIypKoq+CD+vulnp2ogAKP8ge20eFykQM8i2prc6//tQRfZqC7sngnxnek+ZwImv/9wKpopiTB1WZs
	 2Wuci8wnc9MRDuRw5ueq245eAiw4ZDQ==
X-KPN-MID: 33|AYvvhFQ0CcKntWPQiHbgnTO89/P3mD+TasLhVo5XFgwLVEZ+BJUb7i6IQNkLRCE
 7wiVwOFkOstw4R6QUVd83gyrds1mzDNBDW7W7cxFWTBs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jBZ9stUa6k2aMluJYQ9f8LjfK2RxniABe238pJ1VvKgr6KOY7/pMYNi7osSqIMF
 JKlrONttYK1tmgr0UYgB+Zw==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 177b3c0b-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:39 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 20/31] ntfs3: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:49 +0200
Message-ID: <20260630105400.68459-21-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
->mkdir(), so OR-ing S_IFDIR into the mode again in ntfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index c59de5f2fa97..c6efb488e48e 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -213,7 +213,7 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				 struct dentry *dentry, umode_t mode)
 {
 	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL,
-					 S_IFDIR | mode, 0, NULL, 0, NULL));
+					 mode, 0, NULL, 0, NULL));
 }
 
 /*
-- 
2.54.0

