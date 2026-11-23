Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411024;
	b=e0zSHOkTQV1Obvp1NXkAxV78+6OVU0tNORjGBplfbCrXFmAUYP057mZ2m+4koHOzuPN8
	 J3UVk5MKUDzQgcUHpl/XrXecczNVSoYejv8WUja8RtbhuM1X685DlbzoKjo94T9dSONFI
	 qTOGNP4ZSAd4JjFD50K9WrYgJfunX3PayjmMjfNXF/OPqhFbnuZ8LhqlR93+iX25MkLJv
	 iyWYabJRRSu6+yI8HpWzmF8HyFD1rO70XeC7GGos9Z6R+rwtNzsW7j0g6XGduOvoClLIm
	 WedDtnKdfKr98/fui2U6H0zg48qARtuPK3eDioUGwTq0IK9lFWzO+IFJM0cmFQoldEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411024;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l7hTPYaQuZs5nowzDqnJXIkZEzk+2TqU+4QHS0z+lDQ=;
	b=2hjdvg0x9F3YEmNGMkAZT+139Oi3rMWLI4bQ/gjT+DybqHkHzvc8nC4RErAJ6Fvf6gaP
	 kRXnOc+IcYC4hZhD68A4WCln10JdQ57LSv9pEE//OzsYDiNMrWLUjHm8tvPpopP8GlNHT
	 hMi+rRpXEOHVwjpTQm/pdYWRfYl1FLlE8/tjSqHBkOwZyz2OTWOlvwOSXZBf/GgPO/IXf
	 UK5x8yKlUPm09D6r7ggRZ3QtmtyvJI8uemKKSkZ31iOWCpfIVyIciQR9cabsIOeub2WQ7
	 raIQQHpMgnWiJIyhLmW3txP1UdXvlaAKxweLz5nf403KgkmGd/8s0JMMiiqNDIhZrMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VM6v+3Lg;
	arc=none smtp.remote-ip=95.215.58.17
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0992606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 05:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0992606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VM6v+3Lg
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2ZEKg+Jrv+kzCPhpX87e5eDbagmnSnp9jrTVnPFquSQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795411021; v=1; x=1796015821;
 b=VM6v+3LgFBxb1Ek0dfJfV0DNwZd1Ll2q4QRrjqvqSwDimdWPIbVwueCN9Wnkrkci6owpWzVe
 cImJ8qDAZycmtyTHi42ktzvUDwxV25ZVBQdaJB0J7GkbOrJHLG6FYFAZYIotcdE/eM0zIlZ5p8Z
 pS6LYlhD0JHzs9rD39qLc/zE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d9d86598382e1741;
	Mon, 23 Nov 2026 05:17:01 +0000
X-Mizu-Trace-ID: d9d86598382e1741
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: hughd@google.com,
	david@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	andrealmeid@igalia.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/2] Documentation: tmpfs: document casefold option constraints
Date: Mon, 23 Nov 2026 13:16:29 +0800
Message-ID: <20261123051629.2547645-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123051629.2547645-1-cui.tao@linux.dev>
References: <20261123051629.2547645-1-cui.tao@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The casefold and strict_encoding options require CONFIG_UNICODE (both
are refused without it), strict_encoding must be given together with
casefold, and availability can be probed via
/sys/fs/tmpfs/features/casefold.  None of this was documented.

Also disclose that both options only take effect at initial mount and
are ignored on remount: shmem_reconfigure() never looks at the parsed
encoding, so e.g. "remount,casefold=utf8-12.1.0" succeeds without
changing anything, the same way as the mode, uid and gid options.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 Documentation/filesystems/tmpfs.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index d677e0428c3f..032fa55b0411 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -253,6 +253,15 @@ strict_encoding   Enable strict encoding at this mount point (disabled by
                   and directory with names containing invalid UTF-8 characters.
 ================= ==============================================================
 
+These options require kernel support for casefolding (CONFIG_UNICODE)
+and are refused without it.  strict_encoding must be given together
+with casefold on the same mount; a mount with strict_encoding but no
+encoding fails.  Whether the running kernel supports casefold at all
+can be probed by reading /sys/fs/tmpfs/features/casefold.
+
+casefold and strict_encoding only take effect when given at initial
+mount; on remount they are ignored.
+
 This option doesn't render the entire filesystem case-insensitive. One needs to
 still set the casefold flag per directory, by flipping the +F attribute in an
 empty directory. Nevertheless, new directories will inherit the attribute. The
-- 
2.53.0

