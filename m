Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882533F8EA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676038; cv=none; b=Stcnuxh7qn7I+UStG0m4xHUUSsQi0rVCUVXNMsOZt0urO1UZilbXhLwyfWrLBqFerN3iepzU8U9HVqaKWs3Im6zhBo8zZGuV68RUcdeSoVpum9hE6RXkrIV4hwmWqSwTO1piC3uRVDfUEQE9UQE03WDdAGZ+kkCHSa2lMNQ85kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676038; c=relaxed/simple;
	bh=op5FT6KTOFj4auKeOC4UkTSWzUEhg5f38f9n59dfWiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7BkpsjQ+Udl905d/QGf/hW47/eJNMr9AxAgCdOL7cdjwhC2BQqPhoZD/sfgYAk7imcGMNebFXLULOkJcf5IBRWdAubrYuX3mxmKanX9RCATEQquivGPQwtJd6oktA674ES27EcIhEeYrOXidZFyrh/rj9kpSs1SL4MBQtWu8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOGjXkUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOGjXkUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155061F00A3A;
	Fri, 10 Jul 2026 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676037;
	bh=4L+ewyd/DXbi01Z/LJ2w2Zg6TXNholpeEmz+tC5Twp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WOGjXkUusrAH8RHIytLylACCQ+MXGAryQVnLcSJb4+/FZJYFgeNr/USQwWtKYQyYn
	 79DggVuuLRA8yKoCgz/2NAg6vam7ryTZNbkL9i1hQ3rPuca4yabkGmYgqRh6fTCTBM
	 mIKLcHsK1BnIAX8yBT8ZTVqBG03J2je9+rBH97yZ+eSnc/7nLyEr+PoTc9+ayKeuVs
	 kkzVJLIrNR5lTz3sVPBg/v4fxuppbrOVRueAXf2r2PGx8LxVXg+37q6STwe4oq5aFZ
	 LWWgkKUqsort5kGxtSZIjjEYrRk+B/i0JZj1sTaMpvM5QAu5jIw/cP9JTNjrMSrm2p
	 DA7mvCPejCpHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:20 +0200
Subject: [PATCH v3 19/24] binfmt_misc: use a flexible array member for the
 register string
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-19-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390; i=brauner@kernel.org;
 h=from:subject:message-id; bh=op5FT6KTOFj4auKeOC4UkTSWzUEhg5f38f9n59dfWiA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7In/kVv9cIbmhvspmu4xXYc9zfx3sU/Pdq+7fXBVU
 o31Jl+jjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImc+cXwz6Cl48HU+/tOJv1f
 5qq0V0yg9fUbO/n5j/d9W7ylUyN0wi+G/ymntv/8dtvr8RL785+V7pbkWjycYb/6jZljbsDReWe
 t5zEAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

create_entry() allocates the entry and the register string it parses
into in one chunk and finds the string part again through manual
pointer arithmetic behind a cast. Make the layout explicit with a
flexible array member and struct_size(), and give the magic pad of
trailing delimiters a name while at it.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index d9dc9546d199..4cfd3ce5e47e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -59,6 +59,7 @@ struct binfmt_misc_entry {
 	struct file *interp_file;
 	refcount_t users;		/* sync removal with load_misc_binary() */
 	struct rcu_head rcu;
+	char buf[];			/* register string, fields point in here */
 };
 
 static struct file_system_type bm_fs_type;
@@ -78,6 +79,9 @@ static struct file_system_type bm_fs_type;
  */
 #define MAX_REGISTER_LENGTH 1920
 
+/* Trailing delimiter pad so field parsing always terminates at a delimiter. */
+#define MISC_DELIM_PAD 8
+
 /* Check if @e's magic matches @bprm's buffer, applying the mask if set. */
 static bool entry_matches_magic(const struct binfmt_misc_entry *e,
 				const struct linux_binprm *bprm)
@@ -345,9 +349,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 					      size_t count)
 {
 	struct binfmt_misc_entry *e;
-	int memsize, err;
 	char *buf, *p;
 	char del;
+	int err;
 
 	pr_debug("register: received %zu bytes\n", count);
 
@@ -357,12 +361,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 		goto out;
 
 	err = -ENOMEM;
-	memsize = sizeof(*e) + count + 8;
-	e = kmalloc(memsize, GFP_KERNEL_ACCOUNT);
+	e = kmalloc(struct_size(e, buf, count + MISC_DELIM_PAD),
+		    GFP_KERNEL_ACCOUNT);
 	if (!e)
 		goto out;
 
-	p = buf = (char *)e + sizeof(*e);
+	p = buf = e->buf;
 
 	memset(e, 0, sizeof(*e));
 	if (copy_from_user(buf, buffer, count))
@@ -377,7 +381,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 		goto einval;
 
 	/* Pad the buffer with the delim to simplify parsing below. */
-	memset(buf + count, del, 8);
+	memset(buf + count, del, MISC_DELIM_PAD);
 
 	/* Parse the 'name' field. */
 	e->name = p;

-- 
2.53.0

