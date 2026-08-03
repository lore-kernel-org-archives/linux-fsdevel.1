Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDF35F165
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727574; cv=none; b=EXKk5DSoM7BQOImJ0pLnaXw85Susf3Jco73AjGPn4+4feO2+2X2ipCjynmEz8Erjaesw7H0YiYJrR01QnPWqm16dxX3+ncfIo/Gl/MLqhChXZcrGrrzPcujPUWWMST7Z5NeJDpurmo3AKJU6Up8cjxC1f4uEZ7qeoYT07Z9Rr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727574; c=relaxed/simple;
	bh=sZRItxkKEi929mswecs046fLGMHQUXMIE+250d1nYLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfVBIYlBNVEdNmp7jYDXpWqYIvJGbO9AqixVYgG+3yCE/oeJCGb1nvmPLEAktoO1/7rPEZp/FKXmw2G7cXpJY8+YFz58gF7QziQbzx0KtIEhwc/DhjMQzAz+3OVjZYGuAwCYmJbXaPEMj3OVIyiys/3whxXWGFJXEct9mPwTjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKuRMzT8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKuRMzT8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8486ac3f347so3664828b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727572; x=1786332372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qd0UrtkXJJ6ssaYcfX3RHhmPo0J6xySI3bKftzJ6dHg=;
        b=dKuRMzT8Twj319XXyC4LkdABEQkwRhz/VpqbbOzZwTrROWyN0VaVNWRbjNfOz7re/z
         6LkCLsB2B3jQKP3WjYWIngcoKJ362cEfQkEcnJ8+CpmngZzVgUj+vRbWfpzNDpyM/8/v
         AysJsyaN6zoY+pT/U/uqCY+WqB18Y17ovbuFvhahCmA7bgRfzL33LtQCfgxc6f6XoePT
         P6wlcAQkrS0ZK5rFZUZv/icKkLwJw6/vuMjfBO6f0SNP7Rqn0EGgKKi4WgHX7aV4EGM1
         5RHdOsVdv5a2u3bfckl1TxHrNT7hvHGdRIN0MceaLYluYF8dubgR2rjyZROiai4b7H7t
         mxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727572; x=1786332372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qd0UrtkXJJ6ssaYcfX3RHhmPo0J6xySI3bKftzJ6dHg=;
        b=kw2aFOgu2bd2UaqDzocMcY68qPv18AgAJSCpstEiW5WBeis+8j8u/tY9lO25rqfhoP
         DyvVpDEry4G3ZNoExELjLXZCh0InDH2sOAXYD+mPKFrLIrNLbDsPx5FPBCerv2b+7CQ9
         9XjWMHg7Uu4kEm1//MulJAwnO6bscsazqvUiyj3JBzRxmfbS+sYyNNk2u3nNzVJ2qUhp
         FFbdSlqKGylkUnho4nGIRbORMYSBoTkuPuSOJoubcY2oCxwGNxh11KV4orKmSw9+x2Ey
         h0PzFsFY8AvLKCQk+WjhtLNYBOCP/xu4xIx7Yv9k8SG9Q//zAIEWfp3QELWMdW6ht4F6
         u0/A==
X-Forwarded-Encrypted: i=1; AHgh+RqqHNGtthRzJpToEdSqyCqeLifdR+7Coct2qS+zDjIZrES7c9EvqGu53s9lzOopyYyiTV0zYM/qWSNapQPv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+xsWbdxWMgjWYGokOhv8S978hs2ivmiHsMSy5rElHsKUOXkz
	rmgFdy9g+4TI5g8CC7VUCILnZmlzeHzN3W6Mh+U8ww+1ME7hO+fm9E9r
X-Gm-Gg: AR+sD126GzEefrnaB5BDeJCjmehWv+nmK0BknidO9cTInPzRRkseymS/j9TVKr3vgBP
	jR5gklpNVZcQURyxBLVFVU/f+6vSR5nHGJYWlkMI6VsSx8SdA4uELMhOlT0R3RtVZljyFWAt/1k
	KjPwe7ek0pEgpRcrZcabxlZnwsux4E7R4SvXkr7MSwfUCx+ub52vBhY+avQ3xi3EJtEwYtaj3Ly
	QUYwo8kjcf8kqOaBbXUu6pTmQpNt/GGBHdqiBxAcaN7XpQPjxGdCeAMrDU2lJ3IMwO0Xmj0ldQ4
	eNwPrZQo/edonbmh3s6p6htLkJplQsh/BIlan4B5e01MpQHSPeV4nEuQckMeVsvNvdrd221NkA5
	t2/F4Kfrz6d5uf7EP+l70ZXRN78VyTi1snpBpZQeZkwfF0TcFsSerXDBeZ0n/KYHUt+yZBflPAp
	iWepqbvz3n2T3SJa2Eizuqzup8L+SFwfAwzBS0QQ4o6/woNRQBs1Gp5IFRkNYSofr3MnaUPPh4k
	DHqlxqvOwlytA==
