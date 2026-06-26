Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0D3ED124;
	Fri, 26 Jun 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469620; cv=none; b=EB8kmPFzepWLUdheFgAb7J+lh2yQpoajsJrfP1aG7Z30ChRfmDvQBZ9YLft8RGZjsMDIpNn3bfB3MUjNVB8G97vVlLB7KKSpdJe1+tzALmQ8++VAOtwWEeZjB62GYlATaLWEJqHBrSehtugUNN9oOyTfoCLA3YeKg1JiuMNuPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469620; c=relaxed/simple;
	bh=3hMxWewFdcs3COsaq3Am99al+yU2TYZVHTg8HI044ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pEoI4Ao60FuvefrECvAbF8aedBpFzUxOKylbFDxN0Z3UWm7M0+SuGpM4XLM21HUie6qEmqH46Ra6lQWoAzS/AMgju7xWRNyLBIKewRzRHEaCPT37h5N1UHLUAWPGISY94aHJSdJhVtOEF4YguNQap9vluxwMc7kBWFnijm8r0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QOWZEDaX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QOWZEDaX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=fxsrf5xMCeW7a2cFi/ftsWNGiND6fBlGNxnzaIK/z/I=; b=QOWZEDaXobedCWeb3cF0UXvyzM
	QV3oiXKGjyg0Ze/xhBFJG2sYI9+qkFfOUi6+DWn4IlYuouv/zzenwJbsPWZNdRpLq72poMYTyccgv
	JNWxMxpvQD9q99O9VCgIhhr5RRXkbYQe+9RlARX/AoMfq2mlzKXQlrVz6EPBNHyKKqYRFJqSp89gp
	C9PwYRmfGiizNzz9oY/LvvO/xz8D/0Ra3R+aNhigc/BFa/FvK4yHrNxkh6lfuQtrZAjDypFr7w9Fu
	h5D6FwQCel+U+yIuUEpgs/3bc2MRhEcCcTAWw2dhlUq7s2Bt2KfHth6sekeJuTnViFXH8b0KpcesV
	RwI+wpwA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd3ll-003u0W-2s;
	Fri, 26 Jun 2026 10:26:46 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 03:26:31 -0700
Subject: [PATCH RFC 2/4] fs/pipe: add per-pipe pool push, prefill and trim
 helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-b4-pipe-unification-v1-2-d23fa6b1ee27@debian.org>
References: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
In-Reply-To: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2967; i=leitao@debian.org;
 h=from:subject:message-id; bh=3hMxWewFdcs3COsaq3Am99al+yU2TYZVHTg8HI044ME=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPlPZFbecEQcsK+e5kb879smTSPK3kEt2z1xSP
 D156o9QaOOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj5T2QAKCRA1o5Of/Hh3
 bflrD/4/pSrq0Q+cLS/NFVlqibocZWT6t7vPjDOxjmoGDmUH2GxsvaD9RI8hajBVjGID3UVsHKo
 2qhOwd1EqoGFHbcuSimNjUZz19KsDA2CmYJSWiyR1GRJtiS8SfXtUraJnei2jV8uACGXZezUet5
 ozo7mc0H+aqvoQDWSmr/SJeeSkp/EK+WnNST2OUQN/RKHvoW8iPUM/yyb9M7xwvUzS/3yf8FsXM
 TWeZ8W8gOAB4Ibq5wlzqKWoBurXHKgfmhmroJKvZjKJKI8MVvTjfnewEPzc9wnOshMip5L26zQp
 X/lZdWmqvrpDD3juaCWiW26ngSifidd36av87Epy7ifO/WAwBSu59Zct3PJUs2S6GWS2FIA4IYH
 m0M4xkPvMklt2slLaSkQy1gNBErestCBL7zzAVBYnkpqxZs3byD5rt47eSF23ZzGGnlzxcAM5Se
 pNVVW61NA1mNrYSND3EYyLCz6fF+0IwwLBdpEaoZ+Er2W2g0SZKpxHXJB8dW4CBx3TV6dWdLVsD
 NPeHvegAmk898wIIjBKugp0t3E+Yr+XbOYJ4NO26gZyg+VkH5Rke8NuDjXmzA0A5RBVbV4kAj6o
 B/o1EOIpKyYZAQrjN1QcXqIuTnByXna2RCVJY1kbXQ6R7F6lpfubU+Sd+nfnsYT7Uakv+V1CZ+/
 3bqPqBqSSibvRrQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add the helpers the per-pipe pool needs: anon_pipe_prealloc_push() to
return a page to the pool, anon_pipe_prefill() to top the pipe's pool up
before the lock, and anon_pipe_trim_pool() to drop it back to
PIPE_PREALLOC_KEEP after a write. anon_pipe_prealloc_pop() already exists
and is reused.

prefill and trim_pool have no callers yet and are marked __maybe_unused;
the next patch wires them into anon_pipe_write() and removes the
annotation along with the old on-stack pool helpers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 325fd9757dbdd..93bdc7a846bd6 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -155,6 +155,72 @@ static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *prealloc)
 	return prealloc->pages[prealloc->count];
 }
 
+/* Push a page to the prealloc pool. Returns true if added, false if full. */
+static bool anon_pipe_prealloc_push(struct anon_pipe_prealloc *prealloc,
+				    struct page *page)
+{
+	if (prealloc->count >= PIPE_PREALLOC_MAX)
+		return false;
+	prealloc->pages[prealloc->count++] = page;
+	return true;
+}
+
+/*
+ * Top up the pipe's own pool before taking pipe->mutex, allocating only the
+ * shortfall outside the lock, then briefly take the lock to push the pages in.
+ * anon_pipe_get_page() then drains the pool instead of allocating under the lock.
+ */
+static void __maybe_unused anon_pipe_prefill(struct pipe_inode_info *pipe,
+					     size_t total_len)
+{
+	struct page *pages[PIPE_PREALLOC_MAX];
+	unsigned int want, have, need, n = 0;
+
+	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
+		     PIPE_PREALLOC_MAX);
+	have = min_t(unsigned int, pipe->prealloc.count, want);
+	need = want - have;
+
+	if (!need)
+		return;
+
+	while (n < need) {
+		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
+
+		if (!page)
+			break;
+		pages[n++] = page;
+	}
+	if (!n)
+		return;
+
+	mutex_lock(&pipe->mutex);
+	while (n && anon_pipe_prealloc_push(&pipe->prealloc, pages[n - 1]))
+		n--;
+	mutex_unlock(&pipe->mutex);
+
+	while (n)
+		put_page(pages[--n]);
+}
+
+/* Trim the pool down to PIPE_PREALLOC_KEEP, freeing the excess unlocked. */
+static void __maybe_unused anon_pipe_trim_pool(struct pipe_inode_info *pipe)
+{
+	struct page *excess[PIPE_PREALLOC_MAX];
+	unsigned int nexcess = 0;
+
+	if (pipe->prealloc.count <= PIPE_PREALLOC_KEEP)
+		return;
+
+	mutex_lock(&pipe->mutex);
+	while (pipe->prealloc.count > PIPE_PREALLOC_KEEP)
+		excess[nexcess++] = anon_pipe_prealloc_pop(&pipe->prealloc);
+	mutex_unlock(&pipe->mutex);
+
+	while (nexcess)
+		put_page(excess[--nexcess]);
+}
+
 static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
 				       struct anon_pipe_prealloc *prealloc)
 {

-- 
2.53.0-Meta

