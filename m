Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68ED3F7869
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676036; cv=none; b=S00qU0tT3+/UnAk+NpBQshe3VLOQrGmMdR4QBOlzcEis4Qzt1CkwNda8roQV2mIVbHjMkV9nN8BcHHb7oIGSvj9kCqygpOZB/gG4RM60phniRLZB8bTOyXJ92d/AtIJMaUVB7gZZz9r4Je/MOgtGXWSC0lMVTUV9m+NoUcZajjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676036; c=relaxed/simple;
	bh=JtQhDe27O2U+ZmKmCXJomowDYtVwErLVfhHki4PCl94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaSRvYCKp0SQUAN/Nj5vvvaohm7QXih6ra+bHsCf58fHdQA/jLr6u+zgaI7L86Twpmn09JZQx+MwP/bu/O5jGp0KppDLb5GlUT/Z9P+sUK1yjjXfq2BUuppylhq4FxIzo0Wroo1z0axHFqLXenJyHeWoWSAh1rrrXm+MLfTr5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcmdBwVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcmdBwVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4344A1F000E9;
	Fri, 10 Jul 2026 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676035;
	bh=h2zpwyUcEr/QbPM9WrOrK2LoYTyvNqLM5laWV7rkoLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VcmdBwVs0lS00LbjDRFH0RgJkW9rxnzcfZkk2WRAOuYxJiLkShmc7+K2ZE6do9Ar4
	 YD1+iRukJ+AGZzumc2eHlCvRUdCuFED/NuxxRwgdPbcdu73qwri4J3XfF8DNMMWOCG
	 VcSDWYrPm3O+z/sd2NCu7eZddbxRvVRPKYtKksb1XJD2+ru+gP1xt/iUF0nqRlBXNS
	 W4qm1eWaTUsoCG1NoOh5epYllLKncIP2c3gCmqTJrlRsnChCxMqtHXudQ6UMURmGzS
	 Y37FgCqoQ8DprXOMjIQu/aeRT8TNERbEdmhDh1G6aN+hSAMzf98SWv9VjEdnXAa4mT
	 AFrC67RbBU+FQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:19 +0200
Subject: [PATCH v3 18/24] binfmt_misc: simplify check_special_flags()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-18-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JtQhDe27O2U+ZmKmCXJomowDYtVwErLVfhHki4PCl94=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Im/ans90NhHIXMlB5vFQh6eGpVFHjfLlNob7Vpu3
 ffaENTSUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJESTkaGhV/eHGTZJ3PH+33K
 QkY1sf79v6fxRWz9eOvnv+NSF2vF/jMyTFw67/f62f9mVxx6VpX+IP2uqtyqCd4LA6e/UNl4/+m
 d+3wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Replace the cont flag and the pointer increment repeated in every
case with a for loop that returns from the default case, and shrink
the multi-line 'C implies O' remark to one line.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index d6bc2abc4a7f..d9dc9546d199 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -309,43 +309,31 @@ static char *scanarg(char *s, char del)
 	return s;
 }
 
-static char *check_special_flags(char *sfs, struct binfmt_misc_entry *e)
+static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
 {
-	char *p = sfs;
-	int cont = 1;
-
-	/* special flags */
-	while (cont) {
+	for (;; p++) {
 		switch (*p) {
 		case 'P':
 			pr_debug("register: flag: P (preserve argv0)\n");
-			p++;
 			e->flags |= MISC_FMT_PRESERVE_ARGV0;
 			break;
 		case 'O':
 			pr_debug("register: flag: O (open binary)\n");
-			p++;
 			e->flags |= MISC_FMT_OPEN_BINARY;
 			break;
 		case 'C':
 			pr_debug("register: flag: C (preserve creds)\n");
-			p++;
-			/* this flags also implies the
-			   open-binary flag */
-			e->flags |= (MISC_FMT_CREDENTIALS |
-					MISC_FMT_OPEN_BINARY);
+			/* C implies O */
+			e->flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
 			break;
 		case 'F':
 			pr_debug("register: flag: F: open interpreter file now\n");
-			p++;
 			e->flags |= MISC_FMT_OPEN_FILE;
 			break;
 		default:
-			cont = 0;
+			return p;
 		}
 	}
-
-	return p;
 }
 
 /*

-- 
2.53.0

