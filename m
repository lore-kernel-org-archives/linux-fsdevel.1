Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765837C909;
	Tue,  7 Jul 2026 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436756; cv=none; b=WjWqZgpY2ktpjlouzklDcwdiJPXnITVAwPrcODIlshJwKz3lxgHSrufYAeslb5ry4hz8TyHRi/ZOtok3U+AwTbz0DU5FWvVTLXLOJp2GKfUABN8Syv3b1O2rLCPph/baep9xX8BSre6TFbxj8zYNAhFud/z6McQxSDf+oGBYZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436756; c=relaxed/simple;
	bh=AbZH4nllsV6apoCaU6RtXAKD7jAYNPsXOgS4dss6vuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXFupCElU94qpIbs8kTWwV+61Ih0ateOG61+GSEVfwUv29zrnZNNV2uaGGB8RuafMaRZHo6VTuafFfZE1emBKpeUlNqoamPl5BnkIuLd3QlxCP5DcFdZB45f7QZs6qN7HAz3bD//I8QpSSoq73x3h8UU89yq4X2f9+j9kELzfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=emojtA+q; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="emojtA+q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NfmqnMcXbLe2TgDwAEVmu/J8pQJNy3Fz3kSVpgDHw4Y=; b=emojtA+qiyKPMdeDoB3Vz+MiBl
	gTCdAcU/Pi7yN4yUOFaZSV8KphfBH8F+PX1c0WRVRYwezQT5+GwglifuixMOoq90t64LkdtL/8uS2
	6ubQWC0UMArgS5xUz9wG0KlSG8ej7D8te7YpQHk/wMrSeo5RPrNyAusjHrGrzyYuveMMtK9YDd56q
	Jex+kTMRamC98Rzjpf4VpzwZ0sx35lb1wBWI+Dzc6fGW3DAhzTYxn9Jq8vy9ZGiVxsq8aWhdLl49N
	5ObFBiFFdRvqr4YQP4sBYcKZ99VHhAmmPsf2Q+3wUNnViLlccsRXJPvaxvqn0rVD7Vx0MOn38JDYs
	tHHRkPmQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh7Mt-002Gso-0Q;
	Tue, 07 Jul 2026 15:05:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 07 Jul 2026 08:04:59 -0700
Subject: [PATCH v2 2/4] fs/pipe: add per-pipe pool push, prefill and trim
 helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pipe-unification-v2-2-eb52bddeeefd@debian.org>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
In-Reply-To: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3221; i=leitao@debian.org;
 h=from:subject:message-id; bh=AbZH4nllsV6apoCaU6RtXAKD7jAYNPsXOgS4dss6vuM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTRXCSCNVrE642iTEZlml41zqhwZQhQKcZ3rGA
 /IIi5SVdVGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak0VwgAKCRA1o5Of/Hh3
 bX2WD/4ttHdyTMt7nyKVfWEkEQi3w9AOjFUO8ASFwcRys9oOLc5mm+RpP6rwoX4sYA7x+fOgACi
 IZX1+arZ2CuNVjbEMqQCbRp9bLaW0S3+cRSVL8eJbwWvzv2pICJ2b3WvG+1BoILGFTtDfrXorlS
 awCR+qQVsjgAXP0rTEpQsOraa6xMxAg+BzddDezffpiUrvSv0w9n4A9VSFwn03G90MjijD1XP3I
 StUShzJ//DXDUA/N5G3/AbfRn7ecrLf6nx//cB6NMsW9hyo8iFqfjanqH4M4zx44ZEKNAQqbnME
 Lzgabycp9OYjQHSWLYTkaDB7aLk+3oHK/Xx7UEr142HCTqB3edSjRKfxDLU0VI+tabn6goNr6bb
 iASszKlAqQ8Bz09d7PcQJihv6dBTOkip+DALUkNNq3LOzYJTs9sQKQe/qdMBqh96rmvLrq22pbz
 pHKs54TFjfCiaFXVdK6gm2whTKuYvMrXZRtCuvXIBS225MfZij0gtUmdZqM+TA1VWTyxpT1gcMF
 xO1CoL5uVnx0aLkcGH19pD8AL8eWYA/s+TrPTKHTisOisbsec/rYC6s5KS5kXIfsk9FNfGLU3k5
 o9S+nNp8+yuovXMYvuQDmmhhGTUsgZEoVPIiZxdjdPBbd5ZNazpnlM+ax/sr4Vnq+xRbsiyNblq
 v+YTCUc8Wxon7rw==
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
 fs/pipe.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 325fd9757dbdd..240fede27542d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -155,6 +155,78 @@ static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *prealloc)
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
+	/* Unlocked read; the pool is refilled under the lock below. */
+	have = min_t(unsigned int, READ_ONCE(pipe->prealloc.count), want);
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
+	/*
+	 * Just flush any extra page that got affected by the TOCTOU
+	 * effect
+	 */
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
+	/* Unlocked fast path; the count is re-checked under the lock below. */
+	if (READ_ONCE(pipe->prealloc.count) <= PIPE_PREALLOC_KEEP)
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

