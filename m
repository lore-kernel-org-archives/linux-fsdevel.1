Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36017993;
	Fri, 31 Jul 2026 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464356; cv=none; b=LmhKy9arYNrgzp01+BtGrE3WlWMk/N6wYasiOj7P9uCUYPDBnvyD6eWRX6RXnkVZiZZIvWPWc2r9xS/phmrKwX1AMDxq+caHMC5zbBd4sm8vdbFLSiLaSwnHXqV63hMamHBZ0s1kdeiAzFxZA+CTvf4XQ0uOp3wdAdS2rP8Uv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464356; c=relaxed/simple;
	bh=DqfPTlX+yfyrxb3xCV1OtRig1ZTRU/FcuhXD6+EMRPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZdZPfbROxFpHIfBg0PnIS4izIESgFchH/Jq9aFyv6FiktMfy8IPYXa6pf2OQqcLgFH337cmdIPzP7UxLudM4jZOi7lirGDljthx0n/P9ziVyAKiQvifM3dBfAAlSkmGuIVrOunQKKqhPlAYwCRuTqDsuTutYFmG3/oDUAmmc8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OVhhp76y; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OVhhp76y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785464316;
	bh=875ef/wd7/P7ekjh+/T47efe243kE/e3Euzeb7IHCKg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OVhhp76yAyA9ooDAyE7l4gkPsy2a7gUCZ26y8goAXdw4SDHzYO+lUXu8bBZlsVuox
	 VwcnV/m0YQuUAgYOIJdhEO70ZdlQ7v8AgCNHpKWi/MwGG7ZhQRuYQaljvk5sqsvvIz
	 CXFo632lxsSYwSzWxk9HghLUG/vIcn0yBKtZV7L0=
X-QQ-mid: zesmtpgz8t1785464310tc1aee3a1
X-QQ-Originating-IP: 7kdGlDfnNAjaBCEUTZwWh2+/wiZuANwyOZmt7Mu89TA=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 10:18:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14075719228207134714
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] fanotify: report full event length for FIONREAD
Date: Fri, 31 Jul 2026 10:18:27 +0800
Message-Id: <20260731021827.602479-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mutteg8H72qDco6sBqedFrQqeEFY7S2HTUuTUtXe6Dsph12PZU9GiePL
	Q2tJzy8/da5sq2Q/cvFxlwLjL9BN1lMngVxxw2Gxe3DQwZ5dQuUO8dGP+hEYnGU/rO7UYI2
	vxKskmz0d73bQVuXAqjtBrcNOq0NAOTqMa1PicKjlhkM3JUQZE6PNWT7DMzJze5RGgdzvfY
	RBhwpS2Sz+w3pkUu/xOwQF81EZWuOAWHZDdan/BTi1R/Ykz54y4JbmqNH9PA4GGgk0SxQOG
	LuPM3tinouYfS0WE4RhYWyc1EHZOR1AcEy7rcJ4Iq5eeGCRLKrqRbzBYDPncqF+Ot1fxHZN
	pvkVyhhUD8Re+r2A1vYh1e7JNLOQ84D+3PpS4S+16SF78t4RR1GLldTvvUbjWQQ6yqYrxF4
	ssR3WUee8zGinfk4BGSChNsDk89JSRT6GzwATmBxim4hp9k1vrI06qlOjjPztjZpvSua4cT
	oifq+aWqYWgMPVnmGkJ3hkmJL9K96Y2R+lYcyZWyisrNxeSBRDRkQ1+hCo+xRV1nN281qFv
	Lposa8ij/8jwFaVkB23lP5KDy64hjhxv3GAjt8MgGr2N8foOntgqJYo7xYjOemX5BGztCDO
	wTM6J2NdApXhTUuf9ewjaWfdmDyoafjy/kAaNGjBAQcfc1NkafokTfHGLS86fjY+X75h4CB
	wHUIoF4DUTCyvZbn/zRmVsCXi1anSJ/7ccu4ciwUHcABhFLed9n6l2Y3O6ny8rUfKj4Ow33
	guXWY1Qc1VmRnBVvv9AVU5YtacOP9anstl2PbZXhBECcfNLkz0JxV5jAG1mR5gVEb0ICcCY
	/pJQvroCwsywtvfdhFj+FsMYejAEhgcDmOdpDUvKyhQfCxOaPtFaHXa+yQKYcRL5uHSDli9
	6QJBT7La+Q0FaIVi2yw+8URih68QT3QN2/ehbXM093N34c9rZhTXl2UPdzbee0AOxdRnSwu
	KVjGOWMwWUHDgSAlvaKfwpjrqtNvz+vYIfDSodPQOnCBgoWN+Oae1GQJf0zlTB6uq5coZCo
	nT+OPXqML3QFGxx7E3
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

fanotify_ioctl(FIONREAD) reports the number of bytes available to read
from the event queue.  It currently accounts only FAN_EVENT_METADATA_LEN
for each queued event.

That underestimates events that carry additional information records, such
as FAN_REPORT_DFID_NAME events.  A userspace program that uses FIONREAD to
size its read buffer can receive a length that is smaller than the next
event.  Reading with that buffer then fails with -EINVAL, while a larger
buffer succeeds and reports a larger metadata.event_len.

Use fanotify_event_len() when summing queued events so FIONREAD includes
all info records.

Fixes: 5e469c830fdb ("fanotify: copy event fid info to user")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/notify/fanotify/fanotify_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ee373ff5840..33693886b7d8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1150,11 +1150,13 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 {
 	struct fsnotify_group *group;
 	struct fsnotify_event *fsn_event;
+	unsigned int info_mode;
 	void __user *p;
 	int ret = -ENOTTY;
 	size_t send_len = 0;
 
 	group = file->private_data;
+	info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 
 	p = (void __user *) arg;
 
@@ -1162,7 +1164,8 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	case FIONREAD:
 		spin_lock(&group->notification_lock);
 		list_for_each_entry(fsn_event, &group->notification_list, list)
-			send_len += FAN_EVENT_METADATA_LEN;
+			send_len += fanotify_event_len(info_mode,
+						       FANOTIFY_E(fsn_event));
 		spin_unlock(&group->notification_lock);
 		ret = put_user(send_len, (int __user *) p);
 		break;
-- 
2.51.0

