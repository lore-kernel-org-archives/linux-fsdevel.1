Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA793E5EE0;
	Mon, 16 Mar 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686977; cv=none; b=GjZfB0M7rSsCPxOibxMYArMTwlOgJFWUHieAFvzc+CRTk6STFfRU5TLVJv9ellbqVk7ej7eAeiqQhOoj7YnWF3ntDk1UQcIVKLR1pwAGZO9uWOsni+KL6rqhVuAmRzWdD3uWwob1VyNm4ccyHMnkvPZsQa9vad4wiBpO73tZrLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686977; c=relaxed/simple;
	bh=0WMkz7vVn3nyvSKB2y8gCrt2MriBH8Zm6cvqIx3vY/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfdTVcLfAW00Im6k5nRIa2/iIlF78DmFUp911og1+WGt5o0tBZ9F7pTELh1yD8VIh1swW9qD0uLyUcimf+olPut1gw2WhRwnc9jWm6FtPP/Mhz+Aa6wUO4T7RvHVFLgU5eTrMR3iZEmqW+BrySKbrW2BEvG50azUxsSJ9LsicLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3989DC19421;
	Mon, 16 Mar 2026 18:49:37 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] unicode: utf8-norm: fix comment typo
Date: Mon, 16 Mar 2026 14:49:35 -0400
Message-ID: <20260316184935.163597-1-joseph.salisbury@oracle.com>
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

Fixes: 44594c2fbf42 ("unicode: introduce code for UTF-8 normalization")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 fs/unicode/utf8-norm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 7b998c99c88d..41e884569dbe 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -444,7 +444,7 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
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

