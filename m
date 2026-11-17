Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934084;
	b=xJTi4QXVSm09LnUGmkMgWDM8TY1Rb5CZO73/npKbPqm1ghAOMf2m/rxO3uW7H5Hp0kSm
	 nwzPU6g66slcwe2BpPqBUjH+JgLjI6g8ODD+pXDL/jAKlGBtnDNht8txiyWa+928KgDk9
	 QNhjA819z36WY9NK/EqIGVyD6A1gHdBytmy1F6C4h71H/ZsDqkD2+hyxUhbqzsOcdcmoL
	 4p/NrZbt0qOcqNA7hb4lXI1uUT2nGs08Pw5AzcqdpGMaUwfGdoBiBfXGepo/4H5x2wQd3
	 +PjtNdts4JTIqMTSBeCc+YiaMkwtd/4vg/aNRH7twMwwsERmzstVvysqw5cEZd6v95Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ypdQxqNZeuAR8d72dGF4LGjrdC+bZ7mm7BusGxjOzZg=;
	b=BieqNtFvWQ6YF1dPbg5gaGHCT1fgbIbM06W2LG2zz3oeC5AUqNuK0SkHWGUcJV1fqw8c
	 6/YCsdaRbNxN/CpasXvVdNp2NZnCaHq1w70IUp2Xi9QsFZTYF/viZt6q76p/CwolQLqFQ
	 sFnKHd1tlx8e92ypM1dRaVZubdctos9KDydpvWyETN1/uYyfvSkY68d2txunwVZvkXU6Y
	 FLbntdaAxpxvM0wMNd4hSGRP2TQFyweWAyGKZEFAeVpz0gJ3qYlsIkN6QIX28lz1It7BM
	 RpQjGdpjBijaVP+ZNpdEYsPgV5idDDSgc8bu8i4KIsjaIiWz6bAJdmLzfcHe2WI9MPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xu3A1GJl;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2B606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 16:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45A2B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xu3A1GJl
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2af4c8d00so56729c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794934083; x=1795538883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ypdQxqNZeuAR8d72dGF4LGjrdC+bZ7mm7BusGxjOzZg=;
        b=Xu3A1GJl8kozVTJFThjjXwIfrGDfI1536lRTU4RwWvLVpDAwzWzTumzfly5npajYci
         Yefv42bXR7jAWZ8Yedn3w12tlImAMsxHOhg+Y1ExRWhF8efD3WpSSKaKFaJqOYc6EMYC
         oYrUTGoHAQFVVO5qOiywoaNvC/yzO5GTjgV+RprLh9QNhShftBK5DowVp5eFI5yn5iL7
         +5qFmff3+LmBHbCqo56u8KWmQNd2RnsrZIFjW1YAdFBKRBEvIwFOUUKKPM8K6Y3FKUD3
         pb9Ya1yn1swzGGnl7hbAntMxpaeGYrrqKbcfFhzAfkGcnUeDJAOMxFFjGyQ3XXpgsrdg
         Vmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794934083; x=1795538883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ypdQxqNZeuAR8d72dGF4LGjrdC+bZ7mm7BusGxjOzZg=;
        b=sV/F6pyK4BOH7N0UUoph1eatJHklcSZ4zMciIDagpXb0z2l1KJla5rTE2CWEnkO6i0
         uHpeNxkT5oJ4XPO4mT+N/5d6sZWCPTv4ux22xBNIEjB5MaxnbxqvctaNDGLhYkV5YIcI
         69yIIxLpEUojOArCMB7rwL+FCMD0FxuvgigZlJ4CuC8TCvehp+Q34rkuqakcqeu7yQen
         4RPAoXpu4M9AuOAc+l4G+1z54ac1HsnPQYFSs302p1MiqUG/wWT1X1w4WNFeuTDqf/Uq
         m5rTViJY/cLOjN0OjVUkKaAkZgZzwHu8cMzZ9MHgraopvTTjJL5S2Fn14OG3NdIygr4W
         GhpQ==
X-Forwarded-Encrypted: i=1; AL+hErFVsG4E9KXPMHyG9WN4j5XII2tyxa47IJ2WgDo1+FoxBnpbx2EKRwWJQ6+SAcyLQaaURWTMrJ4c+rKsJLm5@vger.kernel.org
X-Gm-Message-State: APuU4Z9W3YCG1tncuMMIPS4w9FLdjhO/lS8ypETGFWb7Tp/8yIJi0i2c
	YhjEAcy8c/X/JYoYwlPOtHXbNTHgf5ATa/dMfcfoSktggDJ6GC9LQBke
