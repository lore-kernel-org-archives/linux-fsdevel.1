Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780A37DAC0
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342190; cv=none; b=jVMpCqS0lBbLpS5zeIYOAw+Y3LisrZvKPHTm6Csbjbn0KdlG8eYxaBTPJf+I5PZOSFAMeU/gsNhsPORtGsprQ9vqPtt6LCiMhMczKEJwLylmXRUjLRd8svVYP0JDUFf542x57RQhTqkiw1wOB1XOwO7JeNZvfr7sgDnNuCZ6FA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342190; c=relaxed/simple;
	bh=4hFw9KCenbVMCqj8NLv/bdnq2jk+Q2d1SQkxjK2TZIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzyxQFTfm1wStgc6gCxFi+UTcqVNPV9dbd6A/2yCZVMlLIi/TebbqhhklWdKkyTH9KBR2IG5d1cFL3k7MsXV+YlfhjrgOrMT5bdnYQHox5EzcFoOB7O/0O8Kd0ogv18Y99SUMrs5fgBJdoCTuWlmi4GlIdwpb8pvSD3Ax3hYw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net; spf=pass smtp.mailfrom=theesfeld.net; dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=L/FWKi9m; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="L/FWKi9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780342180; x=1780601380;
	bh=hQse/rXDp0JQ6h9lkQal2Y3KG8gT/T4hswDIetnx7qs=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L/FWKi9mF2G2E6BK7haoif3L/2h7KZF93y/IygAiCAFMcGUsWbbuX3Zc5JWafjgUw
	 jGscy91NPXzInRikY8YGj8WK9tlFPvW9awS1D9Cbeus8xhAfVonWxSzVtpOpwOGI49
	 EC6/zc7Y+DkaJRZlcLoo1bHK5Wy8tvaBhGMrQAnsQJT6Yl34qlgfN+Em7xr8M/d2yu
	 iJs6Wcb2CVfTPcE3vim5e8tEpUkIMiptXa/xiQAtjZoVa4eQA0H1GWBpb5Z33fnodX
	 a5cX0Yxa59obRF+pJSUD4WQxReojaMhOkUhIm9aT332V8ri4ZM/twFfLuGbwe93LzP
	 AryCWfgHzLLNw==
X-Pm-Submission-Id: 4gTkYW4XqHz2Scpl
From: William Theesfeld <william@theesfeld.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: convert page array allocation to kcalloc()
Date: Mon,  1 Jun 2026 15:29:34 -0400
Message-ID: <20260601192934.617233-1-william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_get_user_pages() allocates the temporary pages[] array used by
iov_iter_extract_pages() with the open-coded kzalloc(n * sizeof(*p),
...) form.  max_pages is derived from the inbound iov_iter and is not
bounded at compile time, so the multiplication can overflow on
sufficiently large iter counts; the resulting too-small allocation
would then be written past by iov_iter_extract_pages().

Switch to kcalloc(), which carries the same zero-on-allocation
semantics and adds the standard size_mul overflow check.  No
functional change for non-overflow inputs.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f94f3dc08..9e258e53a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1586,7 +1586,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	 * manually extract pages using iov_iter_extract_pages() and then
 	 * copy that to a folios array.
 	 */
-	struct page **pages = kzalloc(max_pages * sizeof(struct page *),
+	struct page **pages = kcalloc(max_pages, sizeof(struct page *),
 				      GFP_KERNEL);
 	if (!pages) {
 		ret = -ENOMEM;
-- 
2.54.0

