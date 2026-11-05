Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890682;
	b=qsEGzd5iy0p7ZJY6Dcq6ap+loihf3n4B4y7dPendBnTltZtGPtFrEOPLQfdAGaKB3+w6
	 scDZ0uIgFr8yD3MwAS0VZVX1wHuRebfS6dnmqeS1NjXULgTa3AZUJ2umim7Q89DBEzSsw
	 jiK+0kCXxKJMpdZLZanMwP5WXadC3QtV/oY+ba4T/xOPIWEHGJCBLYLKGs8T/NKzQ74Pf
	 6MpH9rS0jrt53XxXhhvZCH/fX4t6NDlBrv1BT6y9Nv9EycTYMnqefA2ssAqP+QBEj5m7G
	 Rgey+WPquROPZk8DahlACfy5yFXD6El2VKL5VyKBO+0lZoDSQS2gYcW+2TfoAo49bdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1Oa27i8jHKKaCqDgAvABan/T7W1O2wDNoFWitJ9cz5I=;
	b=F1uAKzLz80YtWKtumzOul2Rbj4//Bsn578eQIRmuVUT7Mh9fXe8qmJtcK09SV1js0XMO
	 vt/2YfJcLvxLr8MdvfjInPGZRHS97KUeHa0IpxMV6fy2LtbTOfkJexeXUo2/zcAtc4GGm
	 2eJfVU+5k8lyZcP/5YzdGfTmJkheu5z64IHBt2W/MyxBEeJ30C0k0vz2FA2OICidi90v6
	 rE1wgceP8Kc9VgCFLqc9W4dUmIcEPnSujJ1wKQ0LsLV9Z64QIyJr8iXjn7lQ7xZ7UrZf1
	 ms1Q6y41UklSiG42VtHV84Rg2wrygWKGsqmtFRivHFDtAsjVJWsFm2AX/o8Bn3EArIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hxjM+qWr;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F2606D815
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132F2606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hxjM+qWr
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6dd7070699eso1344643eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890681; x=1794495481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Oa27i8jHKKaCqDgAvABan/T7W1O2wDNoFWitJ9cz5I=;
        b=hxjM+qWrHYYXdnWv7PFW7hcHPLPOdZ0im6EzNDt3mqaXOk8bM34ni57hsQUKgV9aqU
         nzwaQl0I0S/QQuX6DfE0wblG/vhO8XTeTyIXhZsQDYMmbde9qXSBBUkQvYvWn4Ukx99t
         iW6Gzi5hr3M4DJmT1jvz54V/RlpVUTYnlq9SiXniN6R88JwANoacPgOyQWB6kG8SgxD0
         arOgdrKoBdRq+HkgGqnNske6p5djcSV+qsmtgWMA+6rYnqG+NPtBg/Hre7qjzRmzwXl+
         eIk+a981/EVv+b5BZVWQpWOiWVO/uV/4YU6O70LjQc/HSkyL/76+XlKHJlwmB4xuea6I
         ryGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890681; x=1794495481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Oa27i8jHKKaCqDgAvABan/T7W1O2wDNoFWitJ9cz5I=;
        b=St0XCovPLzmladLq/C8nM+13oZo2eF7BITQoRyVcD+yce2NHMW8Tx4I78b+JjS2IOc
         fkhkKXPiaF0YBlFbQzLRBob0jGxJjT17+b6m9TdtqdLRfUZrOQX8aOelMRH1+KKOfNqL
         SexULOyFON0r67KAaGuzB/E6r7C1RA/FMxSq2OZK4XNjNjm0R68AWVgo+ipy0c1r6VUr
         TNlcytH2czqL3LSxEQuu4mBSMRCBe739JUDHbUbBFzMlWUHoayaSq9GIRUFNh06To5EH
         hUTLnqw+WsA0cvn2qKCodA8w4vX/s4IK1qOTWDUmTVSQLXEXv3AG7pgLQsv7eBtOPErk
         pEEQ==
X-Gm-Message-State: APuU4Z8kiuu9TSHfRCof4jXfjgfmba7rtKtSb/UOzxp2oRHDtPbI5kVM
	YS2gch4VCEr8zg8CCijtVoeeWZid1Ulp2OXVkvqcscku/jSFZ0Ajkzp/9wIKZmZIlDw=
