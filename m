Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724863;
	b=NnVh6wJb9gCB064vC92JxRVc8oDuy4feLfWlbk36bKh56h3cFFzjNz/niUHZkPQUYpdM
	 G2woUAFbcnru2KAPCM5oPh0nIutFd86O9caaGHoppisi83L491o3a0Mpk6EFW8KbWS0j+
	 l0ottgTF9bPita+8+eHsPmiiTRVNdOJqiGwsUql88z/PJTiTtkF6OSt6K2KHyyrrsw7Lu
	 wJokzamrf8xtma8BmV1jgPNciMy95iUJ0BZPCPwsrq8bhRfMTOdSwy8aY1i+4Cjumyv0a
	 Pt30r0hLTapHnQPA62n0uqvYUBbM+ORTR7TYqEbY4+s9VefLz55uzNxsx2jbDGlUNEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0wxL6rRTr5TxI9k4bWfQA0MoIQ3omeFKBT3SDFKUMMo=;
	b=ihvBzwnw9j0O3AIRpMG3rMLW0mdFIwQ2A5WSoawAQk8ak0I4RGoyil9pZiAopxkO0v9K
	 nb0UeVQO5aEMe6j1/tWwI1sk6/joIJFZChOXDRXAwcv8vncvDsdaYg1da7I0I/dvLbV+8
	 I7f14aXJzLKl9XO4cmwj+GwSAo4u4EgNE7QWGxUOP0Qjvm3kSgVsMfrbARYMXL9bz9GM0
	 v8cY7yHDy4v2HvrQKeIFz6if68Ewautq6qVdUS+o8b1BDHkXYmr6aYfl7agPFaRQYqtW7
	 uX9BpNQYtVLhqRHLEfjEmXiUwetb61Sq1vtgXjqv0lcUyRTg6jgb+UPw6g1Agu34kyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq+XVB5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB4606A336;
	Tue,  3 Nov 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq+XVB5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A731F00919;
	Tue,  3 Nov 2026 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724863;
	bh=0wxL6rRTr5TxI9k4bWfQA0MoIQ3omeFKBT3SDFKUMMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hq+XVB5x2HiArKSoh5XGsbJNNCRtZbe0OoYaICNobu0IePCMihLcxE1AE7idcLFCa
	 Y/myoGsJC/F4kKi+ZIqR6qe1LlIssyXd5eI/JWNBENfgKdzZU1W/tf4PWymTSO/BtY
	 NmCreYIjd1+FcXaEmk2/joS1Id4VrLI9TS5E850vS1ZmnoPnaCwzpS3GH76dRUKdy+
	 oIv6fcGRHRWDmBpt9JNGoG1X62eaB0usa94on1JpTurzuIJKxa2pR7t2Dgg6P70AJT
	 O3W/F1I0lkDoHnudetCMWs9akmEvT6b0IGaYiSx2P0u5+kDnCpn4ud877wWZnjlNiJ
	 Z8NVbzGRG3EfA==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/filesystems: remove the unused list_del()
Date: Tue,  3 Nov 2026 11:54:15 -0500
Message-ID: <20261103165419.687806-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103165419.687806-1-sashal@kernel.org>
References: <20261103165419.687806-1-sashal@kernel.org>
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

Nothing uses list_del() in utils.c, and clang warns about it in each
test that builds utils.c with -Wall:

  ../utils.c:106:20: warning: unused function 'list_del' [-Wunused-function]

Remove it.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with clang 21; KernelCI's clang builds show the same warning.

 tools/testing/selftests/filesystems/utils.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index d73d7d8171db6..4321f1a552587 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -103,16 +103,6 @@ static inline void list_add_tail(struct list *head, struct list *list)
 	__list_add(list, head->prev, head);
 }
 
-static inline void list_del(struct list *list)
-{
-	struct list *next, *prev;
-
-	next = list->next;
-	prev = list->prev;
-	next->prev = prev;
-	prev->next = next;
-}
-
 static ssize_t read_nointr(int fd, void *buf, size_t count)
 {
 	ssize_t ret;
-- 
2.53.0

