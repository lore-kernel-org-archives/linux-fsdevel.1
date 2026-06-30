Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C386413D8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816891; cv=none; b=oR/bFlp2/dtZbsyW5U1WzY9qaOjLs7pA7YcSiy/1v+p9O1BInjBuBG8UYrfY41ZGuv40Uk2FoHlkVL2PuZF9V+43LMxECWBOVVpTx77LNqQrmQgOBK3GlL9Sgud1+/JHV/kkl2kngIMLHZSUjhGF4+Ux9cPDleuD22GZx/c33iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816891; c=relaxed/simple;
	bh=31Ip6Q4YOuTbhr1bfaRpLGxMH7QplBl/jn+J98CD5Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mrk+I5KWEuGD8cvEc9zOiLfVnDGntDQv0UgOsJoWKwCQneEA+VHoC8vnLcylD5y2aCwXkVRN51WSsgvY8blpp9g1Xgy0VzGeb4azgFpQBu0XgLHfATOaFhVVeTmz/dBAjZREYVoQc3LAr+04RA4I0B4+VeyhHq60exIkUbbaXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Z4O2qpvQ; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Z4O2qpvQ"
X-KPN-MessageId: 1d32b310-7472-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1d32b310-7472-11f1-861c-005056aba152;
	Tue, 30 Jun 2026 12:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=i6MdkJSRjh7B844i9gbOIbWUjkX4oASDuM/GTbqSGW4=;
	b=Z4O2qpvQbVMxH4jTEkIZWl6u146zWhaC5pqOH2Ky5QcsVfQvt0bEOyCctjxpWBI2fqTfKLya0gtSe
	 246+QII4OIayNN+DtSekFWsLwSc/KRw88bGi5iK/X4Bmxz1A8/3lv7M/8ocIGIz+PGi+wpnV4kb4cn
	 IvFp7HPC5s1JmtVKEhxJWhC/kGKKCwlinEJC98gi/li65/iTtGVriZyzPZ+5WWTQ04zGd7cfsiHG5O
	 6m7Gu00u5CJW4rD8cnrlGfhHzIGabsBvkfxtPvbM4Re2n2LWIdzcaLkpFPoi9ypMPJ9I48Scf+paQp
	 0nS8i7Q664gqhiSx9/gxkWcajyvxGiQ==
X-KPN-MID: 33|adAUc/RYnWCXCIwc3WMsedfXbgcXgzE3z+lRqG101Vu2Q4kKZtryA9GGwq7+PU8
 x/BdJLRYYe6M9RwGmxnkPq1yvC1HzvhKswN63lvAB5JI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yV4w+zfoHxhD7/ars7eUGsYXh6makceCdcWjjnrsmyRF4pyLCmTOxiu+Hzabszz
 /HXG4QGkFlRkq9J0lUdNOdQ==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1d0f14cd-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 30/31] xfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:59 +0200
Message-ID: <20260630105400.68459-31-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in xfs_vn_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/xfs/xfs_iops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 6339f4956ecb..a3c02101ff3f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -306,7 +306,7 @@ xfs_vn_mkdir(
 	struct dentry		*dentry,
 	umode_t			mode)
 {
-	return ERR_PTR(xfs_generic_create(idmap, dir, dentry, mode | S_IFDIR, 0, NULL));
+	return ERR_PTR(xfs_generic_create(idmap, dir, dentry, mode, 0, NULL));
 }
 
 STATIC struct dentry *
-- 
2.54.0

