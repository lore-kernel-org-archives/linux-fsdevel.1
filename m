Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891449;
	b=AjneP67J/rTa7RCa8nNuD3ht55CELHSH5f40fmn1Q/yRnQWUq06LxK+5V7E2bluIGqMo
	 5VjfLlmwBOFmQ5csGGNWX5a8W2wPBbx+MW7TLwjClg4BjXxYyP+7RyqSGdkuA3BON4JGL
	 ptixJLhkazMtWIyfE8KPJoRmw4CsYNvVfCYx5x7O5C5Im4Vdf3WGahdGjwGiJNgyMgkX7
	 oJJK9HHXXVBtbN9az9Dr4ew71MEDMPdbn7iOyzW3MyOfrdtwoiWiplnTuy8d/F6/v/Xcr
	 +Qk47RGnyy2JjyE0F88yP6A13h+1nJpcynCBUv3Ue+1Am4qB1fkmvH3U+Ab/8NppsHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=d69VKjHQYfxLBcrT2TnbL+ANtZWJ1rn+UhI7RSFq80M=;
	b=ze9wJajCOyOdVkb+Y9Eu7cf7oRmTCcSP8sNxQAfEZy37AJw5b1Y57gwC9P/6jSZVQt4E
	 dr7eLfYQ1OhLIMmbu0u9JnWrkyJocWIrQwq9iYcF63bOaD9qN+y0Gc1TamQoqBxJvJBEz
	 wsRsuekhbpFfoGpSoNiUibyf/0s0O5ktD+sle6ZfQibDnuzoNHDwIsdB2CoYs9b3LIUso
	 pTjPfOr/j4c7TcAB6DfTEFxV2J2fK50DqrnAa3CO9dgoEBHCiY1yNkuI2Gml/zejgQSHI
	 DHQSgFVFMfe+SQd8fBfoTs5CB5lqCLs07vfDyWFRHme7N1sk+R+KC0OP36/7VWZH8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="CG/I2RTD";
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C0606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CG/I2RTD
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91e8938fd01so16926856d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891447; x=1794496247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d69VKjHQYfxLBcrT2TnbL+ANtZWJ1rn+UhI7RSFq80M=;
        b=CG/I2RTDT8B2mEQOt7wDX4EaDYkGZSBoyOtRjNHa+R3tdr1oaKzJthYiN1JRNY/hcj
         y+uulJCb3B4KKkdpfk4LV0M755LEHc5X/gmrsAhae80qqmGZcRpgBj5UHBqXqvrMZTDE
         LvVgnwBilIWrs0vSHi5X5EEtTLuMNBEXQfOYTwk5Y2rQjCAq8BjzVlFTlF9QHpxoydQW
         EJeex1kBfacssYPFOXOK1bt8p1gC0npzjAyR3k2jdHWU0o3JKWFAFUiFu+aiRapDgO7T
         2xaNZzY6O9b0ZjUo8FINmOPRqhJ54zI3rSMv3GPpP/XJxOYUdt/ki44EyIYWp/Ehy0FD
         rT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891447; x=1794496247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d69VKjHQYfxLBcrT2TnbL+ANtZWJ1rn+UhI7RSFq80M=;
        b=KdsgPCrv1vanrYkf/IfL9vVlN5KN2q10YwEbcrAN0jbkT0w30nCd5S00MlXHN/STRe
         luLZXfH8u7Zi0Z6+pkY586MT02xY3qsEfjaBNeV08eOHqyRxXl/loa5oh7fSIfygD+2N
         W+En14kHQxedC+m+EZ8x8R+ouYzYhOEiQSdk5tSx4I16jeTM3+wmjYyMWdS2Gj0fBQhz
         dr2bNl8DpCJWfEMBllJAKXP4UyVxakwbzPs9f3kVwmnoCiv+P6a5492q/0ewB/kplHg+
         H1eyHBPl0FXKC+kgMW92t3xQl6lbPyoQyEgRG26+xGbs4VorFlV68C0wcCXsqhNXDY9T
         jrWw==
X-Gm-Message-State: APuU4Z9g2DW9ZKYfY4t3wWkfutmdCVRXCqk6yyU4zeGv39v22k1ZuJrW
	iil0xcz+nvQPGxha2ukL5JU83EYlUtPUukGrDB8U1cQjh7nFKshfWIMmdhp2LX/2pEE=
X-Gm-Gg: AYBFou3TPg9J/A0QY3nf58HPQnI2LZfQ/HbXGWf1Eq+afmHjUlYbucI4/hONAdRgH1U
	dSxbtMuGF5WkGFNEff85FHpihb61CnES3mCzu56B/F8qtzScCpgDJWEE75D6iy3dnlyHL5C6AKm
	GULZURsmcT7kENl4EtNbISJE5iDRJDg10aY+7lO+Y8eqYDjxGTg/mxPOXqFQLSmf7Lp9yww74qb
	nvd9JIyZq9zceNx2AdpTApoY8WL31tmjN/Tn8kRNUSdEdlDP0koo6F3soa3D4nGa4f+7g0fC1p0
	ybwBeRsZI2jRHRYRLgrjYkSETApsch88wyc5ly/RwCuQ8dBIDvwW0LSmZa6WFjh54y17FBSlafM
	v3Tzhg7hlT2gGBiobVtNMni2NhRdIglcH0jTtOADq3erK2T/T3F4ygJyEAUqQRDijnOPwoOefDO
	s6ojH/uy0Ctos8T6MYa0n/9PjG8M26HvITAW5fyPllTKd8rtbU8Oq88cAsxLF+K6G+9r2aVchkI
	mtdY0aUp0VMXgUnlu7T8Pu5LNMeTC7NljBWCmLvK9rAtf9mHIOhfxMSgf/UISlEen6jp58qlM0a
	zJ1r05ZCYqzPpBboy+E/zbT8gVKwuJNMwutvNRpW5LnQmw==
