Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A231E84F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585338; cv=none; b=QxQ9HN86jP+iPOUCRxySP3q+BoVJThFzDkI+V0E8s12BLmEDz4l9IxAzUW27J8C9CwRkA6MkGcBXKZwmMN4scAxxXb3KNnAc/Hj6t+Prlx3bKjo+IEeyWdDCkFUrdyAZHLqSLco0LSTGtWaYLl7yvrCgfzrFbk4RnHSToO/koj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585338; c=relaxed/simple;
	bh=neup7ICaOgOYLihbLF8y9EsmEBdbODhV2+JM5dvYnW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTQMFF00OnFRKp1ycL2tRF6A2nuUj2V0pRDFODZRVVfw00qRPJLCagfnSadvBevtdh/5aeFgD0554HKUg9X32fCJMscU97fUw30tigiR8S+BvuTm3/m//RQJcBNH3ng/sbFReFfYxr5f141XB00mWBy0HkJR7cFo3lOkXKT5Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQxNs6F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQxNs6F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3E01F000E9;
	Mon, 24 Aug 2026 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585324;
	bh=LSAPbyLSqSH6TLsiRp8716W8HrJRQsQ1E437qtv0vfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UQxNs6F7NCl+uXnZtGfMUH3qq/JPJqfiNu05qxobF1TB4VcC+zvDiTR1Q8ViCjo2l
	 2q4rAu55edNMjUlrP9m+2pLCWOtohffuAvOAsRNiJvPkxwFUzZ7KWFvGsOHCW3PoyM
	 DrvSjhUjeN0S4y7dQ4GhCXpIR34JU3/ElhhJuDBpdI04+jMaRHLlcbAxQFiA0HTQay
	 +bzM9yD/OsdPF3PEpSqhy8kp2RtIaCtgJOIyB4TJZIFoP0mTjRFIk4CvwlOPmjZzOL
	 96jrLnGITah9OM1QbIPv3wfxiEft3bBXw1lRnjxUfdpehSVEUycCxnZm1DdDPehXe+
	 6EqwIfsqbqQXw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 17:28:20 +0200
Subject: [PATCH RFC 6/7] tools: sync coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-work-coredump-unlock-self-v1-6-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=brauner@kernel.org;
 h=from:subject:message-id; bh=neup7ICaOgOYLihbLF8y9EsmEBdbODhV2+JM5dvYnW0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEsdZZl/kuXQxtJTvwz5Mo1zDn1geRF+LPE5Q87K2
 VNSfzhbd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkiQojw/YHO01iD5+a+i6n
 S+rfgZKlsj1p9kr+m4LL3v9439QUcJPhf4BN4lnnzod6iaXfPLLC5xyz71O3Dr758I4f60eG2Ze
 MmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Sync the headers for the selftests.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/include/uapi/linux/coredump.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
index 6d0c53b534ea..ec09d7ab0131 100644
--- a/tools/include/uapi/linux/coredump.h
+++ b/tools/include/uapi/linux/coredump.h
@@ -19,6 +19,9 @@
  * @COREDUMP_MEMORY_TYPES: dump the memory types in
  *                          coredump_ack->memory_types instead of the ones
  *                          the task selected; requires COREDUMP_KERNEL
+ * @COREDUMP_CLOSE_FILES: close all file descriptors of the task before the
+ *                        coredump is generated; incompatible with
+ *                        COREDUMP_REJECT
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
@@ -28,6 +31,7 @@ enum {
 	COREDUMP_RECORDS	= (1ULL << 4),
 	COREDUMP_SPARSE		= (1ULL << 5),
 	COREDUMP_MEMORY_TYPES	= (1ULL << 6),
+	COREDUMP_CLOSE_FILES	= (1ULL << 7),
 };
 
 /**
@@ -137,6 +141,10 @@ enum {
  * Note that @memory_types must be zero if COREDUMP_MEMORY_TYPES isn't
  * raised. COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of
  * at least COREDUMP_ACK_SIZE_VER1 bytes.
+ *
+ * If COREDUMP_CLOSE_FILES is raised in @mask the kernel closes the file
+ * descriptors of the coredumping task before it generates the coredump.
+ * The task ends up with an empty descriptor table.
  */
 struct coredump_ack {
 	__u32 size;

-- 
2.53.0

