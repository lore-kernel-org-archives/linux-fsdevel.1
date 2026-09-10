Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD64BB5BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055347; cv=none; b=sSfA0ekVnhJku9XSuPsmyVJHu4eZdMjl0zZMVfGeDvjrqGaA7t+9HzBBT3t2PYSKewp27Iz2oWKC45t69XpeBYgJvN5veicMZ+ZmjxVyaRJLhUpxJqAPStwK4YxWu+6btLHb0c+TuU6omKHJ6L99fGJGBiLjAKL1/v3NH24JOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055347; c=relaxed/simple;
	bh=neup7ICaOgOYLihbLF8y9EsmEBdbODhV2+JM5dvYnW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGfzmeZn0qSwYP4/jnxk8gjVGsb8Wi5PZv5c0mFhnK6bWmsZ6Asla5LvsN0J8AjRmKUcn/I5TSzDVah3jnibO/RwDIGpSLDQcBY1IPzri/C5ML081YifUe4OtPnASJEvP7ULtleKd6QpyOGp3qrmk4XzUYypKmxCUfCbVs0K61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqfCqpeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqfCqpeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0F71F00893;
	Thu, 10 Sep 2026 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055345;
	bh=LSAPbyLSqSH6TLsiRp8716W8HrJRQsQ1E437qtv0vfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CqfCqpeILz0zMhWy+Ho2cxxzlKucoIs42LjhEZd2mV51oM65+0A2GtuQDeCgKGUtU
	 qhvoTt7wQtYE4LoqO2Tzt/l1xtdDVW8ORrN/fQqr5z9dIEAWaO/MKdOH9K29WUfyjZ
	 hIJyy2OZE+mhZYSnyhhgzotY4w3gDW/rBv/zNVC+R23Dp9o7IhPd9CfBLumlFqW8Hs
	 YWwNNeVvAyUZ+ZqgI6cEsTA04MLnXnogcP7GxdTyXvj/WwnIaBU5XWNKZy7zKPbNzd
	 I+rAy/WYztJ6o528NjSm35mvldGrUDa7puNjtXmesU/P1JWhfGAob/1y/zyXVITHL+
	 HETbJL6EKN5Ig==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:15 +0200
Subject: [PATCH RFC v4 17/18] tools: sync coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-17-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumi3bW7znC3syenszHWZdQ+tbwVOeHrBqtV8p/e0+
 M2Tr1y26ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhItjXD/8QPG/u5WLRMZro+
 UZR4GC+z7t+Vpnmq63JK1+2omhm2S4Phn4qgBOOCzXviNwX+NT/QZmTqbrNJ8Uet9OG7dnYzHda
 sYwcA
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