X-Received: by 2002:a05:6214:5902:b0:91c:7c53:152d with SMTP id 6a1803df08f44-91ca4b2d871mr318382846d6.29.1793891447290;
        Thu, 05 Nov 2026 07:10:47 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfdfb81sm49464166d6.19.2026.11.05.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:10:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:21 +0000
Subject: [PATCH RFC v3 29/90] cells: add the "ids" slot, for a single id
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
Message-Id: <20261105-b4-cells-v3-29-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=4273;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Mz24/N5BM0N02w6puaOWRvgue7f+PiVS4d0vU6lHB34=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCfxiRi1K35ZRQ0oVanCzlxyt/cSxetoxSr3pId0TKWYV0+IiKkHMbZg9nbj/qCkKVBV7awHRU4
 dbbYx7dNGwQk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

CELL_SET_BINARY with the key "ids" sets how many ids the cell has. Start
with the value 1. Such a cell runs with the uid and gid of the user who
created it, and its tasks see those ids under the same numbers.

This is refused for root, because too many checks in the kernel look at
the bare value of kuid 0, with or without capabilities. It is also refused
for an id of the window, as map_write() refuses to map one into an
ordinary user namespace.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/Makefile   |  1 +
 kernel/cell/ids.c      | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/cell/internal.h |  3 +++
 kernel/cell/slots.c    | 14 ++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/kernel/cell/Makefile b/kernel/cell/Makefile
index ac48bfb289d0..61ca8e9cb216 100644
--- a/kernel/cell/Makefile
+++ b/kernel/cell/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += core.o
 obj-y += slots.o
+obj-y += ids.o
diff --git a/kernel/cell/ids.c b/kernel/cell/ids.c
new file mode 100644
index 000000000000..aaf7e7ed9826
--- /dev/null
+++ b/kernel/cell/ids.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cells: the ids of a cell.
+ */
+#include <linux/user_namespace.h>
+
+#include "internal.h"
+
+/* The id of whoever made the cell, under its own number. */
+static int cell_set_one_id(struct cell *cell)
+{
+	struct user_namespace *ns = cell->user_ns;
+	struct uid_gid_extent uids = {
+		.first = from_kuid(ns->parent, ns->owner),
+		.lower_first = __kuid_val(ns->owner),
+		.count = 1,
+	};
+	struct uid_gid_extent gids = {
+		.first = from_kgid(ns->parent, ns->group),
+		.lower_first = __kgid_val(ns->group),
+		.count = 1,
+	};
+
+	/* Too much goes by the bare value of kuid 0, capabilities or none. */
+	if (uid_eq(ns->owner, GLOBAL_ROOT_UID))
+		return -EPERM;
+	/* Nor an id of the window, as for a legacy user namespace. */
+	if (cell_id_in_window(__kuid_val(ns->owner)) ||
+	    cell_id_in_window(__kgid_val(ns->group)))
+		return -EPERM;
+	return userns_set_cell_map(ns, &uids, &gids, 0, NULL);
+}
+
+/**
+ * cell_set_ids - fill the "ids" slot
+ * @cell:  a cell that is being built
+ * @count: how many ids it is to have, 1 or CELL_ID_BLOCK_SIZE
+ *
+ * Context: The caller holds the lock of the cell.
+ * Return: 0, -EBUSY if the slot is taken, -EINVAL for any other @count, -EPERM
+ * if whoever made the cell cannot have a cell of one id, -ENOSPC if there is no
+ * block to be had.
+ */
+int cell_set_ids(struct cell *cell, u32 count)
+{
+	int ret;
+
+	if (cell->ids_count)
+		return -EBUSY;
+
+	switch (count) {
+	case 1:
+		ret = cell_set_one_id(cell);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!ret)
+		cell->ids_count = count;
+	return ret;
+}
diff --git a/kernel/cell/internal.h b/kernel/cell/internal.h
index 01a7a8581ff7..c7a1895eadd4 100644
--- a/kernel/cell/internal.h
+++ b/kernel/cell/internal.h
@@ -59,4 +59,7 @@ static inline struct cell *cell_from_fd(const struct fd *f)
 	return cell_from_file(fd_file(*f)) ?: ERR_PTR(-EINVAL);
 }
 
+/* ids.c */
+int cell_set_ids(struct cell *cell, u32 count);
+
 #endif /* _KERNEL_CELL_INTERNAL_H */
diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index b3dfb32b1345..cc732c4e09f9 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -73,6 +73,18 @@ static int cell_set_root(struct cell *cell, struct file *file)
 	return 0;
 }
 
+static int cell_set_ids_binary(struct cell *cell, const void __user *uvalue,
+			       size_t len)
+{
+	u32 count;
+
+	if (len != sizeof(count))
+		return -EINVAL;
+	if (copy_from_user(&count, uvalue, sizeof(count)))
+		return -EFAULT;
+	return cell_set_ids(cell, count);
+}
+
 static int cell_set_string(struct cell *cell, const char *key, const char *val)
 {
 	if (!strcmp(key, "hostname"))
@@ -83,6 +95,8 @@ static int cell_set_string(struct cell *cell, const char *key, const char *val)
 static int cell_set_binary(struct cell *cell, const char *key,
 			   const void __user *uvalue, size_t len)
 {
+	if (!strcmp(key, "ids"))
+		return cell_set_ids_binary(cell, uvalue, len);
 	return -EINVAL;
 }
 

-- 
2.55.0

