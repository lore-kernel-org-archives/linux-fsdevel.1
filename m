Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723957;
	b=q8tymWVaw2H7pgs1PF6r3g9yy2l0WylErXp9PCSTAg1rEpIcWt6GYSfLxcPPVsfn5RTB
	 BdQEzwKTovNgXed42heeDmPjWqoXV5WYES11EndIpKnbJq4H81pg2YTTpqnL4tSKTcl5P
	 OTop9iY2nzZHGz6fpRvKYCneIemYHb71W3zv8A+ccPKQS3kcUz1CpxRkJU5t0VTeBhdBz
	 fW2sRyY82ZsCDcpOvGUokoewRG5LNW5KR/LsOSX9FJO6ZUIc9fBe6IPL1c3lHBAderQoP
	 MomqH6mvXMAx8TP1xeaG8QYrU7dtLq0Dmzr4hVzqFQMf0S8fcE0ew02BKMJzOJQ07Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723957;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U1lxcS3q2M2BGowz3comI0WJhii7k0j7HI0vK6MSldo=;
	b=r4fSXZDXJPJ4sEnMCQUZMLXC2gHLvNqaEObtJGW4rMzv7xmPkSPgK4H1/oMkG9JaMo2M
	 lkyqeyHZ80mX0k0cb0fs2e7JUMGBHwXNxnhfhbWJC8oJ6hJS1a9RUdhwoR78Jj3Mk7K4T
	 uxy6U51thgOIeSZiOyzLanwhuyrZ+XYPtA0l6DOWgFi3eGWDHx9WOHrUqC8xMJ+TIILnC
	 oBsG0XqUq84B8UtIqRTh5aW0V+GjCKeCfSq4Y2dvRITq5SdiR8a7xoaFbLNV6+IStLm3b
	 jBFZ98mDcTd5amrG+XkkJRqT+tDCKqhevlJ0JdvXn4+r1GK06q13g10FtdBSPruGcDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB3fYHuz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670A606A336;
	Tue,  3 Nov 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB3fYHuz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4FF1F00919;
	Tue,  3 Nov 2026 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723956;
	bh=U1lxcS3q2M2BGowz3comI0WJhii7k0j7HI0vK6MSldo=;
	h=From:To:Cc:Subject:Date;
	b=QB3fYHuzgSfjedcjS0LfcKXF0ioqA65RuwWVlcDg7WpTcczrHmM65uT3k0u4ze35N
	 1E5g9k7+zMPWCdkbQ8+LpnE5KupAvVkmuHwvn9TwMOydXMCL7V1I0mDpb4InEDg3hd
	 E8jAuPwLLzesrFO3mzrZrgYBtwz8C+9WcmDphO43+jGDeULi0kz8NvzOLs84qJMokA
	 QnTyJhatn2rKaNZ5/ZLi6+DgW07p44lT0uOvFfCI9DXkxtb0cHV7wZbGtjzIXYbii4
	 NwBBYMPIDl/Lccj+3lAbg761XffyhwQ90et1MhFEizjNQM+bufgJTwkX9Xq/558TfZ
	 3z9StkXbrR5uw==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/proc: cast the PROCMAP_QUERY address through uintptr_t
Date: Tue,  3 Nov 2026 11:39:15 -0500
Message-ID: <20261103163915.640990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

proc-maps-race puts a pointer into the 64-bit query_addr field of struct
procmap_query with a plain cast, which warns on 32-bit architectures:

  proc-maps-race.c:626:24: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Cast through uintptr_t.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
-m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without them now, and the x86_64 builds don't change.

 tools/testing/selftests/proc/proc-maps-race.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index bf4c5073f6fc8..c484a14eb6491 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -623,7 +623,7 @@ static bool query_addr_at(int maps_fd, void *addr,
 	memset(&q, 0, sizeof(q));
 	q.size = sizeof(q);
 	/* Find the VMA at the split address */
-	q.query_addr = (unsigned long long)addr;
+	q.query_addr = (unsigned long long)(uintptr_t)addr;
 	q.query_flags = 0;
 	if (ioctl(maps_fd, PROCMAP_QUERY, &q))
 		return false;
-- 
2.53.0

