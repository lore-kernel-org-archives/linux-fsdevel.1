Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626849;
	b=aGdmgyzf1X5g/Lv1LPksiEbtmhgkLDngtQmbBBBNjUtPqga3m8UiuMefvYYX2RSUt3hh
	 7BT7i2Nh+HLVpQqhBiahql/4pXCYMZKoUF5qUbfduI9t2ovWj+S6+zfsIvvk/wXRkhNfG
	 Yy4GTR5GBoJV+s7rnyJkMuQCWW4KJ7KwOGNMcXaBLrhWYUS6/D2Sy6xRrBNBArcacm+JA
	 abQDZTD9WFPEefu/9vPfrClqsXJgxPsR7/f0g1vFNeCGdMSr3p+Lp5mOULtDQYTGV9wdr
	 TI5Oj8k49HiaIfd9+TPcf/dGKUdQRjazLb3rm7aBehlkUBHQUnpFv5ALM2WIRZYLgEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vi7Ga8AzaOEpzqmIG0jTgw8eJ4TgVhlTduBxELRLKlk=;
	b=lCu17Os8TiYKsLrrOb47FqCntwhyzvE1CSE4u1KKze8KRTifQbqjC4b4VlZ2Jd2Qn4O2
	 ciSdnhy3oDEXuvqkZTKOR6NBG+ZlukoIvCOEE/RopxahJPk/sHVy10rgUQ9ocPQ4ww1oh
	 dRqW8sPapNs6sUxLw0+8Zf6b+LFc9G00O8NPo1Vr7IWCZ2XGk03EVBfLHY5nZV1fMuxGo
	 1v27MuL49JZaOp5y0hgbEq/bd/UAu0i4z/RdD5C4HoOLHbTgCxWsJmoEQxrnkrT4pyJIe
	 ZnwrI1P7G3uB88NC5d7xeqHmn4Wwtv1Q7MyEg+bv4EyTKed+8NJxBAuuX/TM8ltrtcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oTkpIRp6;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A5606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oTkpIRp6
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so1388861a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795626848; x=1796231648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vi7Ga8AzaOEpzqmIG0jTgw8eJ4TgVhlTduBxELRLKlk=;
        b=oTkpIRp6ca4AvCwdWImpn3mA0hDMjNB5LJqCpg/VPu2Dn2kn/JgZ5wqO7f4l04C7Ob
         qYahaX8BB8CkoORfW3RbeoYWwBu2K8dlwk2ma8ltBhRH7OBqA9BU2yoYQqPQG6w8MnSY
         d+wPwfU3o+TYJ3sCzwA8sAxzzUlg74UnTAwZt5SSr1MOBJaGt025TFdPgWLIELwQEnG4
         WJ36OttRxq2E0KsE1Cd2qOp7VzlGfEGt8CODbpYY8IH0j+lb4X+xTqtoyj85pBTIUl5o
         4TftDPObNSly8PNPmxDlv90cZ26khwRe+rVP6qBXtZMiX6RjQCLjQDYpbctv5WW4aaWc
         khxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626848; x=1796231648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vi7Ga8AzaOEpzqmIG0jTgw8eJ4TgVhlTduBxELRLKlk=;
        b=S9VcbUGY8ZNkbMo64VHnQSxxSoy87B/BXIx7vZKj44TbUu/AbmKZAl/KtxIEKtf6tW
         0xQqGf0asIKXkILcM7+bdp4ZkEd7AOEO7swe9j9otANUMFZuv2PG2S8hhYq2m0IJb9b5
         AATyF3oo5BgrLfkwDQ+6vSXQahXVK4QFzBKkujbUh23+5HECIb5flDdRINqR1ql3h8Mo
         VzN4jz4dM+Q8w3TK0r5E4AZd1vQNVeonHopNxcPq1y7qKJS9bLznyBBzby0W5KBtxLTX
         gD4EeGNcFgk5uOrofZ8Q1af9EQPdQRApGyCyYLYjRaoHfkKuhE2e7LSwWBNSq2BK44Jn
         7i4w==
X-Forwarded-Encrypted: i=1; AL+hErGiBjz9/LFA9ar3JMUn2vqZIQvyWnfD8mk3kO+06S4i2gyNPCL9mgXOjxDOnQEThE/FWseqnFPduyStHGbV@vger.kernel.org
X-Gm-Message-State: APuU4Z+JoNvh5m2Xq8RUOWw1s54ZuSFIcPiSHKcQtYq1fmBKeRdjk+fH
	7jeu5mV6uG15fxYqyQ9940YSrSKttaSMikqaz5GLNTGf9UvqZeGr87MF
