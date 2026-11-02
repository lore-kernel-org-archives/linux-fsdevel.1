Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793629043;
	b=0WE9+QUK7PDUAxjG7R3L/EN2LHbh7mKf7+ACqqb7uxZNnjbMMVk0Hse9+ZekLlPodBC0
	 CYEnHh8nOQCim4NKN0q3hiTY5/D8l8COfZE1ns53n+mkU3WLaqajf6LvmrlteV/pWe8tr
	 loov/PQoeX5V9DcTgiZhijllj+GV6s9kknKTfrofaVuL/EfEHyVOxQkhC5OK+w/PCFS3L
	 ZYfleFCB9E77MiOeSY2Aqrv0FybtMhADLz/2p3GttENAKODQrIlfNeg+OG/LfdwIeqO8x
	 C54hw6a6wHrSx+FyOgBrazQn/wtOxjjiNYf11klzbr4+tNFnmQWL5+LjPhNOn5Drtyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629043;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xkOl2aWNXWvAkal1PoWEK4rQLMeL8yYl1YycfKL8q9Q=;
	b=cBxIbWz0pXBev3Y3aXnpAxLRCdTRGnqUk5EQE5ihS4cDDum8gyHlTu2GSKWsL188Qf6e
	 Xy/vav6iI7KILf0c58Urbi2cWLnbK8mTO9NFubepCYuP+dJ0kwczi+1nUMVdkQV48hbmO
	 O2YaUKgo1DueLemmSqnp7T1cwZM2jJqI4tuld0yTO8awfPVr7XxFRBcC6rmutduGMKfrC
	 3ssdVlFLckK9yg//cFsRVs17uvU2abiUC9EOTjafquITiKCQkMelTURZ+jUv8hVeCZWY1
	 S68Fg3kwYdm+BrohkoREVqtfR/1tf5/Gb+gOfJ1v5tRR9d3ZE9VJ9Wmw+ZTN0VhdaOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pinc-software.de;
	spf=pass smtp.mailfrom=pinc-software.de;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=kL8of8n8;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lVKKnYjf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6678606B5CF;
	Mon,  2 Nov 2026 14:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6678606B5CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pinc-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinc-software.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pinc-software.de header.i=@pinc-software.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=kL8of8n8;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lVKKnYjf
ARC-Seal: i=1; a=rsa-sha256; t=1793629034; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ns+0g7L9wvXVjz3l8LRa3V9RmAF5vafZCMr+Yl4LLJDPgiaxctLNpXHgACoU4ZX8gJ
    FnEn8VSVRqTYdXhSqrpvUBr4LxDPsQH9rRqT+LaisdldRX2iStuUHcXbIf5dWdEfw0k0
    TIqFvBLqXI5rOhRsdVqKB3kI2oyNEZ5gzM8dKk8qbudKC1P5EhRJfIpdI6+zDYGalpfU
    Y95Tx81EJGQ7OHYM/bw5/6i9z6N98AuJEnZYZOAmnWJAdxli2o3tyig3ulV4YRdUKVJY
    pq1rULzvACz1GkFZnrF0fckWRjv7rE/L4W7SN7W9oB7DJXX0CiTLQkjuxugWuAXSQO74
    3K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793629034;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xkOl2aWNXWvAkal1PoWEK4rQLMeL8yYl1YycfKL8q9Q=;
    b=Yam7x8aWz0DTGwkcxyObKkbVkwmRNALFt98NWFYW35ZKovSH4GW+kYfsMhYinySzCS
    o6JDdg25dwUmQW3NMQIGxe9O4d2EO4wGmwV9FP2h9exBPl77jndi0Fy/9Rw+A0DqXsrF
    tuaP89MaUAcsDTAGlEeCS7PDTGtx7aEOMuyTB1MlNwBASEZ2yNDmJemNnZbdT0rSNyPU
    JcqKCZhcftaWYCVMUuGIIIm8bxmEdzC28sdE3yT55p2no4dmdZw33gYAcFgGo0ap2OMu
    G9Izkt6Aj5MwiKnQb/nKQfh7h5HSDsc1TKuftLmV4lTgGDw0TfFqClTfgxxaKyoci4Z6
    gDyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793629034;
    s=strato-dkim-0002; d=pinc-software.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xkOl2aWNXWvAkal1PoWEK4rQLMeL8yYl1YycfKL8q9Q=;
    b=kL8of8n8Ri1qnV6NQZAl5hiSsadbUxpa0e4aOQ2CoqVdl1nZ5SaZouHNxHl+wokM1v
    MGUiWibAJqXlM1WsGTbIstjFMHhO/d+s7Xq3vYEXqLFoQu1VEXS4A/RlaG1FFQUXC5ba
    2s10oVxunaF4Ur9wjoEsZdN6N+Aw9nil4kO4VSwrLDlWZo5Nc45JWDAULOyjS1+f1dqi
    OP06klvC+FwT3vjgozrnuSYBSaXf5oCGbnZ3aptGM4JGI83tQFAJcFpzl9mQxwqwDW01
    0+ndZa4LZsWveq9JSfcH1DPUTOhqxEhWA6hMyvjXV78HLbYQrpZkJPGRXknb3UwCoFn2
    +sog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793629034;
    s=strato-dkim-0003; d=pinc-software.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xkOl2aWNXWvAkal1PoWEK4rQLMeL8yYl1YycfKL8q9Q=;
    b=lVKKnYjfFEzHrec+Frr79QizmPiQEcFOaBWPZ68ek6TaYarPgCyTqXxOhKoJACARY+
    VyoRTdjY6O2HMVxTjyCw==
