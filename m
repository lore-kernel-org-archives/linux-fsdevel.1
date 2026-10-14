Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22A3A7F6B;
	Wed, 14 Oct 2026 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018700; cv=none; b=Kn+uEPaeRs8yyJZPX0HKBe89zZ+3qJZifW6m7yhHBdiiLvyx7fjgr+PeyBPk/oyCI3/gxnjRiQl0Wir86YmsBYbHUwBaxxI5jmQw+Cvg9E/5P/9ifIavhKBUnFzoE01zGcYU6inx0BHNLv2FQeapFwQy95J6/1vsi8qrE0ZXDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018700; c=relaxed/simple;
	bh=4lQ5Sx5eapvFuAxuoMSbOM+pGIUQt8vci4S0xngNe4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+SuSsTtTobOb1lULo4OFCefL7q8syQRzSSYDR+fYEg7EyZeZRou5yvDrScZKEgf8qsh0e7QcUEZTeqv9UN4IP0AMDTGv+ihbHtv6aAOqM5fx+iWPDeSLs+F7jBAHbFvmMBK15Lzc8HDZfZ3OuU35i9NijZB37TUwpljmc25DZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTqy5WWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTqy5WWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C681F000C6;
	Wed, 14 Oct 2026 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792018699;
	bh=qToNvMNybkudsYQfWPEnIC7sTonlXsbQFFxH0DQmlp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fTqy5WWw1zgKzedFyERlmcmQiq1A+IZvpmHiyuUBqI7tPzkp8Vuu8sWDEBk6HTz4R
	 NAKIeHhABWvG3zxcwQzZ7Y5lBW/5XAY0VAqbNx1td+U/3GACtyKd2Y0RAthMF0j1YQ
	 VqEQPUMyIGVoMYOnR6HaW2vZu8GJP0occapiZyzP/aCibGeXGtm7ArMc+LvimtiLas
	 DgVL0hHwb8yDr3g/E3btZ0WnVqwas47qkvp2D4iuCExgnqryBeHh85HiD39RuvQL1y
	 XrDyhf+nziEaD27yg6CTmTr0Yb09CN+jU9sfB2tTlJzrk/nl8YC+PKhz1LRuh5pkbO
	 3C8mtSYQhNEuQ==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-fsdevel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
Date: Wed, 14 Oct 2026 15:58:16 -0700
Message-ID: <20261014225818.3457479-2-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014225811.i.852-kees@kernel.org>
References: <20261014225811.i.852-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=kees@kernel.org; h=from:subject; bh=4lQ5Sx5eapvFuAxuoMSbOM+pGIUQt8vci4S0xngNe4E=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkXODnM50iqWR0zqDSamzB9a+Q1dgHZWdNXsgWxu02Nf NNemOHQUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJE1rgx/pcTeBn96/mhp0hWz qfJWf55d5N0ZI6z6YfU6+ZeL2ysS1zD8FbH+xrpi72mXXxryim6bo5YmcEWfm9Mw49GneYd9psm 7cAEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In the very unlikely chance that a seq_operations didn't get initialized,
we wouldn't want them calling some random location. As a first example
user of __require_explicit_initialization, annotate them so a missing
initializer is a compile-time warning.

Every seq_operations in the tree already sets all four, so no new warnings
are added.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_file.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index dc0e8c62d9e0..f0e7e52a0905 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -28,11 +28,16 @@ struct seq_file {
 	void *private;
 };
 
+/* All four are called without checking for NULL. */
 struct seq_operations {
-	void * (*start) (struct seq_file *m, loff_t *pos);
-	void (*stop) (struct seq_file *m, void *v);
-	void * (*next) (struct seq_file *m, void *v, loff_t *pos);
-	int (*show) (struct seq_file *m, void *v);
+	void *(*start)(struct seq_file *m, loff_t *pos)
+		__require_explicit_initialization;
+	void (*stop)(struct seq_file *m, void *v)
+		__require_explicit_initialization;
+	void *(*next)(struct seq_file *m, void *v, loff_t *pos)
+		__require_explicit_initialization;
+	int (*show)(struct seq_file *m, void *v)
+		__require_explicit_initialization;
 };
 
 #define SEQ_SKIP 1
-- 
2.55.0

