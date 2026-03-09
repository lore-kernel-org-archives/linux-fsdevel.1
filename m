Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7835839D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093011; cv=none; b=IYqhtjIAPVkaSw1WmR4qp0dhRUsaNkuysLnbtc4BQA/sqRwwbTRJu+tOoX644a3mnA5ZcEFfonRA7exBJFnfDacG7ldDUa+lsYbxbWianUiNXq2g9C9ght1jLzK0KSdJtvC2vqa2O9J+FzZr6gW2v6AZZNIOmxUJ78vlB0V4Giw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093011; c=relaxed/simple;
	bh=TCNDVI1ESlAU7xsc70D4E4dQ/v2Yzwb+pEMzqKqyZwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mudi/Os4HWbY+9HSrKjKQskLDmiHW2tVcUFd0XSeW1Sh9SnoL+hjOx+wbOx3bzRGiabLgDc0nnQYaGQ0kSMmE1M6Z+5sKtKI90skbwzoBL70fwYaMxJuVw1/9E8XAMeZzyqTUiIZjDcWcS631kxdeSgNIifCQDrkMca40s9gc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=KCofmEfB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="KCofmEfB"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d751ef36ccso558617a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773093009; x=1773697809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFvFh4oOChvkx2bi3ZrF/2CPDlLYteGJSvbMKr7ye5o=;
        b=KCofmEfBv2y3uYqbAlchq6WyBN02Reu4VBqIkWpCDLmP6chYyg3CJyc2c16r9MTeNL
         Pca0VhQ9svj3Y1RawMayCO6VRT18Mls1dbbUsKI5slja8kgv96GP74c1vPCHcXjesH4i
         k1ocmDPAgeZjQLFnG0H4HvyOfXL37ODU2hb0Mn5FVihnBfggyWoycxInNjRiyGqXYHSq
         2WTrXFmVFO4GYVJvzSUffGF7SlRlozRU/0Ls6gcHPEF2rIrrYo7nCvdCbZukfpPxq9si
         oMIBSIEfM3hICTFoxY1d9VnfywGhcCxJwNi+I2jdN2rZpfgFtEIM48OYEK9pssbE3zYq
         2QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093009; x=1773697809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFvFh4oOChvkx2bi3ZrF/2CPDlLYteGJSvbMKr7ye5o=;
        b=cpd1OYeAJ+xFzmUvRq47zxK8uSTA+2aRQTVL9ArrvG/tkzDGmDzWzEiidVyzG28uKm
         2L6K2GOZe8AYdxwI8NjPNHCeLXa5I0eBpU8nFL2aBOiHVS9qin121JQ4IuTuxZ4ybliw
         N4/i0ZiI/61+QUgD96Hl6Z8YehCFDz1opGNA2t9r0PNOeG/Hd3mhkXq9nsRDdX6vWgUN
         b/xGp28mo3HUPcHCrxTPYHgKdRQAlmJKGe4uJg6g2RzEaIt6sOedGTTRQ9TXpGLAlmQo
         NkSV6J16YPKoivn8Lnx7omvO6TovmgH7e9DbC6pZmw78TjDan+D20zH9pEWYJ1WluAVk
         7JhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbKeGgPLAyQZrOp+r+yHYBlAl91Iuy48/7paWNuP5IY0yHJc93K6boo0riKerGfS8WtIJmgQowUQfWvRlT@vger.kernel.org
X-Gm-Message-State: AOJu0YxkSEpd6fd5Zz5LSSmIfxOo5C+gTk+qpXm9cS/I+XUDU78d2gG0
	pzMp1PUWJCFQ3MFQ/ALir1k+eiS3aw2oPGZDqMGpCRdU4fv8PU9zb/3g/F1NiIdryH4=
X-Gm-Gg: ATEYQzzL2vL4ng3EDFidFyBRvz6yvfialKTK1ndiFX59V/AJ7dq0RgwozS26oIUs9ED
	VwFvoi8qAGh6cz403lO1cnRTGyrwuDtTcvUr5nkT4VgoAZakPrqkZNm5rOj1lUs3iXAAGaZEeyB
	FAOMlyxf+afwVPkpKcMFfRFRd3yF0L0fixAfExn4W1UE1NXEnKXfoYB1kujL9dUdWHo2mBbKSIu
	Ui7lJ1Ji7XiY0BDIpMPQMgivU5ToYCiurDWtfER5t5cUnR6J8rV1nSeMq+k1PwFm3eRBUN8wzq4
	ozBO4hUrCHE+tCNlomjFbBWD9zqL4XhQb3l6r93GJ0IUE6UtbZp8F9WvIB4tUzNgapSuFCQzNWD
	6g/TAxBwFAvlJkdwRxqTKWOEermH99gJs2uXVcoitzhGJabNlRrvvRlbatNSNvsaztkkz3BrQFh
	dQyICvu871Ep9+/GXd0Nw2emPdgo+cOrvHQPbeQ6ynJ4LSnEknhYY+P2HCnx4yGGoYR7etuZiNy
	vP0ePmlPLteIsKTgfvOEFo=
X-Received: by 2002:a9d:5a05:0:b0:7d7:382f:f005 with SMTP id 46e09a7af769-7d7382ffda0mr3501582a34.35.1773093008706;
        Mon, 09 Mar 2026 14:50:08 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f17e:6b8:fdb8:b541])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728d1238csm7334464a34.15.2026.03.09.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:50:08 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: set ctime after setxattr and removexattr
Date: Mon,  9 Mar 2026 14:49:48 -0700
Message-ID: <20260309214947.1114618-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic/728 test-case complains that:
(1) Expected ctime needs to be changed after setxattr;
(2) Expected ctime needs to be changed after removexattr.

This patch adds calling inode_set_ctime_current() in
__hfsplus_setxattr() and hfsplus_removexattr().

sudo ./check generic/728
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #6 SMP PREEMPT_DYNAMIC Mon Mar  9 14:29:30 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/728 35s ...  44s
Ran: generic/728
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9904944cbd54..796a649ea5af 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -399,6 +399,8 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 		goto end_setxattr;
 	}
 
+	inode_set_ctime_current(inode);
+
 end_setxattr:
 	hfs_find_exit(&cat_fd);
 	hfs_dbg("finished: res %d\n", err);
@@ -880,6 +882,8 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 		goto end_removexattr;
 	}
 
+	inode_set_ctime_current(inode);
+
 end_removexattr:
 	hfs_find_exit(&cat_fd);
 
-- 
2.43.0

