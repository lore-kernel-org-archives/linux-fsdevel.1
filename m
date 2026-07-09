Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBE3B0ACE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636229; cv=none; b=QmM9hgLn0zAUoadpCeaCSZ7PSDewn29Ux53jc6sK9F5L0iEBnfZZ/5QbUu93BYlMiEb52qgBfG2ecI3jREgRgoX6PIVBtyCVSRPCdPV88pN7TgM/4l0Ffz8DgcczX735NOld9Jdjbdk0w9OBK1sPk46L6jF5uaolmnHWjhuYV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636229; c=relaxed/simple;
	bh=z9QHeXcMB2NP6cxIN0CnxHAFiQBh0+c9XtYMXdoWbAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1pHw0TRYPonFpzUVI66AQmkZtYhxomy0eykQKOp9YLqdzN4N2GRg18nDsDdJcJB70DgTvt+RTJPS0pZ/fYs02ywuoBuiqWT5BHVQEm95J70jfD9w+NSEMSOk3jwx6P1iGm6Ncbwx9G+N4LJDDP1B5yishWKTaH8I3Nx07a/R50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqw7KnIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqw7KnIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F871F00A3A;
	Thu,  9 Jul 2026 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636227;
	bh=7TfSZ6IW6EVUOTLu+a8V1x8AdtgO5MINp4HOFsWyE98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lqw7KnIf+yaT1BLIPiQxYYc0ifpBkl6XS0pK/SzC1m2NVk7pvpRJNYxIIcDALVOzt
	 DlRtmQvp5JNG1YWpIZFE/WZ7JYUib0C68wNTVk638OtyJbcxxmIw6ZCmRpIFlH9b8P
	 NQ4gUv4OiN7lC3j/tp854fUUpZqXVq2aee+OgMkC9dLM7xM9uJ6KhxlmEPh4WGX3pQ
	 aMaFXQlzENRj9+O5futEOWTZzHDWRzHnFXGfVxMc4X+JZv1mM70waslwOB3VQG9Mm7
	 L7rMFQQFYFgzKEUEicSaKpEKeOOtq7HL07MVznfqosRDrua1K0jWXr5MRrsrQc7ufy
	 n0jCzCczmCt4g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:01 +0200
Subject: [PATCH v2 06/23] binfmt_misc: turn the entry bit numbers into a
 proper enum
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-6-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3324; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z9QHeXcMB2NP6cxIN0CnxHAFiQBh0+c9XtYMXdoWbAc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHydXqOVJjcpw7O28pyvsvQC9cvyrDxplqYv+N6Eq
 vie2FzWUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHpakaG58oefqs03fUv/Uz7
 23je9vT7jfa5W/rshasvztn9tb/dluGvcHjLObFTcVcn+u1Za8tqmfy053DL1obDl7mfrb2y6tw
 xJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Enabled and Magic are bit numbers in the flags word of an entry but
are declared as bare, unprefixed enumerators with implicit values in
a style that predates the git history. Give the enum a name, explicit
bit numbers and namespaced names and use BIT() instead of open-coding
the shifts when building the initial flags word in create_entry().

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 2a9025627f6b..f1ad0bce5af1 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -42,7 +42,11 @@ enum {
 	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
 };
 
-enum {Enabled, Magic};
+/* Entry status and match type bit numbers. */
+enum binfmt_misc_entry_bits {
+	MISC_FMT_ENABLED_BIT	= 0,
+	MISC_FMT_MAGIC_BIT	= 1,
+};
 #define MISC_FMT_PRESERVE_ARGV0 (1UL << 31)
 #define MISC_FMT_OPEN_BINARY (1UL << 30)
 #define MISC_FMT_CREDENTIALS (1UL << 29)
@@ -104,11 +108,11 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
 		int j;
 
 		/* Make sure this one is currently enabled. */
-		if (!test_bit(Enabled, &e->flags))
+		if (!test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
 			continue;
 
 		/* Do matching based on extension if applicable. */
-		if (!test_bit(Magic, &e->flags)) {
+		if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
 			if (p && !strcmp(e->magic, p + 1))
 				return e;
 			continue;
@@ -413,11 +417,11 @@ static Node *create_entry(const char __user *buffer, size_t count)
 	switch (*p++) {
 	case 'E':
 		pr_debug("register: type: E (extension)\n");
-		e->flags = 1 << Enabled;
+		e->flags = BIT(MISC_FMT_ENABLED_BIT);
 		break;
 	case 'M':
 		pr_debug("register: type: M (magic)\n");
-		e->flags = (1 << Enabled) | (1 << Magic);
+		e->flags = BIT(MISC_FMT_ENABLED_BIT) | BIT(MISC_FMT_MAGIC_BIT);
 		break;
 	default:
 		goto einval;
@@ -425,7 +429,7 @@ static Node *create_entry(const char __user *buffer, size_t count)
 	if (*p++ != del)
 		goto einval;
 
-	if (test_bit(Magic, &e->flags)) {
+	if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
 		/* Handle the 'M' (magic) format. */
 		char *s;
 
@@ -595,7 +599,7 @@ static void entry_status(Node *e, char *page)
 	char *dp = page;
 	const char *status = "disabled";
 
-	if (test_bit(Enabled, &e->flags))
+	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
 		status = "enabled";
 
 	if (!VERBOSE_STATUS) {
@@ -617,7 +621,7 @@ static void entry_status(Node *e, char *page)
 		*dp++ = 'F';
 	*dp++ = '\n';
 
-	if (!test_bit(Magic, &e->flags)) {
+	if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
 		sprintf(dp, "extension .%s\n", e->magic);
 	} else {
 		dp += sprintf(dp, "offset %i\nmagic ", e->offset);
@@ -741,11 +745,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 	switch (res) {
 	case 1:
 		/* Disable this handler. */
-		clear_bit(Enabled, &e->flags);
+		clear_bit(MISC_FMT_ENABLED_BIT, &e->flags);
 		break;
 	case 2:
 		/* Enable this handler. */
-		set_bit(Enabled, &e->flags);
+		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
 		break;
 	case 3:
 		/* Delete this handler. */

-- 
2.53.0

