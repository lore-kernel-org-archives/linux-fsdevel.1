Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890723;
	b=xJO0Q5Z2+lTCLpg0CfJhkcz73cEzxpaipFH00c7KLBL+vofFEG245d4yYop3zbOSCAnG
	 XeCsBQby/wvReQqMVYkmiMkfFIeHmEq9pKwfK9gIIT6hLKhS/k+6oTmrYFRQuHEKX5yWY
	 GBEE/7bvMJbI5EahbbCgaCNsrRR4Jal/htG0l0xes5ypIMjknxGVUYxC3XheD+bfxgtvr
	 ZEX5wkyU+AmPO1kzlQ1jI/08XLMk5ilEcPgs75KmRX5j7Rfe++WHK1g0X0FQRbxDK3L2v
	 jYiQtUz27vebi3MdH1HbLZqa2hBavFzgZdmyAJFutSnOaz4eC8yBiYCNRzurhbPuh4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=GXf1OlJCBQmaXmhy+CXLnH1C6s0TuF7O4mjKSnLUX/0=;
	b=ISpbUgrOfF/cBKhRfM1+N5FQqC4DBrXmkBq/CcRrEUhmVbmJqzDxLSXmGlW/OCrEziGb
	 t3fXlwvwiZsumublHmxQSPtTFyZ3xra+BzmSVkq3lDlkgmVXg3azbKHoEGqBLuaIcgqGs
	 FKEEU5h0BSdpXdX+ycgsFege5+uJEKfR8Cx1Qyg2QyVwx2V9RtyKZVxMlW/iCv+W46mPx
	 d58zoAeIf2+MjIgpl+2rrKKdgXR1u+XF4C7RO3JnZhhst8KdYheILF6KpY5qi0s+WSkfu
	 ojwLiDp93+/0pPo/xQxyr8QlPiiBFGKwAkj0u+fNAo0r/R74llgIAL8Y0XMr9G+6oKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Q1YEybis;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836DB606A328
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 836DB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Q1YEybis
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ea0c05c92so3719596d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890721; x=1794495521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXf1OlJCBQmaXmhy+CXLnH1C6s0TuF7O4mjKSnLUX/0=;
        b=Q1YEybisqf9RratfUVhww3ffmdabO6RJUlY0jEz2D9vkyQxAVyei5+myI7WQhg0S+Y
         JCapHhQqvsM/oIYbE2RENSxJ3FGNEGWqDUFl03gN+5ev1ks4eXcAbamzT4rn9r7mcE1K
         TyN0WGwROnpEusPea82iudPWn9jf38feFz5JJuof/4EYyPSLtBgAzOjK0Q8LV78vt1yg
         J0WQdIKh6SpHrC5t7vgS5AKlm4eS/pI5S50AsRxZm7vRCoc+or1rjAbie8QaTkqUj3BT
         B1/Dz3yLnQxBOGH8CnxzPhQ3FYg2OFp/U3koyp+I/BYWI0C85CIEx///RwqiVKWi8qJ9
         a+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890721; x=1794495521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXf1OlJCBQmaXmhy+CXLnH1C6s0TuF7O4mjKSnLUX/0=;
        b=CNi2mG6vD2ZjHagz2C9a8mrhnEIJK2yrC8RFK/hMIyQhLS4l3hCkpWRKeMBAYha0jU
         7Z2d4Xm80Qb81kW9XY4GO804ci8sIYddY3YsREs7ttdmW5vTTBLbh4HxDOeVY/nn+WGl
         O7HDCUeTHZbieb5ug1kRZcsEL4rATi3sSP72pY3B7eB0zrKbPyK3SXN4DtpoAWArbzGd
         CXhyr50PaQ8f1J1uLmhOfiaDXOtDDv0r6jOgvTPThfCJw0epQKeGkFLf5N/SotYrC4M0
         OLrjxwEuDrjIwapVdsirq/Tsqog74GmAycY9BENsSv5/4X7sJpyZaCHFZjg2NfpHWT6X
         kQ0w==
X-Gm-Message-State: APuU4Z+MGi0/HTbRC+MAPr8SAeC/xgubgSvKnefw5VBUon4Z1J9QRFhn
	4/5QpluvpzR93e4S33eZR6elQ7xmKLCBo/xiKXKsHXJuBh+Ac/ppibGSslXxW7AjB4c=
