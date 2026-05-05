Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00147429814
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984334; cv=none; b=i61XE6scE2amxVdf6fijq4hKwN0U4RP8RSfweaq6JOcDtqQD2CxbpPU8te6jwbQ7j/R2J4tBqpnvUCdS2F/aBZ8vVLlyYUuKuQt/RHxtk0GzZI6CKfX039luUi4poaTohZ02GH+bmWK07pmSJ0m1uuSdJWqPHQcw64FHVO6Zk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984334; c=relaxed/simple;
	bh=hQKRMI9dcGruFwFhlWPrvGsl/UnsK3GKxYSOXyzNMeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lryW0594Z2OmnoDvv7PFXHgqWqqMpARp3UDo0gTk6oNxaCSCgOAijtztFq7RxavY5L8CFZZWRa2vzA+R6r+xRJCdQVZ6kYvCLmif9foYFE+m8t7qYlhoJI/OWSxZq4FgEEcz7/x4UIKfkk7dRVcniYUIM1iLoKMXFEQdwF3NYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 910681CBC3;
	Tue,  5 May 2026 12:32:10 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id na7IHUfj+WmAZAEA8KYfjw:T3
	(envelope-from <dxdt@dev.snart.me>); Tue, 05 May 2026 12:32:10 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v2 2/4] exfat: optimise and refactor filename up-case conversion
Date: Tue,  5 May 2026 21:31:42 +0900
Message-ID: <20260505123144.730782-3-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260505123144.730782-1-dxdt@dev.snart.me>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For better readability and to eliminate potential cache misses during
file name up-case conversion process, replace exfat_bad_uni_chars and
exfat_wstrchr() with exfat_illegal_chr().

Theoretically, by inlining the contents of exfat_bad_uni_chars are
converted to a couple of bit tests and compare instructions, which will
likely be prefetched to icache thereby eliminating cache misses.

However, it is reported that in some cases, Clang produces poor quality
code for the switch ... case statement at the time of writing.

Link: https://github.com/llvm/llvm-project/issues/127365#issuecomment-4362781091
Suggested-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/nls.c | 61 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 7d86fe7f3a8d..68b09a99f8be 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -11,20 +11,6 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
-/*
- * Allow full-width illegal characters :
- * "MS windows 7" supports full-width-invalid-name-characters.
- * So we should check half-width-invalid-name-characters(ASCII) only
- * for compatibility.
- *
- * " * / : < > ? \ |
- */
-static unsigned short bad_uni_chars[] = {
-	0x0022,         0x002A, 0x002F, 0x003A,
-	0x003C, 0x003E, 0x003F, 0x005C, 0x007C,
-	0
-};
-
 struct exfat_upcase_ptable exfat_def_upcase_ptable;
 
 static int exfat_convert_char_to_ucs2(struct nls_table *nls,
@@ -80,13 +66,44 @@ unsigned short exfat_toupper(struct super_block *sb, unsigned short a)
 	return exfat_lookup_upcase_ptable(sbi->vol_utbl, a);
 }
 
-static unsigned short *exfat_wstrchr(unsigned short *str, unsigned short wchar)
+/*
+ * Allow full-width illegal characters :
+ * "MS windows 7" supports full-width-invalid-name-characters.
+ * So we should check half-width-invalid-name-characters(ASCII) only
+ * for compatibility.
+ *
+ * " * / : < > ? \ |
+ */
+static inline bool exfat_illegal_chr(const unsigned short wchar)
 {
-	while (*str) {
-		if (*(str++) == wchar)
-			return str;
+	switch (wchar) {
+	/*
+	 * Control characters
+	 *
+	 * This saves some cmp instructions if the compiler does its job correctly
+	 */
+	case 0x0000: case 0x0001: case 0x0002: case 0x0003:
+	case 0x0004: case 0x0005: case 0x0006: case 0x0007:
+	case 0x0008: case 0x0009: case 0x000A: case 0x000B:
+	case 0x000C: case 0x000D: case 0x000E: case 0x000F:
+	case 0x0010: case 0x0011: case 0x0012: case 0x0013:
+	case 0x0014: case 0x0015: case 0x0016: case 0x0017:
+	case 0x0018: case 0x0019: case 0x001A: case 0x001B:
+	case 0x001C: case 0x001D: case 0x001E: case 0x001F:
+
+	case 0x0022: /* QUOTATION MARK:    (") */
+	case 0x002A: /* ASTERISK:          (*) */
+	case 0x002F: /* FORWARD SLASH:     (/) */
+	case 0x003A: /* COLON:             (:) */
+	case 0x003C: /* LESS-THAN SIGN:    (<) */
+	case 0x003E: /* GREATER-THAN SIGN: (>) */
+	case 0x003F: /* QUESTION MARK:     (?) */
+	case 0x005C: /* BACKSLASH:         (\) */
+	case 0x007C: /* PIPE:              (|) */
+		return true;
 	}
-	return NULL;
+
+	return false;
 }
 
 int exfat_uniname_ncmp(struct super_block *sb, unsigned short *a,
@@ -139,8 +156,7 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 	}
 
 	for (i = 0; i < unilen; i++) {
-		if (*uniname < 0x0020 ||
-		    exfat_wstrchr(bad_uni_chars, *uniname))
+		if (exfat_illegal_chr(*uniname))
 			lossy |= NLS_NAME_LOSSY;
 
 		upname[i] = cpu_to_le16(exfat_toupper(sb, *uniname));
@@ -231,8 +247,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		i += exfat_convert_char_to_ucs2(nls, p_cstring + i, len - i,
 				uniname, &lossy);
 
-		if (*uniname < 0x0020 ||
-		    exfat_wstrchr(bad_uni_chars, *uniname))
+		if (exfat_illegal_chr(*uniname))
 			lossy |= NLS_NAME_LOSSY;
 
 		upname[unilen] = cpu_to_le16(exfat_toupper(sb, *uniname));
-- 
2.53.0.1.ga224b40d3f.dirty

