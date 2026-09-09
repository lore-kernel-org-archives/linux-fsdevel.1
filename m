Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2D57ED9B
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969218; cv=none; b=P2FlK0qCSInjZBALtgRIy1Y8bFJ9B/y3JE37PRZ2hyW0dEdN5r+SLLWipF++7ONTU7n5IhsNKN3eUBANzY53Gu3CnI0QeHVG2lL5Uaj5aR9gW/CK7HObqNc1GWbQJ+7ouwe2xG1k3GHbC/zi3kpnnnMcDPDQ4i+kHmLKOV5p1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969218; c=relaxed/simple;
	bh=neup7ICaOgOYLihbLF8y9EsmEBdbODhV2+JM5dvYnW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WO6bBXjj6pJd8BUD8VV58QNB6RaFFYXZ3AkgfO3wU2yLYrEtT7f4IdDqxcCvoaaR0Gq3U3C2pbf++CQ3AXt+RsRcslc2YYQBEwFCpqCMn2c0KlZwoLCwvil4R3CUB1cqwQ0yjwp2i9U+9itd8lryJ7eY9YSSFv3wVQ+x+oUBW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWTblmVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWTblmVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022F71F00A3E;
	Wed,  9 Sep 2026 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969217;
	bh=LSAPbyLSqSH6TLsiRp8716W8HrJRQsQ1E437qtv0vfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PWTblmVqloVggD0mja5uNsVLsCCius6/5IbDtCjivZebsVauU8XDh0n8yoqnrHrE0
	 etoXZUkUBoZ0c5yGFgGmC3+mUmpvWdoIM9CgDVHTT0w2qHN6v/9W8fQO41lB+Y3F9K
	 hX9RtW8JuQptrW3Ohr3pi2QrNtvKxyhM24lj5vEr7h07KkHiti6XVRDZGAvaW/1NsU
	 aaRwPGDVVapaWIjEzPGzdLaB/ZH4fm59AQYWu7JR36Y1kACToy2yam5QYmZn+WojGX
	 FsKlgq1DAF7TIM9QcaAgRAq+6oLHNAiW+1lebZkdsKRk3t7aJbzjUJO9pMw34w1AwQ
	 x1CBICsKttbDw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:57 +0200
Subject: [PATCH RFC v3 14/15] tools: sync coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-14-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=brauner@kernel.org;
 h=from:subject:message-id; bh=neup7ICaOgOYLihbLF8y9EsmEBdbODhV2+JM5dvYnW0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLj6w2a6b8bHwMkmx7s/Xn0hntS9jF2iYUaR1qeTl
 i66Gg4POkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayzIDhn9LKz4eLRUR+nd52
 4O4UZv79R5WmfJE0+LFgc/JC6bfb1s1l+Gd63iun7vRqQZHfnZeFHsyaprBE5fZDzbp3/IdiL6+
 9ZskPAA==
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

