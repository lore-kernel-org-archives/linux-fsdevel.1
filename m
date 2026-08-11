Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDF3B42D3;
	Tue, 11 Aug 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462093; cv=none; b=h/ux6qi5h0FzqESraciOk/yVMXpJ33IKQ5ulXBkKaxQxfuRLwAYwV3U1Rfz7UJVuRZusi6jpDVVFi4UAYpLr3DRH0laSC5Pa3n9n3i1j3HPyLxkGB3/wXtkDYvxCttRLcJgBZ4C7f0l7hKhYaRUkcawoubIDhTKSzgOU2QWzxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462093; c=relaxed/simple;
	bh=J+PQgfbapuFtQu/lpytQUE+OgnnVZmVmxqMxiZbP+d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wm+MKXugBqLtXAjLI6o9LBud7knIeXQfCWyDaWfCdv8WHXe7SDrXyjwxQqK9SbBZtuFHHV5Lv6xbP/sc5jr55A1WkdmVRTyayb3TadWEu5s4YzZ9c+dxlMzX/qvDDL6rMTuA3NLnwapTSm7C02TRkS8nNLZysRhknWrDinYsdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyURzhn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyURzhn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2261F00A3A;
	Tue, 11 Aug 2026 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462091;
	bh=aiM9rGr2K/f+tuwhqreFuuJ12f+/3ydkN5JIi9mR514=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JyURzhn3XjAcnWiEScQi8/UqT34v+EtK9PIWO1aL/xbGqrmROWJlxuawQ0zj2TNIn
	 mdSc/wJ8OfTYPzeqYptne3SwXSLchu3RUnzvlPpxTDzkn1muQi4ffyTX7rOiKYjPdK
	 s17oHqviPs0IapHVaa8XZjLwVrSi9i1FoQDiB4AZeUOQ9vf74614K2symcIzZlpP7g
	 FNAZX2gF7zep15hvcFXHH+B9mcGI6kfqkw3pyoAvFHtWRH6cXK0VOhNzyHgvwfle76
	 z0Duap9AF7aGLxHPkFsLFaGcmL57DPfm16fPErIvs1fgAps8Cm5CteE7lZkR85em5O
	 YkNO1IPzzTU2g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:29 +0200
Subject: [PATCH 08/11] tools: sync coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-8-cd3e8b1e356d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4229; i=brauner@kernel.org;
 h=from:subject:message-id; bh=J+PQgfbapuFtQu/lpytQUE+OgnnVZmVmxqMxiZbP+d8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2yesOSn0Wr63ryk1puDd6yP8mddjJDheC4Qf0VYQe
 z1XPrS8o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIpkYwM2zq2Spb08z2P36Nc
 38D3QKY95OoHz9b5UZqKne8vvJr3jJFhtXfQFe6LqywULm2aulx9YkT3orcy5pd/R6TcOaiZdvo
 QDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Sync the headers for the selftests.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/include/uapi/linux/coredump.h | 65 +++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
index dc3789b78af0..312bafabb467 100644
--- a/tools/include/uapi/linux/coredump.h
+++ b/tools/include/uapi/linux/coredump.h
@@ -11,12 +11,19 @@
  * @COREDUMP_USERSPACE: userspace writes coredump
  * @COREDUMP_REJECT: don't generate coredump
  * @COREDUMP_WAIT: wait for coredump server
+ * @COREDUMP_HEADER: send the coredump as a sequence of frames instead of
+ *                   as a plain byte stream, see struct coredump_frame_header;
+ *                   requires COREDUMP_KERNEL
+ * @COREDUMP_SPARSE: describe the holes in the coredump as zero frames
+ *                   instead of transferring them; requires COREDUMP_HEADER
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
 	COREDUMP_USERSPACE	= (1ULL << 1),
 	COREDUMP_REJECT		= (1ULL << 2),
 	COREDUMP_WAIT		= (1ULL << 3),
+	COREDUMP_HEADER		= (1ULL << 4),
+	COREDUMP_SPARSE		= (1ULL << 5),
 };
 
 /**
@@ -30,11 +37,11 @@ enum {
  * member is set to the size of struct coredump_req and provides a hint
  * to userspace how much data can be read. Userspace may use MSG_PEEK to
  * peek the size of struct coredump_req and then choose to consume it in
- * one go. Userspace may also simply read a COREDUMP_ACK_SIZE_VER0
+ * one go. Userspace may also simply read a COREDUMP_REQ_SIZE_VER0
  * request. If the size the kernel sends is larger userspace simply
  * discards any remaining data.
  *
- * The coredump_req->mask member is set to the currently know features.
+ * The coredump_req->mask member is set to the currently known features.
  * Userspace may only set coredump_ack->mask to the bits raised by the
  * kernel in coredump_req->mask.
  *
@@ -101,4 +108,58 @@ enum coredump_mark {
 	__COREDUMP_MARK_MAX		= (1U << 31),
 };
 
+/**
+ * enum coredump_frame_type - Type of a coredump frame
+ *
+ * @COREDUMP_FRAME_DATA: the header is followed by ->len bytes of data
+ * @COREDUMP_FRAME_ZERO: the header stands for ->len zero bytes and is not
+ *                       followed by any data
+ * @__COREDUMP_FRAME_MAX: the maximum coredump frame type value
+ */
+enum coredump_frame_type {
+	COREDUMP_FRAME_DATA	= 0U,
+	COREDUMP_FRAME_ZERO	= 1U,
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
+ * sequence of frames instead. A COREDUMP_FRAME_DATA frame is followed by
+ * @len bytes of actual coredump data. A COREDUMP_FRAME_ZERO frame is
+ * followed by nothing and stands for @len zero bytes. A server that didn't
+ * raise COREDUMP_SPARSE never sees a zero frame.
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
+ * COREDUMP_HEADER must be combined with COREDUMP_KERNEL, and
+ * COREDUMP_SPARSE with COREDUMP_HEADER.
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

