Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60F3A5E87;
	Tue, 11 Aug 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462083; cv=none; b=cYmgzsmw+jLXTsx7j8EnVAvEQGmEz1RrG1Opzrh6xxec+wkDpxdUk4b5I4XoQS8PkbZjv2QxUaYFzeec8HCkAGouClFpXp95FOEmQYgr1wnXn0Vtup5ef4U6ogdzCXt9b5H71ijDftEV8hHCsvkQzzhM/Wc3Bj9w2jgVvAObNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462083; c=relaxed/simple;
	bh=4FXENe5nZxm7CHrTOSbNbye686t9axb9imZneIuX9U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCsE8gMh7g6fg8Go2rYKfKBk+kDAjsGtfWVH1y58HX40px/M7jSrDfT5w+zhV82ZNi2TctHn7RoNCM+ljiwXfDaByjaqrdAViBRlR70P9zsiIlDs2ae6tB+tZverXec9KhlGU4o46MgN7ohTlMCZnItDrc5GBtMysE2LgFWoIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/KBwQ1I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/KBwQ1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987271F00A3E;
	Tue, 11 Aug 2026 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462081;
	bh=/2uicMp+SuinB5ktmPhmPvncPAci8v0nQIiqA6W9Fok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K/KBwQ1IHDI1MDYbS7fTsikWbe5KElyxN/AOhZjB5jkNBJTG70ZUanaSe8f+D+AeE
	 N6IKOnLUHHMI54GonNTKAyrWgAlqa6UI0MNe3OwL7GXH+7UrZi8FL8C/JxTP98qeZ3
	 P/hjhDhdyLH0DO/j9njjDI47FbiDrexz407HbGf0WfRTgR2jHrAzZNFjWLo9vmPQP2
	 4AHPVTdesd58QdKSTnuWIzPnAQhxI5FS4OPrgZMg8ohXAhHrioU7+nWPf1+XM6FReW
	 y83+xskJ48xIhl4L4mU6138/NG4e/goXvR9nvqU3of/Pchf/EuFjK9THikQsZU50B4
	 OAIXpFzja6ZcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:27 +0200
Subject: [PATCH 06/11] coredump: add COREDUMP_HEADER to the coredump socket
 protocol
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-6-cd3e8b1e356d@kernel.org>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4FXENe5nZxm7CHrTOSbNbye686t9axb9imZneIuX9U8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2yf0HnkQcXbK/a87tu556aPKp3xmncz5ap7feTlT/
 2x6/qrTqqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi9YUM/yNC4s4dnV+zc/qq
 Tqb1J9e7VuvNM9zOq+t/7+JdEellDzcy/JUVU40XFa5cXPSh9oT/9bi7AVusjpifVM+5/H6OkzF
 /NSsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A coredump sent over a socket is a plain byte stream. The kernel knows
things about the bytes it is sending that a server might care about. For
example, it knows where the unpopulated parts of a mapping are. We can't
communicate this to userspace currently though.

Add a COREDUMP_HEADER feature bit and a struct coredump_frame_header.
Userspace can negotiate that feature. Instead of a byte stream it gets a
header plus data. Reassembling the frames yields the same coredump that
would have been sent without them. The next patch will introduce a first
feature.

The frame itself is also versioned and thus extensible with the same
protocol as the ack-req sync.

A kernel that doesn't know the bit doesn't raise it in
coredump_req->mask and a server may not raise a bit the kernel didn't
advertise. A server that doesn't know the bit never raises it and gets a
plain byte stream.

This just adds the infrastructure.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/uapi/linux/coredump.h | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index 662e0468da6e..5252480d3eec 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -11,12 +11,16 @@
  * @COREDUMP_USERSPACE: userspace writes coredump
  * @COREDUMP_REJECT: don't generate coredump
  * @COREDUMP_WAIT: wait for coredump server
+ * @COREDUMP_HEADER: send the coredump as a sequence of frames instead of
+ *                   as a plain byte stream, see struct coredump_frame_header;
+ *                   requires COREDUMP_KERNEL
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
 	COREDUMP_USERSPACE	= (1ULL << 1),
 	COREDUMP_REJECT		= (1ULL << 2),
 	COREDUMP_WAIT		= (1ULL << 3),
+	COREDUMP_HEADER		= (1ULL << 4),
 };
 
 /**
@@ -101,4 +105,52 @@ enum coredump_mark {
 	__COREDUMP_MARK_MAX		= (1U << 31),
 };
 
+/**
+ * enum coredump_frame_type - Type of a coredump frame
+ *
+ * @COREDUMP_FRAME_DATA: the header is followed by ->len bytes of data
+ * @__COREDUMP_FRAME_MAX: the maximum coredump frame type value
+ */
+enum coredump_frame_type {
+	COREDUMP_FRAME_DATA	= 0U,
+	__COREDUMP_FRAME_MAX	= (1U << 31),
+};
+
+/**
+ * struct coredump_frame_header - header of a coredump frame
+ * @size: size of struct coredump_frame_header
+ * @type: one of enum coredump_frame_type
+ * @flags: modifiers for this frame
+ * @offset: offset of this frame in the coredump
+ * @len: length of this frame in the coredump
+ *
+ * If the coredump server raises COREDUMP_HEADER in coredump_ack->mask the
+ * kernel doesn't send the coredump as a plain byte stream. It sends a
+ * sequence of frames instead. A struct coredump_frame_header is followed by
+ * @len bytes of actual coredump data.
+ *
+ * The @size member is set to the size of struct coredump_frame_header the
+ * kernel knows and lets the header grow later. It comes first so it can be
+ * peeked. Userspace must consume @size bytes and discard anything beyond
+ * what it knows. The same way it deals with struct coredump_req. It must
+ * refuse a @size smaller than COREDUMP_FRAME_HEADER_SIZE_VER0.
+ *
+ * The @flags member carries modifiers that change how the frame is to be
+ * interpreted. No flags are defined yet. Userspace must refuse a frame
+ * carrying a flag it doesn't know.
+ *
+ * COREDUMP_HEADER must be combined with COREDUMP_KERNEL.
+ */
+struct coredump_frame_header {
+	__u32 size;
+	__u32 type;
+	__u64 flags;
+	__u64 offset;
+	__u64 len;
+};
+
+enum {
+	COREDUMP_FRAME_HEADER_SIZE_VER0 = 32U, /* size of first published struct */
+};
+
 #endif /* _UAPI_LINUX_COREDUMP_H */

-- 
2.53.0

