Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795394122;
	b=HXu3dBqK57+PVWi49CspJXKiWoVIgzL3FpLM6RSrQaDDOgML3V9zBWKAiShXijGSKG9p
	 Yb2ZZlfU5kFFBR3VTgcMqBmVFh7QR7lk8097+UBU7mVyPfg3JDdFS42QrSObE3lOYaLh8
	 8nSFFAjZE+txMJg0pvUT17KndzrKPPw2LxRaRMtfR7mUtSf/GLEduq1ZFKUr14PiM1iNb
	 Y0Y7w6xSAhKD0I6QZqaIItGYP5NVqrbpPpRD7S0gWLeXXYJQSTtDYVG1uUQ2iLAWWuFO+
	 jC5pvPdDokrx5NuUGdis2US5aaMbBPzSxP6lAL1f7WnXEqVAl3ZGqGzrHB20kVP2kag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394122;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gQB8IK1b/xYXcMQGxGk0o/WwdPaO6iLlyEsVf0P+2VQ=;
	b=3JiEoO0lpcn0MWhl55IExco87iEuwTFS0eia2UICCB3xBbUKw6H0+ybkA+p9ST+fE+gt
	 54p9tuy5/GA8JzJTY2BJ2VgZlCfjJZhYPJeEEXOaq1Tsbfewnv8WCbV1vQtfAOj1yJOlv
	 UxLsuf1AFexME3B7ZVr8zvcl1N7sJW0UtYjmqs7gLLdg+ZLzX+rRu53EzW54unRjsImKn
	 ccnDe9tS7XECe8F3+uvHH2h1TbWEMsc5k57AKpwN+KRCgqpysU39TpzFS3wC9mDp0k2mD
	 gFw56jWhoC3/+5sdMngx6Wfi+dh9w5cZ4eFhcAkQQ0Cal3XGa2hGxJRsmzXVHeqtXtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0Fgclo1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC03606A31E;
	Mon, 23 Nov 2026 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0Fgclo1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795394121;
	b=DhXB6EzFGHEO/CYTJWDxtyEjGEjJcxEyK2BfHlxO8BF4/WDhd92uWnshwQ8A2hQsHLH1
	 Z0cRK8sFomjGhns4GLFz0tr1iE6PRjig+eaS3XzvjyJRqUrOPcAK/b/IG5YW4fBf8KIYd
	 fLJlDoka93muWks6L3yanx3JYDkV27qgV78BF2+wSrLkOg4fkDl8vakqZlAKaFvE+fZ/i
	 lGgw9g3rRZ34cd9t2EEW01N48rOTtiyjqrN0J3yEsUK5PgXqfwTI0n6M2utq3264+vVOP
	 AKkXwXVNhdCag0jTr3Nygl52vrAblF2Ohp6vTq8bmEOc4xUu2jTzfN9zsCnbwk5DAcg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795394121;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gQB8IK1b/xYXcMQGxGk0o/WwdPaO6iLlyEsVf0P+2VQ=;
	b=vwzRcl7Y5BBeEwZ0UT0ZJBms9v52Cw9+Ii4NyI93gJd/5eznxlf6mb7Qv0ByMQ3gk3mE
	 oz60AIuXfNBHD8w7KqouTCbP4mfIGEGGo4RtoWqXHDMyEbze/lgDLVGrzCqKnUKwAFwNl
	 SLUey/4SBtYWO7VLkQFTMNfLMUt6VhzWSRzEzdhgzRgmPw6H1K+N23Sk0r2fa8DfN33uk
	 SRu9ESe/5YZzzEmQb1v00j+9lKJmGX3e1QGLkeEWHHRFoDxm2VCJw/v4yKeY0Pva7VAaK
	 7ezfPk7FLvTlsXYl1ojNfNrhyooGMp6HrFrJYv9XqMveMi+blK/b/ImqKxZcY8IWWtQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D3961F000CA;
	Mon, 23 Nov 2026 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394121;
	bh=gQB8IK1b/xYXcMQGxGk0o/WwdPaO6iLlyEsVf0P+2VQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K0Fgclo1w2tFgD9BibZyDNMasM3CSUfszyTxfjG65KnhmS7waydUBNcft+i+j9T8E
	 LI7kJZHJXmacdAiq6QDVk5uUwMK/DEp/7asUeCi/4T1F4Oh1aM18EFxDP9VCDFRTFR
	 yQwBf61A/xdLvnyo8ypMdcyv916r4SI52ElQuUps2my9zwZeKEcblj5TVDjz6uMygj
	 XjQeM817Hh4ahXN45Dl0r3CLB8pNCtJl5UJbide/85kMx8u1pv2EQS5JVBvfNvrO5X
	 tHign9EXnqU0fWDdSHmGgscFLHGWNNFAJ/6EHKRGV9dHQ4FfoloGdSHjYaOLrfpFbU
	 kHmSq0Uk9zSgA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8A1364C26D;
	Mon, 23 Nov 2026 00:35:12 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Sun, 22 Nov 2026 19:35:13 -0500