X-Gm-Gg: AZFdTZeDvQT4SvGljDr3N+0ocGUVERCfp+jzKkFZ2pGCQtop+DfnEL5bdpmyhEG4MKW
	rjFZDTjYAYF7VN6OsPe8fRvo5MzQzgLPoO0B9FrUEzqcs0G43nIkfarCLS1BnMPj5krzYdujKgn
	8JsEj1WFLAmOaLCnd7CN0TasbWYsqrSXF41qh/mZ+Khf0h3VKOOvP7GTuBFs1ELH9RWRY9M12Sz
	YsS1l26JWskB9IP4+dOsqpwqy6QjK8c6QkkPgzWdMQBZIYZj/ji+gwK48TZdFro+amo0RwQUVlx
	Xbv8ZJSgJN0oN8OMu1IFuwDdqXEYQR3TMAc1v6w2RyYJd3ViXIvrHiaEVf4xvBS5cSsQuh4kRwK
	rwpw5Lui8NtGxzX7Y2ket77I2Wdw1I96vW25g0a/r+EvqChcYkLebDUf8co4/4ddf4VHiJfk6YD
	mTnCyH4fAl329WIb1zfxVewSoo/Sd9y0uvToRb0Va/FaMi24YJ7hLdK+FBq3V/nD8TqZSYa8u2g
	MGzpoZbP7i1jEx+a/HLRCu8Z7LGeQMyiD2ygMLQ4yS/53tBPKAElrdP4gNbrMOjGR0wjIjYLcFl
	ZCoAOjJk1s0HiUk0SLIcrGTtIg==
X-Received: by 2002:a17:90b:2cce:b0:3b0:aaed:48d0 with SMTP id 98e67ed59e1d1-3b41c94ff49mr18412826a91.37.1795626848400;
        Wed, 25 Nov 2026 09:14:08 -0800 (PST)
Received: from localhost.localdomain ([2404:c140:2100:6::1b:9648])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm28925368a91.13.2026.11.25.09.14.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 09:14:08 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>,
	Jeff Layton <jlayton@kernel.org>,
	Kyuwon Cho <kyuwoncho18@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] statmount: retry an overflowed seq buffer before any other check
Date: Thu, 26 Nov 2026 01:13:48 +0800
Message-ID: <20261125-statmount-retry-v2-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

statmount_string() checks whether the seq_file overflowed only after
two earlier returns, and both can hide the overflow.

The size check runs first. After an overflow, seq->count equals
seq->size, so every buffer of up to sizeof(struct statmount) +
seq->size bytes gets -EOVERFLOW, and the retry with a larger seq buffer
never runs. The result can still fit in such a buffer.
statmount_mnt_root() and statmount_sb_source() write escaped strings
and unescape them in place, so the escaped form can overflow the
3 * PATH_MAX seq buffer while the final string is much shorter. A bind
mount whose root is a 3765-byte path of spaces needs a 4.3 KiB buffer,
but STATMOUNT_MNT_ROOT fails with -EOVERFLOW for every buffer up to
12800 bytes and succeeds from 12801.

The early return for a string that emits nothing runs before both. The
NUL written after a string that ends one byte before the end of the seq
buffer leaves seq->count == seq->size. The next string then emits
nothing, and the early return drops it with no error and no retry. With
a tmpfs mounted on a 12278-byte path, statmount() for
STATMOUNT_FS_TYPE | STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT |
STATMOUNT_SB_SOURCE returns 0 without STATMOUNT_SB_SOURCE.

Check for the overflow before both, so the string is regenerated in a
larger seq buffer.

Fixes: 68385d77c05b ("statmount: simplify string option retrieval")
Fixes: 75ead69a7173 ("fs: don't let statmount return empty strings")
Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
Closes: https://lore.kernel.org/all/179552693473.1490262.10477620788152048784@gmail.com/
Suggested-by: Kyuwon Cho <kyuwoncho18@gmail.com>
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
    v2: move the check above the "seq->count == start" return as well,
    which also fixes the dropped string Kyuwon found.
    
    v1: https://lore.kernel.org/all/20261120033644.99834-1-dingf3ng@gmail.com/
    
    Tested on v7.4-rc3 (65e4fd942), arm64 tinyconfig in QEMU:
    
      case                                          v7.4-rc3   v1         v2
      STATMOUNT_MNT_ROOT, 3765-byte root of spaces,
        bufsize 8192 or 12800                       EOVERFLOW  ok         ok
        bufsize 4096                                EOVERFLOW  EOVERFLOW  EOVERFLOW
      tmpfs on a 12278-byte path, SB_SOURCE         missing    missing    tmpfs
      tmpfs on a 12276, 12277, 12279 or 12280-byte
        path, SB_SOURCE                             tmpfs      tmpfs      tmpfs
    
    A plain bind mount gives the same results on all three (1024 ok, 512
    EOVERFLOW).
    
    A string that legitimately emits nothing after a full seq buffer now
    costs one retry, and a buffer too small for a string longer than the
    seq buffer costs one or more retries before -EOVERFLOW.

 fs/namespace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index aecd05ac0..3c41fd42c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5807,6 +5807,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		return -EINVAL;
 	}
 
+	/* signal a retry */
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
+
 	/*
 	 * If nothing was emitted, return to avoid setting the flag
 	 * and terminating the buffer.
@@ -5818,10 +5822,6 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 	if (kbufsize >= s->bufsize)
 		return -EOVERFLOW;
 
-	/* signal a retry */
-	if (unlikely(seq_has_overflowed(seq)))
-		return -EAGAIN;
-
 	if (ret)
 		return ret;
 
-- 
2.47.3

