Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7508339853
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636235; cv=none; b=gVW32455WRFVlkXcTH8i65C82nQNUH2SA77fVzgISXwGPzTgLrLSRYaud1cXgE6eBSStJ0rLmzhNIAEevnLQr6iLXFiULFceWXJf2iMMtJSa1y18EYTz2ByfRLSkkiIf508uZ0Jivpvnt2hwqh6OspacPvtp39VC9fJUEL/Wjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636235; c=relaxed/simple;
	bh=FSfISUu2uiT1hQ4aaqoGKq/dHZb/P7clvTUP8CP6BKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow/hazekArBe29+dnyda0HrPEd2rkaZmKKSMHmsd+bjG0smabczchJd/lTl1uBKMA13GjOLeaUGCjKcgs1DVRtIMYUkH99qbDsKjdk1dvDw08sAF3yafb9n6UGa33Y++3qtxdVzYON8HFooiqkIQYJiyAexBun4i5izyw8MxuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9EQRxo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9EQRxo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F461F000E9;
	Thu,  9 Jul 2026 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636234;
	bh=Ep96HpN2SK4tV1yyd6qS8lQW48a4xg5uE8G8cVQ2aXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g9EQRxo2bEmF3C8XIG6Za4s1fstrqTQQR+kvBk98pzjWdqAw4hEUJ2BgBg8vj62HX
	 DgnHdrGygvBXcHuJq4D0DWNnU8mUcRtxNgkqqB5tRDBQF6Xb6kbHlhG5EwIY6UUp2H
	 nsF+EeXO5fgrc7KekF3kYsabbAI38ieewUZj1TRWbmmawGkuZdNUC0EOgPnRmyraJu
	 4ThDCj+PxO+Y2s0SH0etE5j6Vu3i9ArygEJLGimD23Byw5VLKGITG34Aq5k6N/sbbA
	 rWS3/6OzhJXDGEwEqBeAasRn7wM0MiLNFXSGw52vpuldk3vKXu1RW8MlTMkDjQF4ie
	 YIPfYdRFWykTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:04 +0200
Subject: [PATCH v2 09/23] binfmt_misc: remove the VERBOSE_STATUS toggle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-9-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FSfISUu2uiT1hQ4aaqoGKq/dHZb/P7clvTUP8CP6BKc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHzl3qeZ2tO5/daCta3TkvgW7vaWCdHr8262vcqjo
 F22U/FlRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETEgxn+x3/dVjbvvHTnZe5P
 dWmnQw0vKhr39oVrTY3asWNdY45QNCPDyTOLc1we+sjxaM91f7svcHvA0xdCF3b/eJDVUNIj0b2
 PDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

VERBOSE_STATUS is a compile-time constant that has been fixed to 1
for as long as git history reaches. Turning it off requires editing
the source and yields entry files that only ever report
"enabled"/"disabled", a format nothing has ever seen in the wild.
Remove the pretend knob and the dead branch it guards.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 93d315758d53..947ef6dfd55b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -38,10 +38,6 @@
 # define USE_DEBUG 0
 #endif
 
-enum {
-	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
-};
-
 /* Entry status and match type bit numbers. */
 enum binfmt_misc_entry_bits {
 	MISC_FMT_ENABLED_BIT	= 0,
@@ -607,11 +603,6 @@ static void entry_status(struct binfmt_misc_entry *e, char *page)
 	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
 		status = "enabled";
 
-	if (!VERBOSE_STATUS) {
-		sprintf(page, "%s\n", status);
-		return;
-	}
-
 	dp += sprintf(dp, "%s\ninterpreter %s\n", status, e->interpreter);
 
 	/* print the special flags */

-- 
2.53.0

