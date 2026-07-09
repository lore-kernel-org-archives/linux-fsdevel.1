Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA264499A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636231; cv=none; b=aTt1G1dUbYnNwRgSl3XVQJMZaddb6o8uRAw2s/2teas5fRDqz8jp0Ui3gYonUvfyBv8glklq2idugnzl0sLlvy6DsC3S3keHofszbNDWyhIGc8xxsSjYaa7aITqE02j2YXBJBfwqWgYuwUfp3yt+T9PgOp9RV0alRI6aF7AyPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636231; c=relaxed/simple;
	bh=oi6YqCiauhLy2SRVgSkkNzs31bAwl53yzw4aBTbiKnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yap4fB5mzc965llFa0nUxFy7+hMbWs6wI4ZmJHOBaHBsn59W6HtY+wRabWqnWKztjrSHpIR04gb5t5qp9+qSfwCImmypUE5CO/vAEu3WyTY5kWzcjBzIn4QVHpSFzsFiqJDFOej/bvwujeN7mbVn39zE++0p1e7pTZ5/Y+iHvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmlgicS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmlgicS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2AB1F000E9;
	Thu,  9 Jul 2026 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636229;
	bh=TpPIWnB5EGOBygOl5xUSo4Bo31VS4QZB7PjbGgp98j4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QmlgicS2TKnrfmRNI+JacrCDJK6QxRMJ19YOOf83cTetLjtNRQPaVj6OpKpbZFN9V
	 9e+Nj98GnLUcOCQKGOJcWGepLY1JLghFmWFL29iuei8rdVVrcsOFeXP/ky+etVDZyx
	 W1yKKDg0hapQKP0kSh7lzDGpzXBIq9HqWMjLH5R/wH8Q/AcCSiUAfsSdtRjlzpFy21
	 KhNLzbn8XfYOSnsA3CI9EoZiR8ErzjCoA/V0REQN8vKI77WdP5gx7BqhGq9yhQpg79
	 zIBiPAHATlqzdIlEW7jevlw/LNyeenpO0Pd6T9IEeYKkkdgc4BXBcpd71dUFaOWrT3
	 lnZw4VqXXIL/A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:02 +0200
Subject: [PATCH v2 07/23] binfmt_misc: turn the entry behavior flags into
 an enum
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-7-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oi6YqCiauhLy2SRVgSkkNzs31bAwl53yzw4aBTbiKnQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHzNylDesETCJeBm4M8dM0NsDhxNcdpil2u1Z9a3h
 A9To+6bdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExENIGR4Yh98Yk650M58259
 sM92jw+tLRSPrzU3XTJXUvbXMbaidwz/tLY82lX1Yn/3uRdrnTkmqL9Z/fDKkcAVG18ecPj6MGD
 fDw4A
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
index f1ad0bce5af1..c722ee54c939 100644
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