X-Gm-Gg: AYBFou18LjM6qwOgurt2VC5EEHzWRZf33ljog8SZgNVaMCd6YJovHB2UWOmMtke6781
	IKDXQPelesU58rUpP72WsKNGeZtcLqhk/aRnYADCfIZ+s7WgRe0ydF7gTmHZmJF1uH51c8nxtz6
	1ZJB5KrJYXoqacnCWQUoThHa+E0nAdaac6L/YiiZNZVIz6ywV7LPC05xwIc2+R9wMU1M4VzA/wK
	s1Z6kZg/TYK5419X/Gjrec9fvQePZCe+p+PWlG1xOBWHpIECLz3JxKV0V60bBF6xOluoyD6T2yZ
	lGCIZBxdqev8wGr43S0BLfhGRv403SF9SgYOnqRtKwTt2Ui53clwBdA51sjRV4I8wfjeBLLWgYl
	WWbNtn4BtjQ2IqMzETND0vvOLNfTMi77K7UQ15LC4f1uV3VmL2Q9fcl/UuDU6yaty/fdsK6WY/6
	RddPDhHw1edelLjFEem1Lg6a2ipleRO6tqcaMK4TbeXUIsyfMg5ghM7g+cPvGTuIe0hKADt2E29
	eC5CcDP91hQWO1HULqPoSCWjAZVNhZbpw2CbyQkxGMw/LS4yBREiP6ey+0xvZT9N0A2XJbHgy6P
	v2RHrsRybQVm9xOig99P06dAX3sDbgTRv5c5rOWWBfmklg==
X-Received: by 2002:a05:620a:a90c:b0:945:d852:15fb with SMTP id af79cd13be357-945d85226ccmr643932285a.69.1793890721539;
        Thu, 05 Nov 2026 06:58:41 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4691a76sm480799185a.4.2026.11.05.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:13 +0000
Subject: [PATCH RFC v3 22/90] nsfs: make open_namespace() available outside
 of fs/
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
Message-Id: <20261105-b4-cells-v3-22-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=2897;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Cpw5XQSfeFmZprja2NttUNWqBgRPkOiqn9DKgMo3mh0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD+MLZs/TNSwTZKPOX+qke7bv+zAZmNRB+WjjWQ7blBmR6YEQpDrGqRPyvBZlkRia4JYKMoU+gu
 W1AUe+gcDXw8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

While a cell is being built it hands out nsfs file descriptors for its
network and pid namespaces. That code lives in kernel/cell/ and needs
open_namespace(). Move the declaration from fs/internal.h to linux/nsfs.h.

The name is too generic for a function that is visible everywhere. Rename
it to ns_open_namespace(), in line with the other functions that are
declared in that header.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/internal.h        | 1 -
 fs/nsfs.c            | 6 +++---
 fs/pidfs.c           | 4 ++--
 include/linux/nsfs.h | 1 +
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 2ce49dff6ee1..8446aed78466 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -251,7 +251,6 @@ extern void mnt_pin_kill(struct mount *m);
  * fs/nsfs.c
  */
 extern const struct dentry_operations ns_dentry_operations;
-int open_namespace(struct ns_common *ns);
 struct file *open_namespace_file(struct ns_common *ns);
 
 /*
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 8179d69da038..2c7165bb6739 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -113,14 +113,14 @@ struct file *open_namespace_file(struct ns_common *ns)
 }
 
 /**
- * open_namespace - open a namespace
+ * ns_open_namespace - open a namespace
  * @ns: the namespace to open
  *
  * This will consume a reference to @ns indendent of success or failure.
  *
  * Return: A file descriptor on success or a negative error code on failure.
  */
-int open_namespace(struct ns_common *ns)
+int ns_open_namespace(struct ns_common *ns)
 {
 	struct path path __free(path_put) = {};
 	int err;
@@ -142,7 +142,7 @@ int open_related_ns(struct ns_common *ns,
 	if (IS_ERR(relative))
 		return PTR_ERR(relative);
 
-	return open_namespace(relative);
+	return ns_open_namespace(relative);
 }
 EXPORT_SYMBOL_GPL(open_related_ns);
 
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 114d2713a79e..ef305cc359eb 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -709,8 +709,8 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (error)
 		return error;
 
-	/* open_namespace() unconditionally consumes the reference */
-	return open_namespace(ns_common);
+	/* ns_open_namespace() unconditionally consumes the reference */
+	return ns_open_namespace(ns_common);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/include/linux/nsfs.h b/include/linux/nsfs.h
index 731b67fc2fec..4cb87c7644a2 100644
--- a/include/linux/nsfs.h
+++ b/include/linux/nsfs.h
@@ -23,6 +23,7 @@ bool ns_match(const struct ns_common *ns, dev_t dev, ino_t ino);
 int ns_get_name(char *buf, size_t size, struct task_struct *task,
 			const struct proc_ns_operations *ns_ops);
 void nsfs_init(void);
+int ns_open_namespace(struct ns_common *ns);
 
 #define __current_namespace_from_type(__ns)				\
 	_Generic((__ns),						\

-- 
2.55.0

