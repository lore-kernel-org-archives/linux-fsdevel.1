Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6B3CEBA9;
	Wed, 19 Aug 2026 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122642; cv=none; b=dNqkgvP9bIj92LHIxQ7AyYfPboV2ZQwlOxzIdzzTdMUzTvCla0Ae/Y+rCa/7y0/ACKa42VtAlT3xbfKP9sU6OrUi1wdSrLfNrvMBVLVVHCTjWtK4w7umP1sjQBcCM6wrlszv/rk1tNfKmKzxoUt3N41e+J6MQSWOX+++SYCvdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122642; c=relaxed/simple;
	bh=BnaDMAZ8Jop9I4TDtKW7q6HkVz6RaPPE9fxgxbNDaAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1Nr06fXLL4Cv2KfL/h3mqH5Df+axeuz8vZuOtwgR4BbtraIWIpe8VZTDHaFGWO76sA9qHFMYhm2nThS3GALYXqzXWPaP+sWxAv+3OsKhkQdcSfC4QzPhEqEeFO1kzI6P1cOXcFYOKzEZ2/O0+QcM9lZ6Zru5PIG2f/VNZ7tuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3H1WtXX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3H1WtXX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q0IdqFnVkqkF5q9pk5IoXLZATdgqmwUq+XC4q3t22bs=; b=f3H1WtXXpW3AKBooPYiQgk+IWC
	SO8y8uXhKiPyf/6BN28IuNcQJ9yBfHrNh0nx09zpU7JuOCuhTfBp9iQUPSIKNDxQuQHfBXiHrt/u+
	0YB584pQNd0b3FAWIctBx+iVjmx+jAz7m7iqhkPz5CZxEB5I3OhC/fdl0hjRg5c5A5ZYH5H95kw6b
	JXPUG7YoN4qdrQZFmJydSjB9ZyrqsE70Eh/JQY1ttyAPCcdYsY0C8w79qPtLjVyMK0T4h6YNUKFzE
	mCp8Dpvrsn3WzypJSqFxBr3TkRuKPTYILZUTiXRdjtNTUcGEtjwOQvEUDJvsoDXrUVzbTtaeInYJD
	4R8WdgUw==;
Received: from 2a02-8389-2301-9f00-b711-947d-6c5b-1af5.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b711:947d:6c5b:1af5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwaEg-000000098qY-2lF7;
	Wed, 19 Aug 2026 06:57:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: willy@infradead.org,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] XArray: document that tags persist after storing new elements
Date: Wed, 19 Aug 2026 08:57:14 +0200
Message-ID: <20260819065714.1358822-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is a very useful feature, document it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/xarray.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index c6c91cbd0c3c..9a0d930a8c79 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -127,6 +127,8 @@ by using xa_set_mark() and remove the mark from an entry by calling
 xa_clear_mark().  You can ask whether any entry in the XArray has a
 particular mark set by calling xa_marked().  Erasing an entry from the
 XArray causes all marks associated with that entry to be cleared.
+Storing a new entry that replaces an existing entry keeps the marks
+associated with the index intact.
 
 Setting or clearing a mark on any index of a multi-index entry will
 affect all indices covered by that entry.  Querying the mark on any
-- 
2.53.0

