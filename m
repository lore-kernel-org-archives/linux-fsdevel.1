Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892718;
	b=fyHjj3zpD7BbNKNaXvl5dMIzzGwP5IwDu6543LsQUX5ogK+xDZ/NC5NKZT3oCSsda7TS
	 Cn0V/jc5iS2um5i9DsB2kjBhMD/Er3PJjDx7dmXwQLgnWkhhFRJ3ZoHy5ANMQlP9kb6uL
	 qROwhUGZ4lhvzrX4eg7hnvBPKAyYo61xLuCi+OwL0It8XFqUSBm4O1O0sqHGk8hVjgab6
	 VPIwf1lo6RLUFwLHc1N3HuEanExWlU2/xQW0dR/iLDkcRC2SZvWHgrNkj07+tOZvENTcm
	 2KZ5zgCyD1r0cZjPx3DhARV9vGzSs/WVTXj4K+tSBHBxeBhS4GnVbYWuWZFiUpXkvQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qCsxOu2h+avACmuxpbYdZAVBqe8KiC2MNfUoR+07HZM=;
	b=Ld8J+2Cr+ZPmrfLQ6jDWxuSb7iOJjcXUg9viLkBNMDGYUFxMEJuCEBGwdoRwO3HjaaEc
	 9muh4JWHBFqvanpgo0fdySbVKIczBoW2Fm3RtPHQh/1C7RP6mSZ7y94arDbw0GN/LRI6r
	 OLGn72mJOnWhmyyoX3g97T4FsBPlyN6d7bXi1pzUz8HKQJ8Sxix8QG5iZ7zIxLsxK1wFI
	 8yOOnxZLTvRwNXrV6UkQucSBF0j3flBXFkpwD4xYigTbYRJ8cAJy87zpTw2HaLMrTUoo3
	 D8YokMI2JMEDTS4BJuIySCEy14HoGw3225bzaEXLAFHmJQCpBUoBb48J6vO7moONzPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QeGnw+BE;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB8606A331
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEFB8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QeGnw+BE
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c67992ce5so15826186d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892713; x=1794497513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCsxOu2h+avACmuxpbYdZAVBqe8KiC2MNfUoR+07HZM=;
        b=QeGnw+BEyIpg5bD27QqT/D97i4sZOM44v4rHnchnwzq3AXjlL553DU2LBDfK1FtP2d
         HTPTJorq6kNf/E4fG2IlEHBwK+NpW5Lb2ojbKErSRO+acHIQUfIc2hX8QizaiGQabHem
         MaDUT/gwW5nwhLlkDEJaYQ2U4SyMLIPXyI3rV86GieRkhppUMyQkscVDQz6+Jlmpj0lj
         8d6llMQnCGxqetQ7CgOVANr4mVsNHUZLXsAiu/LHDx6Orr2TB8ChYHmnznw3S52A9Cpf
         +LxDnhDIqRMrEYLTCeIcHgIpz6/C7rjAs0Sv/5y3hbC6i+VA+SgF37uqpy5r+kv9LcYk
         Uliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892713; x=1794497513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCsxOu2h+avACmuxpbYdZAVBqe8KiC2MNfUoR+07HZM=;
        b=DgeV8oBm2AbecAia2d/t2OKck6WKUGfBufjjApihGxz/LA8n6QJdyjGHdoJaOAD3N1
         QmXAnUXGAv3sd/qnnoxT1KHe74jKWw/S1+Ch5zx0tQ4E2a45NR5HC7/kNAYOOQ/7LMSW
         kESfS8jJ6iUuJoB7xWsrOFSjIFW2xjDyBSc1GEtzIn+WT4xISQZrZH8ZjdANC4Fgs4Xa
         mJ3ST4nhkIS8LKFnLQaxhAflRU2rUjQ961F4MA/Of5YyUBmgzUklRhT35uLeu15a3rgU
         zFlVa5iV4aNKKota5mY6kiIejhtRrWYD30KrxK0sDieuxOUHWi1txAvzxeTVZ7Vdd5/p
         ks0Q==
X-Gm-Message-State: APuU4Z+nUCEf0l+5nsapsV9xSrIY740IrFr+LP00o/Dxy14aTXHWlmw4
	I8Rl+/UZ46jn1UfHoP5yVzauekf5nXIkxfb5xA+tOKovdunv35BdJWFiZs8ljcvDBdI=
