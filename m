Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962944;
	b=anLLQHM7aVhzFYfMxZ5xWLRdao//zUW4FQ3m9UN2kDWF1FOPf401BHC6vwEdpkSKKtB7
	 62iG8XpXDKhf2MUC4aSRgn3g6lTK/iFgduOUQ2fQQ9SRDR/HXI9ERTGw7ALp/p8BUazmM
	 Lr1hmHvhLerN5XQCwNlfQ4SfXYP9tFAJ0ykS8+wAMT9HQoMutVXRMBdtoZII8yOtMtI3h
	 3+oKjA1mm7Zl3mj69ipV0QE5jkQM+UdnlfUhdHhfaj7mtG8seHOcU1/KIsKbsEDIEpRoX
	 nEftayflDKR/pdVIFVaIDrurYRhToA/cxXfMuSM5roSlm72HhXkAMmndUZT9+a0sqGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uygP09TWvScyICofwLDljYgom7VYS3wGkavE3BwU9h8=;
	b=Tx9SUfKcoU1LLiIHfv2T8jYgdALmwCTsB3QtUK1dTZ3uErdKuhaSV0hCe/LXWJ7I8hzE
	 YD7oOlHCmBND/iGGKUQkP57rCE+Ym0advjLN1ru2CjQBsUhgLGxeBpqdSMYyg4fev1rsW
	 xskbfC8KoYzxaXdozWtZnkcM2iTYTTtnBSRW57TCoT1c+HEgUFBPff2ooGySVZ6ViQw/X
	 OftbzNy6U4NwOXozvrap5mztQsuJtpMkf22hQNIj2cs0uRzxCpAmBb3EsFJ1QSvHHzgXH
	 TV9uQdoKEeE5lnJiQvRboOnVKwRPC/9glki3cNy6wxSuLIcXTEmDQPEpTl93nouklSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Dqr3ni5J;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90673606A883
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 00:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90673606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Dqr3ni5J
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67da62357acso508626d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 16:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794962942; x=1795567742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uygP09TWvScyICofwLDljYgom7VYS3wGkavE3BwU9h8=;
        b=Dqr3ni5JjgMu8kUg65eWevBO8hYO/MldUTZEDJdMF+7N/h4n0s+4fvDmy3RG7QoKRt
         0Uw+ayj0sLeXkK+6jVTY1T3uH8wHy4z9m59RWo/n9SOppMcxcVEOJ4UBJYJx3Q/CRs2q
         LznBcoWnqadFL0Wvz0LE0WlxwiAxcSMw5wa6JA5EOL6pj7kCOuULU/fQ9D8xxBmKBO0h
         GIpCWLBPcP4zmnA7Ym3rICn1gv9IQn8w0/PymPyNWsggmYqzOFFsXEWcGG5vhwmrV80U
         fQ9BHH8nYqRsrAAarBdYYQcHCZa9B40kaP38olItOGkpGfe53Lbvv7sXhQFHVwYewHCQ
         Ambw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794962942; x=1795567742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uygP09TWvScyICofwLDljYgom7VYS3wGkavE3BwU9h8=;
        b=BmS7RPt2kgXwEL+POFF/qXleNx8iQz3JLhpeScIB09eDbegaIkJkB8hYa/1Vp6xitL
         v4Gal7ocmQ/lwfW1jl2XI+5xP/MP0xGMbVDuGFWzUucUvzzuSfXreCRssEqr3IddQqV+
         1YloF5Kupq1UDhYYB/7zYhw+wpmLBAdnO6EU3cnq06s9uvGwSUtBiJ85J/dZUox3N9m9
         tZRbH/bAc7iXFeQOPDHS7infb819q9iLDBo2S6WGWp5pZNMwi7CWkj6072vj+Nck2nAR
         83dlG9SGtQB+epyjtpNFMjgVJNKWSOT9MvwPZu1Sdor8B4RP6WVRZY7ZK9iR/X1iUXWO
         QaOA==
X-Gm-Message-State: APuU4Z/nVT7Nl0UYONXztwv7wm5Ac8msZbMSiaTX4JkSql0AWQPIPz6Z
	URFlgkz3VNj46x/HkLkTn8q/Qf0uY3b0jhBi8540a+cPO1WOSY0NVJujub6ewVxJiK0=
