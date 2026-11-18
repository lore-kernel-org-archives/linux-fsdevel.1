Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987068;
	b=t3N0gSTZq3/RbU2oaTJe/FdNFmxG24Nk2ZnzFAIT3SWSbWn9d/t6L0bfYSd0YvBMbB5R
	 vShtkKFwODRed6Jk6i/IYpzFEr/w6354zdFTe4EEwZ0MnxjdFa1dan42rFa3Mcou03SSP
	 d4hwSwg2anso38VSgQZ43lQXD+jTO2INZNcNMMP3sGMLv8IKzU4QECmwHYtW/Qwia5bU0
	 eJ6CWwttVdRqW+F9gI0jyzL0pMwg9Exc9VJGWtZJpxS0iF/wrOtLpG3sskvbRvtETkdMb
	 mw5iVkRvGb7kUs8PsKI7NN5/pDYcc5dYopdkdRgXa0F4OrwO3AN8f0sX1nkitr0ZEZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HnO59Gsxop8C8ANboyy/O6qVew13Ea/m2m09fv+8pYo=;
	b=ntjmGxR9Zfu/d95ftLABKeItFLp0Qy9O8CjBVbwCKxV40+D9ziUq+vJ/1Dtlrh60/ST2
	 y/MbLc+8mLR4ZTro6STDy/RYpLCapzUUnZZTcFT2zA28JMmTNEpoIR/mhmlLMSfotPGgD
	 2sGmW0368s8hM0co8ARQXU2qGtJ9KGvKcH+EZ/NcNm0gtk5O76FIHU62PZELawhuARl7o
	 y7S10CSwQv3v8xKfi9d9Tu/2dUToyWDc0olIoCzmol2iMfB8grra5iG+gFZDycF2rrGfb
	 kLucSpO84aZszKTUvDwjD6scDBBW1SIRaalX3VpkL1r37r7hLVNlXT8q9O/8mkjRQNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLV2x8Ib;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD14606A332
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD14606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLV2x8Ib
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4d581da0aaso60015666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987066; x=1795591866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HnO59Gsxop8C8ANboyy/O6qVew13Ea/m2m09fv+8pYo=;
        b=CLV2x8IbPmBUTIocL0+5nFl06i0tAsAhY4mHmyMQ21lo0OCNrgLfhNw6cUbCTaG+OL
         DveUySaQc7xrrZTx1lqELbvf1/+FsbspOHcsmvv1YJM7LDsrDieg7s/i7qg3QpqbF9k6
         VT5YAx0GrXoSmp08ON5j/ur14vliPFtwMDcNPFoRYjptneXn+9NAbUGhYVTQ/Tfkc01Y
         WAkREPXwknI3cAJeWRiszGkrMsotoGf+b3s3ESjBfKyn2KRT3SddWAb0A4wK8XKL5Lmt
         aN7Q4oyGRzHkZQow5ibn71zNhpAXopA0VhtHq6OW3cTDObsurbxOKJ/CqzdJerrV1E5O
         rWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987066; x=1795591866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HnO59Gsxop8C8ANboyy/O6qVew13Ea/m2m09fv+8pYo=;
        b=ATk40COdI6uIZkcQYuQap1BpO2FVhVNApQL1zEFX2slDXv1YeXRTpSKnnlt7fKJOtO
         Pa17K9E99TD4oQyFxiIu3Y/aVOp2DzuvcqLjqZ4wmT4wxQKhuy3lgeHmbxch0P+vMPjA
         QNVwGiAaxQmi3/NaT7h0LVqF00frBS1rlaWo3NCLhKUl+6fiYTvYR6tawY2reiXxy4eA
         sX4sB1zjDT4/kfWAWNhZBVfdTN/Ij9OlNDUhzRGbquozaJFNxEN86YViZNIoJBViTnsW
         MmLxhuT7BZssDs9Uy7hYxA60TMnt7jsST2SRWUqEzHZ3ZCYF/JIZQyuJv8nYNDaMdrsB
         R9bQ==
