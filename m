Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804468;
	b=dRk70n1JI4FEQV1sWTe6qd99avtEqURquybP6x+Xn1ruMbOvdZ6eciiiLPeCZli4fBrc
	 qckEm5IJjv7zFXmHhBd1MoT4F8tjx9zHIOhs+q4A8bEBnIrQkoG2JbOR8dzPMiltOCMT2
	 v2qxEEJtfLgKA8YZr9p2Gg5LxRhBm/b9PDiZ74SEneuQtPfZwkXOG6eT3qvzEBIAZ3vyz
	 4Wr48Sf9UVJszYs/Jb1qwjdl8oxSn/lXG+YXS6LMPcsZn6dZAyGoT9pi6GPOHrWVLZd9p
	 krwBmXp6f0J1r6r6rFmoASPGEen1jttHznzjQ5NqMiJT7k7cXWczp7jG71eUZ5RSY1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZnL0dEz7DI9cv+KpdECWFbw1dxjA97Ewg+0KEWHPHWA=;
	b=woa0DXKqBATS/j+GCkWU5k3ai1bvu+L5HjT2Obgqg4X568Bfh6quw5lHUOiwrhAU7RR7
	 1MHU3tIRF33A1cc/LbyhDa7+PPas15QjlT50Prn/UI/kSe5nALdHE8qyMdxV1kD1XP19K
	 ieMSB7YFIo50miBoqv5E5582RWOiszQp4FtDk5iyVw5rhHI51L7cGAqmqAQsQwV/IRhbe
	 etIHnDR7/jMoJ+f+Yuojd9+KjCcVn3BFsW2UlcoV2dOCO4gPfBcTQv39G28jBGU4JfnIl
	 nw3gXxosZLQuVYzKdYgw6wyUK7lUdqynxW4QccoRkd2zGd8pAOtJ5vwuR8XyKPuSRNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqPS+VyY;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2F606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 18:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D2F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqPS+VyY
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so72876095e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804467; x=1796409267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZnL0dEz7DI9cv+KpdECWFbw1dxjA97Ewg+0KEWHPHWA=;
        b=BqPS+VyYMKyZ5Kxpq1zgIpEQHLJ/8S0UrvMsapb+eahrWMMbQeUixYsVLminoG3ZKC
         dSKaVhNJ5F4+JHp18WuXkEnENgCnWUbfKJk4qYQNciRdnwd5uH9w5AXOUI6vCOVw3+lU
         YIHAy8qVXkqQ3MatWDRTl7AngbJbp4LVR1zrQwzdq9I3EV3vd+Voup1qSgd93kCrMIqC
         ZMuJwbowj9mhB4xPI2Qq1L5BMp71PMtRkEC7G9INyYT5AkHdsbJvo+gvC6hyRi318ELt
         yiUE3RZt38lXdXCYZVaT35ZBU+ZCGjo1qsFzjJzaMZaKFe2x24AMhaXbUZ/wBGlvYp3M
         5ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804467; x=1796409267;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZnL0dEz7DI9cv+KpdECWFbw1dxjA97Ewg+0KEWHPHWA=;
        b=1/jF1XWVdaCJjA9Fo/p05pKnEJ+oh0u6uytDUGBL28XFkiDYWqp2JWr2zdaeeQog1N
         fdkHOjPMRw+cXj85hnKzuoTz2FJxKjhgCOYXnd5bIlp0E0eONNJadCqe37S+TCsLrIAk
         deuH24BPdkLBGlulEUSehTf1kMP6NU2/fxO84/VQRpSvRjpdoE+t35BwXHxnUZ8jpWFP
         c24LM2f0+omuF7RIwj7pDAfEY1dfi8rQSn6H4Z14+lNKaPpiWfogIfHY96OQ7Kz0txwl
         fzNJN4uJpoXsSAoJoXjyph7JVXWWCxZPtxO7/QcLvEzjfD5bS2jkruyaunIeGKIqSLQj
         u4+w==
X-Gm-Message-State: APuU4Z+PJVZ/r/k5V5QeTPFtsTLLM7UFelR+0t6V6jg99ke9I321QZtC
	W6ZrB56usTL+XI35yssMKmUVRlEge1zeE5madD4OQncUC6qbksWa2DU=
