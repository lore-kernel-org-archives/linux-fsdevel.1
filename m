Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D2D3C455C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774454; cv=none; b=MZ3b6nrV1m5PUO9VEPOQeUJxsFWiq8rF/sndIUioN5AyUaIVOVSOrNlstNPE4VdmEfunvXPdKGydCe5AZAXBs7OdbHjzRWi1P+QPwK+Nce7wWAgrSni+hiy8hhkSs1VRiu2ubjtb5NZxuhgCwuPZ54tWpB8LyM48LjfYiffoCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774454; c=relaxed/simple;
	bh=1SAmTNUP4nVa4Cmns0c1YotmbRnHfrbbzSNYTiKm7fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlYhxoFO9oUpGJ1GuJJF2c4pLBxla3fIKhLwsBnW9vbQ/MTC9WKXvaC4m4uGTuHAG4DBu4E/dZKsO0YbNrp8zMa3ks9GsPQ8lLbCS2ofG6Kff4F5SFP3KIv0wnz/7Qg0yqlA4LjEzDoh9edzn3VbDlwelTRIUfAGuaVRhm9lgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LywYZuWj; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LywYZuWj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776774430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VfKEs50cW0lPuEARl3b2ArTLn6HhuVG4Ihm0NRb7E1U=;
	b=LywYZuWjccl/5n0CEITnSI2JOrt+JOPzEYSqe2G6gCgr4NWMW9Rr6T1/GGsdj+KWACBcly
	Re1zRNSvNl83nJe+k+/U9d+ybxpa+/lgyCqjG647M8gJGAnOHIlq+B+mJpIGBInOCmUe73
	0cJiPGduuSYIlp6lR/aCdhaZtHF7GRw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	wangzijie <wangzijie1@honor.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Wei Yang <albinwyang@tencent.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: use strnlen() for name validation in __proc_create
Date: Tue, 21 Apr 2026 14:26:47 +0200
Message-ID: <20260421122648.56723-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=thorsten.blum@linux.dev; h=from:subject; bh=1SAmTNUP4nVa4Cmns0c1YotmbRnHfrbbzSNYTiKm7fQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnPcznY7z0Un+A5Yf2rQvN5MS3h/bMnlf8qEpCRzP+0Y e3Dp2UlHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjARdlFGhl1xz7SYA0uPvvvN 7v9xcsevP5etVp127zx3ee7hKY83LFnIyDAte4N0cKEMw625V6as6GNqm3IndvbPbibziRurz55 mbmMBAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace strlen(fn) with strnlen(fn, NAME_MAX + 1) when validating the
final path component in __proc_create().

This preserves the existing name limit while bounding the length scan to
one byte past the maximum name length. Handle empty names separately,
and treat names longer than NAME_MAX as too long.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/proc/generic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8bb81e58c9d8..3063080f3bb2 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -427,9 +427,13 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	if (xlate_proc_name(name, parent, &fn) != 0)
 		goto out;
 	qstr.name = fn;
-	qstr.len = strlen(fn);
-	if (qstr.len == 0 || qstr.len >= 256) {
-		WARN(1, "name len %u\n", qstr.len);
+	qstr.len = strnlen(fn, NAME_MAX + 1);
+	if (qstr.len == 0) {
+		WARN(1, "empty name\n");
+		return NULL;
+	}
+	if (qstr.len > NAME_MAX) {
+		WARN(1, "name too long\n");
 		return NULL;
 	}
 	if (qstr.len == 1 && fn[0] == '.') {
