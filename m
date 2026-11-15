Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760589;
	b=I4iNplmbV1XV/YYxMws0r8g1Q1QnNeoKWAMBp+NtyD+4lRIGElDdIz58DldK76F0OkZb
	 UBLVtuC1H/Ti9P3msMhM3K1d15FieSPTeW2YRPki/dgwG9dy/7spOaEFmlayWKZm8Y8ek
	 i7zRBFCV5/Hlt7wJslGcrUrPF5Z8axxl8xrJ31+VBxwaEX32MQ/ryx/slfYZzD1E917OF
	 5F4+WytW7cqD2UoVwy46YdUJpOgRy1J6nojsYwlxRmJ/01FhYAUtydWG9u2+ELv9Yu9DT
	 2t6cFSbYanXD/+eBvXiROXa+5uzhdtl6STHdSJfwGMjSTcO9OYmIDE5Yfs2ZZIqhHKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tmP0MrFrcAmuuhTA1131QnIkXEUazkJUfQgIKsBWJ2w=;
	b=CvMTtczHD2RiiBNyX6Bkdr/OAiGm7J8rY6VOLf1Td37u1nzRbtshVBCMbO26B8X0XjsT
	 jUoHRWz9a3elQGMi7BBXv2BWJfTXmi1RErVC9RWbwnbujWW1bVaRQyPNBHTyV7UWHX4Lo
	 qb33znmvyrG+6DBQ/2P07W+rnMJnrBa6DupXUUt5/VhmTwwMCUCpVO3YDGZR731crooZx
	 nQXTcJG+KEPeGnF9mAL7opBrcWTkRBWdFq38kfTxcIrwM0T/Wj+W/DPZF7mneoCPUFlAz
	 t0Tad3XomoDuf6T3Uq8PTVEqH1F9Yfn7Y9DWaawcUMvDEwk4V+1xG9Xz3anY0QTOyYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JlrNgr19;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BF606A31D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 16:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E83BF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JlrNgr19
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3ada81853so2324064c88.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760588; x=1795365388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmP0MrFrcAmuuhTA1131QnIkXEUazkJUfQgIKsBWJ2w=;
        b=JlrNgr19qouTdtB1fx8LtqYf5Rts+F8e6aG6lxQP1cD2O1n2YYUWEcW1kszo/Cw3fK
         V5NkbOkZ38vr0E/2v2t8tXY9wALoKMgJQSDLoTQHXECefXkgOClfLL0j2TA1+hhY+cY9
         Fxw0YOLcW4sfpoUQIApBTitHY9L0ZePiuDF4kxOvLDVJlrqagOC/LleIAn348/hFyKg8
         LKIza/HMGRv3gmBGOv+CIuo9FCaIZ/iMDuLdeb1AXBH0kt6T4+66DJYakhQnSLeIH5xo
         qlK4qfRtCki02eK2L2K/+VOWxkaS/snckBp+g2FNsINI/SH8YR50tWrMX+Gu2F4Sd+ep
         iLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760588; x=1795365388;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tmP0MrFrcAmuuhTA1131QnIkXEUazkJUfQgIKsBWJ2w=;
        b=xmkzSoazYNpGPw0hWmFAhOkOKtTtQvs4DrmbcRJserFVn9GUzhVrfvtChd51u+ZsLA
         0EgDBu7B86HzyaOa6pS+MGql1cLd1aAMcMUovIoCXhB8l4l4/L9v3OaWxHUbOdPkg2FH
         SQFz7CuYCsDqcdAwHcjdliN4kXCTKz63s3Ad3Z6O3IIblGCfe+7os3m0yveV+p4ir7YN
         RXGzcjHRy9+ZGrr1MJNGV4HnZOe62fdn4AeyrYfM+DEqbLcbpqmuO62h0gdrfEp1jXoM
         FtxeDrVqw9TNFXLWhX7N/dou0cDdDzbKKMtQhj9USurfnKZnQDhKSebSHCMj561eMnea
         v/AA==
X-Forwarded-Encrypted: i=1; AL+hErHAH9Xg7vrJeVoYND4QrDE8aTjpGUvZ9/eFt0lVk6kEmmXcIMiq7T1HHebr4LzYMTzwR3W7bB24fOleh75F@vger.kernel.org
X-Gm-Message-State: APuU4Z9Lxpq1QjcmX5h0i6XliceBKGI3BVggrAMHUMn1vJlD9yM5akig
	YL1CekMgbQ7wMKx2MAAA3MLNHH/rVJI7ohCk19Kq2fXlBInie3Gki1Pv
