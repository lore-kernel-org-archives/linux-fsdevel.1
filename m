Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6252269CE7
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761809; cv=pass; b=Z8778nDx5FMp9/NydO0yOWmEBosr0T8gV6hf8qAF6BMuP9CshqgqJqzlU5QyRAaM3Ial0E6WfG85ar67ws8+/FelR2cf63yY+6utvCASgtRcNbHUM7uTxSFlppgUHDZBIrVCmnVf1Q0yNWOEPJsN4iGX2JGVpacdvZ3fHOQpt1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761809; c=relaxed/simple;
	bh=DoILNNeqxH41jedfRaAeiSUgjh4yN7lclTcGJYuQcEQ=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=XNtrlDncXUt0erIwgxbSqZ9pvrGiQM677905ljeAN7B7lY+nvXytl0RRTuVwuRPI4rJ9sykXP1QvQ3ZjvY7afYLKJlRxp9vgXkuDhymfeHYQ6lfCs9/GJgwFIPCFYC/PA8Y18R/royVzgXNhIQHNVXAVdiZP6uSOTM62+6+n4us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=ppEuKyhd; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="ppEuKyhd"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7c0dea734b8so94673727b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 19:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779761807; cv=none;
        d=google.com; s=arc-20240605;
        b=aezxrNe2WP4+lQhFzzTp+syxMYLyZTFDE44tBHa0xMngwROnVieY7+jLxAeXPPE5dV
         xcCvoAt60KQwDSSpe8KsKlEWlqj6wrzt9G+Ow7VB9Cn5r9wVufzqItc4k3AXXRnahPVR
         IypaO192SJKoZMA/eDjBvb5WqAHLAHXUOP27riIo38JhBkFQAX5hjM32rOYvwJuXio7K
         uWymYcwlSOnAfuyE4NhBbS+4B9bhI15hK07NosutIMNFblN4+UpX0hA71fk0ccZrAZFN
         ibmiU6WE3ssPeuIujyi+o3qm4khIuzF0/DxJPx2yISxA9oYrOIxMqPOc2hwE/o4WZEeW
         puRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=HjGgQCJb397/AHaa//BegFfCtj5XxpuSW9IyLiumWuU=;
        fh=HHj+wSInrr+OCFBtXzTBu/xS3PF20oa0QqUATFV5TVk=;
        b=H8a4GvdxTWNc+5WP99UQACxIo0Bp18+T+qFFHg9xm28Sw7nZMqGRf3J82eV84Qpaag
         QdLu7bcAGuS/DAIpXB9X+G9CcxQCih6O/lbqirVbeNcXfZ6SfPHTLOi10kDPO4vX6arn
         b+WF9lo9ewo/CfT8bBB3beW1dTgLhM6jDJIXV9MQHRunGK/hP9zXeSCBaxjhZdLHWMGH
         RNz8/1lRV+qhvTnTZymlOXChpwMCUO0X+mkunlHLlAdLoHR58saLxZ1a76aPCYPfHJml
         Xt7LILA+XAP+504gMhnSar71YIb+qtdbTnfIgEy+NUrkxmLT1w8LZLDcVczLguEeh5c1
         K0PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1779761807; x=1780366607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjGgQCJb397/AHaa//BegFfCtj5XxpuSW9IyLiumWuU=;
        b=ppEuKyhdtP+z5niDQpqQzTRuA6Q1pLkijq27bPeSJpjzJIY0z5h5FkjpxN8ptxhGBr
         d8l+rHQWduQGucEOXInThMftQtPlujyCsOzVZGQvSuATt7EMYIj5T2Ea6yF3t4dDQeZ7
         RaF75faWwcvhLMehN32Z13v0mxCCY8LWEKqGvAaIKXQAeCLACXx5pefWQyBTGTbli4YK
         +g2P49hKsXhYVIbI0MCsRSW0iF+lkZFXNPIoN9wU9o3Z6KZsPpnG63sko3/zRVCVndXd
         MQGfP8YCYnHWO4YNJoWCpbHLu2+/StnlTfZpBcNM8BeGKar5+CKy/rQeua4Ns2MO1ctY
         yXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779761807; x=1780366607;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjGgQCJb397/AHaa//BegFfCtj5XxpuSW9IyLiumWuU=;
        b=UkUVfo59WpQ3OToucGcfwfr52PZq+YlVQN/RYuD5VwBM32139iCcFNyIS0Jjd780PV
         j80hIN4AQAiA1kdfQMj1UY0s9PQ+V/FxY2zc5zXUs0BcrHLkK1pIuYg2aMC/yjCl59mS
         I26MJ+p3lSVLzAgZA3jnORXMHaeYkQyZ9MXMCm1+RUlNU5tCOVt1OYWVX+urkpxAc05q
         UMQvqeUaPpsKfU8x3vCxm8agWHyy/ZBltl2wj9Qs9+m0UcZR0lSgBR0J9pSiet9xljht
         wRISvvKr07wDbzZNhSHZXn4S0QBliKAV3nDVBWbfN7lWdevNo3AQEBwjFJAsQqlHwNZU
         HcAA==
