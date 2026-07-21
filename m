Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F33C7E16
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627828; cv=none; b=dyDharzDmqJLbkLMxSI48hPZ3Z5H2IN2JZi8DF0+B626ziQtzOqI0fc4HGHntH99s/KiRx1UmDi6UoAMTmltArelA9bEtUNrRVl1JeAfL8eznEnTS4isTMz4Bp+xqKmLpbwONy/kvT4sJE8rqeVhTGLlyu8FPXf+kDh42ZNOUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627828; c=relaxed/simple;
	bh=bgWznk9oVRBJ9R3oMQeubuZtjVDAtCNEiaxdjPJ0AEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0lcPvJwOX9HvrhbyLgf6Qz486Ra/0yhrIGs/hkDvcn3WEU5YUL+6pkCMDWw4/OrGtd5FLlvol4ZpZzkhivCfc4vxCh4b6yl3Pp+VfFJwDb7kQ9wVx9Gs/kS1a1yVsLfDvNdGxGorfx+xgC2vgSuFBTxsNTBrBuuvSGOsJ0ZS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haZzZtTy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haZzZtTy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so8803099a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627826; x=1785232626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8cXrE8/1rGTla5GSK6N2YSNzDuAdTPtHrBFCyOKm5TY=;
        b=haZzZtTy4wdUkNB2KclskqizPk1HJAx4omrkSq0i/2FRSDYsgB7CBma4BYQLL+twwB
         04n2BytmlTBIR/j1ish+YLh1efTHAC4rUbxxVHp5dsLgt3fhOMHw6br3EpqEja3g4B+r
         yM1PyNq4rcgt6+Jo1mSOCMr4evAS3XfVsu5ExEFSbuM3Ftq0DtZhfRQkPFs3i/sbVvL4
         UYHpaEqWOAUy8M59e+IoJ5E1CR66bgA9YPgXD7lo3CcOK8uCl2Jtw7HbJKZGwZM8kpaC
         MJ6ymKgaO/yVP3QpyijRwkjdpe000QwyePtrKdxxG8CKhAs8y7is/TkQKMPz0suKMt7+
         mmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627826; x=1785232626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cXrE8/1rGTla5GSK6N2YSNzDuAdTPtHrBFCyOKm5TY=;
        b=CvgyzSc27Nik/jHNBsTu9vft8TJpNHXjbwdMDYPXfd5OQBzkDko/YxJLgSpk6LQKa5
         U4eDzS838/BQyd3TiKCmGrArwnfeaCe7koH0I61Iz2FECjkv7XMNAkPWqU/q1hklfjqC
         mxsY8wPmGApB5hG6Ob12EJkm6lyJI4XVjp9CgTCIOizL0qEz9tFya3hnv7nhruOd2g0H
         wGz8qeXpDNSNrkiPfgbY7IPndx3ScrZw8sNfd7zgJwERUEif0jHl1N6Uohw2TQI8Tm0p
         9sVxSoBLWi8CQ/ZRoTilStY1eb3Jf+cosCDOMEAKACDk1FpTaJIpPtd/h3nVS5A0DFOO
         otqA==
X-Gm-Message-State: AOJu0YwD3ceveDcALcApyyr2UwFA8/EkV3tlUyIO8UMUwqqZgLMoCLpI
	n68J/XwdS/d+8QZbez3FF/8u6XmaipY1p/2rxTApyiY9QXV3LII5bMDp/fvCCuBm
X-Gm-Gg: AfdE7cn+l3A5aRuTd0e5ycVwXYdZ+zUbLDX9DQMf6dlbC0zHXRzxmWNrwPuv46fskH1
	vCl82R0zWLauz8VVOEZ/Y4DDuImXlRMd6PK+z5HF/x4GnRkWly2snhx/6Tzqh+RMjeK5w41LYC3
	Ui4MPMHzzLF4xOFGqMTDfn7ioZytANA/MEVYTuCFU26RWnH2CPnFcZrsygIYDaJszhwWUmJokMq
	+Qzeoa7xRtSR5zznlgU1ulxaquYtXQGq/EqL8ClC9h2KhhQEej7yNkqWY6zkgZYNskpXtuZBcE4
	mnDcGW1oKfj2yy/Gg3nGpVY5b05QtzTBF1RxmGkQQku12vHTXPy/6HWfXFoBMjoO/Er5MMx+V/j
	nYWmZUoaXgBRuNG8Zrfoiv81GMeZEfn2+kd78OEXHSHndnzk60QdZI6+1f+yBGXoQHedO47D60Q
	tmj5DjLkGIIQqq+nD/TTvQlV5Q1xC+B1mLk5kO
X-Received: by 2002:a05:6a21:7111:b0:3c0:9c19:659b with SMTP id adf61e73a8af0-3c3ada4aaa2mr18870459637.67.1784627826283;
        Tue, 21 Jul 2026 02:57:06 -0700 (PDT)
Received: from localhost.localdomain ([125.20.165.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcaefsm44535314eec.10.2026.07.21.02.57.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 02:57:05 -0700 (PDT)
From: Aayush7352 <aayushdixit924@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aayush Dixit <aayushdixit924@gmail.com>
Subject: [PATCH] binfmt_misc: fix leaked write-access denial on F-flag interpreter inode
Date: Tue, 21 Jul 2026 15:26:59 +0530
Message-ID: <20260721095659.80690-1-aayushdixit924@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aayush Dixit <aayushdixit924@gmail.com>

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

