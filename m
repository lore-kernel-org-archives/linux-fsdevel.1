Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB833B14B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166695; cv=none; b=hjit2gfsr6WKiNWES3G5QQb0N7U2QqRlqM/ov80ZNk/V/Ut0uQW+UmQVr7JxQ0fguEBHB81rgu0gjVDUK5D6Wqt5ax9p+mkRkXCVBXIFrdLhF22qqXJJgBfL+BAXIstnkpSRx7LlEBsMwlwtp3Zo21Vu+aBwPyZvoIhvb14igr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166695; c=relaxed/simple;
	bh=kFMD1PAFWq130cy1+t1UVAVtdBogTeWPy+9n6d3RAL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7CP6QgQMfj73MgSUUr7pqtWe0vlqHGZlyZkn+Pe+kzEGpUxJMH3oyvwng8bu4V8K79Ko7rsnu9IAGZaGYxslie/MPDFe5guZxHVBsIdPGY/NvEuoDT9hqi2+2H+fTHVGUz6I8StwUF9/h47oFioN3kp7ophHCJxoUfE+jVyKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=KGWxOe+m; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KGWxOe+m"
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:9609:0:640:e8a4:0])
	by forward102a.mail.yandex.net (postfix) with ESMTPS id 3C719C0081;
	Mon, 27 Jul 2026 18:38:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp) with ESMTPSA id 1ceLx3mf70U0-m467zPlB;
	Mon, 27 Jul 2026 18:38:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1785166682; bh=u+s8i8ohswZTk/PAP3y4xN4Tg/YmEPFK08LzCaB+T68=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=KGWxOe+mRuuizLYjQSmW5/AZDCcspQlm57qYwrwfAoLorvzWURplqx8u6VXJc9HQa
	 5Qx26iHEG5X6CYacKwqo6Yu/tqp0pUix7MQtlwk6b+mVK8XdykeO1u8lWn7jP0Bxye
	 P2bgm8nJrWBDQ02Y2qv/z83FT40b2YCi9T5R6+Eg=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] ntfs: simplify ntfs_reparse_set_native_symlink()
Date: Mon, 27 Jul 2026 18:37:49 +0300
Message-ID: <20260727153749.385152-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid redundant 'strlen()' and use the convenient 'strreplace()'
to simplify 'ntfs_reparse_set_native_symlink()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/ntfs/reparse.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index fa523dc3691e..50c5f8eede86 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -894,12 +894,7 @@ int ntfs_reparse_set_native_symlink(struct ntfs_inode *ni,
 
 	err = ntfs_set_ntfs_reparse_data(ni, (char *)reparse, total_reparse_len);
 	if (!err) {
-		int len = strlen(sub_name);
-
-		for (i = 0; i < len; i++) {
-			if (sub_name[i] == '\\')
-				sub_name[i] = '/';
-		}
+		strreplace(sub_name, '\\', '/');
 		ni->target = sub_name;
 		sub_name = NULL;
 		if (prt_sub_shared)
-- 
2.55.0

