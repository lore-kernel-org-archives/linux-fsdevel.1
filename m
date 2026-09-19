Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B903F39E8
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808605; cv=none; b=Kk5AZcwekJp+QIXiM3vvYoBm11tfHFJ2J6sO8gjaLIsm88AzT0Xu12GZIshXD6wPloPGVon78W+YN0jXyhUQrx7EzF+Tji7H2rghuQl1Qll6ZVHwwUDidD8A9aBjYCLyEqZRYzdtWiUzKyDL5GLRvb0AqF9U0jLHRC1IsULA5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808605; c=relaxed/simple;
	bh=melq5UXdrQWJJ2k0jZPaqw8rThkFHS1ZvrDkkHIBXg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSQcHeNeT1Sy1oT4iO1+GaTNd45uvNJlQt533MSEUhVLEB0vS/gU3TrJuMazQYV86kV9XyxjKaIjWcPTnmy6SOehAMIPuycX5BPgeqnjwJwA6ZdOGQH2vHczABWGHCNMSpcS1O3WqEv/mL7RmImNbH9go03CMEyVxXxtyC67G+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnopmVHm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnopmVHm"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1464516a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789808601; x=1790413401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5QaSNMO0uUfr1zM6qLt8sUm63zuw2vovwqSO29roHTM=;
        b=fnopmVHmakt4o7P5cYEQt9v9bfEFoC/xmCkEwMkpgb7YQw1v6jr1FFyK5stczEETDn
         /bMp2eHc8aI4BzKaRG+5XFLk1NeSzNcZLyDv2bmIUWZ/1K85eB969wEW3AknO8bUoxI2
         ZJds3DCKE7MXZfE3y1DQqRviEaVwppM06cDi0ZBqQx2ZJRb2deeCye+BxKTSTIHfPeCd
         9Obs4Pgaxj1ura1WYsyuImTUpLjLklKkr+7FAoTLdgruIZJ8No+funLRmaPrOPnuRiHF
         Xu9mNfcJ8+XWtYXSJT/MITBsFbpWpbNTXIPRSBYIwBhL+PVP2f4dfxCRR2D0sf54cu1l
         I+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789808601; x=1790413401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5QaSNMO0uUfr1zM6qLt8sUm63zuw2vovwqSO29roHTM=;
        b=y2AmR3zGeW61t55fAFJfotoUSGhjH2AaLdrzeite4R/4PXTsgiczjpC9A/C7RfpFvp
         vpQQubAMQW5hixoVj0wm/5B2QSvJ9DKqs2uDuO3JE1PVvqvCKOh4CdbG1bk81pdsa+Cm
         HcAj0C2tzSNyGwyVVNf8eZkTEQ7urJSn84kYUmth2TyRPuqmWAtpgH8go/FiooP8Jy/w
         VTXiCAUuOW/wEI2jY3ka49FO4xAKg1CRw7/nmomd/76K4CpwEHH6pndZ7eMZNXTEwggG
         vI6k3AMNtwzoO0EniTjr0RFBjHh9dDRFyuVJe5iawyYKeVu09DyLCtj5dagaqXcCuN5q
         SDWg==
X-Forwarded-Encrypted: i=1; AKwUvBx43kqVe+Mm6ZCjyNVc23pnxX65/x2atBCMGQn1ES/oolY9RFysfabiITtdEE3FMrCV+v1mHbyl8OPqouGx@vger.kernel.org
X-Gm-Message-State: AFuF++m1VQACBV2Sz6GkzXREW4Q7QdHEFdR1lJGPCSyDZeB4wv+yDytl
	sYMbVd+LhKTKWh8stFgKyci3a9wDSbK+5EOF0IRDshRvuirRdQVwJ6v5
X-Gm-Gg: AYBFou0X+pTxG8TTXlFH1uAzLHhpVo3oBALRLzE6AaNUMddTHcN2Tu9b4+0FxPbFz2x
	Bg/UsOV2K4xr6YlRCy92ALhUeETYZMQVTATksMPjhK7yvccPubZlyy/V8/y9ZuxoKQRz31tRjqE
	YcA772m9HuJHOaqv2WnJx1xM5j//WhRHq38EjqS0I4+C961l8RVYsdBPcUJgtnDSRRuJsAvmCRi
	udLqAwo4RbkoT1hhmSqkSSF73TS0Jkod+VjcDpQ/wP+PXoDTGuKNN7dzut5XJBWsa4aARCCMwy1
	hvK4G92iE2Sp3bOaQDRUZ6ckw7yMjznqsDQgdSydVhIyyfXVbw8wZLLJRugz31PIKlLmb9ZielS
	KmXi27y7NWLGHs1qR0fX++Fc9kSoGsLeKRKQLWxv2S9nNVKDYq5DJvHyhv4WCL8NGm6BpazQibv
	ey0FkUCA6bPTYvPVgQCkKSGrVCrshJos6/1jiB6XnS4AuZeZkl6Zx38NAnHtPzj035l6MfMHFTF
	EgUOe42vEVwrxjVz5Hhx56WIjBReHrKDgz2gtoeIb2FhxqJd96Mq1dmJ+hOTx2Sj/ghHwZOvAqu
	BSFHaiUHUvc=
