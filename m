Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890691;
	b=eXsf1NDfhQnTcvZQqtPLLcoYVShQt2+QIA2FkAYdHR6G3cng5JhagsCX38SbmFXzpOlZ
	 gCR7/IAyTTRDFBHAEUphQLFKA8DYlJnVQP6zuHvB9C1jL6oKba2zK93RSlSHyQssBmpX7
	 xKPEg1RxAUmD8P0hwH1N41xjSNNs102vdzUpMz+Qz1fVbfZtYr7Jhqn5uLKq3HajKSBtU
	 r3QtWjUO6/9/SJ6kRtnFNR6weAPVRbuEm+HuYq3rEvb8Y3Zb9mfG7EXiyktT6MNYc1tIT
	 W9oGIvGqNb7Of2M+X8LTv2ZyllSA84OZ7fjG6enIhQO79AoyDnw8Uu3X2wj5YQvIOKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=K/YG+aq9tXklCRb7yDJeFE3l+WkDZoCBNu+6Hf9fIm8=;
	b=Tja8wEgRp37QjLA3/hPCAECQPgGUPonmLUipxwj9xDuyt0U+MavXlILdU1FBXsPLoEoW
	 /uYjUpbAPWdMl5OIQjw2G/7iaJATTwc3T/Xm1UB3FcA5S8xaHqQ5RqDK3TBLugfM2L01t
	 lfcVuVfvBp1CtVAWlHRxIi4q9v2D7TgAsbW8kdcl3++r3dkeYx5WLMU3DkY7odkocDCqT
	 jbYGYNXQm3xaBNfwSVomblLHGnUHL1iBRg0h62pXpzjb5B34fji7wpT2Itwehb1ZhicDU
	 bGORyITvawk239jiEqJj9PSD9JO3j6JSH+YPEpd6Tqa/yOpv4u8x1Wc+U4xhBwkNIYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Abp9Kx9Z;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D06082BC3
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 767D06082BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Abp9Kx9Z
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-83bbcfba0ffso1346940a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890690; x=1794495490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/YG+aq9tXklCRb7yDJeFE3l+WkDZoCBNu+6Hf9fIm8=;
        b=Abp9Kx9ZxNrYDvhuglxqLHmemMfbrR189lq8yhUDVpNUPsVUlBMqMHkb3wzhkQrIe0
         DMKRvb2qGKckX7FMWndMwmGJ4bfFc8TpgLgxpmFCQVKYlJ25V8+1HFuEjU/cA/nzbZPL
         /7wfJaupRI3GBTX79MpDaeqXPuvCfL71YDiAOLk/w4sX3eg6FVBVEJN1OECDX2og7iT+
         JqXIQ1z6M+/S51hBiYk0/3c47weWB/IOGNEl7IFRYi1CAo1Acj2pZz32rwIB5xyQDMQk
         yLL9r2s9GsjVU26+v6Gq6ddzxDmatFM40W/Okan89S7Q7qkU01zF/wxihSozMDMoU/nx
         6KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890690; x=1794495490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/YG+aq9tXklCRb7yDJeFE3l+WkDZoCBNu+6Hf9fIm8=;
        b=xSTAJmtfSgeUdDWJRUT9w+wycizGpSonaOnElucS8mhfWI/IRJNZauOb+K/qAlEpEL
         DrVOfYZdQq2/9ChFZ8INbPZyL+5EB71eqTUJbQpz+6imGMWRHk1VdKvNJzedGbbfLw5e
         u7/xVxXiNt+hcCEAEEO5eJqwayWgLVSxMC0YyHW3xwyPBJkycjGjMm878sMOJWbtb96o
         RqXhoRdZ4TaANGs0eNy7RDQQnCEPJzKmud3Li3w+yvXl2k86dSuEpznqQh2Xn554A5wp
         ONj/jn21BldxSQ1ecjwnrjMLCniFaulCoU3tNcbAXHnlCPwRiOooANs2enO9GcAZcHDU
         Dceg==
