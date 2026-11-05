Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892648;
	b=b2eJYv5qTYH+WmB1iN+0lTR7KvRqfah/KTDF00aBn8cwHA5cW+aXtExIOTyO/tX9ska6
	 rDX4MhBKznE5tCCuIZ7fxwyBSLH0eCW15e0/M071H4GHVdtCSS8vjPedA0/l8KqQLN1m0
	 p8g6qCEr8mkeZ5rfrdKXEiDQ474HaR2Lq/cEfYqhR/u+V1Vg4cH068zBIAKxdSiovkcPR
	 ckRcZiGg4QGhwuKBp8ongaHqyELucf79WjPaUnO66S+bq83KO01uZ3+ycrIlJ/sRqs3KV
	 z2re6Y0+WDxfK8gzscw+ddVX2PsMaMf9V5ZfBf3AVuDKv0PJ7pqRVqudQ3d4F80I1Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nVOLC1481GlgjMTkzK8f9vuBxCGSBwLfRkCkFzdoPWA=;
	b=mPTJVoUlTVzREv/CstT5/ceet5KDtI5eHJDNxO/psQ7SDmZvvF3bWYlsS5NWWZX5XEcw
	 XXDqOyVlA/DFU+k8ds5ty8CPOytxWZkWF+sjLrweUs8M8XgDE4NuLqWITDGRmX4s+9f2b
	 KPGmcHaosqxZokgnC830ak9E61DofMRwobQkZy3DTufbDJvmbiSlnfwylFgBs7w2Wh7sB
	 +Rk5/YNWXBC2GuoDeeK34g3+fFW8MkqVzGKEOcP1TFX34qs4u7ga+R7ZOJ3yTto9m3w5c
	 iWd4afFawM9ufC1MlVTHpeZjSN2kDwwgn/fo+YarWojHtK2rg9n58X0WKmdZH/4od8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=gYy1L3ol;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF06606A328
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF06606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=gYy1L3ol
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so1153055fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892647; x=1794497447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nVOLC1481GlgjMTkzK8f9vuBxCGSBwLfRkCkFzdoPWA=;
        b=gYy1L3olEkVSBDVUFUntLn7+j+BlFkB6QjdST16Wz3CO3VtGW4Y5gzIrHizC6J2DLi
         tg2GuvJ4PbMTlGLewaJ3n4iHNT1M56KOPs8gT0BlSh/s2sZDwm7R5slHdSoiRPk3YCWr
         AzMyLDUgolfw9HbKHscZKhmue8ndT3wKIN5aycsZwFD7/TSyHHqR5ap/SG9nfR+jZDuI
         +c1CD8xJjPeHu5QYRQVjcRuLGe4SuKVua+NBS7VnjGMu7JnN65DrEtJvN5Kg3fMurHVn
         /kfPCXuf4r3h8unPNu0oPAVXNHS63WpcJd2KoTcwCJZJE++Dt9zZzTd0K4ar0zOwBoRf
         o9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892647; x=1794497447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVOLC1481GlgjMTkzK8f9vuBxCGSBwLfRkCkFzdoPWA=;
        b=g8hSwpowdhivz6I7tJxYV2ob7dmnDl3WwXJqc0r0Tkn9nvcWVV4Sgvb7Qiejh2N3Kf
         YrlD13mgHUPdPe2AaqAkBT7n3lpNkXjbkgBYpm3JMXnoLGajoaSTKOAN8kGxZsz2r+Ci
         iJWApZAtpYzt+0qHSkyWqncJfn6pPcxc92bxJqozhfHBBm+Ob12vpipUbBXw/f8tyU/F
         xiO1SkY9jnAgUDz/s4uXfl//u1f3RCTC0FEHK9ABh2GCt0FIdlXJy63TJ1IRfZLY65Qz
         P70jAUsiFIgiWceXn354YqXnenSfhgOHS1iqsVziJ2Dq5BoENiOGtlClyI+rl9OTPqgA
         SMgw==
X-Gm-Message-State: APuU4Z9o8CHR2C79VvyZnvo74YlDJJnyec5S/il5/xgjGAwGssvuDD33
	T27yv9rXEinVlUE/h8sGGGwOG7I4y+QNkZPvrK2zGjUo3L0XhsPOvbUTac6T2m2N91s=
