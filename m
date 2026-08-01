Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CE3644C1
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548435; cv=pass; b=lCZ65rTB56ZWlW9dU4MYa1+nVkytusuSLO7DApM0qtxXabiW3n814ITI42xXH5Oc8WMlXmsM/0iCsOTx+1zqYxBK5m7uRAz9n5JrHrt2JtwKouAcr096CwKXYdg/xpVG6ndBR7JFSAvRDktYtaevqzK+AdBrHBW/upjepvcmeGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548435; c=relaxed/simple;
	bh=PQHehb6xaaZzsOT+UAqx24TvQXdpb5AYYVC1wuJvCXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZSb+Yr6jrDRI2cnhqhJh1vN5GCetnn3PKww/yLAxRsvBkCjc82YMf+Mp2s+hWiW0qGty2WBImjKG/ihJrn+EB2SNWwzEOpA8AGxs3VhPOqtpN0WxlrY6MkjQz3BGUhNmEXx5ohDOrpzTWw5y/e29ZmkdneCd5StPcXbuaTfPCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=ezifo1sD; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="ezifo1sD"
ARC-Seal: i=1; a=rsa-sha256; t=1785548394; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ktZ9WE5wztzujSnr2adhkNffrE2mRVenRoiV3VpYsF8F4oln9Qhycm8TV961smJTWomg2s7hh9lzNqRYehhBFjj5bbAkvoM5OGrAZtNsIrdYABf72jqWWUxASZs7Iv7W9e1QqYZ9O0ldhecIBKWTkbskpMpikDIlByQ+YWk8KrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785548394; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AW+NI9SvimOLdQ5yoGAzcVWLFENjdPCnYfCezV2yINA=; 
	b=Pwip+qWJ4oTVAeZisJbjsUEq42tNpdNzytuWGtjeqFTlI2ItfQ2b7z1eg2Rin5EWbx3JKlsX/a9LwMSpyLAxzyfHTv4L6M6agSeeb735eLwEsH9uwUIdx6a5IEUHmvB+U9MhF9ReUZZC5K+isNyXKN1Lpur2AhFsKgQxsEjXnuw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785548394;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AW+NI9SvimOLdQ5yoGAzcVWLFENjdPCnYfCezV2yINA=;
	b=ezifo1sDBtCYETBS1RZ+e8ujJkwD6jLA7oMIAjsgwmODRA5H1cwebiXrP4fZIiT5
	J1M/CJiT5jwP0OcSzTRUX7xaw0+7gGML2sCiIwqzod47aqcHEjWQW1dM7v8hmwt1mLU
	Hry9NqySHQwjVg9v9m4wM31vpmkHmHyJj3WfjGyY=
Received: by mx.zoho.eu with SMTPS id 1785548392351287.62015178759646;
	Sat, 1 Aug 2026 03:39:52 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: do not treat unreadable directory blocks as empty
Date: Sat,  1 Aug 2026 04:39:32 +0300
Message-ID: <20260801013942.279992-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ufs_empty_dir() scans every directory block to decide whether a
directory is empty before rmdir() removes it. When ufs_get_folio()
cannot read or validate a block it returns an error pointer, and the
loop currently skips that block with continue and keeps scanning the
remaining blocks.

If none of the readable blocks hold an entry, the function returns 1
and the caller unlinks the directory. A directory whose contents live
in a block that cannot be read, for example because of an I/O error or
corrupted directory metadata, is therefore seen as empty and removed,
losing the entries it still holds.

Follow the ext2 behaviour and treat an unreadable block as a reason to
consider the directory not empty, so rmdir() fails instead of
discarding data that could not be verified.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index e62fe5667..ce43cf20b 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -590,7 +590,7 @@ int ufs_empty_dir(struct inode * inode)
 
 		kaddr = ufs_get_folio(inode, i, &folio);
 		if (IS_ERR(kaddr))
-			continue;
+			return 0;
 
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
-- 
2.54.0

