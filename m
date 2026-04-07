Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78388165F16
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523045; cv=none; b=K3shhqqRmSvfeS9u84pFKs8ZVEqQT1fyArybFnDshpdIFLaMS63y2rEa3gHQjaqIk8f6y2ODw5wtxORM/nzL2MYGpcaVO7AqPJSyvIiZls/DAx1QfHuABHorwChPQl/sDSY1IHrX+ZnpH++EfmXoagaS+MP3StiUW7FxFV+yCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523045; c=relaxed/simple;
	bh=GqmnXc20Q+HviynpM0TYllhE9324tV/AV0Ch1gye6To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXT8zX3mDAGyC8lI4eAzxs8Uv24J9S1/yq7Yjl9YBKJS+Bvs/Fh0MY8OhW9Ya2j+gRDoz9jL1fPMRcE16v44f8B7IzJGZiE7/RjEy2viox32hHxBP7wQ96Y9AAIVBNoghfmBhjrHrswhlewjvkDeRMyyzfTFBVBy4gnsqVSSObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rk5hTRed; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rk5hTRed"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=++UoC5lCT4BjFTx7h6nLJrZsMRmg1dnaNt+ijKfMWzg=; b=rk5hTRedHABiW6JPWUEezhG/Ij
	Neu8NqK25ajRaFX7w71ZbjfDZMAwOQ3xi2FBAt13pMigECOsIV8doMwerGopASYzzNK+0bGj8L+MD
	lS3dJGfGNzbAfGNBpApbXiVhP7Wx2mjFNXw1E2aQFuwORWLbps9A3h9Y4+8HLowxYUQjqfLf4kLs+
	UbLC6IaRA85sNvvUJ7RdWrE7e5QLFCUVrxrMfHKlIj+5I+k+hQlFHWY4S8szjVmBAKQDU/n4Nyzap
	97cRleHPGylUgIjm08Lvr/LflxTtn5zIiz20XuHNCu2YrrziV5qXaCcs1KnChb6fYzznjE8RvKAGu
	j1QsIWBg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9ueP-00000005ff8-1P2f;
	Tue, 07 Apr 2026 00:50:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 1/3 v2] fuse: {io-uring} drop kernel-doc notation for a comment
Date: Mon,  6 Apr 2026 17:50:38 -0700
Message-ID: <20260407005040.1929492-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use regular C comment syntax for a non-kernel-doc comment to avoid
a kernel-doc warning:

Warning: fs/fuse/dev_uring_i.h:104 This comment starts with '/**', but
 isn't a kernel-doc comment.
 * Describes if uring is for communication and holds alls the data needed

Binary build output is the same before and after this change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase and resend

Cc: Miklos Szeredi <miklos@szeredi.hu>

 fs/fuse/dev_uring_i.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260406.orig/fs/fuse/dev_uring_i.h
+++ linux-next-20260406/fs/fuse/dev_uring_i.h
@@ -101,7 +101,7 @@ struct fuse_ring_queue {
 	bool stopped;
 };
 
-/**
+/*
  * Describes if uring is for communication and holds alls the data needed
  * for uring communication
  */
