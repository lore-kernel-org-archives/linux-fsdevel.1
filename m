Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890698;
	b=BsjfVonPkQLV+4pVJe2NERXqKAslcz3OBf0TMlHEN6iBi4g3HjllL2qSJbYuPO/0Hxy+
	 ynBzs4BcFvu21FD1UyHfKjqTDbX72N+94hHQIe9wQCg3XWQeiUEWvlb/qmAnhN9pNDLi0
	 tDsYttre+mz9amuGU6D3kU5IKxPyn8yALKoXzV1gIqiiyY6+EyvIItepTw/z59BeJlR+1
	 Hkrob2CvkRCB1mi9uxmgGOsdlPo+YvRswVpTU9G7ywRGqDNeDbEKyLs9c27RGpTJO1Ka6
	 fiYm+8t+/XNpbKq8ln6MoF6Dhj2zpI1kl7DscC03YUibUbTq9MM1Dk5yrQBLrK+MnuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=N2Sw5k2zoAbf8kMPvXvGclCJzMguKEAbJOTPyXxLomU=;
	b=iit9U1AsjIYIFp47+wbq/i5+ahmma55YM/EWiMA8bzGccMzphJZAYwTth0/SmPHnTwGV
	 pjltp4eySZ0ZYUb8XjYeHdc6JQRybC4O8E2OifDinsawYDwuoypwu/XVtTCO3CRmj0DNH
	 IsHo+wYwAawuYHieZ65tuNSEwKGOTDk34uMKCi3oiiTSZvwtRhCHPxPetozkjW5NAOSEx
	 4Di8opMr+ze6DJ55ac5kwFwlKxF9XdRhdgK3qcDTmRNVFyJ8MqfScFRh6cmSAWVA8ZJC7
	 bxNr+5K75mFGEKswmu4hjzCIo9S1YujW+/cCFHTDYeHGqx7F8vbyFS9FcLKkxNPnWYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cUkzH9nV;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F8606D839
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3F8606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cUkzH9nV
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4ad881b6517so253808fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890697; x=1794495497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2Sw5k2zoAbf8kMPvXvGclCJzMguKEAbJOTPyXxLomU=;
        b=cUkzH9nVh0CF0EBc9T+AQdS/3nNNE6tdOjn75GHN2koVLh7GoGrvjOCRGW84jf5iG+
         tudm86E1OSWUU9hFQM8ERCHMpPCjRJW5zt7zicSb2Qaik59an2iIiYEUuhUIxx6gUIcq
         fgDB2256saUYE8DA+t8neyNawnRIubLkTdTFfDpADRGhJjll0JihxKpK32ukAqFy6knj
         CDTy1vVK1k7SvpSWeZhpO+O5VsaQA5zK2RdS8g89/5V7Pz8ABLK4HExdXygsiWvZ6Zow
         aecMyIdRLoWmmZwyR7IuOxXz7xwnBLarTfKFsaGXcET9jvHrHsItDqufw/VLeeDA2Ax7
         Mt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890697; x=1794495497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2Sw5k2zoAbf8kMPvXvGclCJzMguKEAbJOTPyXxLomU=;
        b=uqUExCkX7h3fM4AwFmlAd3gKyKiPg0zPqWyeJyDTn2DfDNicLtoftyXrw/O5nG1uvY
         VJ1D+09ekfcHHOUHBsDG4gzsErkQd75NEgUH1RNK68NEzBLVlo8UqWx1y6ErcwgWOR6l
         gyGfKKtHJYMrP6l+qo/mnwGEQYl4bLZ0YK5MLxPV7EIveWnzPaNdwP+ColJxu+5pWdPF
         e4jxz6ZyaUIt2sNlrSZ5o7C5R3x9BLMtLRefD05XqkV9/WkOL4M/R03c+zen+HdA9vIt
         7WxTwL3UJbZruih30znfRWm9nQHtlUBMHcBw6j1Sr/DVxml2q0GjUnFrRaUDxEzCPoHx
         mjAA==
X-Gm-Message-State: APuU4Z9kD+Y5l0XcecPuGmzJx55//9NuDEZL9XoeFLvnmBMByjMe+9GA
	lr8niXCooba9iWNMSwMfuL03451PbUpHseNZIQTQP0Hbi9lUiBSnJS0eTXv50psh5fo8aVBa6eR
	nr9iDUak=
