Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD992D0C95;
	Wed, 18 Feb 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376846; cv=none; b=kez75gbCx1F3V0jd5eJzGL2ci7QGUE3+XtYDwhogb6r8cudL45gT8Pn7+/o7B8zrhfNZHWjCyEcH8Td0Qf4DxwRYWLYXZFmCnuGDlHxAG56loKbuB9z7aDWyS1r7BWudFw4LRWzi43tI2a3QqznpKxnW/127i34G0lURC8iWLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376846; c=relaxed/simple;
	bh=+CVW+jqAGcNQgZ9KfyjdE5n43SFWkJierbzGyPZLvRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0n8kC54UxccEpWZr+glEMrOko/dOY8hYPhbdYsTFDlCaHsne4pAZTstR+8jYdcnlOD+n5DYaz/2HFFWtpUOJB0sqPHbDyioWXE34vTmIEg/GwM+vmDp5Gb15V3yyDfZCZjSkc7HjNiMQiUXa/lIGwn2hi8Bp4FhiFmCfG2SUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDBzI+ET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDBzI+ET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B83C19424;
	Wed, 18 Feb 2026 01:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771376846;
	bh=+CVW+jqAGcNQgZ9KfyjdE5n43SFWkJierbzGyPZLvRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDBzI+ETOPtPNXj4q8nVG6tfq//g8NUv+bPnpFcwarAdu5fdVH4+tRCkC3FrOVEBX
	 tNLKXhHKJZaUMRoyPyX5CuBmsl55h4dqLD19pKu+1Bpuwji/AoLtl4SsM9ZGDha4SO
	 xtF3++c2KoYuZcszkDX+RINQxJ+udkvo8um77T4CO0iTQTXJ2QHqn65FQ1BhcDUO+q
	 piHvt8XvyHIytzqAsU2OcfsJqIDlddtwz1bahMDuqbOBhjKisyjWbYV4TVUtYiiqsQ
	 21O7cy4HrDLlVUJsngMtdJ5eyhL6gpH+1LUOtWYSb+umO9Ps5ifgvZsN/HCfSupb+H
	 yyQPZ5CVZwb6Q==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v4 1/3] f2fs: remove unnecessary ClearPageUptodate in f2fs_verify_cluster()
Date: Tue, 17 Feb 2026 17:06:28 -0800
Message-ID: <20260218010630.7407-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218010630.7407-1-ebiggers@kernel.org>
References: <20260218010630.7407-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unnecessary clearing of PG_uptodate.  It's guaranteed to
already be clear.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/compress.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 006a80acd1de..355762d11e25 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1817,12 +1817,10 @@ static void f2fs_verify_cluster(struct work_struct *work)
 		if (!rpage)
 			continue;
 
 		if (fsverity_verify_page(dic->vi, rpage))
 			SetPageUptodate(rpage);
-		else
-			ClearPageUptodate(rpage);
 		unlock_page(rpage);
 	}
 
 	f2fs_put_dic(dic, true);
 }
-- 
2.53.0

