Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892669;
	b=eya3gzy1+gQl+NRqKDCOGQW1RQw3kLZRBhmvf9Lzh1OYUrgLlNHk1APWnzKs1bKcoXZY
	 jkTwvzfhivvTcJVxibcj/moe64wL+lCF2THu3Pi7u10EdS4PflZTFIyYkwOISDpvH1VtP
	 2e1ZbRz/goZK/FAWxhJuGfqQ7oSmO2mGSZGBCfREuy9IInVlSFqHkbR+D9tI/b3rCrtGY
	 Sht2w3BjDuyk5xdx7Vjt3EwDLukacuEMB2pQQ0fVFJA/crWRq8BPQvf2oGdpkEKkRHaDh
	 3Uqn9oX0tWWE47zoyH0Tv1IXDMXl1q5ihMDCNK3iqd/f5enqtyns/Zever9j1i6bPCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3R2czUSj7k9mXzWp34vQ+UPKLXJTAziTv8XQt/Yq6WM=;
	b=T1xLwpGy0RWk2FOMUsotUPOUXpx29ROEwPbUAdZ2iHeejhWJqK7EXDPyjMDXhNDXmL5j
	 ilZxj+A7jWphnxE3UoXzOYK3gnYsWX7mjkrmhLNIlI2M43aLU2SbkPc3bYeZotSA4iF2p
	 iIUK5XEZaN+KD/ZqnAe4WTkdZCwn1mh4Wk67SW0yNejBtEnQGyfFk30iwyUduEBxvKjge
	 h5cyc/S00cDzasYk4XUcKDn+fJC8YF5xf47jO4QREuqQpPrxNUbh8Nnp67ycfn0V1yOTZ
	 wqBJFjjbB7p6fLI0KyZwqdCA+xbI5wECsk/MwfMQLOGkV6gb0EMY37yN7Rp0oPax7oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=pD2eQjz9;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A9606A333
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 251A9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=pD2eQjz9
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7c3b75caad1so1261428137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892668; x=1794497468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3R2czUSj7k9mXzWp34vQ+UPKLXJTAziTv8XQt/Yq6WM=;
        b=pD2eQjz9nJ80ro07vuH5pQfZgVRFavWnMBp/qjChaKXURhrDaFD5wSK3G2H0eVv1Nt
         J+t9nGT8sOwIHJ7NrLgByIcN6dXJbB0DgXc5OTyerpuGm5DDGfOlORkCzDmZR233/trE
         BuAR67NhYb+TW2XPxyNbVkVmhX+zOF/a2mrVCTaTi3ncUshlMAZSySy92cy+O4sZiBXI
         z05WQkQJdU3jKwaHIbMUWy1v7XxmEAA1zO5TJwwnyycTXhXRLWXYITIrcWwxq19YoFvk
         J4a/1Ok17SjAebJRN+8BId6giSDYlVfN2Ugafwjr5+4w0HuqG6KpNjHi+KDTZOT1IWKo
         cU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892668; x=1794497468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3R2czUSj7k9mXzWp34vQ+UPKLXJTAziTv8XQt/Yq6WM=;
        b=J3YnsxGX9KX023lcUocu7ApkMivtGLoecp4jtTpRko4mjVnsT0rEZNM+2kN7h2i7nA
         QFWX6RGD0vkFcGV7rWQpd5mhdqx09O5sZ5IVjWzzKYl+CdTSjEb3iKsPq5Eq48+C65Pc
         l3hqYd8FobCSxeEGQ84UEGXjmJkQgjixln3BmjxGCRFeW9gtkOuB5OhnolxqboLlGJao
         wNZPj2bIh1MTmjLsFSv8R7BYLHdAMrpE2W0kIg9NNBQbrmdXiv+d0SoxmoCz4Eij3cDV
         cwk73N7sbFPoYKze4ucT97V8dgLartR69oDSRW7/Wbijb/oCsxQahKu2dfXC1uOB5SBE
         qwlQ==
X-Gm-Message-State: APuU4Z+PeldZC2KNtlaVe0J8P3B/EBuy321QLt3kNt+W5XEWn8gFdS8g
	RCU7KoJe7gMnlfvuYIlTYY613NkD2iXZX5c0hqEkUnA3UabDEr3QwQNciwUJgshmU5Q=
X-Gm-Gg: AYBFou2MtUTV4HMQ18cnpG2cd80afXK891LaSKIhRuwTlX0z28wwpadCrXvmkv+kfmD
	rHPHL9vgs1kAhkBEFYt1gIpeyK7qLqyK4BaK+bwxCfP44svNRv3fH7bPH4QEzzSuulknC93MQLx
	cowwFUcwEdoGYIRabhWnOp9pCm3MoHVWnopU/xcMSXzXIjYQ1FZHSYq8l4napgdTI8ilbaw0r2l
	gLWBBlHax7AuJY+Wj27Owfg94QjdmN52JwJrxTRALHoJvsMCn2ndyqBduqbOQvcSmrIc53Kl7NG
	9UOXAtdEUR+GxNjrWup2oRf+6ng5bSOPFd2wZGfWugqXP2Z5dEr3C82HXWN/pEvw/N8p8JIlbVF
	1zupVLPMlJhckCV9oyvpRc1ru4qzjnvKOECIMzC1DqMb+6MnjOXE0JmG9jdsFvR/L3XAJLeiW+g
	h5nZlk/1zs5NwpCUvMCdQApL7Ry0QGJKZXZYiOls0LJag9ZR6DoVMTCvcfWZRgsceLHZumSoUHK
	nFak4FFUxwUIJUtS50vlwsKlDUeW9TFpVUXu6++4xBx9phC7qv24IMpJ9JuNVslrqxvgz6bLPtL
	3ocXq2Wk+Jvvb1PvYnoO6jW4llZ9JKQQnId088R2cOLituFYq5ynEguEeVK02baVHxo=
