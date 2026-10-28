Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175644;
	b=E74vA7zWRhP09ds3RuxXs1/fZFV0IBPpU6oCbzFA4gjtL7Ei8Dgh6zZ87wWnORxe/1t3
	 MkemMyQwiNFcsaS46qwcrKKtvQdVc3U0FVqza8pRF+fjcHaGyJETQ4nW4izg6fmz/r8Gs
	 /JPdU5aOEF+sont42NzDyloU/kRxNq4vH0NsHYxfwYxyVHGzx13EJYvijPN9Ep/gQEPMz
	 4lr7TGnQqYVo5HldaKQO4y7dqmZrR9RM/7kpALZ1QkrgjhGOLsKMxvEGReWDDEHZsHTBf
	 UGyE5YQbEQSx0d4znm4x5D+6VPYumZ6QDfQ725Qj/SEsvuRp31vLcvA1vjrLUam4kjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175644;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AdVY/3WZr/KgFPIGBWq+6cOVqwnT9WYPit6o2kFUWLI=;
	b=kdarmknCfewb8YOrGc2xbSDT4Fxe7KKif3aIpcAynjlxkK9zvKnu0dtDHlytRCO8K8TS
	 G5FA0+LbfZkbwZRTCs48msr7S3iUVjUb2V247ES1ImE8LEQfBQfIwAX3oC8g8xmAO3BZk
	 sg/zhMw8tk3EJALpzco+ZxJtyVbib/RziVB65BmdqJ3H3ofRQM25pKqNCEztYAby5ws/F
	 7JggMwU8Qsw9rvH0HuN1/7p34/FoywS3G0rjuRNYXOHDhAf0jfTdWZ47suImcc77UUwrL
	 7nNH62tQV19kuhJLi6C2u9a0r4g/+pGn+eZUVnY6qnqOf3s8PT08uIlpEyfwwQykakQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=fRqV9usC;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30960A2606;
	Wed, 28 Oct 2026 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A30960A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=fRqV9usC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793175634;
	bh=AdVY/3WZr/KgFPIGBWq+6cOVqwnT9WYPit6o2kFUWLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRqV9usCJkdMBWrlhWbddwDwn+QiWrVuXXhlmM06WA8hyjUwJjBOQD3oUvn7U51hA
	 cz9ypprvSW6rwhpGQQm90dgUka6nWyEZzu4lfjwdDuK2/cx66TCGAU3CwyclW84k6b
	 EOioxvCx2Rj0sgA/zgEBxG2IHQAcr5/J9BnKuTEI=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 65391FBCED;
	Wed, 28 Oct 2026 08:20:34 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 03/10] lib/list_sort: Switch to __nonnull_args() macro
Date: Wed, 28 Oct 2026 08:19:42 +0000
Message-ID: <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 22302af28d3f ("cleanup: Annotate guard constructors with
nonnull") added the macro __nonnull_args() to wrap raw compiler
attribute.

Replace __attribute__((nonnull)) with __nonnull_args() to
standardize nonnull attribute usage across the tree and keep the
attribute's quirks in one place rather than open-coded at every call
site.

Add spaces after the commas in the __nonnull_args() argument list to
follow the usual coding style (according to checkpatch).

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/linux/list_sort.h | 4 ++--
 lib/list_sort.c           | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/list_sort.h b/include/linux/list_sort.h
index 453105f74e05..48a91ef0d751 100644
--- a/include/linux/list_sort.h
+++ b/include/linux/list_sort.h
@@ -6,9 +6,9 @@
 
 struct list_head;
 
-typedef int __attribute__((nonnull(2,3))) (*list_cmp_func_t)(void *,
+typedef int __nonnull_args(2, 3) (*list_cmp_func_t)(void *,
 		const struct list_head *, const struct list_head *);
 
-__attribute__((nonnull(2,3)))
+__nonnull_args(2, 3)
 void list_sort(void *priv, struct list_head *head, list_cmp_func_t cmp);
 #endif
diff --git a/lib/list_sort.c b/lib/list_sort.c
index ff99203f208f..da34c46cf5d8 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -9,7 +9,7 @@
  * to chaining of merge() calls: null-terminated, no reserved or
  * sentinel head node, "prev" links not maintained.
  */
-__attribute__((nonnull(2,3,4)))
+__nonnull_args(2, 3, 4)
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
@@ -45,7 +45,7 @@ static struct list_head *merge(void *priv, list_cmp_func_t cmp,
  * prev-link restoration pass, or maintaining the prev links
  * throughout.
  */
-__attribute__((nonnull(2,3,4,5)))
+__nonnull_args(2, 3, 4, 5)
 static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
 			struct list_head *a, struct list_head *b)
 {
@@ -175,7 +175,7 @@ static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
  * of size 2^k varies from 2^(k-1) (cases 3 and 5 when x == 0) to
  * 2^(k+1) - 1 (second merge of case 5 when x == 2^(k-1) - 1).
  */
-__attribute__((nonnull(2,3)))
+__nonnull_args(2, 3)
 void list_sort(void *priv, struct list_head *head, list_cmp_func_t cmp)
 {
 	struct list_head *list = head->next, *pending = NULL;
-- 
2.53.0-Meta