X-Gm-Gg: AYBFou0hGei+jWIaP0xEhYnNQgmbNjcWkWud2cPwq4PvD/vzoNNEuhR2hm6GvFMIi+J
	E/HVxPCxx82evySX3t2iZjP8RIAxOwacHqCYYp7t+SPgBd/0v/XG6RZ98jjD9WwZFkGYT22n+Hh
	Lj1wWTd0SiGdIi9xATGx+LzEbiR5J3Pj4ogKj+NpACRh7QSq327dOELuJv/dKZLD8jMgzVHY4g7
	Al4ToBM44T26seOMTXzbAY/Dg8UT0rwJKoFzVJfgHfCj70Cj7G9DfElMmLN14iRxrWnkzchDXVb
	SUgFRFFbN2BsnbSRcMWeVoy77IqAp+ZL/bnLtXWCFTsFgCDiL4nELagjaaiFd7Q942O4qe7mdb3
	UC27NKbsjPXCHFQoWKv8+qZGzE25sj35wd0hA8pLZ/7YzBwNxh9x2m3NN1HhoshqQXG+FKqlsgr
	nSYa9iQyNxhjBEyS3xWQ6TjlR39TlNT2LBZCLiXFhbEcN19mhmYL1uvi0tcZWf0YvhfTjZfAB9n
	nqfbeP6FKWHHg10cTmZTVIXfN6x05NG/dlGUjELZbh2LSXtw3am9kJ5eo2zLLXI7F/aVy2V7EDR
	GXtNnAgHdJAlbI1A7p5je+HuMwRn11XO5lJnUvHvi8TrLiUL9REjTnFydfvMc/suHPDj
X-Received: by 2002:a05:7022:7f0f:b0:176:a225:e364 with SMTP id a92af1059eb24-1b50312eb89mr7083533c88.35.1794760587827;
        Sun, 15 Nov 2026 08:36:27 -0800 (PST)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm29298232c88.5.2026.11.15.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:36:27 -0800 (PST)
From: Cheng Yongkang <teel4res@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] devpts: lookup racing with devpts_pty_new() can return ENOENT
Date: Sun, 15 Nov 2026 08:36:20 -0800
Message-Id: <20261115163620.225761-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Al, Christian,

I hit a narrow race in devpts. It needs a lookup of /dev/pts/N at the
same moment pty N is created, and the result is a short-lived ENOENT,
so it may not matter much in practice.

bacdf1d70bbe ("primitives for maintaining persisitency") says that
d_make_persistent() "is always called in strong locking environment
(parent held exclusive, or, in some cases, dentry coming from
d_alloc_name())". devpts_pty_new() is the d_alloc_name() case, but it
does not hold the parent, and the d_alloc_name() dentry never goes
through the in-lookup hash or i_dir_seq. A lookup of the same name
that missed the dcache just before can then finish in simple_lookup()
and add a negative dentry:

  lookup                           devpts_pty_new()
  d_alloc_parallel(root, "N")
    miss
                                   d_alloc_name(root, "N")
                                   d_make_persistent()  -> positive
  simple_lookup()
    d_splice_alias(NULL)           -> negative, same name

Both dentries are hashed under the same name, the negative one first,
so stat() or open() of the new pty returns ENOENT until that lookup
drops it. As far as I can tell, the old d_add() code before
b4a76faf9d96 ("convert devpts") had the same window.

On v7.3 I ran one thread that opens ptmx and immediately stats the new
/dev/pts/N, and 16 threads that stat the same path. In 120 seconds the
opening thread got ENOENT for its own pty 13 times, and the other
threads saw ENOENT for a pty that existed before and after the call
26,372 times out of 6.5 million lookups. __d_add() and
d_alloc_parallel() have changed since v7.3, but the same window is
still there in next-20261113.

The same commit message says what d_make_persistent() would need if
it were ever used with the parent held shared and a dentry from
d_alloc_parallel(): the in-lookup logic of __d_add(). I tried that
direction for devpts: devpts_pty_new() takes its dentry from
d_alloc_parallel(), and d_make_persistent() does start_dir_add(),
__d_lookup_unhash(), end_dir_add() and wakes the waiters when the
dentry is in-lookup. It takes no parent lock at all, which is weaker
than what the commit message assumes. With it both counts went to
zero, and basic pty tests still passed.

You may prefer a different fix, for example creating the dentry with
simple_start_creating() as mknod_ptmx() does, which I have not tried.
I can send my version as a patch if you want it.

Thanks,
Cheng Yongkang