X-Gm-Gg: AYBFou0GFux01Y+f8cEa39dMpz62tLZg9zf15trud2xfW3WNmX5JHdy4koltenO/c+M
	V6cc1e4Kvvsvz5Za4xUdpdugF33209xxlUD70ty1YEOcCbFACyk9OeqiKyTCEbpO/O45jxz5TYs
	DBhfVDVOkDpSL8T0PdCLheGg/0YFpAoENvoyagpmhe3B45s7XHWeaUf7yc3VDH0jeIqUwLWK6NL
	NCiL7LDQ0BlrWJjnruQ+b4jhMu0hJFUjfCB5sgXeU9vzmNQN0ltX1iXCCSdEDGFKAY9fKTNPGmY
	LtL8F4DHajYI0gfp1b/fGXD/yJx4w7TipmV6FWLMfumjlcPxAQOz1b27Z6jVZKjszhPP2PYJcPl
	2mpdG2oIe+iz7RirCFihKlEDRNzxdXtPaXamgK95QEhlWZiFWRD5f6oI3QNhtTj2gHuPIFWIh7z
	rclUDQm4B+fxoieNAKLhiIddk95P+mtlhwGXKwI3TNb4ZtG+QFYEvPp9U4HN7dVNpwISIfghBTy
	bD6NIC6FoChtWnt8L2CZ/9DLV7qkCEg5QloHdSF1NrQxTCJ29MgtiBSsQimwrsLV/sO7VI+IuC/
	xQgJn6o6UAU7L2fONGhAiIZBOIKkHUjRSxzNg+ya+VpviA==
X-Received: by 2002:a05:6808:4f07:b0:4e6:b6a1:5af2 with SMTP id 5614622812f47-5640dec8e9dmr14562981b6e.51.1793890696980;
        Thu, 05 Nov 2026 06:58:16 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567ab6a5270sm4310527b6e.0.2026.11.05.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:02 +0000
Subject: [PATCH RFC v3 11/90] keys: add key_user_range_in_use()
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
Message-Id: <20261105-b4-cells-v3-11-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=2810;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FsWxd9HeFTqWLJHWFepRnb32ZJGXZSQ+D5GxnVuPwnE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM4q50/Vtn2BVCZXSWdRPrBYhO+eUfTN4poTCTQy5zQKsnEv6M1CUaQGKBoNweOydR+a2m4acAF
 YFGWrNpZ3Rw4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The key quota record of a user is looked up by a bare kuid and does not
pin a user namespace. The record, and possibly keys that are charged to
it, can still exist after the cell that used the kuid is gone. If the
block is then lent to another cell, that cell would find them.

Add key_user_range_in_use(), so that the block allocator can ask whether a
quota record exists for any kuid in a range.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/key.h |  2 ++
 security/keys/key.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 115db6e60254..0bd77fcab4db 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -461,6 +461,7 @@ extern void key_set_timeout(struct key *, unsigned);
 extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
 				 enum key_need_perm need_perm);
 extern void key_free_user_ns(struct user_namespace *);
+bool key_user_range_in_use(kuid_t first, kuid_t last);
 
 static inline short key_read_state(const struct key *key)
 {
@@ -521,6 +522,7 @@ extern void key_init(void);
 #define key_fsgid_changed(c)		do { } while(0)
 #define key_init()			do { } while(0)
 #define key_free_user_ns(ns)		do { } while(0)
+static inline bool key_user_range_in_use(kuid_t first, kuid_t last) { return false; }
 #define key_remove_domain(d)		do { } while(0)
 #define key_lookup(k)			NULL
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 6ebb8691551f..0a6e741805d6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -113,6 +113,44 @@ struct key_user *key_user_lookup(kuid_t uid)
 	return user;
 }
 
+#ifdef CONFIG_CELLS
+struct key_user_range {
+	kuid_t first;
+	kuid_t last;
+};
+
+static int key_user_range_cmp(const void *key, const struct rb_node *n)
+{
+	const struct key_user *user = rb_entry(n, struct key_user, node);
+	const struct key_user_range *range = key;
+
+	if (uid_lt(range->last, user->uid))
+		return -1;
+	if (uid_gt(range->first, user->uid))
+		return 1;
+	return 0;
+}
+
+/**
+ * key_user_range_in_use - is there a quota record for any uid of a range?
+ * @first: the first uid of the range
+ * @last:  the last
+ *
+ * A quota record, and so possibly a key, is keyed by a bare kuid and pins no
+ * user namespace. The id block allocator asks before it lends a block, and
+ * before it takes one back.
+ *
+ * Return: true if there is one.
+ */
+bool key_user_range_in_use(kuid_t first, kuid_t last)
+{
+	struct key_user_range range = { .first = first, .last = last };
+
+	guard(spinlock)(&key_user_lock);
+	return rb_find(&range, &key_user_tree, key_user_range_cmp);
+}
+#endif
+
 /*
  * Dispose of a user structure
  */

-- 
2.55.0

