Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E7466B1F;
	Sun, 11 Oct 2026 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757025; cv=none; b=A70f5Bpg1oJZRtaLC6TTpAiEUiOp2Rz5FuXkHybpIcFV6pGEQmI3neupNAWOmgJkmK2Rvq4metSZSZupK6Ez79IW5yiwNt8+jpaQ8dq2Q8/b6LQTjI6U0VuaDBcmOD6LHLrjTlx5Dpr8Qg60adDnO7v621uv9Q2Ub+pflPDQuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757025; c=relaxed/simple;
	bh=tYh8LAju9x5gm/R+5i1VOBu2X9zoCdj3qKEBcl/myGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0zKQQ5sVzwaXlZhPreSmcIj43mu93Xiurn2CpH2T6JkKTnhskmttyWuZqZryD4d2qylAo2YYhKmlDiHZJeN/y5sgzBDAN7vQCCsGKVRL8hpIQBBepfuTQG3RhWOWaWpYqItQ3u3oqWoNsM432920DFYzgcXVIUxEMz9Wa1HAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6bRdIhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6bRdIhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A3D1F0089B;
	Sun, 11 Oct 2026 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791757023;
	bh=042cmRAIrm79Hl5Htgt8e/7zD5iXKGGI0/EF03jkDfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A6bRdIhgIq/oAX7etWdKQzwgeQ4K+UAGDSfz7k2MFpKOczqUNxQNnlkiY9MaD2rc/
	 9gtWKV+V+RqcVcpLpSOth/k4noOuSa+tlf2mt6pr4GM1RPHQzGHLwtxOFFCXW7UnG/
	 l0anYkB0ll4rBGaRqzHIyRfT+yQlvy/SMjzmRfe796q82lK9T2jiT3tEjQ1KOUCJJ3
	 rRxpw5kjjFznb8PZwm3zSI4yBVXeRtoYgQkwXTNm23cTO61/ren5cvqlLNldlNrmbX
	 pMGZURQgr4DdxqOm9/THDNpbTrfwUVv2cuhT9Xe7yzrM0Cs2kg4kGzLfOwzm/5qFR9
	 65MeDchBDn34A==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 4/4] ntfs: document named streams
Date: Mon, 12 Oct 2026 07:16:48 +0900
Message-Id: <20261011221648.6811-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261011221648.6811-1-linkinjeon@kernel.org>
References: <20261011221648.6811-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the streams_interface=windows mount option and named-stream
pathname semantics, including supported forms and stream lifetime.

Describe the named-stream ioctl operations, request structure, and name
encoding.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 Documentation/filesystems/ntfs.rst | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/filesystems/ntfs.rst b/Documentation/filesystems/ntfs.rst
index 4bfa392daec6..ec329bb142a0 100644
--- a/Documentation/filesystems/ntfs.rst
+++ b/Documentation/filesystems/ntfs.rst
@@ -169,4 +169,38 @@ symlink=wsl|native      Configure how symbolic links are created. Under
                         Linux) compatible symlinks are created. Under
                         "native", Windows native symbolic links are
                         created.
+
+streams_interface=      Select the named-stream pathname interface:
+                        "none" (default) treats ':' as an ordinary filename
+                        character, while "windows" interprets the final
+                        component of a path such as "file:stream" as a named
+                        $DATA stream. In "windows" mode, filenames containing
+                        ':' are hidden from directory listings and cannot be
+                        addressed through the pathname interface. Only the
+                        file:stream form is recognized. Typed forms such
+                        as file::$DATA and file:stream:$DATA are not
+                        supported. The ioctl interface is available in both
+                        modes. The base file or directory must already exist
+                        before a pathname stream can be created. Creating
+                        file:stream does not create file. Removing a stream
+                        while it is open fails with -EBUSY. Removing the base
+                        file while a stream is open detaches the stream from
+                        the namespace; NTFS has no orphan-stream list, so a
+                        crash can leave that stream's data unreachable on
+                        disk.
 ======================= ====================================================
+
+Named-stream ioctls
+===================
+
+The named-stream ioctl interface is available regardless of
+streams_interface. Open the base regular file or directory and use
+NTFS_IOC_STREAM_READ and NTFS_IOC_STREAM_WRITE with a
+struct ntfs_stream request. The request contains the stream name,
+byte offset, and transfer length. Write requests create the stream when it
+does not exist. A failed write can leave a newly created empty stream; use
+NTFS_IOC_STREAM_REMOVE to remove it. This ioctl removes streams, and
+NTFS_IOC_LIST_STREAMS enumerates streams. Stream names are encoded with
+the mounted NLS by default. Set NTFS_STREAM_FL_UTF16 to pass or receive
+raw UTF-16LE names. These ioctls transfer stream data directly and do not
+return a separate stream file descriptor.
-- 
2.25.1