X-Received: by 2002:a05:6102:1623:b0:7a7:b6a:b022 with SMTP id ada2fe7eead31-7d072ca6f38mr9775854137.22.1793892667951;
        Thu, 05 Nov 2026 07:31:07 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm3795969137.10.2026.11.05.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:31:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:16 +0000
Subject: [PATCH RFC v3 84/90] net: honour the rights of a cell in net_may()
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
Message-Id: <20261105-b4-cells-v3-84-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=4670;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=D8ckwWJwKp136ciWrSD/HHJY/nLRMwaP+d/bPdHDpiQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEpr6f5A4Th9ZAWOY4nnbD23a0amnyyfbAhKTCyZjxYB7yn6nKNcLP/3gcgqiYL3XvyG2WExMfh
 ZneBF7LiTswU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

net_may() requires a capability over the user namespace that owns the
network namespace. A task of a cell never has that, because a cell does
not own a network namespace.

For a task of a cell, use the "net-rights" slot instead. net_may()
succeeds if all of these hold:

  - the network namespace is the one in the "net" slot of the cell
  - the builder granted the right in the "net-rights" slot
  - the task has the capability that the right maps to, in the user
    namespace of the cell

The slot decides what the cell may do, and the capability decides which
tasks of the cell may do it. An init can set up netfilter rules and then
drop CAP_NET_ADMIN before it starts anything else. A task that is not root
in the cell cannot undo those rules. LSMs and audit still see a capability
check.

The network namespace still belongs to whoever built the cell. The builder
sets it up with the usual tools and can enter it at any time.

A check that has not been converted to net_may() still requires the
capability over the owner of the namespace, so it fails for every task of
a cell. Anything that nobody has looked at is therefore refused, and each
conversion adds one thing that a builder can allow.

The rights apply to the network namespace of the cell only:

  - A socket that was created in another network namespace and passed to
    the cell carries no rights.
  - A request that names another network namespace as the place to move a
    device to, or to create one in, is checked against that namespace and
    fails. This matters because such a namespace can be named from inside
    a cell: a veth device whose peer is in another namespace gives its own
    namespace an id for the other one, and any task can read that id.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h     | 11 +++++++++++
 kernel/cell/boundary.c   | 19 +++++++++++++++++++
 net/core/net_namespace.c |  8 ++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index b12e2f124769..e79ac7e9ec60 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -256,6 +256,17 @@ bool cell_no_net(void);
 static inline bool cell_no_net(void) { return false; }
 #endif
 
+/* What a cell may do to its network. */
+#ifdef CONFIG_CELLS
+bool cell_has_net_right(const struct cred *cred, const struct net *net, unsigned int right);
+#else
+static inline bool cell_has_net_right(const struct cred *cred, const struct net *net,
+				      unsigned int right)
+{
+	return false;
+}
+#endif
+
 /* A mount is idmapped for a cell. */
 #ifdef CONFIG_CELLS
 struct user_namespace *cell_idmap_userns(const struct file *file);
diff --git a/kernel/cell/boundary.c b/kernel/cell/boundary.c
index af67ef68d4a2..dd49a6e4b39c 100644
--- a/kernel/cell/boundary.c
+++ b/kernel/cell/boundary.c
@@ -104,3 +104,22 @@ bool cell_no_net(void)
 
 	return cell && cell->no_net;
 }
+
+/**
+ * cell_has_net_right - has a cell been given a right over a network namespace?
+ * @cred:  credentials of a task of the cell
+ * @net:   the network namespace
+ * @right: an enum net_right
+ *
+ * The rights of a cell are over the network namespace in its "net" slot and over no
+ * other, so a socket that was made elsewhere and handed to the cell comes with none.
+ *
+ * Return: true if @net is that of the cell of @cred and @right is in its
+ * "net-rights" slot.
+ */
+bool cell_has_net_right(const struct cred *cred, const struct net *net, unsigned int right)
+{
+	const struct cell *cell = cred_cell(cred);
+
+	return cell && READ_ONCE(cell->net) == net && (cell->net_rights & BIT_ULL(right));
+}
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d211631f8c42..be29eddaa9a2 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/export.h>
 #include <linux/user_namespace.h>
+#include <linux/cell.h>
 #include <linux/net_namespace.h>
 #include <linux/sched/task.h>
 #include <linux/uidgid.h>
@@ -371,6 +372,13 @@ static int net_right_cap(enum net_right right)
 static struct user_namespace *net_right_ns(const struct cred *cred, const struct net *net,
 					   enum net_right right)
 {
+	/*
+	 * A cell owns no network namespace. What its tasks may do to the one it was
+	 * given is what its builder named, and who among them may do it is whoever
+	 * has the capability in there.
+	 */
+	if (userns_is_cell(cred->user_ns))
+		return cell_has_net_right(cred, net, right) ? cred->user_ns : NULL;
 	return net->user_ns;
 }
 

-- 
2.55.0

