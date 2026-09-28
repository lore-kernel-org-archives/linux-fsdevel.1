Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C333CEB83
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621956; cv=pass; b=Hm13fS9KPQw/RlXkpFeFoQf+WTRTq4OZATG1nnYxlq/xioWDTiQCx/66YFwQg7lDryJ8bNIEflbSVYfLPOYSbrYU04TOsn3NaO8QUL+HVNvKQEOwVi36HmyHwXBXGyOELQc9bYsaWkdU5szR7jP9AVtOOVzysM3UutQoh0fAb44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621956; c=relaxed/simple;
	bh=ZckUBzuxfDct7Xtg49y5TXXNnoeTTdLGKQnVGpqLnmQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BvQslehMV7lU6MUibsjFG7iI3qLnRsyuQUMy73Wc2rKc6rVIQ8XkmTlOBhUB6uwFtg2ITqYuBAnrGpZgeeAGRd8YYDXhJzkFj2EillFuNdAN5vOv6S5XZ/zgSKT/hnf6xlrke816GMnaDvC/VVYgL2QaF4+x8UOsOPWEufWlXtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3SffaIu; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3SffaIu"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8eb15037aso1185714e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 11:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621950; cv=none;
        d=google.com; s=arc-20260327;
        b=IOi/N9OEShIHxtXNcCUyq+3TRMZKfFOqJCYratla0QDY2jllOVCk2N9PpMWaIEDxVr
         VhDQrV2GLklPT2yyhbD0LMkHJjI0o8fA2hXbDFMbJtq0xJy2XxzgIwnszBqxcJk4/N0m
         EMZWVoTsl9ejELK80+irsFFLK5zpFtyt8hj5iUKWoY3+MW4NvZWGRO428pq+mLlAZZgP
         HaigL04bhfyt5j+iWqDfAEX19GB55Uok1hcN9mb8tMr2xrdML9IM/QItpuW8WnTYUovA
         25L0WB00nCVdlciGfXIMWVIoW0ynBBvqX6JXbIcEMIKZA0Nk60RizAd8mPRqT4X376YF
         jhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        fh=iwSNYB5TTTpVJ7mIYOQ+y13SNI8qU+/J0C2fWIhfZi4=;
        b=Pw9Frn1Y/Vh7MAF9tZ2E1U/829F64JURplYk6nJoPYcUQW7Qn9M/RqZxWPqjgd5C1Y
         8EZtaL7cbzJ/8AgvYEK7XwiaOd6ULUA4bFlYqIvt9X5kjZ/FcmUXBemFLsUKjugdM5VQ
         TVaNWocsr4DKDt0vjjBWc1ot/S3K/5hf01cliGPlQLa570bidqx8xv156RzTSyvCDoC8
         0eIxTNskh9Db9J8XFg0OZ4MLqblNJGVhVOxMRFc4CxQu6SIAdCQ5M2MWrNmPT7aYdwpx
         RwOh7LAUlFOU09WGLpkvhNAF70pH++eVmEOdzBcd6NeTjYPMKeiPR3eH6uulSQz8tkOZ
         L8gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621950; x=1791226750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=h3SffaIuXFZFlrN3ssHMWUrw9m8vbhLctkQmnh/rvdVVzzlksx4S5ogP1wK1h5TGAI
         wgUF7yo0fNaktuyNZJoMC5eSIIc4tibqykGmSyVkpCCmpVbQZ173yEv6wm4D/oZjZfMa
         HUgJkW25BBx/4ngNI5m39GxRf7pVm5kHjXAqSsx33ReLW1N4uKQK+qESkc7n/62N6pxZ
         iDq8jbO7ge5JdBa1+TCocUuJzCYbOqF5oFo7g3LUp1Uu87AonWLkTyO39Hg7C0A+uSe8
         fv8S5qeTXQlSYWymNgOix5a2Fr+3Oj6wp1fnhd2CmeBa/jTbmIMltZqWrGYpyNbo70wa
         qq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621950; x=1791226750;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=FLRNxdoN6eyXXaQim4WUvrIBIHE724MwTTwFhf/dpPao5MRZqXQe48EIlC2ZUNHk/b
         Nb63XsvbswznJ0oNn2AJ3AkDaOhARgwsT7wgsWaWz0e36l3JyLIf8pDIbSXyuoGhMBJj
         23fmpW+gotrLobLD2PnS5/68fHBYTKmG5NqcykQi5w7KmcZQrOIEDs+VW9iOJCf2E7RY
         tv65fKHwsNxPh7wcL1WWn8eag9tARR1SshbpMOyeXtmoVmPBSOBdjIU9P6Ezf0n9T2ka
         lbokdLu5V/O94Xv9Fv072jJtpJFKEF3Am6Csi8ZAtm3cZZj3wmeXZQNU6MFkr5nWZO0s
         zE3A==
