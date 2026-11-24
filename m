Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550084;
	b=2tmSui/8/w7+6NTbFrm1dMRi7CWSiCWNXic/iOT7/A6HnOdbcfx0L+EjIkIrVkiS2vLP
	 y4Am15mWYOpEsst29G1XWcT11dCtFUW30Lgf5zraMRqVcj+nAiHSfq0zT75VJ6wCly+5p
	 apxWJvI7D5Eg9q+M/fBXi5E2Wr+ay9lFO2eadShgL0bucU4yTGjx4X5c/M5f6IWJ7QlYF
	 GMqTljUCHSm23cjLUxlSgo3Ge4PkX/Bm4v7K0eMWFrE59g+TAdiTLj94tzYwAOhPlB2MN
	 whTSFh1dhvAXja2TzBAIprE9BmTB02gCWG/o79V7kr8u5pT0n4Q+EucpAJUT4O7ngtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CMRL7IAFTXqZ9ddm2mkT9rLkzrVp3O3yLJXKdJzaMHw=;
	b=c2Hm+EBffxgZ6S3q6u5d3/ld1byydeLlQIVzu4IaKW+eun1qKO5WpDwjwYF/z1vgGjg4
	 rT7WEpGi9P5AoYu2IN4aTtdJeDW3iDmsT2JMO9/JCsYw0FCWcj8jARx5nGGZTjiQeFIDx
	 MtT2UY/rFZRS82RFpRaPRtrJNjLMVFfaf5WRi50eulgd1D8vpOc0TkDmr7WAKKaev83eO
	 gICKzAuhilvoELCzcQKgUYHGteBkMm2O7I8BngUTw5KYZBrvnUoJ+1Yp48soGk80eJiHJ
	 IL+1erwh2eYJ1uBATmsiT14JBtHIf9+G6sPURzxRTZ7ko99xTBTxl7tj73XgIRQfAvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HwF08vE8;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B10606A335
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B10606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HwF08vE8
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e3b22e971so2610812f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795550082; x=1796154882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CMRL7IAFTXqZ9ddm2mkT9rLkzrVp3O3yLJXKdJzaMHw=;
        b=HwF08vE8pTntd6ebrHbTMoSPpoWYr18xwDyN09ucSsKYQAsnMjh5JfMToykcXZTLWb
         fq8FxhScBcP9Fyj7wc6yq/GnqCTxqEzu9ke3XMel0xx4fo3VgJvHxAm4LivZK5srCgXU
         bLpyyl2zZ7j1RRJUneUQuyRJeN5c067KX9YOtgnsBU0/gKmoDC4aOjlDXbQcaWGlCyWh
         hjsIqolz+TOYnPlKLN6X77d65g3YKloMIeyQ2w9rZI8sYTT5kAODBi62DEKTuLowOJJn
         utILCQNfu5pQgRMoHfVWyoiefQNEG4VoKJnjQQqbuJbpgukWgeaJjbWOfCWKyRmL2alA
         4Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550082; x=1796154882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMRL7IAFTXqZ9ddm2mkT9rLkzrVp3O3yLJXKdJzaMHw=;
        b=AegsC7KeDAKhGovsnRcM9J2YGPEHF52cC0HbcIWPrXOvNeGQRajGoKvoSN7EUTjjrt
         Kh8o3giV7HOVicF58NvVSFWueMheOvbc1Orvn0Zyk7mjCCmipnZ6v5ZPXR/RP9taQyoK
         VGnoLRIio4CiVJQsu4+n2GoLTeaJd0vN2yDH/CNQ0FC/8ebXVhYKLAIHcSqpLot6K3JH
         N1ytH2IddRS2D+Z/PgztOohastBuXe9Y219Su/MhqFs1PQyzpZGeUn9vE08RTJUuxJwj
         ByGmYXZtLr5we1DPF6B2/a1fnZL2EC/iQt+SyoUBBc+cv1/nZKKBcQaJcL7+MeM07N6E
         NH3Q==
X-Forwarded-Encrypted: i=1; AL+hErGJfTy5KZMV3uX1Z588elGlrPsfvTC8jNP0zdah2H5dv8FZLl7VnfJ9vBO8o5wUTwfSlRT7wVPayd6khBaG@vger.kernel.org
X-Gm-Message-State: APuU4Z/D4bX1MJt0u6cNUdqUj0lbGwTFn7e0IJfhPPTDMvm2VMdX2fRK
	IDc117uCRW85ya4+kPQdSYZTtag5BQ4EZQYvqZ4JCWzxTutNuJCYxgVMmtHKfN6QZEMD
X-Gm-Gg: AZFdTZclSk7Si9knrK4Eb4QmbXANS9Z0DGCfkKSJHuS5t76KhfClUnqY7M+vv8+YUv2
	xtSDxR2COCk34kMy3EqtETDoVOGwQ4e+GuZqAZ2TpeOl/CuILU2vDUjbXdBs62y+u2jIquibUAQ
	l5tD+UoAWtWXjVnyqoTcevCXspyui/Zl85LErkm2vSFh4RJm4ZQL0jBrqWOi80lJdCjsvjKhSo1
	TzPgS5BBoibvEL4+EuTeYosii5LdUK1g+ocaNmfg1Usip1IYK27dqcb6psUWNuSFROTJiiL7eEN
	9RxzgFKCp1iVmem8NkA38MEGWJLPaJ4+d+CAVA6GR7GSjfyz8IF4xDsL9Fci24aA5gTEX7c39AZ
	mV2FPZe7FFMpvhDq75pKCghfKkDrUpCN1jJEy9IPzDqwzF3kf1sxyWByVZPMOlh/F5nAfbbH6L5
	pBLc7CMkABEkupgndRgDuBRWSrUOfBxHJt85LUllu82Ewlo1Hn/RAr1fqxkmi7U2UC4Icyz8Apz
	TP+z6CUlEEn0wYtCybO3z60o3aI1/U+65yhyYTXK0eElzv81sGO35SEapZLYU1HEpXC7yOXkruV
	QjsPp15t7njeAEYTt95GyUhogN2tMXnbnZSar1XGNXtPHb0l31tt7ro4kl07ltsbqrEhzE9Q+Jx
	HYtPf2gXFl3bVIYKwAsBWM/QrQxS4mNQuZkSv
