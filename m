Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCF3EFFB4
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891781; cv=none; b=aM5Foj/JYa2FvAwcbw/j45R9uc4Ag/LwmZHgPUd2wnGnaGqPTwmnsPhSQh4geyQDQdHpfJ38dhtf3A9NOL5a584aM7sG4J9cdx1MH94MTydqy7oG6Zjx8T2+0XOasF2z5CjPKLkBoSA69us4xVHqcJ+IbP+MUqG77l9evkH097w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891781; c=relaxed/simple;
	bh=xjMrBCKu/fTigdq2Pu1gfQYTUesGI1+DbafXQNEpgWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+tNgTjMeUhxAV5GluPyGapEcHfz96GIbLkzqQE7cjGKywiI3jFME6FPmkSdA6YvN9iWyrWFtmKMiyEIVAZhnejs2Gdreh/s05P8m1yC4UyDhwg7koLzk0ESTTMtis2Th4vjqrky5fx03CFAvB7Nq3c9fi/FTJGABaeAXJtOYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iI9J+HxK; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iI9J+HxK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779891777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1949LkbHYnEgfJnvIrC8JHHRZyL7QpljwnzcRWc11g=;
	b=iI9J+HxKFjsBKOPUCcJl88u+sm9qBx+JCOwklyy8b4ssjb0wfp/Wcm5M8JZxKAHh1PdxIP
	j57UFEHyb8OWsv9qYfqNqjVCn/nf5GcebDBKICJ3STc3n+ouOWN+ycrnmqLFHEE9Amxi0R
	bs/ryoY0jvkABYZunHtktYtYUrXmmgw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fanotify: simplify fanotify_error_event_equal
Date: Wed, 27 May 2026 16:22:35 +0200
Message-ID: <20260527142233.1256340-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=thorsten.blum@linux.dev; h=from:subject; bh=xjMrBCKu/fTigdq2Pu1gfQYTUesGI1+DbafXQNEpgWM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFli/zTlu8trbs9+t+rc16nBl4rfaiTYMup0rHcIf6bCl ef+fXZmRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExEdhfDPy2HV46Tcv70R27/ f2T2Iad/xXP6vn18cXrmDUnHrrykP5sZ/gcsSPgaYT5X5xBDlY/ES4fmD6d5366xdeLsEFNI4v7 AxgEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Return the result of calling fanotify_fsid_equal() directly to simplify
the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/notify/fanotify/fanotify.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 38290b9c07f7..8ed77901db57 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -120,10 +120,7 @@ static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
 				       struct fanotify_error_event *fee2)
 {
 	/* Error events against the same file system are always merged. */
-	if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
-		return false;
-
-	return true;
+	return fanotify_fsid_equal(&fee1->fsid, &fee2->fsid);
 }
 
 static bool fanotify_should_merge(struct fanotify_event *old,