X-Gm-Gg: AYBFou2FaQXvx7DUG424tNIPUPgidGg6/ZigeNjXmCPVSrVflJOcE67eFZIGQvpzful
	j5pzEHYFyPa9UpwlqV5x+8FqbCGUrhEtFJbrivdswlo81/8gcY8Q5UmLqE/20qUtLjxJT3Huj1Q
	u5+H/9O/Cf0Cq5RHt3vwJI9hJuCg7O0BQ+toUROyLHgaHNqWCi1+Jkpf3PSrkuzWkYvnM27wfzu
	t5Tnq91wrZ8C316XfynSgKAEp5W6oyq+QTXg0pDqOocPWQA+VZVQ54bAn1ltLu4DuIn4yRft1sa
	bRsH+7ACX6h4KO+Yumn/g5LL4cktEjramGuHunde8AaL9FPcbxO3kIxrZFvytrRBzKLBh3wpqOK
	j+WdN/jgGHBqOgoNMvxdAQt0VzbdklbxvLc+qw9gepkPCI7SLHFJvtVMNG1ooBkHjSw8ddND4rm
	aIhuN2lBPXL+NnSB6MROYzzjPXrjHf9tKMll5LCIg4tWOVP0gmgB8aufAN1CtQC/WO7ZaFAK20u
	gtMmEQxj8QmAeFYPbFlMjqp53eJbOVYVlHJ5nPYPxdq4uFCLfDMv6eTclXV/3eWwAbSn/A8N3ao
	CnMroyAhcZH03bgENlj5SC5gGw35Lj+41nDx+4EYCuu8ywi6WuclLLLbsLDjDgY//PJx
X-Received: by 2002:a05:6820:83d7:20b0:70b:8148:92b with SMTP id 006d021491bc7-714f24e7804mr8959940eaf.62.1793890681047;
        Thu, 05 Nov 2026 06:58:01 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c134ff86sm4261668eaf.14.2026.11.05.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:00 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:54 +0000
Subject: [PATCH RFC v3 03/90] cells: reserve a window of ids
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
Message-Id: <20261105-b4-cells-v3-3-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=2655;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=uYURFlGP89RDbq5t2H13wY1pbXbymFIdj6H++R/Kjxc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDQNC3zLxxRe7ukNn89rleJLFuizIwJ7EfSDVIS3gJlCB2pATqsdHif6i+tM5R6Ir6BIpCSJgkm
 OU6JAGpy6gQM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A cell needs uids and gids of its own. The builder should not have to be
trusted to pick ids that nobody else uses, so the kernel picks them.

Reserve the upper half of the uid and gid space, minus its last block, as
a window. The kernel will hand out blocks of 65536 ids from this window to
cells. Add helpers that tell whether an id, or a range of ids, lies in the
window.

None of this is compiled yet. CONFIG_CELLS is added at the end of the
series.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell_ids.h | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/linux/cell_ids.h b/include/linux/cell_ids.h
new file mode 100644
index 000000000000..df0b874d5788
--- /dev/null
+++ b/include/linux/cell_ids.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CELL_IDS_H
+#define _LINUX_CELL_IDS_H
+
+#include <linux/compiler.h>
+#include <linux/limits.h>
+#include <linux/uidgid.h>
+
+struct user_namespace;
+
+/*
+ * The kernel hands every multi-id cell a block of kuids and kgids out of this
+ * window. Nobody else may hold an id in it: a legacy user namespace cannot map
+ * into it, and no create, chown or ACL stores one in a filesystem that the cell
+ * it was lent to does not own.
+ *
+ * The last block is left out so that (uid_t)-1 stays clear of it.
+ */
+#define CELL_ID_BLOCK_SIZE	65536U
+#define CELL_ID_WINDOW_FIRST	0x80000000U
+#define CELL_ID_WINDOW_LAST	0xfffeffffU
+#define CELL_ID_NR_BLOCKS	\
+	((CELL_ID_WINDOW_LAST - CELL_ID_WINDOW_FIRST + 1) / CELL_ID_BLOCK_SIZE)
+
+#ifdef CONFIG_CELLS
+
+/**
+ * cell_id_in_window - is an id one of those the kernel lends to cells?
+ * @id: the value of a kuid or kgid
+ *
+ * Return: true if it is.
+ */
+static inline bool cell_id_in_window(u32 id)
+{
+	return id >= CELL_ID_WINDOW_FIRST && id <= CELL_ID_WINDOW_LAST;
+}
+
+/**
+ * cell_range_in_window - does a range of ids touch the window?
+ * @first: the value of the first kuid or kgid of the range
+ * @count: how many there are
+ *
+ * Return: true if any id of the range lies in the window.
+ */
+static inline bool cell_range_in_window(u32 first, u32 count)
+{
+	u32 last = first + count - 1;
+
+	if (!count)
+		return false;
+	if (last < first)
+		last = U32_MAX;
+	return first <= CELL_ID_WINDOW_LAST && last >= CELL_ID_WINDOW_FIRST;
+}
+
+#else
+
+static inline bool cell_id_in_window(u32 id) { return false; }
+static inline bool cell_range_in_window(u32 first, u32 count) { return false; }
+#endif
+#endif /* _LINUX_CELL_IDS_H */

-- 
2.55.0