X-Received: by 2002:a05:6000:2dc5:b0:4b3:71c7:42bb with SMTP id ffacd0b85a97d-4b371c74483mr14127763f8f.19.1795550082102;
        Tue, 24 Nov 2026 11:54:42 -0800 (PST)
Received: from alex-t14g7.lan (p200300cf572c2800fb4fa6aa0455ce36.dip0.t-ipconnect.de. [2003:cf:572c:2800:fb4f:a6aa:455:ce36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm30622222f8f.53.2026.11.24.11.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:54:41 -0800 (PST)
From: Alexander Mikhalitsyn <alex@amutable.com>
To: code@tyhicks.com
Cc: brauner@kernel.org,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>,
	Jan Kara <jack@suse.cz>,
	Seth Forshee <sforshee@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: release inode on error path in ecryptfs_lookup_interpose
Date: Tue, 24 Nov 2026 20:54:29 +0100
Message-ID: <20261124195430.105522-1-alex@amutable.com>
X-Mailer: git-send-email 2.47.3
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

Currently, when ecryptfs_i_size_read() fails we only do make_bad_inode()
which only removes the inode from a hash. So it's not getting released
and on umount we get "VFS: Busy inodes after unmount of ecryptfs" (see below).

Let's fix it by using iget_failed() when inode is I_NEW and iput() when it's not.

This was accidentally found while working on SB_I_PSEUDO fix.

------------[ cut here ]------------
VFS: Busy inodes after unmount of ecryptfs (ecryptfs)
WARNING: fs/super.c:731 at generic_shutdown_super+0x117/0x1a0, CPU#11: umount/402
Modules linked in:
CPU: 11 UID: 0 PID: 402 Comm: umount Not tainted 7.4.0-rc1-virtme #9 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:generic_shutdown_super+0x125/0x1a0
Code: 5d 5d c3 cc cc cc cc e8 19 d0 f3 ff 48 8b bb 18 01 00 00 eb d7 48 8d 3d a9 93 d1 01 48 8b 43 50 48 8d b3 d8 03 00 00 48 8b 10 <67> 48 0f b9 3a 4c 8d ab 40 05 00 00 4c 89 ef e8 17 6c b0 00 48 8b
RSP: 0018:ffffccc0406bbcf8 EFLAGS: 00010283
RAX: ffffffff87d54a20 RBX: ffff8a7bc2358800 RCX: 00000000000000b5
RDX: ffffffff873e7853 RSI: ffff8a7bc2358bd8 RDI: ffffffff87e52550
RBP: ffffccc0406bbd10 R08: ffff8a7bc235d408 R09: fffff12a00000000
R10: ffffccc0406bbcf0 R11: ffffffff87d209d8 R12: ffff8a7bc2358d48
R13: ffff8a7bc2388824 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fd846e02840(0000) GS:ffff8a7c76af9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd84716e8e0 CR3: 00000000037d8000 CR4: 0000000000350eb0
Call Trace:
 <TASK>
 kill_anon_super+0x1c/0x80
 ecryptfs_kill_block_super+0x1a/0x50
 deactivate_locked_super+0x39/0xc0
 deactivate_super+0x47/0x60
 cleanup_mnt+0x3b/0x80
 __cleanup_mnt+0x16/0x20
 task_work_run+0x64/0x90
 exit_to_user_mode_loop+0x177/0x570
 do_syscall_64+0x352/0x410
 ? up_read+0x1f/0xe0
 ? schedule+0x27/0xb0
 ? schedule+0x27/0xb0
 ? schedule+0x27/0xb0
 ? trace_preempt_on+0x28/0x80
 ? schedule+0x38/0xb0
 ? preempt_count_sub+0x4d/0x70
 ? irqentry_exit+0x2e1/0x700
 ? exc_page_fault+0x8d/0x170
 ? do_syscall_64+0x33/0x410
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fd84705c1d7
Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 09 3c 0d 00 f7 d8 64 89 02 b8
RSP: 002b:00007ffd3839fae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000055b7f819dbf8 RCX: 00007fd84705c1d7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055b7f819df30
RBP: 0000000000000000 R08: 00007ffd3839e8d0 R09: 00000000ffffffff
R10: 0000000000000103 R11: 0000000000000246 R12: 00007fd8471ba26c
R13: 000055b7f819df30 R14: 0000000000000000 R15: 000055b7f819daf0
 </TASK>
---[ end trace 0000000000000000 ]---

Fixes: 3b06b3ebf441 ("eCryptfs: Fix new inode race condition")
Signed-off-by: Alexander Mikhalitsyn <alex@amutable.com>
---
 fs/ecryptfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 48e520960d66..3a966348a578 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -362,7 +362,10 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 	if (S_ISREG(inode->i_mode)) {
 		rc = ecryptfs_i_size_read(dentry, inode);
 		if (rc) {
-			make_bad_inode(inode);
+			if (inode_state_read_once(inode) & I_NEW)
+				iget_failed(inode);
+			else
+				iput(inode);
 			return ERR_PTR(rc);
 		}
 	}
-- 
2.47.3

