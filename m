Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B611B142D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787721673; cv=none; b=TNqvTxdIMsvKVtwzGSnQVV8MjL2Dh3jSYhxFVwHdQP8rNiAFvl8KYJ/zU746A0cPUKt8CNmIks9qw6/+LevgPdHA9gYeFjiP/nar6T+BzH48mCNKhAHowo2VFO+osXgwPDgo0xsJGSzJkMAldCpb678CSUSQrxOvBfWU/xdEzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787721673; c=relaxed/simple;
	bh=w5KSPtKV0YgCLci4joYya/6i/uT9GHt+Vm6dHfbUJgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqwM/cSkV9wzUz3D21HnFbz0Ej6EjQGsCdP7FtPjZtk+fPfP8lfBPRr3xx2/XvKDVBZ09zfM/hEbV5UktXSNuLhWJLqLZXDDO0HZHeOT0SXmbOoBugApd6OiXkDgxsiw3QBhumdiP6k7i2wonKu0uqMk6j9Br4YGoBNoQ2mf/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxh0xi1e; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxh0xi1e"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8541875f596so3566b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 22:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787721671; x=1788326471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNJ3kg/OSSC9Faib6mXlgA6wYEseQ+hAgHk+fzn3jtA=;
        b=Dxh0xi1eFGUDIzk6T0bCdhE7cHJB20gfbFVAF4pljQfix3uc4XktLI2W7Uh6jqyC1l
         mjLDub0fdbwN7Q0E1M6h3d4YUse9K1k3l1fu7npPcs++tcNJcskdBovSQmbrtNJpcNkg
         dzQQDjJWcVEcvviGThLVm84IuGh84bwr1ArLAOSBs84iCRabLxv74e5M9VVxnmxsYCQs
         VkCXH9iN0WsgKIVL/dQ6r9XMxM5JFfuDhctE066hgmzOSGbUJXUigZ4OoyAmSaplo9Ds
         dcG3y6eHWOhlxyfrVcTrJf1VziGm++1gSMb09tioWDtmiJxbl/44qqfwdv9U4Jn2zucq
         Sxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787721671; x=1788326471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNJ3kg/OSSC9Faib6mXlgA6wYEseQ+hAgHk+fzn3jtA=;
        b=MTV/XrkPCtr0SMYw/NXa90tpf+jH79qHCse/m5//N5SYsz91VkdvdxIes/XIzM0cde
         RAQuA67KbgKyYYLBklFJvk0Hz7h4H+DiFlcPvbUyP5LcF+XrAXJXDNwQ7Dik3UI5TpKS
         NJOsUInxe6nUc/y8a6T+GvWpNNrIcsM02Qvbsw0Bpt3lJqtH2UQI1oLUNOdh6iri0k5Q
         9Bh9TrWsgKpMihQmZdpTQn/CCmT5Tbr9LVuDCv8U0g4+NHfa6QIu5KBW3mNiWBSBK2MN
         IieZ5I2BvtBgMLRTxC/137zcbG21STs/J8OAwjcJ9BI2kIGk61YzeNQBBAp49pdatgI/
         7jrA==
X-Gm-Message-State: AFuF++k9hGs2WN5oMDIQ3w1tUm1Npyloikqw3ED15U6eh6oNf9X6m6/F
	GlhxW4VI4qKsgHzYkGzdYLfSg75mbOks/fZgwZDOTUgv5Gfhie9wcwAe
X-Gm-Gg: AR+sD130PJsPa+NM2ztChyLK4IGwaQrC8O8ackKdUk4O7vTwKv8Nd1ZPVA9nlQacq+D
	Cm4lsf20t9o1wum/dKCntRCRQ35NjdmijoGALtqCza41lDs7InTEMICfKYK8mE40QUAAHXyKhFZ
	URCqiNblh7UrtnBx1Youdg/MhDLXC6fipsu7gCz/eDFiAY2I+hkZRf7VbbX3JMzip6TmL1MFX5o
	W1pfDGgD63jyRvC3/K+809+GpedI3566qmXIYHHJ4EEeI4nhkybO8FIQrhS6P7iq6fN48hJtxrL
	lgaU8ZEv77CevqrSOHUAq1A6MxTsLZ12xHtArCteLjEn4DjDxBm+kBjFwHqQyroUzgX5zJrc+l8
	IwB8rvLXucnAjz5P+ThbfWjQOnW/vAJf6djPhX1DgVFPZ2Mf5vsoe1p8ndYp3T+2N5f4bhIPHUX
	OrRMVRKCRQ8nREC/Zw3a/F+zteLZ6YcgzOs8PikbkCS5hB5Eb5yqAZGOn2YfHfvHGLB8fLdo6+6
	of0UzWYRsRppiwTE3fjuedOVC9H2nJfOFw5Ush00UIBPej7AK61zTFsL8ZqY0LTBqw2Kin8wwT9
	meyKxOUeKx11eN4=
X-Received: by 2002:a05:6a00:6c8a:b0:835:6388:655d with SMTP id d2e1a72fcca58-853752c58eemr7806183b3a.14.1787721671319;
        Tue, 25 Aug 2026 22:21:11 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535d344602sm521443b3a.58.2026.08.25.22.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 22:21:10 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] chardev: check return value of kobject_set_name() in __register_chrdev()
Date: Wed, 26 Aug 2026 12:20:55 +0700
Message-ID: <20260826052055.19201-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The kobject_set_name() function can fail and return -ENOMEM if memory
allocation fails.

While all other functions called inside __register_chrdev() are properly
checked for errors, kobject_set_name() was missing this check. Add the
error check for kobject_set_name() and jump to the 'out' label on failure
to maintain consistency and ensure proper error handling.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 fs/char_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 00229e25c10f..5ce5423f6c99 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -280,7 +280,9 @@ int __register_chrdev(unsigned int major, unsigned int baseminor,
 
 	cdev->owner = fops->owner;
 	cdev->ops = fops;
-	kobject_set_name(&cdev->kobj, "%s", name);
+	err = kobject_set_name(&cdev->kobj, "%s", name);
+	if (err)
+		goto out;
 
 	err = cdev_add(cdev, MKDEV(cd->major, baseminor), count);
 	if (err)
-- 
2.43.0

