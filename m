Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A83DA5D9;
	Wed, 22 Apr 2026 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861245; cv=none; b=GbiU/yazUUuzznszNeFKUqvsQG3/Y9lq+jtyuQYsJCVw+4ilwqQRqGivCnusAZz3DE51KOlO5rdpth1tbO6Cq/cPv+zBWAoVfzoHUGCplmOY2/o6CV3CvfKHNh/NUUZcA5afox8tylUyYWUMcqpu5ymV0Zk+ZKvtCP342ZratBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861245; c=relaxed/simple;
	bh=/HrVpyGFW+njbwKRn41kwXDM07sN7zR1VVs91JJBY78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPcq0ERR3SwY7CF70KZZrb5eGxKNWhzd8ca6O7VUg4FZ7NiNpOE8P5bBkZFOM7yY5OeO3qEKZFTAtIwYEiw8EXPrmKUQkfXt21ToQ5YKQ7IpstEmag6vfBqnNlN42glZl56G0mStsKzEmsBJJVTcF3h923Zh0TSRT8gEOKRsPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aaWKNLmj; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aaWKNLmj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776861236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Kc86s3mtOezS6sduXRpeNvIwMzFmJztt349ea0Gft0=;
	b=aaWKNLmjKuxF1riyOV2JimLb1wvD6S4Sn8w6Q5naMYhDJ9y+dRHK5vUX3PEg1nf7fx39mi
	rdHGkvLzgBndMC6b1UXnJQAnOkvB1Dx93s5A62ZezQGCuBFAtGetYj6bCh8O+rcoSbkCGj
	AE43n6mqFXAkk+/pxfBC66VwszSVHwY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dcache: use QSTR() instead of QSTR_INIT()
Date: Wed, 22 Apr 2026 14:33:46 +0200
Message-ID: <20260422123345.100436-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=thorsten.blum@linux.dev; h=from:subject; bh=/HrVpyGFW+njbwKRn41kwXDM07sN7zR1VVs91JJBY78=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkvDmju/cqQNHve22X66wJMm3QZ95hPr4h2rvNlzWLgP PZ2B4NERykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzEdhkjw4H33p4pXxQjGASS 3nW8PiWTlJjAetDHfm6AaMGSlECJk4wMncH804rLLvc1bubK1tKf1SOYmZIQyKWc9aikOXqvmDg 3AA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the hard-coded length arguments and use the simpler QSTR().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/dcache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2c61aeea41f4..c5536da1634d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -89,11 +89,11 @@ EXPORT_SYMBOL(rename_lock);
 static struct kmem_cache *__dentry_cache __ro_after_init;
 #define dentry_cache runtime_const_ptr(__dentry_cache)
 
-const struct qstr empty_name = QSTR_INIT("", 0);
+const struct qstr empty_name = QSTR("");
 EXPORT_SYMBOL(empty_name);
-const struct qstr slash_name = QSTR_INIT("/", 1);
+const struct qstr slash_name = QSTR("/");
 EXPORT_SYMBOL(slash_name);
-const struct qstr dotdot_name = QSTR_INIT("..", 2);
+const struct qstr dotdot_name = QSTR("..");
 EXPORT_SYMBOL(dotdot_name);
 
 /*
