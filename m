Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411007;
	b=mqrdDufb10G4m1jKQr9WNlx+A7l5s+C8IuLZdPPcJJd+oNvJVIB2Iegu7K4gFaXvgLlh
	 0int7V9K5zPlAKOzWzNOkHX/PikztwxXPKAcjqxHQrUMeYGWdkycTsnvUAVbiw+4aA2GC
	 zCpQ0V8oBkXoGQDjkXmjSM2jA4OT3TOKuU/WrHjQfdbIOe3FLS/hwKzT7Cx04YcJZkWdx
	 SRzxHXg1CPv31VJEgidqHKbct6DVIKfYePjWbLC+aOa1o/kQzJLjCL6U9pcpv5AzaRiY6
	 KT6dyFMoAJfAgZHMWn1Yu2NsPCjElbgWvYXq75UT9FEoWWxjLbHMiFQtM1NUQsNUctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411007;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ATtbdInCTfCLTMOr7GSbNivMP7bT/TsUu68gzYudVls=;
	b=xAQU44BoA2xXUod+sFuSNo3QMyHbo+/hKbzPChgXgFEcVF8uq0a+T5O2vy9t76i1IH8Q
	 nUCR5yRxhhcqlxD4ikwwAehyfUDKTvJ1QfoDRtWyhRUL3xdetrnaRlqgvnsHmrD6H0a0J
	 zhrAQxLsegf8bsKqshzYTkFvdAGRGZ3tx2eca3X39X52xTxWK9kvaPZkLJ9urApU8rPiz
	 p2m/b91kj8RR4Ws0UcEgnRHBl3/5U/3gS9diK7p30sL4JlpWWsOx7vaY8ZDUer4kf9LIm
	 ALNt0RAqqYUJm5mcECVhS37sxAVZ0MuhcQ7xbmPZJolDIl0fK+BtCCK9yptdY625thQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qBXXpIpR;
	arc=none smtp.remote-ip=95.215.58.9
Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA62606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 05:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA62606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qBXXpIpR
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4ZVQu84GIhvyCFBAaRbAzEUdagqqwSKzjRDGIZcVneQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795411004; v=1; x=1796015804;
 b=qBXXpIpRoEH0/5sLMDtF5f1T8vbxYlouvNobBVVxs9O0EtUr1qJIcw9jy0sQKCVEpsxPy1iQ
 thpP6wBcy0C/nPUTU75XaV465u8YME6O4VffO4elBkxbQGND2kAS39fblMfwib45emdsDLQIehQ
 ln4ZAzZk2gouGCM6v9+xnrxU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b4f2a7d411dd012f;
	Mon, 23 Nov 2026 05:16:44 +0000
X-Mizu-Trace-ID: b4f2a7d411dd012f
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
Subject: [PATCH 0/2] tmpfs: fix casefold flag inheritance and document mount constraints
Date: Mon, 23 Nov 2026 13:16:27 +0800
Message-ID: <20261123051629.2547645-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
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

Files created in a casefold tmpfs directory inherit the
directory-only FS_CASEFOLD_FL flag, which shmem_set_inode_flags()
then rejects with -ENOTDIR on non-directories: the inode records a
phantom F flag, so the value FS_IOC_GETFLAGS reports can never be
written back and attribute changes via chattr fail, dropping
NOATIME/NODUMP from the same request.  The casefold mount option
constraints that commit 5cd9aecbc72c ("tmpfs: Add flag
FS_CASEFOLD_FL support for tmpfs dirs") landed with are also
undocumented.

  - P1: mask FS_CASEFOLD_FL for non-directory inodes the way
    ext4_mask_flags()/f2fs_mask_flags() do.
  - P2: document the CONFIG_UNICODE prerequisite, the
    strict_encoding pairing and that both options are ignored on
    remount.

Testing: on a VM with CONFIG_UNICODE=y, before the patch a file
created in a +F directory advertises the F flag via
FS_IOC_GETFLAGS and chattr +i on it fails with ENOTDIR; after,
the flag is not recorded and chattr works as usual.