X-Gm-Message-State: AFq9FYIrO6cpYbaL9OZeU8hoGPUK7S0yGPILCKKzR91/q4Mc+4vqvGeB
	kkgM2syfirw9mJ+77foXn4Uzm0RONsCJCrTPOpGxzmR3y4tJd1tfFKalmFqAMKoKhpYxjtuiBYk
	CcuStBf8D3rJTh+BYE1SmkClojmUg4qe3cX4yqP4=
X-Gm-Gg: AYBFou2fRwI50nX3toDNepdR7WHCuS/tV10EdWVGiBGgvEJBwfBv7ou2My0gXyTn2xU
	3Kbggu1x8nInNIhvnP/MslQb2PYcV978tzxR0vPfEyB3Gobll7OEqX/dz918vLfXx/IMaSPMScY
	e54IBUT2E1mzksc4bsgHwGlW23bqz5iQmmJ3UR6+wSmVCOaltuvbmQV7OjeueoLVoHa2XtkJe/X
	gR0i34cQgUqZW2iJnF7e3H6mFjd8jVdkobbYsjMJJMAC+G0gtsLKvE2PJN7f1w0Kq2LZ8RoNSAn
	tvt0KKQHzBCW9N0jIM6Kyjr1tJbJ1dLl7e4cYnk6qqDVmWHemlFPya6+N72CW/6oAkUO8S3C9yk
	/kKvrjpRaU8v1
X-Received: by 2002:a05:6512:134c:b0:5b6:10bc:b864 with SMTP id
 2adb3069b0e04-5ba2e6289cemr39499e87.18.1790621950325; Mon, 28 Sep 2026
 11:59:10 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Mon, 28 Sep 2026 11:59:09 -0700
X-Google-Sender-Auth: ZwCvM-sC4hIxe8N8dJb-AWb4nUQ
X-Gm-Features: AclHuK-2bu843UqJ0hkn0uiGUfhhfw492ZeGe05OpMyUNCkLbPWCoP_36qHDt24
Message-ID: <CAANnmVBmovjCL0Ky4F3ay8pnmm4jp0+HyXC9QYyHo_1Bi1FucQ@mail.gmail.com>
Subject: [PATCH] ufs: verify cylinder summary size against cylinder group count
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, marco.crivellari@suse.com, ali@iusegentoo.com, 
	kees@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cylinder summary buffer is allocated with the on-disc fs_cssize
value in ufs_read_cylinder_structures(), but it is indexed through
fs_cs(i), which expands to s_csp[i], with the independent on-disc
cylinder group count uspi->s_ncg as the only upper bound - see for
example ufs_new_inode(), ufs_free_inode() and the block allocation
paths.

Nothing requires cssize to be large enough to hold ncg entries of
struct ufs_csum, so on a crafted filesystem image where cssize is
small and ncg is large, every fs_cs() access is an out-of-bounds
access: a read when scanning for free inodes, and a 32-bit
increment or decrement past the end of the kmalloc()ed buffer when
an inode or block is allocated or freed.

Since the summary arrays are only set up for writable mounts,
triggering the out-of-bounds writes requires nothing more than
mounting a crafted image read-write and then creating or deleting
a file.

Validate at mount time that cssize covers all ncg cylinder group
summary entries, and reject the image otherwise.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 fs/ufs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b065..2052d5225d03 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1139,6 +1139,11 @@ static int ufs_fill_super(struct super_block
*sb, struct fs_context *fc)
 		uspi->s_csaddr = fs32_to_cpu(sb, usb1->fs_csaddr);

 	uspi->s_cssize = fs32_to_cpu(sb, usb1->fs_cssize);
+	if (uspi->s_cssize < (u64)uspi->s_ncg * sizeof(struct ufs_csum)) {
+		pr_err("%s(): cylinder summary size %u is too small for %u cylinder
groups\n",
+		       __func__, uspi->s_cssize, uspi->s_ncg);
+		goto failed;
+	}
 	uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);
 	uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
 	uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
-- 
2.47.3
