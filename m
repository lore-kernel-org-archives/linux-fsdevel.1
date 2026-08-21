Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE3481233;
	Fri, 21 Aug 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313154; cv=none; b=lZU/sBgBpLwyPw4vpjMtAAc8v0DyA2qP+XlM3vN2R7vhuPSXOgRvz8Sf8OrtoRcutvBYMzkG377q0t2MnB7Ylm1dbOqJd4y4Um/EA4QwDfQTmLPXy5HmZkY7jtbCf5PG1qriitb/AAaeNN6LMw2MpsuxGwdRpMx0nVOOMfAaP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313154; c=relaxed/simple;
	bh=krg//AleJGD2GFAwzKeE8XxsWdu9P/L1FEEAeAWptmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AoqT1HZKsDTxjelf5cK8ew/Ydb1LWr3skPlr1qUcqr9NQBoxgIOf1w4WppHBMV9Y3CWBmKtzZmQhKLtsxNSsswZkO/0+YZhU8ZarJra6srFDz3nfzPYlWLLNiB/6Qlm+JpvK9daRFuRg4dQAtppdUpSr7re9Ulw02eEHYkYn4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLS0styc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLS0styc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AEA1F000E9;
	Fri, 21 Aug 2026 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313153;
	bh=odR88LvmkXJUel+yfmqMfCEBYRvaMuUJ63+FLM96VQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HLS0stycO+AMv5SgTYnG86o4zJb0Q4K0O/vKTaDKX0YTjKL3oX1a0BrhS2TxtZXhE
	 k/BhT1MSgPWJybaecWgRcgibDdgdA4EykvCtXfRSuLC49ipt9MioJjJEdWj3tCu84V
	 cgk8qJmr+m3N9V/PMgOM4GqMI6n2R9L5Fpniw+YzIJBCXbdRzLWvKO3sj1PCcV3PaN
	 5H4QE9d7a4mlYi+B9Nu2A5i+gA9YFDPlTV8uYWeJC/BhxTDBKHofu+6PJ36IBPL/jU
	 8o9V3Ln8S79g0GpfIvmO9GMHw5Qji3t9Uh+7XxhsZMLyPg99ejFwPl+W3OOg/o/V51
	 n6iBy3ah1RAhQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Aug 2026 13:52:03 +0200
Subject: [PATCH 2/6] tools: sync coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-work-coredump-filter-v1-2-91f9a73ef03e@kernel.org>
References: <20260821-work-coredump-filter-v1-0-91f9a73ef03e@kernel.org>
In-Reply-To: <20260821-work-coredump-filter-v1-0-91f9a73ef03e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=krg//AleJGD2GFAwzKeE8XxsWdu9P/L1FEEAeAWptmI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR1WH88qvizd42RTUDUPZ6uCueJj1L5P/TFPPj3dbMg1
 1Knqt6ajlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkoJzAyrDQW5bnQEBs/+YYr
 1yn2TQxyQjuWO9fcm3W7WOzsTu4LHxgZtjkKxYcK+PxW+RhX0vBxu86WLolF7O02NhdOc65J2/m
 REQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Sync the headers for the selftests.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/include/uapi/linux/coredump.h | 70 +++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
index f3771861ca48..6d0c53b534ea 100644
--- a/tools/include/uapi/linux/coredump.h
+++ b/tools/include/uapi/linux/coredump.h
@@ -16,6 +16,9 @@
  *                    requires COREDUMP_KERNEL
  * @COREDUMP_SPARSE: describe the holes in the coredump as zero records
  *                   instead of transferring them; requires COREDUMP_RECORDS
