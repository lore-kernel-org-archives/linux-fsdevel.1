Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E33486B8F;
	Fri,  4 Sep 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519583; cv=none; b=GK3nnXVjEIzk4aLi2WeT0VlWvq6Hx75Mh66WcK0gdaQIRr/V16lQ1BXRYdKd0e0O3CdN4p9uBqWUr5XnE5ibbi/1UczkpMnWm3WGE3R1TDqDZKojWTaCmC9/Ko1CsJj8SnqF2Q1XnuTth/ctsgJLHU9T+JLlFGqTufCbUTJyZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519583; c=relaxed/simple;
	bh=vV1T58b8s1+tve3cVZAubxq64Ua4qR2tbUc3dMYC5Z4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xvd9RI10cFbgp2xhhFb77vCB6i73xImbHd7Nu3hzHOJAe5BLoDz4o/PmL9qeU4zhli3tjaykqhvzRL0WKL1qY43pdCeMatFXvPO0AzRCkseO5JVi5t4VnOthxfYKCcAFmCH1HWL7i2x9yV+mqfJpCpD2S9TfsK3S3HDGKBcvgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=rS+1pSfo; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="rS+1pSfo"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9B0511B5;
	Fri,  4 Sep 2026 11:00:36 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=rS+1pSfo;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 58D9D2205;
	Fri,  4 Sep 2026 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1788519576;
	bh=5otnK8lKNv0CFrblr8NbQa/JL5FxxysDmPvRmnxoP4c=;
	h=From:To:CC:Subject:Date;
	b=rS+1pSfoHbgsl4i7OYPA49Ow6606g9dyOnT/2pHbrE4V7Cbt+wJ7iUFlsdIAskd46
	 Oir+0XY2PXfXPtSthtOHPJLxOzGT/Rejil6QS4btMDjfUAqIkhYhkq7fJGQp3Ab57f
	 pr48qgySY4IOnE+WiPBx6o6hq5h+lw/763E0N2cc=
Received: from localhost.localdomain (172.30.20.203) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 4 Sep 2026 13:59:35 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: document ads, nocase, and delalloc
Date: Fri, 4 Sep 2026 12:59:25 +0200
Message-ID: <20260904105925.11058-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

The 'ads', 'nocase', and 'delalloc' mount options are accepted by the
parser and reported by ntfs_show_options(), but were never added to the
mount option table in the documentation. Document them.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 Documentation/filesystems/ntfs3.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index 2b86a9b3a6de..e1d86dcc3316 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -109,6 +109,29 @@ this table marked with no it means default is without **no**.
        Kernel. Not to be confused with NTFS ACLs. The option specified as acl
        enables support for POSIX ACLs.
 
+   * - ads
+     - Enable access to alternate data streams, i.e. named $DATA
+       attributes. A stream is addressed by appending a colon and the
+       stream name to the file name. Reading the pseudo-stream
+       ``query_streams`` returns the names of the streams attached to a
+       file, one per line::
+
+         cat file:query_streams   # list stream names
+         cat file:ads1            # read a stream
+         touch file:ads2          # create a stream on an existing file
+         rm file:ads1             # remove a stream
+
+       Creating a file together with a stream in a single call, and
+       renaming a stream, are not supported. Enabled by default.
+
+   * - nocase
+     - Perform file name lookups case-insensitively.
+
+   * - delalloc
+     - Delay block allocation for buffered writes until writeback,
+       rather than allocating as each write is issued. This lets the
+       driver allocate larger contiguous runs and reduces fragmentation.
+
 Todo list
 =========
 - Full journaling support over JBD. Currently journal replaying is supported
-- 
2.43.0