X-Gm-Message-State: APuU4Z8US63vDpl0rMXBJrziLS2VEgFgI80p5e3ABpEiK9cNcm1S+13u
	0pOcccaiH9bLSDMuNAhZSMXo4Urvr2d90op6wT8wRvrsWnm6CNKV43PD
X-Gm-Gg: AYBFou3V0yrpdujAvnVEUDJV9DNQad94acb+a6hV4LccnO5pkBTRT7gqiBC6N1FltY9
	YXwmwiKpZ7telpGkDBgrdwgF7JCq0hE/pWZtV9x3pfAJiQoyxNhqMcNamwwwfiry7ZjeYsfvesB
	mS4iG57ZIULhJtbLNqafOMHGZ5iqzjzDdql+pS37MvPfdWSQ6hM5IKSoEIG72xYGPIvI9+YFMiz
	LytoCqx/w8yCwriHeKoZrwueeDMl28605a5bwSL/oFbmFUG7EgjRLUIquQjzD39jso3iCzb6Nuh
	DCfMzvEx2jo8qI5tddChlDROEVM9s0mbq3Jb2BJJyB2DVixV9UI/du5UdnsaY3ee3hbCs+QKdmf
	Tuja37EH1bd+dmdB+TtDNZI/+/iGJ0RjBm+X0s7zMbzFbvz0QZeNeGhVAy2H48MZTH+cYGhcODY
	//e77BgQSiTYkQiqzZxcmeIKzPM7gHAmG20DZz7+sVH1EICfBxQUBD9zkNAlTrTY4ahNZh/CizW
	NJ5vQxuIlQeuFxSI8HPQExxwBoSbynPFTKUxXzy92ewWOQUn45qoDFWs3/IY3Fp/taGYMnD50//
	/i0FtM5+T2GVt9rfYUTxHknAKKCCiMC9f6A/58rQ1d7gymgijTsir76FhQBgPweHIIdVqq9f40O
	qugeIbIhFKPGmdfTOBzFoko6HX/++RaKG2Q==
X-Received: by 2002:a17:907:d307:b0:c3e:f39b:2298 with SMTP id a640c23a62f3a-c510e19965bmr112773766b.16.1794987066137;
        Tue, 17 Nov 2026 23:31:06 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510ca0f03csm66065166b.19.2026.11.17.23.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:31:05 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 3/6] ovl: refuse pseudo filesystem as upper layer
Date: Wed, 18 Nov 2026 08:30:59 +0100
Message-ID: <20261118073102.1216568-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118073102.1216568-1-amir73il@gmail.com>
References: <20261118073102.1216568-1-amir73il@gmail.com>
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

Using pseudo filesystems as overlayfs layers is a questionable practice.
Copy up requires that the size of the lower file correctly represents
the expected data size, which is not always the case with pseudo
filesystems.

None of the pseudo filesystems can act as a functional upper layer.
Most of them fail to create the work dir and the overlayfs mount falls
back to read-only (e.g. sysfs, cgroup, debugfs). Others (bpffs, configfs,
tracefs) create the work dir, but fail the mount later on. So let's stop
pretending and explicitly deny pseudo fs as upper layer. Setups that
used to fall back to a read-only mount now fail to mount.

Link: https://lore.kernel.org/all/CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 0c7bfff7f06dc..8da739b9fb883 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -347,7 +347,8 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 	 * as the mount attributes could change.
 	 */
 	if (upper) {
-		if (path->dentry->d_flags & DCACHE_OP_REAL)
+		if ((path->dentry->d_flags & DCACHE_OP_REAL) ||
+		    (path->dentry->d_sb->s_iflags & SB_I_PSEUDO))
 			return invalfc(fc, "filesystem on %s not supported as upperdir", name);
 		if (__mnt_is_readonly(path->mnt))
 			return invalfc(fc, "filesystem on %s is read-only", name);
-- 
2.56.1