Subject: [PATCH v2 2/2] sched/wait: Pass wq_flags to
 __wait_event_interruptible_locked()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-sched-wait-intr-head-v2-2-4a764b64e8ce@columbia.edu>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
In-Reply-To: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795394112; l=2225;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=roZMgbnlfY7Z0LN5dKGYogcKymzGcKkdtpGYCk/T+Jo=;
 b=xrysl58p2Ru8qL/I34WaiTlZ2Jjlmo/1OMOvsM2VNL7THSVyD3N/OCDGp5pMp2Ksr7eY+X8KH
 qunO9+E8kDRAfZ4Y/6VV4B2u8uLcrt/ykpUfKJ1YllQaWphsSXSRhno
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

Commit cea5f91daa3a ("wait-event: clean up the internal helper
arguments") made ___wait_event() take the wait entry's flags instead of
a 0/1 argument for whether it is exclusive.
__wait_event_interruptible_locked() still takes the 0/1 argument.

Pass wq_flags here too, so the _exclusive_locked variants say
WQ_FLAG_EXCLUSIVE rather than an unexplained 1.

No functional change.

Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
 include/linux/wait.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index b3e94c71cd3e..6c039d92c770 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -770,12 +770,11 @@ do {										\
 extern int do_wait_intr(wait_queue_head_t *, wait_queue_entry_t *);
 extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 
-#define __wait_event_interruptible_locked(wq, condition, exclusive, fn)		\
+#define __wait_event_interruptible_locked(wq, condition, wq_flags, fn)		\
 ({										\
 	int __ret;								\
 	DEFINE_WAIT(__wait);							\
-	if (exclusive)								\
-		__wait.flags |= WQ_FLAG_EXCLUSIVE;				\
+	__wait.flags = (wq_flags);						\
 	do {									\
 		__ret = fn(&(wq), &__wait);					\
 		if (__ret)							\
@@ -870,7 +869,8 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
  */
 #define wait_event_interruptible_exclusive_locked(wq, condition)		\
 	((condition)								\
-	 ? 0 : __wait_event_interruptible_locked(wq, condition, 1, do_wait_intr))
+	 ? 0 : __wait_event_interruptible_locked(wq, condition,			\
+						 WQ_FLAG_EXCLUSIVE, do_wait_intr))
 
 /**
  * wait_event_interruptible_exclusive_locked_irq - sleep until a condition gets true
@@ -901,7 +901,8 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
  */
 #define wait_event_interruptible_exclusive_locked_irq(wq, condition)		\
 	((condition)								\
-	 ? 0 : __wait_event_interruptible_locked(wq, condition, 1, do_wait_intr_irq))
+	 ? 0 : __wait_event_interruptible_locked(wq, condition,			\
+						 WQ_FLAG_EXCLUSIVE, do_wait_intr_irq))
 
 
 #define __wait_event_killable(wq, condition)					\

-- 
2.53.0