X-Gm-Message-State: APuU4Z/P1J51zw8oVz3byGNKvAnoHBBZ74xyb7Bx6k9jSrBHaEOzW818
	a+mixbaCULwpNNnztRjrqH8T1d/uPYkILUIAqEdM478/YR6zNYe4/OjhMbm38NnG1xo=
X-Gm-Gg: AYBFou0SmrId/4tzGSbon/N4XJsYW11xE90kPoJRP+fA7uPkvdLwCX17LuU5/NG9+zR
	VazWgdK9L7TZDzAs9TxOagwwb6Yn3Q2xqUku4rjnzTvnye8UIDKDcnS8XFNlbYiaHSSxAhVlG0T
	MpVBqI61OzormVDDgkl3vdhNHnkyV8FPdozdh9ofsaexHmAEIX3BwsGHe3X5YzmJX+Ivn2KWPu5
	O32Bb6rFrKbsl1JpISGhrYBbaaZLXDlEDzlFbyXG8NdMf+bcGIHBnowUew/6Wd80rGuMU0Veii/
	8WquLv/0oPS283n9G8xCK5kkocsB8asVtgd7LvBkOlujQGMUlgQ0vLIAeaQ1Lkx0C0toReNuDYg
	n6R2jnfDj0g5fOi/oPI1P5pHk3WHkwY83lyke2YWWrY3gQjNt65Lq8adxFlb+t3xK2mthx2kwIF
	47l0IoMXVlPBe8RH5JG6z40Aban+KPVXh0RfFgtvbBMcVlHJkvbrAhSUEIC9ZeSDaOnuUUP4+YI
	Y7sdRgDbF9mIn7QAVlQwAvoivlmwHwK1eQIiGWVptmXtfAH4KThpUbOLxAIkEYDMgxOznZYdbH5
	kUzeYNYN3BfEoTTSSWcG+PtdDQEQz0cDDoI45A2yPVQ5Mw==
X-Received: by 2002:a05:6830:43a0:b0:806:dbd8:9929 with SMTP id 46e09a7af769-85d3652ea54mr16022799a34.15.1793890690360;
        Thu, 05 Nov 2026 06:58:10 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e170absm4744674a34.15.2026.11.05.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:09 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:59 +0000
Subject: [PATCH RFC v3 08/90] user_namespace: let the kernel map the ids of
 a cell
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-8-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=5731;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oV96zWzSgFL3jNXwinYKrOo2cM9oFlK4P6S6oV3cc6k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIaAb7GwO8ZBHVxrWC5ZqzAX/7cRkPe1b/gujCQNJ6TOjJBSgF0KE3r1Twdu2cXWR5gqDFlzx3j
 OKPhTFz/xpAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The id maps of an ordinary user namespace are written by a task, and
map_write() makes many checks on that task before it accepts the map.

The maps of the user namespace of a cell are set once, by the kernel, to
ids that the kernel chose. Add userns_set_cell_map() for that. It takes
one extent for the uid map and one for the gid map. The checks in
map_write() are about the writer, so they do not apply here.

If the cell has a single gid there are no groups to drop or to add, so
setgroups() is denied permanently.

The namespace records which block it was lent and which ucount the block
was charged to. Both are released when the namespace is freed, not when
the cell dies. Every credential and every object that the namespace owns
pins the namespace, and may still name one of its ids.

Add userns_retire_cell_block() for the case where something that is owned
by those ids could not be cleaned up. The block is then never handed out
again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h           |  7 +++++
 include/linux/user_namespace.h |  7 +++++
 kernel/user_namespace.c        | 65 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index 6a65d035ffca..37fde4bfea44 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -145,4 +145,11 @@ static inline void cell_put(struct cell *cell) { }
 
 #endif
 
+/* The id block allocator. */
+#ifdef CONFIG_CELLS
+void cell_block_release(u32 block);
+#else
+static inline void cell_block_release(u32 block) { }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index f0b0fe12c2fd..4a48ead45820 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -123,6 +123,8 @@ struct user_namespace {
 #endif
 #ifdef CONFIG_CELLS
 	struct cell		*cell;		/* whose namespace this is, counted */
+	u32			cell_block;	/* kuid block + 1, 0 for none */
+	struct ucounts		*cell_block_ucounts;
 #endif
 } __randomize_layout;
 
