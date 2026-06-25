Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6987326927
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376564; cv=none; b=HrzJ9r8UvBzFJs9BZ/BBQFuFIYqfLGhHy5VTKNVM+9HYQQ5a2MjInGxTrNKm7DdhUB7SVCi8pd3YUVXLFREvg168RMYrnuaZXcGrDI1LKPS2YaX5GMLHznbEHO0A/bbvwmve59EDOVbx81Hb4Imz/yJcMQT8dByThDjTLmUGVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376564; c=relaxed/simple;
	bh=cFehA3I9prjpPS9MpvxHw5vuJaTELUrjhx5IPWyT2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxLpPhtzZE8kps4P0PhvTix4ULeAtOIZO60Wx7Rccpc3UMDdcdpvqdI7guxjbuD/cW+SAZ+TJP6y140bv/uR8/C9k2gOLKroCQo5U0PbIEhY6zyaCbCNQvva1mctv6SARjQ9WZWqvTyYZGCgUH2Y7Z+ONkpGNdCEqsRumZbU6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ubondpu6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ubondpu6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so12516055e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376561; x=1782981361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=Ubondpu6xJgw/p84wAy8wNH/JR5wUCsCd/5xeQSpoNrfjzYHLUwW8PBbPetdv0J4jl
         O94zcjadi65puUvpau74wT5BgSn//VHTqqIGGsONw3MI/n/FrxOrqCrhL7VyTXvLWGnE
         HPDOMUBZB9AYgKkkkyyVAxnQTkdR/cRFmGfInKWLNmBYNAThciWyKzYzkDFCSrEg4WzM
         WZavq5gQo95nHZcd7d8LuTkVUcPnP9kN0A7XjFPa2MgBiW2JiQ9CZBp+Jxw54vN4GFV7
         IG/oHhjwJVK88hdwkyQdESlXyM1I/7dDyaEQ0s6mkM9fLog6IlI//dvhOP/fAoQLTnJt
         3+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376561; x=1782981361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=FxrN6JSDkstGYjG6q5d4PpMcWnFnWZWrZvp6FIObmCJFMeibC06zEGzuMj/jQrsT9N
         3+aFEkXuYTkEAdGx58x2QFHxrJl6vBgG6K2CyrWB54w1yO0pJd/y6aj/rWPuYyVNHUE8
         xvtBNo/teu8jmcCkkktQusGKCSHn2J0i9PSiJbVnfnmyrFYUOqGnKWrCtbmua3MY1Hb4
         ptOl8ikA1HlWDtyaice0K/H/kA/I8/vue6pZDOu6y/H5cOKo/LownBMoBYD6sIyP4lbw
         Mids1vkRa93X9mguqMqdJoqyVP8Qyrst9wdz11or+kT3DTpn7mf6pnQZFiICCTiYfAnB
         3Tfw==
X-Gm-Message-State: AOJu0YycLaubSHtQu9YPyidhlDeTJYnNYWsF3shH20BKoLSOwRSKMT87
	FEZgAOl5WwRLXsa5s8dIJdikfff8sKDiHuCoIPKVl1bYNc1aO/2HBBsXV3bAkaVihis=
X-Gm-Gg: AfdE7cnQh9AOOCMXmeaMA9cTQQdSBlY8VbSMX18qtYcb0wzFEv8F6CJBz1nx4quSs1l
	eXHXPvmM6wJEICBJTsrKIo+39LyXcx5sY1X0fYvggo6TxH/84aAz85k/3TqLaJbzSDDfPboEuDC
	i0rxLNSu7VbUQpaSEGROC2Jl4Oo/KYqQbZ4oyz/oqc9saxPDt7zxviNkhB1DUYPN166gl5VYcPX
	tSJhx7B7UgwX6pWz4QfyfePlMAsRoP43wYsbVYs1YIV55RI47fZu0l+1iYzcWlx0f3ykR84CzO8
	Q9d2p4yiK8PTa4/GrQ5AYsbzUVy9dU14athhH2gEX8txEfcUCYr9vUkC+HLvG3sgrAIGrdeg1mq
	3iqjOGdgMeB6x+pQgJ3FWBNLEqoTEVWXnrN0qfOwWdp92iB1jpUyhuUDl5VSZe2ctdwchhE9Iq2
	lqtAOSln1j
X-Received: by 2002:a05:600c:c0d2:20b0:492:41c9:886b with SMTP id 5b1f17b1804b1-4926684c948mr14881805e9.14.1782376560755;
        Thu, 25 Jun 2026 01:36:00 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4926401a2e7sm80070205e9.3.2026.06.25.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:36:00 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 3/7] splice: turn wait_for_space flags argument into bool
Date: Thu, 25 Jun 2026 08:34:05 +0000
Message-ID: <20260625083409.3769242-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to do this, because I will move this function to fs/pipe.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6ddf7dd72..707db2c2c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,7 +1239,7 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
+static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
 {
 	for (;;) {
 		if (unlikely(!pipe->readers)) {
@@ -1248,7 +1248,7 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 		}
 		if (!pipe_is_full(pipe))
 			return 0;
-		if (flags & SPLICE_F_NONBLOCK)
+		if (non_block)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return -ERESTARTSYS;
@@ -1268,7 +1268,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags);
+	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
-- 
2.47.3

