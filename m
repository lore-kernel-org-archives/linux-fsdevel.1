Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9E3BB11C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623669; cv=none; b=IC96IvXAguBVK7IC4TJBHRRaGetp+Pzd/bZXP82euHWQ4T3hRx4bOFholi+XXkmlzp7wJuh8p38UNRUiDHm+tVcVg+dUoomWBYBffUbLwJ+qXgv13jKCMKthxcm9pEQKIYYAcnVtv2tcYY7P+fzQXB2UMQKcUgYS9YsGn73MgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623669; c=relaxed/simple;
	bh=F7E/fevZGREnKNOFDpeucj81dgcEzXnGUrVa6tJQVSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CyUSL2Du6xTqzVuG2UCPe0uSK/Uev+BbSe6ejQ04e/6p8YGgXLMI4tPk8jOv3lWRzkme2YaxTa27MbmqmJAQR512AWPiyLMZTFCZ1dp3CoGj8RgcJvgb/o8slidOT9IpiY9A/QEbv94MshqmOc6Lz+mmav0e9Na+HWlL3vF1PYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcQ/N4mp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcQ/N4mp"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-caf707e3a70so2836175a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 01:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784623668; x=1785228468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pst/rsRfBSd3UPzARuf28kFUe4BuzsljjgHEUWwqZn4=;
        b=bcQ/N4mpdpJg8CV4Jf5RxgQrGJQ9+XVkPKhtheJ6p3v7Wor6fKbcKB1nj5imUDrSCe
         LkIi1h5eSZGEIbH6NgI4hT7gkTyKysHkVz6ysVRYAiHlRwbehfr0uvnqEycn0+AqvByj
         JPEKlDiNmIgmW1zDQQtvIRd5O77OpU2c3iSbzjSY7HYkFS8881ZNTcfZ64IltQ/tSR4j
         /cxhqMhdZX91mvMUsd1mkxb9NqY9MgO6Lh+1T6g7+mWlW0xNzmddm5yJSE7ZJnXCGfD7
         ADVos1uahc2HwDqO3HCl9JhhUVCXFQMxMQEp5bPdyWeqxXlJifsxPBKv3UPvISdX6sJc
         uDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623668; x=1785228468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pst/rsRfBSd3UPzARuf28kFUe4BuzsljjgHEUWwqZn4=;
        b=fcHJlw8h/xdaEJkSye1p8OdLPzPvR0XR/0gEnBCtBlq49zfERBfJ8aDMkebPocwEIh
         xDGSHyWb/8pw0DJjj76yOKsSr/fLJAKtOwxld/I/cXNPOxqeakUA7RJTvl2Cdnn/jVxd
         r26Xa8kuqZlaVyWYWieR8q6s9FY/GRkVcAcPsaI/99K2MYGsvul9FfULY0c2xeq2Swrg
         BSoENNh6680MENLVpJ53dP1jzbUm8u36jrLwXz9BR3myFJX1XW7kG5jsvCN725zb4sBL
         gAZM3wN4j4klRYddZkN+nyyOm9Rw9wqFAXwI7tl8F6gb36ueRqbWCcfEkhBTs9GdW+xy
         ocFg==
X-Gm-Message-State: AOJu0YxZYkiKWygVLJgzcWgHnSXJozLecIhj2bL5PiCUsFsmn0TaOWmC
	e0RbaU/It5VJZ7+Q77YKTb8wsi8hoihT09QlmmuUKLLK2Zhdt3wyhQ4g9ApL6u63
X-Gm-Gg: AfdE7clFq+RyVC6UUTs6odvYeJSel94FiE8flzZWQpHZ4fpYIHAAO+UF5EUEn5O/S5H
	Vt8IHVOBGQJZuxQZE1fEAQkC/1LDiaRuoevIuU50iIWZRzhvgXhKIk6ZToZ5d4d4SEPKc07Q0T9
	Ou/iidaOlLf9OOca3xaU8k0srrnpNifJSdictQcEhCxvH+VmUN7cxgI2A1gA6JggMbYmTYh6i95
	amh/dfjcVCUPCCrsYU+8tmuKZG3NysPLFYgajno8c07anHKa434/O5tYdGHMxRo20ORCY9pdI+n
	b0xi3evgZt6zS+ow5+W+hTbicW1PbzYSvivUTFVGgqH7f9+7R3SP8kkEs2LjY5ZqbyhNGqK9TmF
	D+TkQ4mnQdKp4eQfUUWYBLF5YjBp+to3TrFrCtFyPdGRnIIIgOfMYF/Y6H7GMa+IaxYaJFMj3nC
	wF3O/wV95Fqf85Bx++qHUf0ZpfqVfiLJ+CKCJWOg3RBWYgNmc=
X-Received: by 2002:a05:6300:6690:b0:3b3:a66e:3911 with SMTP id adf61e73a8af0-3c38db31692mr22774653637.19.1784623667613;
        Tue, 21 Jul 2026 01:47:47 -0700 (PDT)
Received: from localhost.localdomain ([125.20.165.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b1f3sm43735487eec.26.2026.07.21.01.47.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 01:47:47 -0700 (PDT)
From: Aayush7352 <aayushdixit924@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aayush7352 <aayushdixit924@gmail.com>
Subject: [PATCH] binfmt_misc: fix leaked write-access denial on F-flag interpreter inode
Date: Tue, 21 Jul 2026 14:17:41 +0530
Message-ID: <20260721084741.79326-1-aayushdixit924@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_binfmt_handler() closes an F-flag (MISC_FMT_OPEN_FILE) entry's
interpreter file without restoring the write access that open_exec()
denied at registration.  Every register/delete cycle of an F entry
leaks one i_writecount denial on the interpreter's inode, so that
inode returns -ETXTBSY to all writers until it is evicted from the
inode cache or the machine reboots.

The registration error path (add_entry failure) correctly calls
exe_file_allow_write_access() before filp_close(), but the normal
teardown path in put_binfmt_handler() was missing it.

Fix by adding exe_file_allow_write_access() before filp_close() in
put_binfmt_handler().  exe_file_allow_write_access() is NULL-safe
and skips FMODE_FSNOTIFY_HSM files, so no imbalance is possible.

Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Aayush7352 <aayushdixit924@gmail.com>
---
 fs/binfmt_misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 84349fcb9..de50a7468 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -162,8 +162,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
 static void put_binfmt_handler(Node *e)
 {
 	if (refcount_dec_and_test(&e->users)) {
-		if (e->flags & MISC_FMT_OPEN_FILE)
+		if (e->flags & MISC_FMT_OPEN_FILE) {
+			exe_file_allow_write_access(e->interp_file);
 			filp_close(e->interp_file, NULL);
+		}
 		kfree(e);
 	}
 }
-- 
2.55.0