X-Gm-Gg: AYBFou064R0n31dButLSfsZPDnU46PojgkqT2SId98iWP/n9of2AicFFt9F24fc1MAk
	QzmqxShR4R6ryz5ZNJVyZUJRBO59cAahHC1ALENJgkVs8oVky5pINj9p2/i3ZMUt/auklUklIcH
	DaATC0qO2CJzvm4cTWYfTHeXolxE+7mLJyNKIoJ/39FZ5Qwlr3YSEc2ANY8aYZXrz1/5rAaTXb1
	b0WhfwLUxZccq2CYgFp57XuNoVAcsqmjDLla+X15RtdUa/jU29wlLvNt6x1SmFP/plHnVNGsgCb
	t/RQ/PhapQszIY8L+bfEZnQrO7Dz/O5RsfXCAWGJBe9zZvyo39eFPtOVLXMFRzg64WtpfV5UtEr
	jxOxmLHMTL+WDwT7cfcsH0okFFWjlRi4f3IEgTsJW52xp6JphqwhVHG5o6JFJWmUiMJFU/4doEU
	2qwtIZ6kpkNLNg7K5CWCmTMKXEKrhq6E7j6UyYAPMxzLhWsxpbT8yJj5m+efjgpnCjNi4onWErO
	/V5W4b920ryYtCQGB6bURxdLb0vV/jyZNJZ9kgZH21SbOMba7vAABQZzFkcZHrGh6X2e3o52mTX
	254YLiPHJmqFevOmH3XrrQeVgxj5qIaMDEGrAtBf8wAwZuya/T1GxpSVqoQBDDFxtlcwVDYixyX
	KHtxXubeBnmr0/Vj1/e6L3fDeTy9aEcJiXpMvLchK6zzKYCOp9OGbgfqxxWA93gnYbOtWgOGIgj
	ZX9vkM2Bw2lEjVcZr3jCygU4jeHSudddfgvsmmRI1jejlMBh03TANcPbmyaUIvOkMfrKZYxbx+p
	uD79CQitr4wjNM=
X-Received: by 2002:a05:7022:294:20b0:1b5:2dce:1b6d with SMTP id a92af1059eb24-1b543cffc70mr134285c88.17.1794934083141;
        Tue, 17 Nov 2026 08:48:03 -0800 (PST)
Received: from FT6N242TWK ([223.181.112.111])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm60883753c88.9.2026.11.17.08.47.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 08:48:02 -0800 (PST)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iomap: fix offset truncation in iomap_fill_dirty_folios() on 32-bit
Date: Tue, 17 Nov 2026 22:17:56 +0530
Message-ID: <20261117164756.97065-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
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

iomap_fill_dirty_folios() turns the page index at which the dirty
folio lookup ended into the file offset it returns to the caller:

	*start = (pstart << PAGE_SHIFT);

pstart is a pgoff_t. On a 32-bit kernel the shift is done in 32 bits
and the upper bits are lost for every offset at or above 4 GiB.

XFS uses the returned offset in xfs_buffered_write_iomap_begin() to
trim an unwritten mapping to the range covered by the lookup. With the
truncated offset the end of that range is below its start and
xfs_trim_extent() leaves a mapping of zero length. iomap_iter_done()
warns about it,

  WARNING: fs/iomap/iter.c:38 at iomap_iter+0x33c/0x36c
  WARNING: fs/iomap/iter.c:39 at iomap_iter+0x34c/0x36c

and iomap_zero_range() does not terminate: a mapping of zero length is
what the iterator takes for the start of an iteration, so it asks for
the next mapping again and again without checking how much of the
range is left.

On i386 with XFS (4k blocks) this is enough to trigger it:

	fd = open("f", O_RDWR | O_CREAT, 0644);
	fallocate(fd, 0, 5ULL << 30, 1 << 20);
	ftruncate(fd, (5ULL << 30) + 1000);

ftruncate() never returns. The task spins in iomap_zero_range() with
the inode locked and does not react to SIGKILL. A write behind an
unaligned EOF which is in an unwritten block above 4 GiB fails with
EFSCORRUPTED instead, after "XFS (vda): Access to block zero in inode
132 start_block: 0 start_off: 140002 blkcnt: 0 extent-state: 0":

	fallocate(fd, 0, 5ULL << 30, 1000);
	pwrite(fd, buf, 100, (5ULL << 30) + 8192);

The same calls work below 4 GiB, and v6.19 behaves like v7.3-rc6.

Cast the page index to loff_t before the shift.

Tested with an i386 kernel in qemu and XFS on a virtio disk: the two
sequences above hang and fail without this change and succeed with
it.

Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Prepared with Claude Code (Anthropic), model Claude Opus 5.5
(claude-opus-5-5).

First sent privately to security@kernel.org on 11 October; Matthew
Wilcox asked for it to be posted as a normal patch. Sorry for the delay.
The code is unchanged in mainline, so this is the same fix, rebased on
666539eecdf4.

 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6d843b1..846f87a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1735,7 +1735,7 @@ iomap_fill_dirty_folios(
 	}
 
 	count = filemap_get_folios_dirty(mapping, &pstart, pend, iter->fbatch);
-	*start = (pstart << PAGE_SHIFT);
+	*start = (loff_t)pstart << PAGE_SHIFT;
 	*iomap_flags |= IOMAP_F_FOLIO_BATCH;
 	return count;
 }

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.43.0

