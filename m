Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FF386C17
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803632; cv=none; b=ECNmKRNkgmOCH8BasS/fSv4MpPnbznS87yDEvhNwigWB76KSVjpWKfiCQTgai4M2l7tmud2a2R7S/jNxEJwaZYCpa+0Gzu2I0mYwLgRtBB8Aw8+8fLSMrYr85bulY7fx/O4HDXdLxW2WbPZqAfp7zo4/oEGuZyz81R0Ed6sdDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803632; c=relaxed/simple;
	bh=+NX37KmNCiRQobtp0AZJA83dK44q/9DxsG2l4pUAzfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eq+rbnYDTmlVkea02Vox88eSIphHBOhnHMXTYRA/y/FupOvyIgTy9XPYW/4JybnxM+U9NxmyxB8hsE3gVyeyw6jaMleEF4P+hAhPL60HKH8dljbOlyiyXwNRzlqcXTtgQoSqxX9bkJhRRwWyrjahk7NG2Q521nzbJQT+1gyKBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOMbLBEt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOMbLBEt"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso26374265e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775803628; x=1776408428; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RODSSp/HcmdrzLuyL94yj+lqKUbtuAT0pxgzahly0I=;
        b=UOMbLBEtRjbFe0J5jY/6QC+zskT0kU7tBQBn9V8VNBOLSGaM/t0IOnpDOCgjga1/Qe
         s/vH2ZJFsDYFt6TduBk/+bPGaB9I4BgI+bFF4mfhhyTnW5qcRkOGH7jxbgYL+hnyYN+9
         eC8LKibeS4Z8Q1nqCKGCbUTGOPe/iHUrhh2r54MX6hNgnJsRltQ8n2v9wmTGpm/jrzTF
         KSHX5nDZGhqVAQ/sSXbQoIcpiw5+Xz346JtUZYl3hkXhVBEx/raz7ZzPtfoNyTO9kDcj
         PrfSI8Rg69bpfgAMm6ZkcFCKvBnByKvKXPeyXG1PU58Dx0n5HQudxN2t1IToq7NLyl1V
         7o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775803628; x=1776408428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RODSSp/HcmdrzLuyL94yj+lqKUbtuAT0pxgzahly0I=;
        b=NxRoQlk//zbmKl9d5z/aX1WQFyWDPbWNU3IrLeG1IYlHj5KGubgf/12hO6fU7bMTEW
         Ou/H+RCSyH7YniLkUd+rLi7cQDe9IKV/p64yDO+KjfM2STSHApKmzkz9rIRXwMHz15or
         96ixpjeF9ewDAQ6i1h4cIex+r38XP1dJ4+p4JkjvAOMBS6ziwabFf3JhxwXY600fRs2o
         Qu+VUbhuo3CLHS9zCcDsWMPEfcvhEqDvReGzUmfFU5VM67b4fozUTm/1w5qoXWuKXhRl
         y8CfpToyr1sPp+D4D8JMTYqg1Oj2no/Obtunoy7KUvwnm1U4EIMJ7qVo5jUQXmKrf465
         SyFQ==
X-Gm-Message-State: AOJu0Yx35buGyp9EqS2E0p8Zutn3yD2SqAxo76Ak+e3ZbdGj+RArPQB6
	0WOMUq+p6IWnOduyTsYvvegvCcs0HMKVr3/YGaI/0bVrNGyLmLqZ5e6ijSyLKLaa
X-Gm-Gg: AeBDiev17GwucZZCEa+ZNPIcR+gsPMabOqWBQTVpXR+H4GHekEv/I9P4K2k8TlaGkr8
	ayZ4qYFmyHNOYV9X9yh3SxAaehEmj8g18ISuXt7dD6f5W08UA4Yj0cvxdKqiuITAIH5I8lPz8qT
	vBh20mp2P66HnbDE/a6ky+oKtQj5ntHiMHJcGoLAJo4xRnK4B7Zi466tp8aO2nVcPJ1hudulScr
	i/W5EJAsSM+zS2qfrLLkFdwT7aFOfeMGedEuf15F2j24h+uT0oyyDQvytClBv8NHz9WKyY0HDs5
	+CjrFTg/szqLy+WPyiQR0a3UvxDz2CFJ7XKMIoaA9we9EGMTL/79HP/RuJaSUJoDG5xCmO0Ieoz
	k6wkurei9SFxdLYRpJqi6rz3irzN3jHocJZHGQfx30v2uE/5yyMOFy0r/VfXkoYannhAsfgdmtU
	i7TLjcszlnaSoCfbZLdZc=
X-Received: by 2002:a05:600c:c16d:b0:488:be21:54ae with SMTP id 5b1f17b1804b1-488d66504bfmr23421935e9.0.1775803628349;
        Thu, 09 Apr 2026 23:47:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888c12sm57403135e9.3.2026.04.09.23.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 23:47:07 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:47:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] ntfs: add reparse and ea operations
Message-ID: <adic6OYLSfoUEcDu@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Namjae Jeon,

Commit fc053f05ca28 ("ntfs: add reparse and ea operations") from Feb
13, 2026 (linux-next), leads to the following Smatch static checker
warning:

    fs/ntfs/ea.c:444 ntfs_ea_set_wsl_inode() error: uninitialized symbol 'err'.
    fs/ntfs/namei.c:651 __ntfs_create() error: uninitialized symbol 'ea_size'.

fs/ntfs/ea.c
    405 int ntfs_ea_set_wsl_inode(struct inode *inode, dev_t rdev, __le16 *ea_size,
    406                 unsigned int flags)
    407 {
    408         __le32 v;
    409         int err;
    410 
    411         if (flags & NTFS_EA_UID) {
    412                 /* Store uid to lxuid EA */
    413                 v = cpu_to_le32(i_uid_read(inode));
    414                 err = ntfs_set_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &v,
    415                                 sizeof(v), 0, ea_size);
    416                 if (err)
    417                         return err;
    418         }
    419 
    420         if (flags & NTFS_EA_GID) {
    421                 /* Store gid to lxgid EA */
    422                 v = cpu_to_le32(i_gid_read(inode));
    423                 err = ntfs_set_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &v,
    424                                 sizeof(v), 0, ea_size);
    425                 if (err)
    426                         return err;
    427         }
    428 
    429         if (flags & NTFS_EA_MODE) {
    430                 /* Store mode to lxmod EA */
    431                 v = cpu_to_le32(inode->i_mode);
    432                 err = ntfs_set_ea(inode, "$LXMOD", sizeof("$LXMOD") - 1, &v,
    433                                 sizeof(v), 0, ea_size);
    434                 if (err)
    435                         return err;
    436         }
    437 
    438         if (rdev) {

err needs to be initialized if rdev is false.

    439                 v = cpu_to_le32(rdev);
    440                 err = ntfs_set_ea(inode, "$LXDEV", sizeof("$LXDEV") - 1, &v, sizeof(v),
    441                                 0, ea_size);
    442         }
    443 
--> 444         return err;
                ^^^^^^^^^^^
Also Smatch thinks that this function can return success without setting
ea_size.

    445 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