X-Received: by 2002:a05:6a21:4cc5:b0:3c3:6c34:f9ea with SMTP id adf61e73a8af0-3c92afdafb1mr7337597637.39.1785727572406;
        Sun, 02 Aug 2026 20:26:12 -0700 (PDT)
Received: from localhost.localdomain ([113.23.46.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e47dsm46591358eec.3.2026.08.02.20.26.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 20:26:11 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Bae Yeonju <iwasbaeyz@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] adfs: validate zone_spare in adfs_checkdiscrecord()
Date: Mon,  3 Aug 2026 11:26:06 +0800
Message-ID: <20260803032606.81686-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of a free space map zone is derived from two on-disk fields:

	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);

log2secsize is validated by adfs_checkdiscrecord() to be 8, 9 or 10, so
the left-hand term is at most 8192.  zone_spare is a plain 16-bit
on-disk field that nothing checks at all, so any value above the number
of bits in a zone makes this unsigned subtraction wrap to nearly 4G.

zone_size is then used as the scan limit of every map zone:

	dm[zone].dm_endbit = 32 + zone_size;

and both bitmap walkers use dm_endbit as the bound of a buffer_head that
is only (1 << log2secsize) bytes long:

	fragend = find_next_bit_le(map, endbit, start + idlen);

so lookup_zone() and scan_free_map() scan hundreds of megabytes past the
end of the map buffer.  The fragment end they come back with feeds
adfs_map_lookup()'s returned block number, so this is not only a crash:
it is an out-of-bounds read whose result steers which disc block is read
next.

The same expression also divides:

	asb->s_ids_per_zone = zone_size / (asb->s_idlen + 1);

and adfs_map_lookup() does "zone = frag_id / asb->s_ids_per_zone", so a
zone_spare that leaves fewer than idlen + 1 bits is a divide-by-zero as
well.

Reject both in adfs_checkdiscrecord(), which is the single gate both
adfs_validate_bblk() and adfs_validate_dr0() run before adfs_read_map()
is reached, by requiring zone_spare to leave room for at least one
fragment id.

Mounting a crafted image requires CAP_SYS_ADMIN in the initial user
namespace -- ADFS is FS_REQUIRES_DEV and not FS_USERNS_MOUNT -- so a
plain unprivileged local user cannot reach this.  The realistic threat
model is untrusted media and images: automounted removable media,
container/VM disk images opened by a privileged mounting agent, and
forensic or CI tooling.  Once mounted read-only, an ordinary
getdents64() is enough to fire it.

  # 4 GiB sparse image, log2secsize=10, nzones=2, zone_spare=9000
  mount -t adfs -o ro /dev/vda /mnt
  ls -la /mnt

  BUG: KASAN: use-after-free in _find_next_bit+0x68/0xd0
  Read of size 8 at addr ffff0000ccc6d000 by task ls/136
   __asan_load8+0xcc/0xd0
   _find_next_bit+0x68/0xd0
   adfs_map_lookup+0x1b8/0x378
   adfs_dir_read_buffers+0x178/0x2b0
   adfs_fplus_read+0x50/0x2c8
   adfs_dir_read_inode+0xa8/0x120
   adfs_iterate+0xf0/0x2c0
   iterate_dir+0x12c/0x400
   __arm64_sys_getdents64+0xf0/0x230

(KASAN calls it use-after-free only because the scan leaves the
buffer_head's page and lands in freed pages; there is no lifetime bug in
ADFS.)  Hundreds of further reports follow, including reads from inside
adfs_map_lookup() itself.

Real ADFS images use a small zone_spare -- a handful of bits of padding
per zone -- so this rejects nothing that mounts today.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 fs/adfs/super.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index a4cd0a5159dd..1ab810f96edb 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -82,6 +82,15 @@ static int adfs_checkdiscrecord(struct adfs_discrecord
 	if (dr->idlen > max_idlen)
 		return 1;
 
+	/*
+	 * zone_spare is subtracted from the number of bits in a map zone to
+	 * give the zone size, which is computed as an unsigned quantity and
+	 * is also the divisor for the number of ids per zone.  Require it to
+	 * leave room for at least one fragment id.
+	 */
+	if (le16_to_cpu(dr->zone_spare) > (8 << dr->log2secsize) - dr->idlen - 1)
+		return 1;
+
 	/* reserved bytes should be zero */
 	for (i = 0; i < sizeof(dr->unused52); i++)
 		if (dr->unused52[i] != 0)
--
2.51.0
