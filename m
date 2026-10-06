Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EA3A254C;
	Tue,  6 Oct 2026 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326518; cv=none; b=XuZ3Cwb5Mqf3GeCfvsiwrXr6DKbub7apTQdLexGVgs5J8g7pjIgyRi1iqbc5IUC71MdxvulJBimmKLmeLMNS97LM+glTAJ/SdWNhQjpLuW+ItA2gurEmAfTlmF6TTiyOptRspbf2Z3wp6MgAhzywqwpbci+fNI1qYgN/3ADEQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326518; c=relaxed/simple;
	bh=tYh8LAju9x5gm/R+5i1VOBu2X9zoCdj3qKEBcl/myGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Igopf00uk5Auoop74TnjB9gR7+lI8gCOQvL9oHChZT7NbVpt+h3NU9LD38kN65FzQH9c3ZItENo9XyjgmQpdo1ykHw4qKNMrSoIeE63HGt0Wc+Y+0IudhgtAFaphx+hJdsnYBrC0AzCFD5QN6zZtFhSoV9ylczGIfJhmYOFWm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUuvgWEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUuvgWEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1331F008A5;
	Tue,  6 Oct 2026 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326471;
	bh=042cmRAIrm79Hl5Htgt8e/7zD5iXKGGI0/EF03jkDfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUuvgWEpKzIYtu5q0PqrIYyqvkMSbbWs4Yr2OVqAtUm/o7I+CtdAj9qP9TNXGInga
	 +DlactZZzzOjcQj6TPkpCc5cBvyefoUVL2a4xNsYsWApQLm/41DkBw/JpWdQIgZ/qI
	 J0J+lmq2wtz53iHiCC/ng/GWq59cUj2h/uFvCzgLMIN9d/HHcGChcwbilV1IrMoFON
	 qQL0ePQjx8KHHxXaMEc2gcOiBbNYgDazf9daf1S6bgEHlUt3vySIVQgMNGDymn1UhE
	 +K4bulhcZRdc5lvHJlOgoaDedkXIeyEC0k4VufcbDVGuZAwIuQCnmKbfv6w0y3k0d7
	 fVvPkV+SrgDgw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 4/4] ntfs: document named streams
Date: Wed,  7 Oct 2026 07:40:24 +0900
Message-Id: <20261006224024.14535-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006224024.14535-1-linkinjeon@kernel.org>
References: <20261006224024.14535-1-linkinjeon@kernel.org>
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