X-Gm-Gg: AYBFou3zPciAxNwWgWLg/HfFXta7tR8k5Ld9huZ94+rqFSnn0ydXEhsYDD/kBOjXHYL
	RXF5mtzJ/IeYpio+VtWJbum10NXdJKaHvoxmcHrUhF0/AtjJ3BwuZxXIGU5vLS1FlcGQSW7m7+K
	GcQtKs9RjG6Q8Bp2F7apFlRB5yI6/XaCIv8EJ08XCCpQlc/4eFBLoj4dD0PJA2rocV0zshlUs/x
	Aqpsr85wxunlqMSIAurhj7+1FshdxsK4ggldnfd04haaN+UUKJES6JEGDmNLpX/lL069jnGwwMR
	+ry5LDUgdyhD2KKxcsl2z26leniKLOKWqgCPvUgv2B2anfH2tr9py1C+7Qw5F6+76w6iTOwhcmz
	FXbV9qhDcFdZR4GzHEScETWiyIvc1OjJbykFwseaARP29l9AXCZtFbjp/cYOTBHY3A5P0sRTTLB
	S2ZxVBB4OLqDE0kCovR0Cme4sl7iAhQ3HOyf8SRSnEpn3mVRm2R4Y40fCaG6WyrVUH5Q2I8K+lJ
	uyXWyUmY/wFu6i7z2/P74mK5jMkHysVRJKqaIXqyqp6eH6RxE1GSTRflDiTw+2W8G2LYfmp8csa
	RrPe4Mmt9QjRXMzSjwk4iUqahQXELO5+H21AociuwfLa
X-Received: by 2002:a05:620a:31a6:b0:93d:f7ac:4706 with SMTP id af79cd13be357-94421541a92mr3269657185a.9.1793892712569;
        Thu, 05 Nov 2026 07:31:52 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482eb96sm488072985a.23.2026.11.05.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:31:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:18 +0000
Subject: [PATCH RFC v3 86/90] cells: add cell_info()
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
Message-Id: <20261105-b4-cells-v3-86-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=6237;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=1k/1F+e803S2yTvlGK9tp5BF4RJM2FSGjnqpd/RdqzM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGd5aeupkTWIEKGc87kRac1nNHkIduLUwfr3uJZIsM0VMtNlC07iA87yKG+bQFxADi4nt8RISJq
 j2pTrvF/EIgI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add the system call that reads from a cell. It reports the id, state,
flags, exit status, budget, capabilities, ids and network rights of the
cell. It comes after the slots in this series so that it can report all of
them.

The kernel chooses the block of ids that a cell gets. cell_info() tells
the builder which block it was, as soon as one has been allocated. The
builder needs to know, because some things outside of the cell are
configured by id, such as a netfilter rule that matches the owner of a
socket, or a routing rule for a range of uids. These are set up together
with the network of the cell, before anything runs in it. The first id of
the block is reported as the caller sees it. It is not reported at all if
the user namespace of the caller has no mapping for it.

The struct can grow. The caller sets mask to what it wants. The kernel
sets mask to what it filled in, and supported_mask to what it knows about.

With CELL_SELF in place of a cellfd, a task can ask for the id of its own
cell and nothing else.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/uapi/linux/cell.h | 28 ++++++++++++++
 kernel/cell/core.c        | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/uapi/linux/cell.h b/include/uapi/linux/cell.h
index c0d17c890552..22cd5e1f8f24 100644
--- a/include/uapi/linux/cell.h
+++ b/include/uapi/linux/cell.h
@@ -45,6 +45,34 @@ enum cell_state {
 	CELL_DEAD		= 4,	/* Nothing left. The status can be read */
 };
 
+/* cell_info(): bits for @mask. */
+#define CELL_INFO_ID		(1ULL << 0)	/* id, parent_id */
+#define CELL_INFO_STATE		(1ULL << 1)	/* state, flags */
+#define CELL_INFO_EXIT		(1ULL << 2)	/* exit_status, once CELL_DEAD */
+#define CELL_INFO_BUDGET	(1ULL << 3)	/* budget_cgroupid */
+#define CELL_INFO_IDS		(1ULL << 4)	/* ids_count */
+#define CELL_INFO_CAPS		(1ULL << 5)	/* caps */
+#define CELL_INFO_IDS_FIRST	(1ULL << 6)	/* ids_first, if the caller has a name for it */
+#define CELL_INFO_NET_RIGHTS	(1ULL << 7)	/* net_rights */
+
+struct cell_info {
+	__u64 mask;		/* in: what is wanted. out: what was filled in */
+	__u64 supported_mask;	/* out: everything this kernel can fill in */
+	__u64 id;		/* never reused */
+	__u64 parent_id;	/* 0: the host */
+	__u32 state;		/* enum cell_state */
+	__u32 flags;		/* none yet */
+	__s32 exit_status;	/* as wait(2) reports it, of the cell's first task */
+	__u32 ids_count;	/* how many uids and gids the cell has */
+	__u64 budget_cgroupid;
+	__u64 caps;		/* the capabilities its tasks start with, bit by number */
+	__u32 ids_first;	/* what uid 0 and gid 0 of a block are to the caller */
+	__u32 __spare;
+	__u64 net_rights;	/* CELL_NET_* */
+};
+
+#define CELL_INFO_SIZE_VER0	80
+
 /* cell_open(): @what. */
 enum cell_open_what {
 	CELL_OPEN_SLOT		= 0,	/* An fd on the object in the slot named by @key */
diff --git a/kernel/cell/core.c b/kernel/cell/core.c
index c780094ad794..12773f16d188 100644
--- a/kernel/cell/core.c
+++ b/kernel/cell/core.c
@@ -386,3 +386,96 @@ SYSCALL_DEFINE2(cell_kill, int, cfd, unsigned int, flags)
 	cell_kill(cell);
 	return 0;
 }