X-RZG-AUTH: ":LXQBeUSIa/ZoedDIRs9YOPxY4/Y41LMYtYgA+S704E62CSg2BLG6dk+k8/0cpS1xrQjovw=="
Received: from phoenix.fritz.box
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id a2f6e42A2EHEALH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Nov 2026 15:17:14 +0100 (CET)
From: =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
To: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] befs: Large file support and a superblock check fix
Date: Mon,  2 Nov 2026 15:17:11 +0100
Message-ID: <20261102141714.306719-1-axeld@pinc-software.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two small befs fixes I originally sent in 2019 [1][2], which never got
picked up. Rebased onto v7.3 and resent as v2.

Patch 1 lets befs serve files larger than 2GiB; the on-disk format and
the implementation already handle 64-bit file sizes, only s_maxbytes was
never raised from the MAX_NON_LFS default.

Patch 2 replaces a superblock consistency check that compares ag_shift
against blocks_per_ag, and therefore emits an error message on basically
every valid volume, with the check the BFS reference implementation
uses. Note that a mismatch now fails the mount, like the other
structural superblock checks do.

In v1, patch 2 just removed the check; the corresponding v1 thread is
"befs: Removed incorrect check" [2].

Changes since v1:
- Patch 1: rebased; sb_set_blocksize() is now checked for failure, so
  the assignment moved below the new error path.
- Patch 2: replace the incorrect check with the one from the BFS
  reference implementation instead of just removing it, limit ag_shift
  to what a block_run can address, and explain what ag_shift and
  blocks_per_ag actually mean.

Both patches were build-tested with W=1 and CONFIG_BEFS_DEBUG=y on
x86_64 and i386, and tested by mounting a Haiku volume: the bogus
ag_shift error is gone, and a file larger than 2GiB can now be read
beyond the 2GiB boundary.

[1] https://lore.kernel.org/lkml/?q=s:%22befs:+Allow+file+sizes+beyond+2GiB%22
[2] https://lore.kernel.org/lkml/?q=s:%22befs:+Removed+incorrect+check%22

Axel Dörfler (2):
  befs: Allow file sizes beyond 2GiB
  befs: Fix allocation group consistency check

 fs/befs/linuxvfs.c |  1 +
 fs/befs/super.c    | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.56.0