X-Forwarded-Encrypted: i=1; AFNElJ/kuly2llh+WOnUIrieXKWyP/teGybhDSGx2OUnucglGLrftV36RCfLOybul5JKlIn0zbFL952aBIgC1I0A@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxDY+tYai8m+djOtzzbdI30IbnSEGgZMRKvWD9fOrqArvExU0
	lnsiGCUxYw00g9uur6SxXowaA3o7S7HbSuGrNKR+35GtR8DLsSV4StzBU53QCjnujArLPGpAdhD
	IZT2qbnsSTOT14kyxbRAfVrbKIVJjdTmxjxwvHQTc
X-Gm-Gg: Acq92OEOBrPFsLRATAUz/pPa34Y99sLRCHmbsPlD5wiPKwqIDRVpXOeELoHxvfzrG/u
	DOm1M0K2QyRUgrYt5wfmrCm7kLXC9paqeVRCsauppuwIAbbGGyr85b7ypbEeOsAo4MDBhe30CRD
	iRcjHYTu75Sez3XkzHGNP7bgX5DGIJ58H5o3EaXniajhwXlJ3bCW0gKI05P32hWxpMIEomdldKF
	DcEBuNdHY5Doe3D2XvHbvs90grtibdOFjz/2xUFzNV/h8M2s6f5EcyH9VG9K74AWeeBY+jxL88K
	dCCgYVUAsA==
X-Received: by 2002:a05:690c:4486:b0:7d0:ef8:6898 with SMTP id
 00721157ae682-7d333dcd235mr172828517b3.14.1779761804763; Mon, 25 May 2026
 19:16:44 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 19:16:44 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 19:16:44 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 May 2026 19:16:44 -0700
X-Gm-Features: AVHnY4LnOz-Lj7DewSLB5aGb-AiJI5KmyXtvU8-Qu1OXQtqAo7qOklRH_EqvdpI
Message-ID: <CA+0ovCjJwMoTa8=PEiYGXEhqC5Af7h5guqEnAs5kv95M295N3g@mail.gmail.com>
Subject: [PATCH] affs: don't instantiate dentry if affs_insert_hash failed
To: David Sterba <dsterba@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

affs_add_entry() calls d_instantiate() unconditionally after
affs_insert_hash() returns, even when the hash insert failed. When the
parent directory's block cannot be read (e.g. -EIO from affs_bread on a
crafted image), affs_insert_hash() returns the error, but the dentry
has already been bound to the freshly-created inode by d_instantiate().
The callers (affs_create / affs_mkdir / affs_symlink) then run iput()
on the inode in their error path, dropping its refcount to zero and
evicting it through affs_evict_inode().

The dentry still holds a pointer to that now-evicted inode. On umount,
shrink_dcache_for_umount() walks the dentry and __dentry_kill() calls
iput() on an inode already in I_FREEING|I_CLEAR, hitting the
VFS_BUG_ON_INODE() at fs/inode.c:1980:

  VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR))
    inode:... fs:affs mode:120777 ... state:0x300 count:0
  kernel BUG at fs/inode.c:1980!
  Call Trace:
   iput+0xe29/0xe80 fs/inode.c:1980
   __dentry_kill+0x20e/0x710 fs/dcache.c:718
   shrink_kill+0xa9/0x2c0 fs/dcache.c:1195
   shrink_dentry_list+0x2e5/0x5f0 fs/dcache.c:1222
   shrink_dcache_for_umount+0xa5/0x170 fs/dcache.c:1738
   generic_shutdown_super+0x74/0x2d0 fs/super.c:624
   kill_block_super+0x49/0xa0 fs/super.c:1725
   affs_kill_sb+0x4c/0x160 fs/affs/super.c:590

Reproduced by mounting a crafted AFFS image whose root-directory header
block is unreadable, calling symlinkat() to create an entry under it
(which reaches affs_add_entry() with retval != 0 from
affs_insert_hash()), and letting the mount tear down. Trigger requires
the ability to mount a crafted image (CAP_SYS_ADMIN or equivalent).

Only call d_instantiate() when affs_insert_hash() succeeded. On the
error path the dentry remains negative, so the caller's iput() correctly
disposes of the unbound inode and no stale dentry-to-evicted-inode
binding survives into umount.

Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
 fs/affs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 5dd1b016bcb0..517d40c6c7df 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -407,7 +407,8 @@ affs_add_entry(struct inode *dir, struct inode
*inode, struct dentry *dentry, s3
 	affs_unlock_dir(dir);
 	affs_unlock_link(inode);

-	d_instantiate(dentry, inode);
+	if (!retval)
+		d_instantiate(dentry, inode);
 done:
 	affs_brelse(inode_bh);
 	affs_brelse(bh);
-- 
2.43.0
