Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530663;
	b=wMc0HK3OvzuPd4RTHrFdRp5YucN/oN7HO0buaFHQQsMhO0IQ3LD/FDW51zsrkN49gqTm
	 3S2BmbH2/MGRssucEwh1dY32hN4tpJfG4NU5Iz+aoN/Mc1BZJ+Hy1ccT28oFs2T3wyr//
	 bWO382CryjbEC9dUr3aXNNRIt1yW6jM1VgijbA0ev5O/mw+A/ipVEaJIJbQDo0IbFOm5N
	 juvV4kiUml6Zb9paM8I7fDil+tFG+jdOWMA35bEAY0P2QuxvNYAtidNvzvZijE6j5zFen
	 HkGPNoLbx7KWvoXuRJQ28zi2gH0uLO7RN95V2MHl1l7R0a0XzVNLjNkswndow4IvJVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530663;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XDOS+Bm4IgloJh1ZEJcdCw53kK6A8TiEOwvnUx/Qbxc=;
	b=B6wg3oZiM72vHs0/AQXxiBZBODBHD8zWFuwChmrGReX+b2V4+1Pipcg0Ees1EBM8rXq7
	 9n7kwC0n9+ns7AKcL3QDIc/r4J+CuKErKDGj2QqdIVQZivG78Uxk6783lE5/U0blD+o8E
	 yhs6Vip9ThgkYiZUzqPcydofohFTKyVPj/wKaR7gyFtiqrYUzdX/JO7s/umeaLgilQ4a/
	 LZXhYtuJai+//TvimvRg1cupXwyNoQY5NjaD6aCaUFRCQCx6uQ0YppKcYPZSIgPT2q7j7
	 lo1MLuufSDslg4cfrhIydXeUIt6YlC6yroThT7uMJp0iHW0A++PVz5iuhspkxllM2sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MMkW0g/T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7E606A331
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMkW0g/T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E891F00A18;
	Sun,  1 Nov 2026 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793530662;
	bh=XDOS+Bm4IgloJh1ZEJcdCw53kK6A8TiEOwvnUx/Qbxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MMkW0g/TIWw2HzpCGu030sDRgxZFi3l/2JmUpA44SpF15pdIvlxHI+yzS83UEDhbr
	 HYFKWVx7Pb92GkXzKu/Z0RcJLaUbOonkCL62Nn2CyMovzkCYG65eVChVtjVZRCCVlD
	 4BrDW/GAeHuilOGZSh0wNpEbA4D2047vruXt5MRrznh6k6ZIc6IoezmoZclEftxduc
	 vCUAFbPdIItLhPbo8aWy0ncD9mcNgzyz5hEhkXK3MSC3U/AF5E2mTAg/2Igagh/PTA
	 fGyMMi3aIrEXK7B7LgjFK7y+p/dbqpvFldaP/2H3swHYRe8NDZqg4Bz9JvoUriaQKL
	 BExL7gYu6/zuA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 01 Nov 2026 11:57:22 +0100
Subject: [PATCH v2 3/3] libfs: end offset readdir at positions past
 DIR_OFFSET_EOD
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
Message-Id: <20261101-work-libfs-offset_readdir-v2-3-c621125b56d1@kernel.org>
References: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
In-Reply-To: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
To: Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UR7/mSS0/npFDIJPEjAT2lcRx3Nzk85lCT8Fgx4PlRc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9l5Ztv6eYF/xuzcagO1Pf/39k9FawMu+xzB+F+qeOX
 F4TZzOad5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk4gnD/1gN7T8Lzmb9uPUn
 NMXRPHZe3Mmfuh0L37CIJi45Lui/fB3Df9foeBPfIoZHTPWndLk/cn+L09heJvxp9rdHjq7T2ie
 t5AUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

offset_dir_llseek() takes any position up to LONG_MAX but
offset_readdir() only skips the walk for DIR_OFFSET_EOD itself. For a
position past it mas_find_rev() starts the walk at the highest offset
in the directory. So an lseek() past the end makes the next
getdents64() return the whole directory again.

Before commit b9b588f22a0c ("libfs: Use d_children list to iterate
simple_offset directories") the walk went up from the position and
found nothing past the end, and dcache_readdir() returns nothing there
either. So only walk for positions below DIR_OFFSET_EOD.

Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset directories")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/libfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 654f487b05c0..46e0205154e7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -530,7 +530,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-	if (ctx->pos != DIR_OFFSET_EOD)
+	if (ctx->pos < DIR_OFFSET_EOD)
 		offset_iterate_dir(file, ctx);
 	return 0;
 }

-- 
2.53.0