X-Gm-Gg: AZFdTZdNkSNVSuquK+/GjBFXBPISPo3SOIT38yI7HcMe9Cnc0WFyTuDw7mvzlC/ZVJu
	y4KFLKUDlJ09SVOASyMuF2kB6K23ch7PpaSgs5j/Ww9BVmhrRIMKrBzIPmF41GXE6mC+jIy5uiG
	b37EAPHIUqX9ntVFL72hS5AOlfKfmjLXKl1sunS5RjKY1C7SCLrP07dvxWz8cM2YL4iSFJhOTR9
	hqbzO6JWOtI7s9lYtw6X5QyZ0Yse/UTJZBtNqy3w/jO1atVEaP28E2I0U2dh0kETw9CAxGWRK5e
	V/FBABRseh0YRqalkaGtAXn5T9O6bQy0umGARwaWic+M1HwnHSjyAPvgDn0cwvageo+x6tDZQVy
	nvOXOKs6FYouXdCiU0Nv4ZWJEjjkzMEmdifbDcy5hzZt2rbTqRXQSRpXs9/qDrSBH+EMLb4p6Pg
	DfjBmjTTS6Xh1dufAWPoWWwRyEsVKETyicNyiDHPzNXChO/NB3WhY2vnvMBKBQMLvehim/luEyG
	+/K7YW/aPnsCijcl2Iywgayvucjs6Bs4XJw//soUS06ai+K75iLJ3KKMpQA+BySKuw37Y/hmprl
	Ph3M/o9PFC2sSwoXZLptvPQZlL1LvTIGzwfbARajelRYdsB3JnrRjvnMRR0plDTNINozs82D51B
	rejxlKy5u/coWO+CMancjnZRhVkZ4vjB70MtNWIG5tvG0rzwJIs9s0bl4VKNizgsaydMo7IY=
X-Received: by 2002:a05:690e:12c6:b0:67d:ac2d:d821 with SMTP id 956f58d0204a3-67dd45342e3mr649464d50.44.1794962942572;
        Tue, 17 Nov 2026 16:49:02 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:5fae:4d02:7055:94ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd56ead87sm729575d50.1.2026.11.17.16.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:49:01 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v5 4/5] hfsplus: return -EIO from hfsplus_map_extent() if no extent covers the block
Date: Tue, 17 Nov 2026 16:48:43 -0800
Message-ID: <20261118004844.3849979-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118004844.3849979-1-slava@dubeyko.com>
References: <20261118004844.3849979-1-slava@dubeyko.com>
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

hfsplus_ext_find_block() walks one 8-entry extent record and returns
the number of contiguous allocation blocks starting at the requested
offset. If the offset lies beyond all entries of the record, it sets
*dblock to 0 and returns 0. hfsplus_map_extent() ignores this and
returns success, so the caller gets allocation block 0 as the mapping.

This can only happen on a corrupted volume, for example when the
extents overflow b-tree lacks a record for a range that is below
alloc_blocks, or when the found record does not cover the requested
block. THe hfsplus_get_block() then maps the file block to allocation
block 0, which holds the boot blocks and the volume header. A read
returns that metadata as file data, and writeback of a dirty page
of such a file overwrites the volume header.

Return -EIO from hfsplus_map_extent() when hfsplus_ext_find_block()
finds no extent, for both the fork's first extents and the cached
extent record. The iomap conversion later in this series relies on
this too: __hfsplus_iomap_begin() derives the mapping length from
max_blocks, and a zero max_blocks would produce an invalid zero-length
mapping instead of an error.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/extents.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index cdb337ba3924..bb5a1508498d 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -67,7 +67,7 @@ static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32 off,
 		}
 		off -= count;
 	}
-	/* panic? */
+	/* 'off' lies beyond this extent record; callers treat 0 as an error */
 	*dblock = 0;
 	return 0;
 }
@@ -273,6 +273,8 @@ int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
 		*max_blocks = hfsplus_ext_find_block(hip->first_extents,
 						     ablock,
 						     dblock);
+		if (!*max_blocks)
+			return -EIO;
 		return 0;
 	}
 
@@ -300,6 +302,9 @@ int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
 	if (was_dirty)
 		mark_inode_dirty(inode);
 
+	if (!*max_blocks)
+		return -EIO;
+
 	return 0;
 }
 
-- 
2.53.0