+
+#define CELL_INFO_SUPPORTED	(CELL_INFO_ID | CELL_INFO_STATE | CELL_INFO_EXIT | \
+				 CELL_INFO_BUDGET | CELL_INFO_IDS | \
+				 CELL_INFO_CAPS | CELL_INFO_IDS_FIRST | \
+				 CELL_INFO_NET_RIGHTS)
+
+/**
+ * sys_cell_info - read from a cell
+ * @cfd:   a cellfd, or CELL_SELF, which tells a task the id of its own cell
+ * @uinfo: where to return it. Only @uinfo->mask is read
+ * @usize: the size of *@uinfo as the caller knows it
+ * @flags: none yet, must be 0
+ *
+ * Fills in what @uinfo->mask asks for and the kernel has, and says in the mask
+ * what that was. @uinfo->supported_mask is everything this kernel knows of.
+ *
+ * Return: 0 or a negative error.
+ */
+SYSCALL_DEFINE4(cell_info, int, cfd, struct cell_info __user *, uinfo,
+		size_t, usize, unsigned int, flags)
+{
+	struct cell_info info = {};
+	struct cell *cell;
+	u64 want;
+
+	BUILD_BUG_ON(sizeof(struct cell_info) != CELL_INFO_SIZE_VER0);
+
+	if (flags)
+		return -EINVAL;
+	if (usize < CELL_INFO_SIZE_VER0)
+		return -EINVAL;
+	/* Only the mask goes in. The rest of the struct is the kernel's to fill. */
+	if (get_user(want, &uinfo->mask))
+		return -EFAULT;
+	info.supported_mask = CELL_INFO_SUPPORTED;
+
+	if (cfd == CELL_SELF) {
+		/* A name, and nothing that a handle would be needed for. */
+		info.id = current_cell_id();
+		info.mask = want & CELL_INFO_ID;
+		return copy_struct_to_user(uinfo, usize, &info, sizeof(info), NULL);
+	}
+
+	CLASS(fd, f)(cfd);
+	cell = cell_from_fd(&f);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	scoped_guard(mutex, &cell->lock) {
+		if (want & CELL_INFO_ID) {
+			info.id = cell->id;
+			/* Cells do not nest yet. */
+			info.parent_id = 0;
+			info.mask |= CELL_INFO_ID;
+		}
+		if (want & CELL_INFO_STATE) {
+			info.state = cell->state;
+			/* There are none yet. */
+			info.flags = 0;
+			info.mask |= CELL_INFO_STATE;
+		}
+		if ((want & CELL_INFO_EXIT) && cell->state == CELL_DEAD) {
+			info.exit_status = cell->exit_status;
+			info.mask |= CELL_INFO_EXIT;
+		}
+		if ((want & CELL_INFO_BUDGET) && cell->budget_id) {
+			info.budget_cgroupid = cell->budget_id;
+			info.mask |= CELL_INFO_BUDGET;
+		}
+		if ((want & CELL_INFO_IDS) && cell->ids_count) {
+			info.ids_count = cell->ids_count;
+			info.mask |= CELL_INFO_IDS;
+		}
+		if (want & CELL_INFO_CAPS) {
+			info.caps = cell->caps.val;
+			info.mask |= CELL_INFO_CAPS;
+		}
+		if (want & CELL_INFO_NET_RIGHTS) {
+			info.net_rights = cell->net_rights;
+			info.mask |= CELL_INFO_NET_RIGHTS;
+		}
+		/* Uids and gids alike. Not everybody has a name for an id of a block. */
+		if ((want & CELL_INFO_IDS_FIRST) && cell->ids_count > 1 && cell->user_ns) {
+			info.ids_first = from_kuid(current_user_ns(),
+						   make_kuid(cell->user_ns, 0));
+			if (info.ids_first != (uid_t)-1)
+				info.mask |= CELL_INFO_IDS_FIRST;
+			else
+				info.ids_first = 0;
+		}
+	}
+	return copy_struct_to_user(uinfo, usize, &info, sizeof(info), NULL);
+}

-- 
2.55.0