X-Gm-Gg: AYBFou3ahCqQ6YENfQ6vYw8KIFtMpULc4CAf3a88el5ZUN8W2UsozuaoQVgUeBNmrg4
	53yxq+SiQj1BheTMBejPjK/6NueOq1bNaZ+u/ZpYpsGljE3nMjIsRlfu22oRVnQZniWNUVaYQ+5
	Vv0xINx6tYKN8Art3j9a+gUPOzpwVDZzhAJFC7s3vgl0AlFpV0buHrUMh+mhIsDum6L+an5z/H5
	pRkc9Gq0LecsFsPR0AvxHrL1w5wvpdpRYJ2q7UmcH06MymxDdIIlDzc+j7Lx3ssHmEsU44m8FF1
	DPCPF6Ig+n8H4AhXzpD1yW3bZX7GeATa50sCSvBYfSR9XMzswKKvlVJxMq3hcGp2kS0Y029Rdbh
	LkzBL1KbHtbbTaz1NgpLZoB3Jl2QMEfy0HZ3wrzf+FCzm3f3fpbvYi2amU6GClPR9bg8+6vVobQ
	PT24KK62y1EwIMEF1rHIVpLErQ3uliXRXUxRrq+V7KNYIIjfN7YIX9YupWicztbHHgACrgVu0DO
	bYW6ehJVx1Djt4hmVLWYnLZ3zfgQyrjEAguKi8Qk5H9TGcABOaC4Ojl10kelO0NrOhU9E9uIC2q
	VhDwlzFRySS6SsAUQ1JEizEjCN2sGfpzLHusW2cGVKNm8g==
X-Received: by 2002:a05:6871:2b17:b0:494:895e:c3e2 with SMTP id 586e51a60fabf-4a90764ca88mr13284805fac.20.1793892646658;
        Thu, 05 Nov 2026 07:30:46 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea547bfasm5076176fac.7.2026.11.05.07.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:30:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:15 +0000
Subject: [PATCH RFC v3 83/90] cells: add the "net-rights" slot
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
Message-Id: <20261105-b4-cells-v3-83-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=5322;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=mxfNqe1Q4Agi5B9+WEE4ECRvr76+56ghqo3HPxPudx4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMjBvTwzaahX+4bZL+xD+NdT+JgCUyZb+3+pI5tuZjIdiZTOdDdZeOYSHYN8Bjvq18Wr9RNNucP
 dmUIUbFNTPwA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A cell never owns its network namespace. The capabilities of its tasks are
over the user namespace of the cell, so they do not apply to the network
namespace, and the tasks cannot change anything about their network.

That is right for most workloads but not for all. Some need to add
netfilter rules, run a VPN client, or create a tap device for a VM. A
container gets CAP_NET_ADMIN for any of these, and with it everything else
that the capability allows.

Let the builder list what the tasks of the cell may do to the network
namespace in the "net" slot. The new "net-rights" slot takes a __u64 with
one bit for each enum net_right. An empty slot grants nothing, which is
the behaviour so far.

The caller can only grant what it could do itself. It must pass net_may()
on that network namespace for every right it names. This is why the "net"
slot has to be filled first. For a builder this means having the
capability over the owner of the namespace. Once cells can nest, the same
check will let a task of a cell pass on the rights of its own cell.

This patch only stores the rights. A later patch makes net_may() use them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/uapi/linux/cell.h | 15 +++++++++++++++
 kernel/cell/internal.h    |  1 +
 kernel/cell/slots.c       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/uapi/linux/cell.h b/include/uapi/linux/cell.h
index 3c10c9179289..c0d17c890552 100644
--- a/include/uapi/linux/cell.h
+++ b/include/uapi/linux/cell.h
@@ -21,6 +21,21 @@ enum cell_configure_cmd {
 	CELL_CMD_SEAL		= 4,	/* Validate everything and seal */
 };
 
