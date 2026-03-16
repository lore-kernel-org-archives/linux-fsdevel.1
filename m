Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3F33BBBD;
	Mon, 16 Mar 2026 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686553; cv=none; b=A1qmhme4QkB5BaKOKoDwnZiSsolC0PpA/ar+dfBvbkZi3dY1mBXdiL7tlsTzfa/WwkmqWBUWOvD77f7+N1DHj5zOEfrc004Kefyxwimc/wmIL6+YIa3psaqrcn4yLtlMEAlQGBsMyyX0lBt/PPMcq1gljKCOF+0OTbjehpslI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686553; c=relaxed/simple;
	bh=B+m4aCVxJyeURCN5klrpnSrWpshyedEBO9JGcMF0aYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggi5Bmo95vx4B6Dm0AZ8zzWF6Umh8J2GQdw/u32p/Ywhod/o0AREpQ7rjbXf0p2x7i9rjBY4EodJERqopdA1Mrg3IeKOj06wiCqeUXjf4ul26HqOFG0rr/Pdc4gpxklfgum6mKQV1NEf5cYpoSSwLNiN5nQ/qvzORjrIIh68Txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376CCC19421;
	Mon, 16 Mar 2026 18:42:33 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] unicode: mkutf8data: fix comment typo
Date: Mon, 16 Mar 2026 14:42:32 -0400
Message-ID: <20260316184232.161045-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file contains a spelling error in a source comment (succes).

Typos in comments reduce readability and make text searches less reliable
for developers and maintainers.

Replace 'succes' with 'success' in the affected comment. This is a
comment-only cleanup and does not change behavior.

Fixes: 955405d1174e ("unicode: introduce UTF-8 character database")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 fs/unicode/mkutf8data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index 401f5d3aeb0c..1c0069661a83 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -3030,7 +3030,7 @@ int utf8cursor(struct utf8cursor *u8c, struct tree *tree, const char *s)
 /*
  * Get one byte from the normalized form of the string described by u8c.
  *
- * Returns the byte cast to an unsigned char on succes, and -1 on failure.
+ * Returns the byte cast to an unsigned char on success, and -1 on failure.
  *
  * The cursor keeps track of the location in the string in u8c->s.
  * When a character is decomposed, the current location is stored in
-- 
2.47.3