+ * @COREDUMP_MEMORY_TYPES: dump the memory types in
+ *                          coredump_ack->memory_types instead of the ones
+ *                          the task selected; requires COREDUMP_KERNEL
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
@@ -24,6 +27,37 @@ enum {
 	COREDUMP_WAIT		= (1ULL << 3),
 	COREDUMP_RECORDS	= (1ULL << 4),
 	COREDUMP_SPARSE		= (1ULL << 5),
+	COREDUMP_MEMORY_TYPES	= (1ULL << 6),
+};
+
+/**
+ * coredump memory types
+ * @COREDUMP_MEMORY_ANON_PRIVATE: anonymous private memory
+ * @COREDUMP_MEMORY_ANON_SHARED: anonymous shared memory
+ * @COREDUMP_MEMORY_FILE_PRIVATE: file-backed private memory
+ * @COREDUMP_MEMORY_FILE_SHARED: file-backed shared memory
+ * @COREDUMP_MEMORY_ELF_HEADERS: the first page of a file-backed private
+ *                               mapping that starts an ELF file
+ * @COREDUMP_MEMORY_HUGETLB_PRIVATE: hugetlb private memory
+ * @COREDUMP_MEMORY_HUGETLB_SHARED: hugetlb shared memory
+ * @COREDUMP_MEMORY_DAX_PRIVATE: DAX private memory
+ * @COREDUMP_MEMORY_DAX_SHARED: DAX shared memory
+ *
+ * A bitmask of memory types a coredump may request to be included. New
+ * memory type bits must ensure that they do not steal memory from an
+ * existing one so a coredump server will continue to get the same
+ * coredumps even if a new bit is introduced.
+ */
+enum {
+	COREDUMP_MEMORY_ANON_PRIVATE	= (1ULL << 0),
+	COREDUMP_MEMORY_ANON_SHARED	= (1ULL << 1),
+	COREDUMP_MEMORY_FILE_PRIVATE	= (1ULL << 2),
+	COREDUMP_MEMORY_FILE_SHARED	= (1ULL << 3),
+	COREDUMP_MEMORY_ELF_HEADERS	= (1ULL << 4),
+	COREDUMP_MEMORY_HUGETLB_PRIVATE	= (1ULL << 5),
+	COREDUMP_MEMORY_HUGETLB_SHARED	= (1ULL << 6),
+	COREDUMP_MEMORY_DAX_PRIVATE	= (1ULL << 7),
+	COREDUMP_MEMORY_DAX_SHARED	= (1ULL << 8),
 };
 
 /**
@@ -31,6 +65,8 @@ enum {
  * @size: size of struct coredump_req
  * @size_ack: known size of struct coredump_ack on this kernel
  * @mask: supported features
+ * @memory_types: the memory types the task selected
+ * @memory_types_mask: the memory types this kernel knows
  *
  * When a coredump happens the kernel will connect to the coredump
  * socket and send a coredump request to the coredump server. The @size
@@ -49,15 +85,27 @@ enum {
  * struct coredump_ack the kernel knows. Userspace may only send up to
  * coredump_req->size_ack bytes to the kernel and must set
  * coredump_ack->size accordingly.
+ *
+ * @memory_types is set to the default memory types that are included in
+ * the coredump. This can be overridden by raising bits in
+ * coredump_ack->memory_types.
+ *
+ * @memory_types_mask contains a bitmask of all memory types the kernel
+ * knows about. A coredump server may only raise bits in
+ * coredump_ack->memory_types that are raised in
+ * coredump_req->memory_types_mask.
  */
 struct coredump_req {
 	__u32 size;
 	__u32 size_ack;
 	__u64 mask;
+	__u64 memory_types;
+	__u64 memory_types_mask;
 };
 
 enum {
 	COREDUMP_REQ_SIZE_VER0 = 16U, /* size of first published struct */
+	COREDUMP_REQ_SIZE_VER1 = 32U, /* memory_types and memory_types_mask added */
 };
 
 /**
@@ -65,6 +113,8 @@ enum {
  * @size: size of the struct
  * @spare: unused
  * @mask: features kernel is supposed to use
+ * @memory_types: memory types to dump, only with COREDUMP_MEMORY_TYPES
+ *                 in @mask
  *
  * The @size member must be set to the size of struct coredump_ack. It
  * may never exceed what the kernel returned in coredump_req->size_ack
@@ -74,15 +124,30 @@ enum {
  * The @mask member must be set to the features the coredump server
  * wants the kernel to use. Only bits the kernel returned in
  * coredump_req->mask may be set.
+ *
+ * If COREDUMP_MEMORY_TYPES is raised in @mask the kernel dumps the
+ * memory types set in the @memory_types mask. Zero is valid and dumps
+ * no memory apart from the mappings that are always dumped.
+ *
+ * Note that memory a task excluded via MADV_DONTDUMP is always left
+ * out. A coredump server wanting to add or drop memory types instead of
+ * outright replacing it should simply copy coredump_req->memory_types
+ * and then mask off or raise types as needed.
+ *
+ * Note that @memory_types must be zero if COREDUMP_MEMORY_TYPES isn't
+ * raised. COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of
+ * at least COREDUMP_ACK_SIZE_VER1 bytes.
  */
 struct coredump_ack {
 	__u32 size;
 	__u32 spare;
 	__u64 mask;
+	__u64 memory_types;
 };
 
 enum {
 	COREDUMP_ACK_SIZE_VER0 = 16U, /* size of first published struct */
+	COREDUMP_ACK_SIZE_VER1 = 24U, /* memory_types added */
 };
 
 /**
@@ -90,11 +155,12 @@ enum {
  *
  * The kernel will place a single byte on the coredump socket. The
  * markers notify userspace whether the coredump ack succeeded or
- * failed.
+ * failed. After any marker other than COREDUMP_MARK_REQACK the kernel
+ * closes the connection and no coredump is generated.
  *
  * @COREDUMP_MARK_MINSIZE: the provided coredump_ack size was too small
  * @COREDUMP_MARK_MAXSIZE: the provided coredump_ack size was too big
- * @COREDUMP_MARK_UNSUPPORTED: the provided coredump_ack mask was invalid
+ * @COREDUMP_MARK_UNSUPPORTED: the provided coredump_ack mask or memory types were invalid
  * @COREDUMP_MARK_CONFLICTING: the provided coredump_ack mask has conflicting options
  * @COREDUMP_MARK_REQACK: the coredump request and ack was successful
  * @__COREDUMP_MARK_MAX: the maximum coredump mark value

-- 
2.53.0

