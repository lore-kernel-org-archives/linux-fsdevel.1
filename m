Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175F3806A1;
	Tue, 24 Feb 2026 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934180; cv=none; b=bxmChgknTCpnkTNtE4841grZCRQTF422HAX1wthtzb6aVzYThKunCzmydriU/ntJqTB3zVHSMKVtSoUUsVWQ6owPlb2ItiyUxvRQrmAGUoyg8YSfK1QUB8V9v9Of2vILqeuU+fJzBAYA/3MUmsJDTDJfh3+qgbxPGZONwEoSqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934180; c=relaxed/simple;
	bh=srpLL5U9iTOojIaPu/WlZF4fGmvvQZbJumftBSOyAXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HeyFaqtlHXUlGQKMGtdMk3D/nAFwL3OVmh/WRX8oIJjlJRCGtoUdGE+INyouKsY1l0YLOr5l7coPxh/iTrLgLR6rTtk8XNeLtKznGocUviPXOvEBWB+DooE9wfE2MQ079+GwUUatE3pr9e9cRP27Jxd9CGnrqSywjVGkCYPEz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ploN+3RT; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ploN+3RT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771934179; x=1803470179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lNm+qpcn+86D78pkQFn2GxBWwuUGg4Iw0xHk9NJNaRk=;
  b=ploN+3RTFbjnWn0S+7J47Z6dTfSYhh9zCikusj8QLDhhquy+vyLC6oLN
   5U+T0/HnV/DPKahxHbA+9We//VU1kniUnmJaEJ36XvzWNIP0w7VEyOwwA
   A4PHY8cQlWI0MhGCujpOZdhr0WVCB9d7GPZS6szqa7ih3Dz0AVgTsVpXB
   o2dtF0387q+g7t5CJ2Ln8MsDYwNLQ0UPNISpcI2q7It54Nieyaiqx1IZL
   NgEC5XsKgkWCT3pwD0pL7jYnd+h2YHL11pw52MsVVC2LJkb7ncwZ9lC4l
   jeBnUX/m/It6nzxxu7CfcylCFe6RFzSCjtyBpaYOy7BMw6I/1N9BrtK4l
   w==;
X-CSE-ConnectionGUID: Y8yDxO9qTuSUitf/APdozA==
X-CSE-MsgGUID: NNh8eb5JTrKEFh58cvlmug==
X-IronPort-AV: E=Sophos;i="6.21,308,1763424000"; 
   d="scan'208";a="13478288"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 11:56:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:19167]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.246:2525] with esmtp (Farcaster)
 id 44172891-dcbf-46fa-ad60-09fb3aa957e8; Tue, 24 Feb 2026 11:56:16 +0000 (UTC)
X-Farcaster-Flow-ID: 44172891-dcbf-46fa-ad60-09fb3aa957e8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 24 Feb 2026 11:56:16 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 24 Feb 2026 11:56:15 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yuto
 Ohnuki" <ytohnuki@amazon.com>
Subject: [PATCH] fuse: replace BUG_ON with WARN_ON and -EBUSY in fuse_ctl_fill_super
Date: Tue, 24 Feb 2026 11:56:07 +0000
Message-ID: <20260224115606.4249-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace BUG_ON(fuse_control_sb) with WARN_ON() that returns -EBUSY.

Currently get_tree_single() prevents duplicate calls to
fuse_ctl_fill_super(), making this condition unreachable in practice.
However, BUG_ON() should not be used for conditions that can be handled
gracefully. Use WARN_ON() to log the unexpected state instead of
crashing.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/fuse/control.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 140bd5730d99..8bac837fd4e1 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -316,7 +316,11 @@ static int fuse_ctl_fill_super(struct super_block *sb, struct fs_context *fsc)
 		return err;
 
 	mutex_lock(&fuse_mutex);
-	BUG_ON(fuse_control_sb);
+	if (WARN_ON(fuse_control_sb)) {
+		mutex_unlock(&fuse_mutex);
+		return -EBUSY;
+	}
+
 	fuse_control_sb = sb;
 	list_for_each_entry(fc, &fuse_conn_list, entry) {
 		err = fuse_ctl_add_conn(fc);
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705



