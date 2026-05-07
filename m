Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255239B97A;
	Thu,  7 May 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153251; cv=none; b=Y/pA5jwFYbGwPGHXWjdx68hH4wbsWWSfApeMA17tqE1r+0HRxFR419oiMB6Al2CqZkqKWyLq/igVRKQ0+g7fvjYl5ahAcvkamPauQNeWojRDVvHvBUOFikCEDTHipJ2AsXz2PfVhGxdzlK99C6Nc/kRHlLOvL5Z1YqyZObolL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153251; c=relaxed/simple;
	bh=uMgzkn4mhzquLtNAfnhlFHgJyUM2YrumFH2xoyclWlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MjLwhJlYkpVqgE3x5BeJWFv1R120H5NWDbA/GQrJimxysEVkK79SvqUdonniti6zAsytse3s6NwMLZdjBiTQATW293rMMNkfl0taih9I7Y355V1Q2jT5sPF1pGJ2ts3Tva4f3RzjMuOcJLrgb2twEGuWo2dSjfCQXR38Pwe2q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OZY1c5dZ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OZY1c5dZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DF01+QXLy8g00wDgYh2jIyULzG/ALEH5daN6HCCGS+0=;
	b=OZY1c5dZwIHv+7tJZ1Gd0Xy1YYrZCGUiPTMBTbrJYl+wJ5KTIg17n87XbXnvPOq+3SlpPG9oo
	1G/8t/1DI4jdvvMBtuSeCKBbEcE+jWb+lXy4hOrBvOVu+gtT1WoQ5K8z/YA3YyxK96CdaZVl+sj
	QttWLOQTq/Joczf5r8tclK0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gB8th31PPzpSts;
	Thu,  7 May 2026 19:20:28 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CFC220104;
	Thu,  7 May 2026 19:27:19 +0800 (CST)
Received: from huawei.com (10.50.85.155) by kwepemk500005.china.huawei.com
 (7.202.194.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 May
 2026 19:27:18 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jlayton@kernel.org>,
	<josef@toxicpanda.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>,
	<changdiankang@huawei.com>
Subject: [PATCH v2] nsfs: fix wrong error code returned for pidns ioctls
Date: Thu, 7 May 2026 19:23:01 +0800
Message-ID: <20260507112301.1042757-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500005.china.huawei.com (7.202.194.90)

When executing NS_GET_PID_FROM_PIDNS (or similar pidns ioctls), if the
target task cannot be found in the corresponding pid_ns, the error code
should be ESRCH instead of ENOTTY.

This bug was introduced when the extensible ioctl handling was added.
Without proper return, ret would be overwritten by the default case in
the extensible ioctl switch statement.

Fixes: a1d220d9dafa8 ("nsfs: iterate through mount namespaces")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
v1->v2: Delete unnecessary blank line.
 fs/nsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 51e8c9430477..160018c4fb36 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -266,7 +266,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		else
 			tsk = find_task_by_pid_ns(arg, pid_ns);
 		if (!tsk)
-			break;
+			return ret;
 
 		switch (ioctl) {
 		case NS_GET_PID_FROM_PIDNS:
-- 
2.52.0