X-Received: by 2002:a17:90b:2686:b0:39e:6a81:c91e with SMTP id 98e67ed59e1d1-39e6a81c997mr5758631a91.17.1789808601184;
        Sat, 19 Sep 2026 02:03:21 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm3563781a91.11.2026.09.19.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:03:20 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Russell King <linux@armlinux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH] adfs: validate bigdirobnamelen in adfs_fplus_getnext()
Date: Sat, 19 Sep 2026 09:03:19 +0000
Message-ID: <20260919090319.3238583-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adfs_fplus_getnext() reads the directory entry name length straight from
the on-disk F+ big directory entry:

	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
	...
	ret = adfs_dir_copyfrom(obj->name, dir, offset, obj->name_len);

obj->name is a fixed size array of ADFS_MAX_NAME_LEN (260) bytes inside
the on-stack struct object_info of adfs_fplus_iterate(), but
bigdirobnamelen is fully attacker controlled and never validated.

Mounting a crafted ADFS image whose big directory entry declares
bigdirobnamelen = 264 and then calling getdents64() on the directory
makes adfs_dir_copyfrom() write 264 bytes into the 260 byte obj->name,
smashing the stack frame of adfs_fplus_iterate(), and the subsequent
dir_emit(ctx, obj.name, obj.name_len, ...) reads the same out of bounds
range again in filldir64(). adfs_object_fixup() may then append up to
four more bytes for the ",xyz" filetype suffix, extending the overflow.

Reject entries whose name length exceeds ADFS_FPLUS_NAME_LEN (255).
That is the maximum the F+ format can represent, and it also leaves
room for the four byte filetype suffix appended by adfs_object_fixup()
(255 + 4 = 259 <= ADFS_MAX_NAME_LEN).

Reproduced on Linux 7.3.0-rc3 (5dd1818b15d9) with KASAN by mounting a
64 KiB ADFS image (loop, MS_RDONLY) containing a single F+ directory
entry with bigdirobnamelen = 264 and calling readdir() on the mount
point:

 ==================================================================
 BUG: KASAN: stack-out-of-bounds in memchr+0x82/0xb0
 Read of size 1 at addr ffff88810099fcac by task init/1

 CPU: 3 UID: 0 PID: 1 Comm: init Tainted: G    B D    7.3.0-rc3-g5dd1818b15d9 #1 PREEMPT(lazy)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 Call Trace:
  <TASK>
  dump_stack_lvl+0x70/0xa0
  print_report+0x153/0x4c6
  kasan_report+0xf1/0x120
  memchr+0x82/0xb0
  filldir64+0x56/0x5a0
  adfs_fplus_iterate+0x1a6/0x2c0
  adfs_iterate+0x1bf/0x4f0
  iterate_dir+0x1c1/0x560
  __x64_sys_getdents64+0x13a/0x260
  do_syscall_64+0xda/0x4b0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

 The buggy address belongs to stack of task init/1
  and is located at offset 380 in frame:
  adfs_fplus_iterate+0x0/0x2c0

 This frame has 1 object:
  [32, 320) 'obj'
 ==================================================================

A matching splat is also produced from adfs_object_fixup+0x3f5/0x480
for the write side of the overflow.

With the check in place the same image is rejected with -EIO and no
KASAN splat is produced.

Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
No Fixes: tag: the missing bound check has been present since F+ big
directory support was introduced in fs/adfs/dir_fplus.c, predating the
later refactoring of that file, so there is no single commit to point at.

Found and verified with a QEMU + KASAN reproducer (crafted ADFS image
mounted over loop); the fix was rebuilt and re-run against the same
reproducer, which then reports no KASAN splat.

 fs/adfs/dir_fplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a1592401..517ffcc91 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,8 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_FPLUS_NAME_LEN)
+		return -EIO;
 
 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
-- 
2.43.0
