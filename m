Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCF378811;
	Wed, 19 Aug 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181014; cv=none; b=V/CNrW7Dudb1srzCrpIkGoxqaaobuh3+AfqzzQcyRy0MiFCrnn1r+aWD4/shr5oncDe1mLeYxwAdefW2ZKQa8/YEK2nMLvA+Uq6oNhwY/z9Jr2lMgubPe91BCp+8rkCh0Ry5f2dglja6u+wVsuA1QV9zTDddJqgqtysT7XmueBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181014; c=relaxed/simple;
	bh=5Qwhyl+9KLUXcn7sqhHlco4XV14G2yqAc5quiUYCHt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2va+OndrCNwxIkbE7wNVUrb2GxsJUzFEttFBH4LxMQ1lgmvnAPD5nPpE7jucH62IcmAWvHXk5C1Yf2ASJEZlVpz8T71ywxINxdIkaC8jjiTopjV+JxLkPc9KObsnUpsABCtRNp87GugT+C/BKPQXzjH5P1nkDoctuDwEaABCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAI6Ih3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAI6Ih3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ABF1F00A3D;
	Wed, 19 Aug 2026 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181013;
	bh=0RC2YxYzQBAU6npYN6xnbM7sVbfE8POELBDVIx12dQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oAI6Ih3ES/uFGIJgmiQTn7WY/aZkn/AmM5u9fkKnyStjUi5sXMyjRKOtSV5LDe940
	 7wihflb810Z+L9Ww4j7YrE8EejKnI6YrxR4rECv8TzgORD9meFSPK+LjfG/oSYFWLC
	 6vsnvLC4hn1ofgJ7jtXSxaJL35SXJnVtwb4tWWg/egX0jbQmfm7BhPxfbbRF8iiVZw
	 PalTaJOSi03ConwvdOQZfr0rrSv8vPIXC7y4mv38CBQxMR5h4+4LjCxroelASoaXzv
	 9zh1A+0jgLLMWzoIQoZ9mKRhWi/Fo/js7nQJb+oLreuUtRaSdzXx90mtVuRx/bt2T4
	 yPwURA42dZGog==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:20 +0200
Subject: [PATCH v2 03/22] coredump: set the minimum send buffer size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-3-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5Qwhyl+9KLUXcn7sqhHlco4XV14G2yqAc5quiUYCHt8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me8TeBZ77qmlydyE53qlJxOEfibmzdt/tU1OvC3v2
 LHf31YrdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEVISRoVPG1XmbU4xXxda6
 P7ovat3kLVoWdwuXsnMvDFOOcrv1iOEXs+T5eW+uTLjurOJqYFRRsmHCi7ULJ++9HRoYU2ka8iW
 fFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The send buffer of the coredump socket is subject to the limit in
net.core.wmem_default. af_unix uses sk_sndbuf / 2 - 64 bytes for a
single skb. That means a send buffer below that would split a page-sized
write into multiple skbs. Raise the send buffer to leave room for a
page-sized write plus the header. The default value is well above that.
So we really change it when it's below our minimum.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index ac4e922c9cb9..24a6405ea242 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -665,6 +665,9 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 }
 
 #ifdef CONFIG_UNIX
+/* af_unix halves the send buffer to size a single skb. */
+#define COREDUMP_SOCK_SNDBUF_MIN (3 * PAGE_SIZE)
+
 static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *cprm)
 {
 	struct file *file __free(fput) = NULL;
@@ -690,6 +693,10 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	if (retval < 0)
 		return false;
 
+	/* Don't let a page-sized write split into several skbs. */
+	socket->sk->sk_sndbuf = max_t(int, socket->sk->sk_sndbuf,
+				      COREDUMP_SOCK_SNDBUF_MIN);
+
 	file = sock_alloc_file(socket, 0, NULL);
 	if (IS_ERR(file))
 		return false;

-- 
2.53.0