+/*
+ * The "net-rights" slot: what the tasks of a cell may do to the network of the cell.
+ * What is not here they may not do.
+ */
+#define CELL_NET_LINK		(1ULL << 0)	/* change a device: up, down, mtu, name */
+#define CELL_NET_LINK_NEW	(1ULL << 1)	/* make and remove devices */
+#define CELL_NET_ADDR		(1ULL << 2)	/* addresses */
+#define CELL_NET_ROUTE		(1ULL << 3)	/* routes, rules, neighbours */
+#define CELL_NET_FILTER		(1ULL << 4)	/* netfilter */
+#define CELL_NET_TC		(1ULL << 5)	/* queueing disciplines, classes, filters */
+#define CELL_NET_TUN		(1ULL << 6)	/* make tun and tap devices */
+#define CELL_NET_SYSCTL		(1ULL << 7)	/* /proc/sys/net */
+#define CELL_NET_SOCKOPT	(1ULL << 8)	/* SO_MARK, IP_TRANSPARENT and the like */
+#define CELL_NET_RAW		(1ULL << 9)	/* raw and packet sockets */
+
 /* Life of a cell. It only ever moves down this list. */
 enum cell_state {
 	CELL_BUILDING		= 0,	/* Slots may be filled */
diff --git a/kernel/cell/internal.h b/kernel/cell/internal.h
index 4eafa19daa25..469842ebee95 100644
--- a/kernel/cell/internal.h
+++ b/kernel/cell/internal.h
@@ -34,6 +34,7 @@ struct cell {
 	struct pid_namespace	*pid_ns;
 	struct net		*net;
 	bool			no_net;		/* the slot was left empty */
+	u64			net_rights;	/* what its tasks may do to @net */
 	struct cgroup		*budget;
 	u64			budget_id;
 	kuid_t			budget_uid;	/* who owned it before */
diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index 2273d9ce733f..5f5378ddfe15 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -157,6 +157,49 @@ static int cell_set_caps(struct cell *cell, const void __user *uvalue, size_t le
 	return 0;
 }
 
+/*
+ * What the tasks of the cell may do to its network. The network namespace is never
+ * the cell's, so no capability of theirs counts for it, see net_may().
+ *
+ * Nobody hands out what is not theirs to do: whoever fills the slot has to be able
+ * to do all of it to that network namespace itself.
+ */
+static int cell_set_net_rights(struct cell *cell, const void __user *uvalue, size_t len)
+{
+	unsigned long rights;
+	unsigned int right;
+	u64 val;
+
+	BUILD_BUG_ON(BIT_ULL(NET_RIGHT_LINK) != CELL_NET_LINK ||
+		     BIT_ULL(NET_RIGHT_LINK_NEW) != CELL_NET_LINK_NEW ||
+		     BIT_ULL(NET_RIGHT_ADDR) != CELL_NET_ADDR ||
+		     BIT_ULL(NET_RIGHT_ROUTE) != CELL_NET_ROUTE ||
+		     BIT_ULL(NET_RIGHT_FILTER) != CELL_NET_FILTER ||
+		     BIT_ULL(NET_RIGHT_TC) != CELL_NET_TC ||
+		     BIT_ULL(NET_RIGHT_TUN) != CELL_NET_TUN ||
+		     BIT_ULL(NET_RIGHT_SYSCTL) != CELL_NET_SYSCTL ||
+		     BIT_ULL(NET_RIGHT_SOCKOPT) != CELL_NET_SOCKOPT ||
+		     BIT_ULL(NET_RIGHT_RAW) != CELL_NET_RAW ||
+		     NET_RIGHT_NR > BITS_PER_LONG);
+
+	if (len != sizeof(val))
+		return -EINVAL;
+	if (copy_from_user(&val, uvalue, sizeof(val)))
+		return -EFAULT;
+	if (val & ~(BIT_ULL(NET_RIGHT_NR) - 1))
+		return -EINVAL;
+	/* Rights over what? */
+	if (!cell->net)
+		return -EINVAL;
+	rights = val;
+	for_each_set_bit(right, &rights, NET_RIGHT_NR) {
+		if (!net_may(cell->net, right))
+			return -EPERM;
+	}
+	cell->net_rights = val;
+	return 0;
+}
+
 static int cell_set_string(struct cell *cell, const char *key, const char *val)
 {
 	if (!strcmp(key, "hostname"))
@@ -173,6 +216,8 @@ static int cell_set_binary(struct cell *cell, const char *key,
 		return cell_set_ids_binary(cell, uvalue, len);
 	if (!strcmp(key, "caps"))
 		return cell_set_caps(cell, uvalue, len);
+	if (!strcmp(key, "net-rights"))
+		return cell_set_net_rights(cell, uvalue, len);
 	return -EINVAL;
 }
 

-- 
2.55.0

