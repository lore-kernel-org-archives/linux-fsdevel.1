Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982473;
	b=s5cUDlYK3H0sfmsp9Zf8vxm5wBP+zF00lIS28uxSI2337MaZiPtamMPnqofAfgKfGX1R
	 Qx4TjlXuW3CdP+M9vNY1SAfw/gHDgNQr71zss0B/gaVAUDtvfLVcVmLAQc6KB8sSF/scr
	 pbUAl6enjnRoFOTpwKppYSLmUIJA0x6nDD5BgjE20GdllVgZhnQPjrcIzHomh0JSK17Wc
	 wWHsxDBeiEv7tr+U0eTBzGNsVXu4i0fBs2pmSCWm33D9hfd/rLAcbwDeoDZHLJ/wZ1Xts
	 lJM0Yjkpvq9BiGccEF3+8tvd55KfkPLQcjz6M81Rpu/TuiytVU+0y917OFLNwuLZPng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982473;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=8md3aC1uv79iBkW0iZ31AbdvtK6VKNmFBBO3obnuVyw=;
	b=LYvTzB6fFNXinImAVDPG7vyu54+ohy1a2RnFGZ+LlcYy6Cfi1PjefSGrJvbHFELpHM5p
	 vvFBmol3j+jFwzNZuqsELQHRmJULXFtJ0g7epJQuCCJynL5w/ZvmKDo/I13EAjq7netqN
	 qWyEqNaS6fCGoyhNXOD/xpXc6gMiKHPn14708XejRdfRslLJF+gwzE8xT8si+dwShdg6a
	 6ep5q8MYRkYJ4iG/t30BZb/f/nWQuErdcJtS+2UH+9+QdImtVCSvMtB7bzETToIOcI4zp
	 K9oyQqLS6+y/IsJcX5P9Y42lJk/Y5vABfAlJLgLJWaqagjjFXlExl1sJ8AHYLP0g1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JTSuRcbb;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0714606A31D;
	Mon, 26 Oct 2026 02:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0714606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JTSuRcbb
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8md3aC1uv79iBkW0iZ31AbdvtK6VKNmFBBO3obnuVyw=;
	b=JTSuRcbbjtl1P87qGeQqwzfuIBaibQP3rmYWsWmdXuosNrD+8IpuVY7IxAcUP+PcG4jmofV9d
	38fLxi+vrSxaCEFNtqRmaH78UoxqgIRYQo3GQQRD4HD3AQLv6RvsW7aT/Wr8d4OEnptOEs+MfmQ
	YlYPeCPoQ5eOIhkjr/lL5Go=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jCdCq5m07z1T4j9;
	Mon, 26 Oct 2026 10:40:55 +0800 (CST)
Received: from dggpemr200001.china.huawei.com (unknown [7.185.36.96])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EC0540537;
	Mon, 26 Oct 2026 10:41:02 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr200001.china.huawei.com
 (7.185.36.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 26 Oct
 2026 10:41:01 +0800
From: Ran Hongyun <ranhongyun1@huawei.com>
To: <drifabdelmalekmohamedsaid@gmail.com>
CC: <a.hindborg@kernel.org>, <brauner@kernel.org>, <jack@suse.cz>,
	<leitao@debian.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ranhongyun1@huawei.com>,
	<syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: Re: [PATCH v2] configfs: fix slab-UAF Write in config_item_put
Date: Mon, 26 Oct 2026 10:33:26 +0800
Message-ID: <20261026023326.4041232-1-ranhongyun1@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com>
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr200001.china.huawei.com (7.185.36.96)

Hi Drif,

Thanks for your detailed reply and the new patch. I agree that the
IS_DEADDIR() check is needed when simple_rmdir() fails, and that my
error paths mishandle parent_item and leak target references.

With IS_DEADDIR() added, the patch looks functionally correct. There
is one small point: in the CONFIGFS_USET_DIR path of configfs_rmdir,
S_DEAD is set regardless of whether simple_rmdir() succeeds or fails,
so the subsequent parent_item check appears redundant there. It is
still necessary for the non-CONFIGFS_USET_DIR paths, though.

I have not found a clean way to avoid this redundancy, but it does not
cause any functional issue. It may be the best way to fix the UAF issue
so far.

Thanks,
Ran Hongyun
