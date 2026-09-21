Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7434AA406
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000160; cv=none; b=lYGYcGrARnbIZciwlyRmO7d6O8qXamMBoFRj3QHbj68demrQ+9vnYs0Yf4Lwi54StyAhg4KNbR2hnv7luM8UXB+/fnLtTqG13/Wossuk6VSnfV9H8bxjTqFUGO8GQYQ6ZKlKTmagBV8A6Lc7vwKNuyuL2NLg9EY1GYq7bUusDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000160; c=relaxed/simple;
	bh=h5X/3tQChPuozCtfQeWZ2quV99eEDYpRq7dsPCcYTfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfXFp3iEJqRXWetCghcHfJvjrPUXJNrW+yNUX8hq/k96jYjFagTfaywD6JQL8lqx11ukY2cxue6p//Bf6VUxt8i+NBap6af0yT1SBK4RTjhJGJHK6S37K0bX06R0zlvLC0A66QDTekIsR9a8F3cyP0aZLgOMf0kpjaZSVPZvN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi6njA74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi6njA74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EDA1F00893;
	Mon, 21 Sep 2026 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000158;
	bh=n4v5/LfddgDUf/Nl4eUBwTXOZyY9fAVjANLvZx4ETwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wi6njA74/40x7csp0VqMHNPqUADqp0QZRlB0+BDU46YMKAP9+hLwpSLn/ISAoknPj
	 d2xJGycR9dBDtX/31Ptd0+MG01YbtSjIYSJTiyLNqj8oRrSBsE7pFEKugmfIbf7XUq
	 Ak68GvpIWg+bdvtbrrDsRHyWm9DaI7WbStmaiNc4tKA0uc3nrT8f05CgPTvbZdGeh7
	 mftZSdbic2NrgCW1EbL9e42FlA4Q+vDNHEJh+7dP1nEwHbqp2ukJKbQ3JYGFJBNUQv
	 qHj7t5re5hPVqXJdNrjA8YqA2KihoshsLHv4H4E8MFMMSKCmgNBLch7t9jh1WrKdps
	 PixKUJeNsnEqg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:33 +0200
Subject: [PATCH 05/10] close_range: turn the flags into an enum
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-5-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h5X/3tQChPuozCtfQeWZ2quV99eEDYpRq7dsPCcYTfw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOHRSXtWptDzQsrTKXKftUeWQQKvP6v03NvCv4/sN
 ftivP9RRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETOfWVk2PpY2frFg5z7Qmzq
 uxpnm07oWVd2w+xsfWfaI/lfU1OeRDL8UwybstVmVkat3efzX/6uOindO0126QS+W4c6up76eMo
 c5AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Turn the close_range() flags into an enum. Makes debugging a lot easier.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/uapi/linux/close_range.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
index 2d804281554c..b1b637d74deb 100644
--- a/include/uapi/linux/close_range.h
+++ b/include/uapi/linux/close_range.h
@@ -2,11 +2,24 @@
 #ifndef _UAPI_LINUX_CLOSE_RANGE_H
 #define _UAPI_LINUX_CLOSE_RANGE_H
 
-/* Unshare the file descriptor table before closing file descriptors. */
-#define CLOSE_RANGE_UNSHARE	(1U << 1)
+/*
+ * A macro of one of these names defined before this header is parsed, by
+ * a libc or by a program's own fallback, would replace the enumerator.
+ */
+#undef CLOSE_RANGE_UNSHARE
+#undef CLOSE_RANGE_CLOEXEC
 
-/* Set the FD_CLOEXEC bit instead of closing the file descriptor. */
-#define CLOSE_RANGE_CLOEXEC	(1U << 2)
+enum close_range_flags {
+	/* Unshare the file descriptor table before closing file descriptors. */
+	CLOSE_RANGE_UNSHARE	= (1U << 1),
+
+	/* Set the FD_CLOEXEC bit instead of closing the file descriptor. */
+	CLOSE_RANGE_CLOEXEC	= (1U << 2),
+};
+
+/* Keep #ifdef working and let glibc skip its own definitions. */
+#define CLOSE_RANGE_UNSHARE		CLOSE_RANGE_UNSHARE
+#define CLOSE_RANGE_CLOEXEC		CLOSE_RANGE_CLOEXEC
 
 #endif /* _UAPI_LINUX_CLOSE_RANGE_H */
 

-- 
2.53.0

