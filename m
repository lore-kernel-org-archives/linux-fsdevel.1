Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786D3F86F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676016; cv=none; b=ndPCBGqrqr0Lv55O3cfW8oQ6Ho4ZG8pFGDEvdpuUyYalUlI6HZV0pNZZVBzQgimH1TvEATeEdoEnlWenddXQOZAKGNpRSsNnR0TODbmfQaXNot/eKXFxf2EPwkWQs+x6dGabNnop3CiYz3jOvZhVjxMuLYmsff6qI3afSQqb7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676016; c=relaxed/simple;
	bh=Dcrt+QSqAlata86DaTvTin1H3ls8seBaxje2cS4eFWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUxclay5s00SRpwZX3kCQE++Ugv1FnK1FjpwS8DZFW0XEfbHEwfX2hRr71ZzZqtEcN0f98oja8T6PJ66cqrNWC02BBiX3wJWhuHkZULKR0Xx+ccGjz314h4JIplHi7cGw8AZtAtpwOAoC0GdDNZl391cVP765HKV5dntfc9Rq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrEvJv4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrEvJv4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973441F00A3F;
	Fri, 10 Jul 2026 09:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676015;
	bh=m89br04tyLYQ4I/MwspJogYMJTjB4GK+VbNn92eUW0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WrEvJv4dawq0XTUD22FYy4GaQKuvTC/DFfO/ZywhSl3RTMbyy28JLhjxg6Pb5zE83
	 qVJqZAkPeTM8ykGx6C+ZXOh/cZ/a47HSJ+K6A3cYEJsZH3UkU6GhyhDSE0yvBY+Px/
	 F8MOCEkRaSrrlE+REf2yqCvlP9EHL/KRFUiQiqONr6EL/ZS0dlEMEaPOiYUQnLm4Q/
	 n0/PAsn/eqjPVnCAv9T8tn5P4YutxcN7E//zAOCHAUoiRx30wEBdLXwv3EtCuFDaQ5
	 LrqQ5rQEVjaz5JvuziSnC1EBUhjzmCaFbpAeLw4EvdAQnXu9bu0i2IPUzJnMLsEiV+
	 9ypru71iVq12A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:08 +0200
Subject: [PATCH v3 07/24] binfmt_misc: turn the entry bit numbers into a
 proper enum
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-7-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3324; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Dcrt+QSqAlata86DaTvTin1H3ls8seBaxje2cS4eFWk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Inr3zDlkv6eQD65A41Bq/TyjwmbnduQbHHFd4P1M
 vEky85ZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ/YWR4VO6zg4H4Y83jp+9
 e2XB4i+/mXX3TbaZVXzIcLb4+7CFkWqMDM9/fzydvY6r0+TfkgkezFV93WZXM8vuWB1Y/v+hYTz
 fTSYA
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
index 0b9758da1f88..90962044d19e 100644
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
@@ -417,11 +421,11 @@ static Node *create_entry(const char __user *buffer, size_t count)
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
@@ -429,7 +433,7 @@ static Node *create_entry(const char __user *buffer, size_t count)
 	if (*p++ != del)
 		goto einval;
 
-	if (test_bit(Magic, &e->flags)) {
+	if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
 		/* Handle the 'M' (magic) format. */
 		char *s;
 
@@ -599,7 +603,7 @@ static void entry_status(Node *e, char *page)
 	char *dp = page;
 	const char *status = "disabled";
 
-	if (test_bit(Enabled, &e->flags))
+	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
 		status = "enabled";
 
 	if (!VERBOSE_STATUS) {
@@ -621,7 +625,7 @@ static void entry_status(Node *e, char *page)
 		*dp++ = 'F';
 	*dp++ = '\n';
 
-	if (!test_bit(Magic, &e->flags)) {
+	if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
 		sprintf(dp, "extension .%s\n", e->magic);
 	} else {
 		dp += sprintf(dp, "offset %i\nmagic ", e->offset);
@@ -745,11 +749,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
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

