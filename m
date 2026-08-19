Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEF3EC83D;
	Wed, 19 Aug 2026 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181071; cv=none; b=NcknMoU7FrWF6fDfOQUfVZ56cBrwb8rFxlhp2kK/+0mUr7iJOnlYdXpbfJ9JRzwhgScR8tD3kBBl4wgFykJgGqoLdL+CnYTrF9JzwlKNzi+qn5YJi7+ceexyKDIBOZ9l+tFp2jWCw5f0SNhF2rytg+PUdo7/hMQrtJSbGlVFxlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181071; c=relaxed/simple;
	bh=r1vIA9hpNEqv9L3LrgExsab6+Vxj9iHA3Av+wMJZgnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngc2uWhKpgOhf2FHFfOrv9DHIsHk6ZQFMpDf4JRuufgrWilDeeEABlV76b1r8gE127Nfkkbln2CzZfE69B7/N1xyOKDIYgw+xKGf/TkXSofts4JwCCJh6La3PP2aotDeBxTFt1sKdtNGF202E/nzgdI4ELyxAie1H2KkmrmiNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQBRGmLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQBRGmLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECFE1F00A3D;
	Wed, 19 Aug 2026 23:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181069;
	bh=jCUvWFr7gPW9ynmwtqLqLk7sLgqWKyJVLH5+/uw4b/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XQBRGmLyQq+gFdTAfXJTbo4gh1jXQzfreWedQazCzjs87t7/N+VKU6T9W+qUn38ZR
	 j57ezN5YX/+dNb2pl+ZLvK0Hdx+iF15DU/zpG8wiAXOQBlC5VUuqWfpFZaqn3Uavig
	 dFJnnTLx5cHdFsMpBHg/EKrLaUEvdXMD+LnlttUDvAHHSwaOPpXoX4p9rL+k5CqryN
	 K1hxF94nl58Lx3koPf/d5lzpiQ0UavvwTnwGQwI/mWHjlTQoDQiIY90bXwAIm/oMRB
	 PZ8YYwSWT5U6u+c8KAIOOXLW7rxcDRD04zZ3ZosFQdDTa2c/JZkOxNN0sdcFeWyAX4
	 fTcZUi2YIX2HQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:30 +0200
Subject: [PATCH v2 13/22] coredump: add COREDUMP_RECORDS to the coredump
 socket protocol
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-13-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4628; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r1vIA9hpNEqv9L3LrgExsab6+Vxj9iHA3Av+wMJZgnw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+P1N8vecCyR3bxmp9b1X6zrvxbmSh4bm2mgIReo
 naBw8+6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMfsvwTyvFasLKOTm/GH+9
 r9Sv+/7jzp/yNe7FL798/XCbrSXtFj/D/zyvH2/uzv7MNlW68YuvmZ9eikOUSdCrxb8XTmJ5V7T
 EnBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently a coredump sent over a socket is raw data. The kernel knows
things about the data it's sending that are useful for a coredump
server. For example, it knows where the unpopulated parts of a mapping
are. We can't communicate this to userspace currently though.

Add a COREDUMP_RECORDS feature bit and a struct coredump_record_header
so userspace can negotiate that feature. Instead of a byte stream it
gets a header plus data. Reassembling the records yields the same
coredump that would have been sent without them.

The record itself is also versioned and thus extensible with the same
protocol as the ack-req sync.

A record stream ends explicitly. A COREDUMP_RECORD_END record closes it,
carries no data and reports the size of the coredump. It is only sent
once the whole coredump has been written. If it's missing the coredump
should be treated as truncated.

This just adds the infrastructure.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/uapi/linux/coredump.h | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index 662e0468da6e..0bd5c8662ebe 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -11,12 +11,16 @@
  * @COREDUMP_USERSPACE: userspace writes coredump
  * @COREDUMP_REJECT: don't generate coredump
  * @COREDUMP_WAIT: wait for coredump server
+ * @COREDUMP_RECORDS: send the coredump as a sequence of records instead of
+ *                    as a plain byte stream, see struct coredump_record_header;
+ *                    requires COREDUMP_KERNEL
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
 	COREDUMP_USERSPACE	= (1ULL << 1),
 	COREDUMP_REJECT		= (1ULL << 2),
 	COREDUMP_WAIT		= (1ULL << 3),
+	COREDUMP_RECORDS	= (1ULL << 4),
 };
 
 /**
@@ -101,4 +105,66 @@ enum coredump_mark {
 	__COREDUMP_MARK_MAX		= (1U << 31),
 };
 
+/**
+ * enum coredump_record_type - Type of a coredump record
+ *
+ * @COREDUMP_RECORD_DATA: the header is followed by ->len bytes of data
+ * @COREDUMP_RECORD_END: the coredump ends here, the header is not followed
+ *                       by any data and no further record is sent
+ * @__COREDUMP_RECORD_TYPE_MAX: the maximum coredump record type value
+ */
+enum coredump_record_type {
+	COREDUMP_RECORD_DATA		= 0U,
+	COREDUMP_RECORD_END		= 1U,
+	__COREDUMP_RECORD_TYPE_MAX	= (1U << 31),
+};
+
+/**
+ * struct coredump_record_header - header of a coredump record
+ * @size: size of struct coredump_record_header
+ * @type: one of enum coredump_record_type
+ * @flags: modifiers for this record
+ * @offset: offset in the coredump this record starts at
+ * @len: number of coredump bytes this record accounts for
+ *
+ * If the coredump server raises COREDUMP_RECORDS in coredump_ack->mask
+ * the kernel doesn't send the coredump as a plain byte stream. It sends
+ * a sequence of records instead. A COREDUMP_RECORD_DATA record is
+ * followed by @len bytes of actual coredump data. Records arrive in
+ * order and leave no gaps. So @offset is the sum of the @len of all
+ * records before it.
+ *
+ * The last record is a COREDUMP_RECORD_END record. It is followed by
+ * nothing. Its @len is zero. Its @offset is the size of the coredump.
+ * The kernel only sends it once it has written the whole coredump. A
+ * server that hits end-of-file without having seen an end record must
+ * treat the coredump as incomplete.
+ *
+ * The @size member is set to the size of struct coredump_record_header
+ * the kernel knows and lets the header grow later. It comes first so it
+ * can be peeked. Userspace must consume @size bytes and discard
+ * anything beyond what it knows. It must refuse a @size smaller than
+ * COREDUMP_RECORD_HEADER_SIZE_VER0. @size covers the header alone.
+ * @offset and @len count coredump bytes.
+ *
+ * The @flags member carries modifiers that change how the record is to
+ * be interpreted. No flag is defined yet. Userspace must refuse a
+ * record carrying a flag or a type it doesn't know. Every new record
+ * type is raised in coredump_req->mask as a feature of its own. A
+ * server only ever sees the types it asked for.
+ *
+ * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL.
+ */
+struct coredump_record_header {
+	__u32 size;
+	__u32 type;
+	__u64 flags;
+	__u64 offset;
+	__u64 len;
+};
+
+enum {
+	COREDUMP_RECORD_HEADER_SIZE_VER0 = 32U, /* size of first published struct */
+};
+
 #endif /* _UAPI_LINUX_COREDUMP_H */

-- 
2.53.0

