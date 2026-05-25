Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8543F5BED;
	Mon, 25 May 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729589; cv=none; b=tkmy+lR0Sca71SNQF76erdQ4izkYrvIMcxovtlsmTHhA07EgwFg/0jN6EYWCSuZCRO/y6esxUHmKi6EJ14UIUc7mrc5KPJtCnX307Pk8pjDGJbxZZfNzP3AdSduD+8OyfdL3eshuHhmoc6d1IxbfIrA92VRg7YEGqO/i29Bs+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729589; c=relaxed/simple;
	bh=2DOB9qs9pZsu5ZuDapC/k1C2vPy/j9vBGqnC1wR92FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8cIW0Pa0whfjOTaBZUa9sABljV59Ny3qfpcXVuO6ETub25xz3dfGvETqeVF9nGfC0/+UxCnCzbpgB0GM+jIiBQ9sIblmzmTpsKYFUsF/vwoMkF8qE7GDlX5CMOAM99yIN2o/+aDiSqlqP3ZTp966lvL0rtpUMnm90Vv4DU2PQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iC+yXTzW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iC+yXTzW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QgWegyhQiEFyROPbBNGEIRAUki0P1kYsbbqmoE0ljKk=; b=iC+yXTzWvmtOg5NH+o1B2z2cZ6
	SLI+L+kYLRvo91CtYTX3NbbDiM719xCKqvOcW/cDTOTuuxOvv3ph4C+UHohBPWTiKalUmbvGyDhCe
	/wO1vCBvSOGsyzrZfx9JmFTyiA8a4DRd3UOTHkgaY7SF2178rjdfS4qMcp2As05gqmrSdcxENTpZv
	GjJFK8iqRHbah5EMVp2ADcIc8J5LMOMyEHyIOsLSubxRAloKpKH6clCVtDOY2XRKLLDWXrzYdpoS2
	8DtT1STgGC/zw8UIyCBHLJedxnIG3M894Xb1wRorapI50GaF8v7yaDYlqUtEBNcnqH5Cv/Sf/Tj9O
	vxa1U3hA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxs-0000000HOCP-0nFy;
	Mon, 25 May 2026 17:19:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 23/34] gfs2: Convert gfs2_dir_readahead to bh_submit()
Date: Mon, 25 May 2026 18:19:16 +0100
Message-ID: <20260525171931.4144395-24-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525171931.4144395-1-willy@infradead.org>
References: <20260525171931.4144395-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid an extra indirect function call by using bh_submit() instead of
submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: gfs2@lists.linux.dev
---
 fs/gfs2/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 022dbb31e0d9..f5972160906e 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1508,9 +1508,9 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 				brelse(bh);
 				continue;
 			}
-			bh->b_end_io = end_buffer_read_sync;
-			submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
-				  REQ_PRIO, bh);
+			bh_submit(bh,
+				REQ_OP_READ | REQ_RAHEAD | REQ_META | REQ_PRIO,
+				bh_end_read);
 			continue;
 		}
 		brelse(bh);
-- 
2.47.3