X-Gm-Gg: AZFdTZfTLx2PVqyPLmhorbQ6l1a+sEMqZ599VSzKih9L3fE1nMsH5BE8ipeeSmz4sbh
	6Qv8qY2eTd8jIbwPFbIvoxO4vC7mXj4C8+NnJmY2BWl9xgxEz5+V0ym19NGMHY5f6rPgvpGNsXt
	JxLDW4DpAugI0ZGqO9hhx4/CyyP9A/JUg8dJRHLBh1ikhqiJD8kxfy1Fvx4o1FkTT0UvCJaP0et
	eAYZC5yC08c9ILDu63NekQwiPPivQ7STmTWcXf1RyIs85fY9/keLVy2XF5FnYfDV8mL+xd6Ksur
	9tBwmWtg6JJNHXUJGIvSE6ftKRubCYj60SfeppFZiNm5enCB0sCwf9oCNrj6LqyL3WG4ixwoAzz
	a7wY1zqG7PpnGuBy3wzul7ZyE5H9Ri+N7+u1mthmOmpQi5zKBZUnPcrzwn/2i1TPW3xjFRTpuVP
	EyaN0q34Kbfu5rUVxWPfDLX+sOnJkX/A5qZ8dADq32gt/opqBnnfA56NqlFfJEFbODyUCKBYeCw
	ECxa8a51RyIlA2hx47+N5x0HN7Q+l4+0iQadDvyvG6CZOkUNH1YWBLn2gN7ByonYrgoVRFp+oQV
	KPtdZoJNBW3+l5/W
X-Received: by 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id 5b1f17b1804b1-4bb88817920mr551429755e9.22.1795804466734;
        Fri, 27 Nov 2026 10:34:26 -0800 (PST)
Received: from p183 ([178.172.147.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba6a0d65fsm231669635e9.3.2026.11.27.10.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:34:26 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	adobriyan@gmail.com
Subject: [PATCH 1/1] vfs: delete fasync_struct.magic
Date: Fri, 27 Nov 2026 21:34:15 +0300
Message-ID: <20261127183418.441040-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory corruptions are supposed to be found by KASAN these days.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 Documentation/staging/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/staging/magic-number.rst | 1 -
 Documentation/translations/sp_SP/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 fs/fcntl.c                                                | 6 ------
 include/linux/fs.h                                        | 3 ---
 7 files changed, 14 deletions(-)

diff --git a/Documentation/staging/magic-number.rst b/Documentation/staging/magic-number.rst
index 670d3189a976..6cc11ee25f53 100644
--- a/Documentation/staging/magic-number.rst
+++ b/Documentation/staging/magic-number.rst
@@ -70,7 +70,6 @@ Magic Name            Number           Structure                File
 ===================== ================ ======================== ==========================================
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/uapi/linux/pg.h``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip/slip.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
diff --git a/Documentation/translations/it_IT/staging/magic-number.rst b/Documentation/translations/it_IT/staging/magic-number.rst
index 43dd6398300b..f1d61e5525d1 100644
--- a/Documentation/translations/it_IT/staging/magic-number.rst
+++ b/Documentation/translations/it_IT/staging/magic-number.rst
@@ -76,7 +76,6 @@ Nome magico           Numero           Struttura                File
 ===================== ================ ======================== ==========================================
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
diff --git a/Documentation/translations/sp_SP/process/magic-number.rst b/Documentation/translations/sp_SP/process/magic-number.rst
index f5b4c3f2849f..58834098ac27 100644
--- a/Documentation/translations/sp_SP/process/magic-number.rst
+++ b/Documentation/translations/sp_SP/process/magic-number.rst
@@ -75,7 +75,6 @@ Magic Name            Number           Structure                File
 ===================== ================ ======================== ==========================================
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
index 05ee75cf4346..7d825a37ebef 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -68,7 +68,6 @@ tty源码经常通过特定驱动使用这种方法用来反复地排列特定
 ===================== ================ ======================== ==========================================
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
index bc7eb025dd1e..384149cad76a 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -62,7 +62,6 @@ Linux 魔術數
 ===================== ================ ======================== ==========================================
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9b71bc9d71d1..5e49ec102baa 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1066,7 +1066,6 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
 	}
 
 	rwlock_init(&new->fa_lock);
-	new->magic = FASYNC_MAGIC;
 	new->fa_file = filp;
 	new->fa_fd = fd;
 	new->fa_next = *fapp;
@@ -1130,11 +1129,6 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 		struct fown_struct *fown;
 		unsigned long flags;
 
-		if (fa->magic != FASYNC_MAGIC) {
-			printk(KERN_ERR "kill_fasync: bad magic number in "
-			       "fasync_struct!\n");
-			return;
-		}
 		read_lock_irqsave(&fa->fa_lock, flags);
 		if (fa->fa_file) {
 			fown = file_f_owner(fa->fa_file);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77..053a6e04cd91 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1369,15 +1369,12 @@ static inline struct dentry *file_dentry(const struct file *file)
 
 struct fasync_struct {
 	rwlock_t		fa_lock;
-	int			magic;
 	int			fa_fd;
 	struct fasync_struct	*fa_next; /* singly linked list */
 	struct file		*fa_file;
 	struct rcu_head		fa_rcu;
 };
 
-#define FASYNC_MAGIC 0x4601
-
 /* SMP safe fasync helpers: */
 extern int fasync_helper(int, struct file *, int, struct fasync_struct **);
 extern struct fasync_struct *fasync_insert_entry(int, struct file *, struct fasync_struct **, struct fasync_struct *);
-- 
2.56.1