@@ -193,6 +195,11 @@ static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 extern int create_user_ns(struct cred *new);
 #ifdef CONFIG_CELLS
 int create_cell_user_ns(struct cred *new, struct cell *cell);
+int userns_set_cell_map(struct user_namespace *ns,
+			const struct uid_gid_extent *uids,
+			const struct uid_gid_extent *gids,
+			u32 block, struct ucounts *ucounts);
+void userns_retire_cell_block(struct user_namespace *ns);
 #endif
 extern int unshare_userns(unsigned long unshare_flags, struct cred **new_cred);
 extern void __put_user_ns(struct user_namespace *ns);
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 45699a0a0bfd..4155e2e77497 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -78,6 +78,66 @@ bool userns_is_cell(const struct user_namespace *ns)
 {
 	return ns->cell;
 }
+
+/**
+ * userns_set_cell_map - give the user namespace of a cell its one and only map
+ * @ns:      the user namespace of a cell, which has no map yet
+ * @uids:    the uids: .first as seen from the inside, .lower_first the kuid
+ * @gids:    the gids likewise
+ * @block:   the number of the block the ids are from plus 1, or 0 for none
+ * @ucounts: what the block was charged to, or NULL
+ *
+ * The kernel chose the ids, so none of what map_write() has to ask about the
+ * writer applies. With a single gid there are no groups to be dropped or taken
+ * up, so setgroups() is denied for good.
+ *
+ * @ns takes over @block and @ucounts and gives them back when it is freed.
+ *
+ * Return: 0, -EBUSY if @ns has a map, -EINVAL if what either starts at is not an
+ * id.
+ */
+int userns_set_cell_map(struct user_namespace *ns,
+			const struct uid_gid_extent *uids,
+			const struct uid_gid_extent *gids,
+			u32 block, struct ucounts *ucounts)
+{
+	guard(mutex)(&userns_state_mutex);
+
+	if (ns->uid_map.nr_extents || ns->gid_map.nr_extents)
+		return -EBUSY;
+	if (uids->first == (u32)-1 || gids->first == (u32)-1)
+		return -EINVAL;
+
+	ns->uid_map.extent[0] = *uids;
+	ns->gid_map.extent[0] = *gids;
+	/* With a single gid there are no groups to be dropped or taken up. */
+	if (gids->count == 1)
+		ns->flags &= ~USERNS_SETGROUPS_ALLOWED;
+	ns->cell_block = block;
+	ns->cell_block_ucounts = ucounts;
+	/* Pairs with the smp_rmb() of the lookups, as in map_write(). */
+	smp_wmb();
+	ns->uid_map.nr_extents = 1;
+	ns->gid_map.nr_extents = 1;
+	return 0;
+}
+
+/**
+ * userns_retire_cell_block - never hand the block of a user namespace out again
+ * @ns: the user namespace of a cell
+ *
+ * For when something that is owned by the ids of @ns could not be got rid of.
+ * The block stays marked as used for good, so what shows is -ENOSPC and never
+ * one tenant owning what another left behind.
+ */
+void userns_retire_cell_block(struct user_namespace *ns)
+{
+	guard(mutex)(&userns_state_mutex);
+
+	if (ns->cell_block)
+		pr_warn_ratelimited("cell: kuid block %u retired\n", ns->cell_block - 1);
+	ns->cell_block = 0;
+}
 #endif
 
 static unsigned long enforced_nproc_rlimit(void)
@@ -273,6 +333,11 @@ static void free_user_ns(struct work_struct *work)
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 #ifdef CONFIG_CELLS
+		/* Nothing that pins the namespace is left to name its ids. */
+		if (ns->cell_block)
+			cell_block_release(ns->cell_block - 1);
+		if (ns->cell_block_ucounts)
+			dec_ucount(ns->cell_block_ucounts, UCOUNT_CELL_ID_BLOCKS);
 		cell_put(ns->cell);
 #endif
 		ns_common_free(ns);

-- 
2.55.0

