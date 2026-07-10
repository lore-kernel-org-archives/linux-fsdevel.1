Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29A3F871E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676018; cv=none; b=TG+QCRar3Ok46OembVJTFXVa2ePyALJ5UR4vPiKu/IEvbfcxELCj4118rxjkeqVJdyqW9MR7jeYFLLEO0v64o6wwBYs6vID7l9WNyfpQ1pGVFPtkJfXZT5Qs6y3/+aDsjfMVeDf1kQA61W0t68jVjvgogTbBuWGPK1FhVR8JeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676018; c=relaxed/simple;
	bh=+MBgYU1GV0umHJMg17ftmyaxlU63xECEjmXgq5k8HHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NhfY41cRHtEuHwiVFREcu57o9matHyu6PQr80Wd1TjFJpWPCiisz2xekSevB7tLLEfcc9gqrY4E9i7CZLjUT7FNzK+B9GAXL36cMykY8Isz1JJsYrxfLPJr28+JDwuuJe7lNIRuaarDLEclV0rDwUlJ/YngD4aQCL18nKCOnE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An4q1j2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An4q1j2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695771F000E9;
	Fri, 10 Jul 2026 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676016;
	bh=iwlYheVG6icIHmdmsNMEBkrrzNe9SOaUJzkR1EUgI/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=An4q1j2GaYhe/VG11utIIbx9ZF3sOE20R2NXRqRhdS54DN/TroTMHWLmwPLDBv29S
	 y1BprT5jdp8tmpe4DdAev4nW+nEEKrWoCqyL5qDaXwLu5u428YlwjFhVWsH2+npjsd
	 EwHM701o3Rr5ZMj/0oC4PVNEqIB+bmcIk9UXDTKTuH7GUaUzoqz66gKsHIeSsxjLBz
	 N+9kxriJZxpeKnSz4bvdyf7QFv/cN3VVVclwCvAn7oZbpcCNaMvKL979chf+Fxai73
	 rIxvEqipoP6/8E2+1sJ6gVdk/1L3FGz8/S/S2wEiJq2TiZGw/8UWq71+H/l1d1sM/x
	 4cfSmT/ZxOFyw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:09 +0200
Subject: [PATCH v3 08/24] binfmt_misc: turn the entry behavior flags into
 an enum
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-8-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+MBgYU1GV0umHJMg17ftmyaxlU63xECEjmXgq5k8HHQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Ilb3TP90MlPzCGiyz/ObrA48e9GotOkRfu2tbae+
 bld2+SmU0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEqtcz/M8W6f0kYPO8bl8G
 /8MHr3l+72/w3fJOubkkXWTe8921X20ZGU4vPL5osahB4sRoZpErPbvOXXlx47pA46po42U5hm1
 tW9gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The MISC_FMT_* behavior flags are macros using unsigned long literals
while the entry bit numbers right above them are now a proper enum.
Move the flags into an enum as well so every flags word constant is
declared in one form and shows up in debuginfo. (1U << N) keeps the
enumerators within unsigned int range which is well-defined for enum
constants and the values are unchanged when promoted to the unsigned
long flags word.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 90962044d19e..98ad1383ba6b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -47,10 +47,14 @@ enum binfmt_misc_entry_bits {
 	MISC_FMT_ENABLED_BIT	= 0,
 	MISC_FMT_MAGIC_BIT	= 1,
 };
-#define MISC_FMT_PRESERVE_ARGV0 (1UL << 31)
-#define MISC_FMT_OPEN_BINARY (1UL << 30)
-#define MISC_FMT_CREDENTIALS (1UL << 29)
-#define MISC_FMT_OPEN_FILE (1UL << 28)
+
+/* Entry behavior flags, fixed at registration time. */
+enum binfmt_misc_entry_flags {
+	MISC_FMT_PRESERVE_ARGV0	= (1U << 31),
+	MISC_FMT_OPEN_BINARY	= (1U << 30),
+	MISC_FMT_CREDENTIALS	= (1U << 29),
+	MISC_FMT_OPEN_FILE	= (1U << 28),
+};
 
 typedef struct {
 	struct hlist_node node;

-- 
2.53.0

