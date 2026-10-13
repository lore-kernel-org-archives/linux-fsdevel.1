Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C951EE00;
	Tue, 13 Oct 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910106; cv=none; b=gsWkKqprZgXDuj9kqPNv4wNTfpJrvrq6jwxZxEPMNpz7xooltHhuP59FC8YlxCFUbwGUCPiRnwk4QFkjoOaYVSdO9A1WLk0/Bt/aQyBHcpMs4ssmMtToDwcwQdjGSPNAaAJCrM7pNmk18bDfFfDa8CbsBjH6yF3aOeF7OKUSN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910106; c=relaxed/simple;
	bh=cBw07y9UeT6Oz5V5csqY6bxbBuCWOYNz1IJzigUI6cQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=ndUCeEjAhlqf7FY13lzIAJ5sa4uRXda4ZcdZ2dmpJatXNfoVZE99TBXJ3GxkpdyxRf1+cnf1SJbyEHK4kSMaiM4x7GS4DgkjpTt5TouLpbjAEu+RozPsUs5rSCO4bsg6uA8Q4AsmZFSqrTl3nesKOgHu75b4aRTfNrx8R6tx2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KO1m50MV; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KO1m50MV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791910100; bh=+haVIeY0MNRtYQnSiotqInM+BDa2vUgq5oVbYQNZUvo=;
	h=From:To:Cc:Subject:Date;
	b=KO1m50MVbq5jMNCSZQtufJym+Czkml58ZO1HMn3SIOieLHebtPussbEqFDey+XwJc
	 nRgh23VypGudYSPck28UeYI18oF89joQNq9i7RKiC9/tXxBuAswYLriLBG34o4pXHM
	 nfp4hojTonlJ49kkAnqdhnaeFMTFKNtWyKVsFCSg=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id C12A645F; Wed, 14 Oct 2026 00:48:18 +0800
X-QQ-mid: xmsmtpt1791910098tj1mbgpv6
Message-ID: <tencent_629FA673511C3E765167A994DF7A23524E08@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9Xy691StZsN+noP0zlU0xyi+dO9y3oz/KQV34qqOP6j4oefef+gH
	 VBz6W6xQUbGp6ZarDMaYQVLIIcTO81yzTluK+dvf4QT3qZW/WdTlI85Betr4+JNqw5VTZlVNzr3/
	 81gxZUxfOpJBqNa4hwdJGjPrDjlYWvkB5TF0nEnWAEfs/x1h5cRK9XZz9l9Iqnz7Ocu7vMT5TpIM
	 LQy3WoYgZWGhPyNVriockuvp2YFH9EGp/UpaH4fT7RstDh3evyalKjuGnc6cL3vFZDZk54PghQXw
	 IZnS0fO1TsavDr8Lp18tG83NZ1vclFp0L5vvNOc0PhiZPWeA1w9/yS897G+OU4Z+RYh4Pfh7DdSR
	 SiNQL4+gPC3ZUIvRu//EbYDMI5TBEcjQwKsZJaE1joUQAQplDIjgpDghSWvke0+1Kgm0jdonQkMp
	 c5bKVK0r6ScUU5CTeIhZDNxe5Ko250CLzDfjs+rXnMtiFNc0hwNo4KpVG5KPDeQja9KU44so0Lnt
	 iA4/OEZ/xivnpOqTghkCc7L/n3hsvKuJ3SK0GanW2t7YmTkImxmNqIR+WqL2ozw1qFhty4n+j3nT
	 HpUeKL5t1Jx8+tIJ8Co6+EhupFRJkj8innyDxHkXGmAuIPewkQePFEmz4j89d39scXY3Lkd6LMyS
	 m81rvLcQq5DTYOlldGgvWULG2YzBV0vaDDxxqsosiGlWtLBUSXdHkazQMwHsX1bvkvlv4KqFiwXT
	 MsoGjg6DGWu1hBV7GxrCwzWOZIemd8RZVulwbiwq+qKKYmp53LiaNk1j8dVtxkOLMArTZAWE6j5/
	 NoBjwkLolMudh7Wyh+jLYqlyQkNJrs08XpNLMad9xGOitrV4J0QC0XVMfJaA6zA9+IZJBC7ipBX1
	 gq51uhJVHOxqj/JdyhK9I8u2HOi6dV+Ot6NWurVDrN4bE14maOX8QWoxd5ZEnCiOri8sqlCtHQUb
	 k7lRwwN/9MYir+mvOEMBKh7PzAJsYpiVsBzt2xM1wrtKzOq0KWxs5f2q3u6thHWPQ/sqq7wwa5RS
	 E2hvdnJwMmhnxswvIRuUQZlfrk/RyEcjhJUOoeghxW2qIc6xDoNT6BPJwGgFJEE7n9MmNujcvLEf
	 0JGw7O
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: yangguikun <yangguikun19@qq.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] jfs: BUG_ON in jfs_evict_inode fires in practice (anon_inode_list assertion)
Date: Wed, 14 Oct 2026 00:48:18 +0800
X-OQ-MSGID: <179191009833.67328.2894987293976030407@yangguikun19.qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Dave,

the BUG_ON in jfs_evict_inode() fires in practice, and it still does on current
mainline: our fuzzing fleet hit it on 7.2-rc5 on 2026-10-12, and fs/jfs is
unchanged between that tree and current mainline, so the same code is still
there. It is easy to hit - a corrupted image is enough, and the crash is a
panic, not a graceful error.

The assertion that fires is

    BUG_ON(!list_empty(&ji->anon_inode_list));      /* fs/jfs/inode.c:175 */

We think the interesting part is that this assertion contradicts how the rest
of the file treats that same list:

  - txQuiesce() (jfs_txnmgr.c:2827) walks TxAnchor.anon_list and dereferences
    the inode directly - ip = &jfs_ip->vfs_inode; txBegin(ip->i_sb, ...) -
    without igrab(), i.e. it assumes every inode on the list is alive;

  - jfs_sync() (jfs_txnmgr.c:2895) walks the same list, does igrab(ip), and
    when igrab() fails it does list_del_init(&jfs_ip->anon_inode_list) under
    the comment "Inode is being freed" - so the code explicitly expects that a
    dying inode can be on this list.

That is, the list can hold an inode that is being evicted, and the BUG_ON is
the side that fires in practice. Making the two consistent would mean dropping
the inode from anon_inode_list before it is freed - the same thing jfs_sync()
already does in its igrab() failure branch - which also keeps txQuiesce() safe,
because it would then never see a dead inode.

We have not attempted a fix. Happy to test a candidate patch against our
reproducer on our side if that helps.

Framing: the trigger is a crafted/corrupted image, so this is a panic/DoS on
such an image; we are not claiming a privilege-boundary crossing.

Thanks,
yangguikun <yangguikun19@qq.com>

