Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890695;
	b=2LFm17uHL7ZbWrgAB/kWhzPkmiuWtUo9spgJGVKjM1ZMZKz63N8IXAjGy6tDeddEx8bT
	 ZeHy2YuYO7TLpj/a5Fe0Lx5Pt2uxpTutFePA0GA+/1BsCFhuP9p/QzNA8/hoTHQr7GG1i
	 qLje2VcXW/WNTsPrQdJReyvR5SQTqh56prPwNgapgv6FcJy/GMhe9NQMvdtig6YeRe+bQ
	 w22zDKqwyANIBDIFQWx7OuYGvtJFdGgQszShnr291WjBZZClfikYyk8zKYHC0c2syKpIv
	 8BkEtbtMdfZgZ30sqkFdI1QiEY5bZuPCd+eQwKofXOuHPPA+4TUo80p6RPRDNElDUow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=n8KlRql37zZhzcrWtiUq/YJzuLrtZ3+UZAwWXCQZmLk=;
	b=dGubTSFC7ddMeMQiRei4W5PWESQZnlUv68JEs3XL7EOKw9sTRMf/w3B13jzTU2oCQsMm
	 GIc4dZV1CBz3L5N44k9vM20rnFdWB7Gh+GW5ZMGDadd6EyGz+aAsZB0uv2jPWQpFMJniP
	 fHEKgKEheHPC22E9U5yB9Qnde6yW10QA444SD+BMlgz+7ap+gcwiZhl5yrumwORJ1JVyb
	 q8W0ztGg7fuc9lY/nTX2dgtbQqL2OeOdcqG+UEpu5lhS+/jAccCvv+06IxqxRcmN9LGxT
	 Whkm4/h5zrpjGYgAw/ZhTSPvqLO+J2AXqZeiH8q/kAkEaiPLEu14uCjhR+WKP3q1oww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nsnvqRkc;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08886082BDF
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E08886082BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nsnvqRkc
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-84a248254f4so1134291a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890694; x=1794495494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8KlRql37zZhzcrWtiUq/YJzuLrtZ3+UZAwWXCQZmLk=;
        b=nsnvqRkc77TVsfXyMlj6CiiKo+ONWgJ0s/rKHnhL+CfnjAoUQiNPJg8suJ0xmaUIVk
         eq8d8VlQoIGKC7D7MbwbzPGETJpUeI0/TB/qSHZhHSC17CD6T2EUPtHGkSThuOi2j0Ue
         idhvwi4f4IXhh96MHL9TmkJjhNRFxLGRQCJKrlhd2xAl3r9MqLaPW8XfSqDiSELy5gHd
         RVuaMlRS9CVFnPP+YI+tj6rbapS5Xq6K0gvhh3LWV2ofyBUu7i24FvICTn9AaoBr7aCd
         Kk8Z0wGxsgSJYiopKAMQJ2OIwFamM6uL9Lt51fwyR3khnxXH2NUAkMf9LWq+Lxu8frwc
         UCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890694; x=1794495494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8KlRql37zZhzcrWtiUq/YJzuLrtZ3+UZAwWXCQZmLk=;
        b=cCwaTrnZ4OeHg4iUJaYf3HGk/GVCielX0kVL9SXh1L0lD1Z9ayuPsfXIm9ju9JJNEe
         VLjZtGiBPNbK0Cns3OtjNcBTDRYiJtBPJUl2eGL0eNjzT5FwWoM75WyFf/4VLYKbStDt
         zkDPV2PLoSDn3trfmdtrgLiBaNngmjMOUcL4d6jaQRUxRQ4nbIK+pUAw/AJIp6Q4814i
         AWwp0PcepOxldcAgwY0+PqllQD9a9TZ/AhQWEhClaWKsHDW0WXSdz4d21Qqz2oi8wOV2
         qput4NVSRzuJmbtfHXXIdlT4yn8Gj6JBRa65HziYFBp3AlWsB3bNNzr3Ib7C5Ycg4b8w
         lR/w==
X-Gm-Message-State: APuU4Z9SWwNEspZCxk23SqN3HjiUXYao1IXsJrSSGBEWD5OEO3K9nbrs
	Jd0aMORScJsu5NtMShUXkzqINqYOv8B2BZ0ebmE20TgEe+5LilvxxglGeE5MOtCg6Zg=
