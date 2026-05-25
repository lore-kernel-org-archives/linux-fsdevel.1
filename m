Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22ED30149F;
	Mon, 25 May 2026 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729588; cv=none; b=nc0Mt6sZbHQXAqE1RYngI+vApgMa74RanySA5zFYK7CiQipmIMA7tIckqmc/Tz9iY135seAT4x+n6VXHwKPWh9BhWVCMrFwWU1g3UIiWnlIthriD64awissx+hrwapoIteHEv+w/5rFdbCnorsb+anYSYlCCKeCYGFZvhSJ7bhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729588; c=relaxed/simple;
	bh=wO2te+7AJyYxIRH7DDcCNG4XqElSYKAZMj8jAIsLqqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcvLzfQExtwS0wE0QE/n9zuv5k3lWs4QRKenunS9ZrPwl1JTtbS4l2cWTI7+q+EsmmZxgwgExNDGgJlwGxe/I+IxysbpxPqP1tK+JH4pLQ6CNo2rJyz+soC7y0PfvM33/XaqFQYYDGygU4ch7KwblBDaDlsdfEkILwFxfDspUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LMwYC/t6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LMwYC/t6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=18aDbOLfFIBliXb+PjyHOddV3iT2K4BXuAUU5XXHkew=; b=LMwYC/t6kqpxlXVj9ri/rFfYEO
	7sFODZT4sUAQxAMjN7B5LGH9+1cwZ90nuEhZBSc0/DnUs2QH2iEQeeBKB0/LmLudyUiGcdE7vGPt+
	SRQlj/lDo/0lsIIsH2bY3hCsu9SHxxHBSP0eCeAWe0GDHNAY9M3MaSGfD9cwOkd1ZRSkSrQe8rCSf
	x2wxAzGAMHSwaATlRNm7cVBc45cNXaukgrGYCLWxfON9tAfLswMucZEVQ1YP4FIiaM2zoPQfEfUoD
	dgmK+VPlFW2IUVzEsjNX14T6Ui0/iLyqU1UTD/m8obReJwQgT4LzZ4nLLTgwMBMQtLiA8GBVXzNVw
	zqzG9D4g==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxr-0000000HOCH-2lcX;
	Mon, 25 May 2026 17:19:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 22/34] gfs2: Convert gfs2_metapath_ra to bh_submit()
Date: Mon, 25 May 2026 18:19:15 +0100
Message-ID: <20260525171931.4144395-23-willy@infradead.org>
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
 fs/gfs2/bmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index b3d7fcd95f03..9b97b728eb94 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -304,9 +304,10 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 		rabh = gfs2_getbuf(gl, be64_to_cpu(*t), CREATE);
 		if (trylock_buffer(rabh)) {
 			if (!buffer_uptodate(rabh)) {
-				rabh->b_end_io = end_buffer_read_sync;
-				submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
-					  REQ_PRIO, rabh);
+				bh_submit(rabh,
+					REQ_OP_READ | REQ_RAHEAD | REQ_META |
+					REQ_PRIO,
+					bh_end_read);
 				continue;
 			}
 			unlock_buffer(rabh);
-- 
2.47.3