X-Gm-Gg: AYBFou2qHyGoCml/jaXgBYbfW69hXFNU5/30h3RQLypk7DgXI9aIZHoVSgx7Gfvf1zN
	5LYxhhvQhw1OCYoH8V7tWjfbFYT62/X6Dwtg1bbDt/1IIq8HaweFYbtxRkjafLB9IE6kHazQFlU
	GR6+zd17hyom4qDux81QKYGsB71/hXF1hr8jVGkF3kYhNGqoqCEkkQtxOo5XaAM3bPD0kQeoSK/
	Sta8JjHi1m9+GU1fGvk0hLZrUqaaVflAwyRDHhTlwCu0W6MEiurCpdF8ziwnlbV3CDFXBx4x76j
	8Q0TTNg8HJ1XCBIDP2xqDLLivd+KJNArRUqXOWUDLwEfNezERLlMk4AtJ7aHWOHdwY6rt0ZrpbI
	g5SKjqmo8z7xpaA5Hbsr/jsAR7p1FJaZRUfYoefcqOOUC1CtUp3IwKbY6tInRCRQf1FJnz0eYf/
	s9+MjbSTnUKaT9QCZbYeL1d+iQp1cpI32xRzVlX3/dofsWjSEBp8dfL0J0ZlrVDZrEkmwAmaZbP
	cfWE5F35BdPsdZ7ni2Ql33qFXyL7ghqICowM/Bbg2G89gR9zsvn3Hs+AwFFvuzFvgBdwKoUyuen
	R9946va2IO4dfXHM6qw2+immJUNDibOatvblCLafIPgMvQ==
X-Received: by 2002:a05:6830:2e04:b0:84b:c230:c2c1 with SMTP id 46e09a7af769-85d36400d05mr20652432a34.18.1793890693809;
        Thu, 05 Nov 2026 06:58:13 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3dd8e0bsm4540509a34.11.2026.11.05.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:01 +0000
Subject: [PATCH RFC v3 10/90] user: add uid_range_in_use()
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
Message-Id: <20261105-b4-cells-v3-10-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=2228;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=A67jx9CN/4Nku0qN6fflC+v+zmDOHx7clVwYdMOrGpM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK3+61hDWhWuF24XmZdX33PUUniNQ+qb4CC024OSRK4VSnZzOg/HR+BcK7Hd02ot1g1Di/MY3iO
 5QtAcjdYQCQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A user_struct is looked up by a bare kuid and does not pin a user
namespace. So it can still exist after the cell that used the kuid is
gone. If the block is then lent to another cell, that cell would find the
old user_struct.

Add uid_range_in_use(), so that the block allocator can ask whether a
user_struct exists for any kuid in a range.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/sched/user.h |  1 +
 kernel/user.c              | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index ec262b605437..5966e355db9f 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -55,5 +55,6 @@ static inline struct user_struct *get_uid(struct user_struct *u)
 	return u;
 }
 extern void free_uid(struct user_struct *);
+bool uid_range_in_use(kuid_t first, kuid_t last);
 
 #endif /* _LINUX_SCHED_USER_H */
diff --git a/kernel/user.c b/kernel/user.c
index 21bafdc11379..b69cab2a5a3b 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -154,6 +154,38 @@ static void user_epoll_free(struct user_struct *up)
 #endif
 }
 
+#ifdef CONFIG_CELLS
+/**
+ * uid_range_in_use - is there a user_struct for any uid of a range?
+ * @first: the first uid of the range
+ * @last:  the last
+ *
+ * A user_struct is keyed by a bare kuid and pins no user namespace. The id block
+ * allocator asks before it lends a block, and before it takes one back.
+ *
+ * Return: true if there is one.
+ */
+bool uid_range_in_use(kuid_t first, kuid_t last)
+{
+	struct user_struct *user;
+	unsigned long flags;
+	bool ret = false;
+	int i;
+
+	spin_lock_irqsave(&uidhash_lock, flags);
+	for (i = 0; i < UIDHASH_SZ && !ret; i++) {
+		hlist_for_each_entry(user, &uidhash_table[i], uidhash_node) {
+			if (uid_gte(user->uid, first) && uid_lte(user->uid, last)) {
+				ret = true;
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&uidhash_lock, flags);
+	return ret;
+}
+#endif
+
 /* IRQs are disabled and uidhash_lock is held upon function entry.
  * IRQ state (as stored in flags) is restored and uidhash_lock released
  * upon function exit.

-- 
2.55.0

