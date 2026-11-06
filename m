Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968430;
	b=ZwoLxkRsMqGHTL3nS9jX7qqbjtzlRc3JXWEGpuDC98NaShxEJHN4zBA9ld13h2PD9STo
	 /Y+1ZBeTzk+E2xrAyafKXkbhsUpeOrxrYTaSlL4BWL2+V3n/icdwAq0yk58ieYFLdbnkI
	 FPmkSMyCXGcQxa8lHMZuNCuqH67khimeiJd+AOqDciwJ+l/70Y7c6WCDPjhWZv7Gz3tuI
	 6UwYQVzj4njClzb86BhBrVzBvvzCbjwX9JGbAxX8HsUaecXLcVDSstF1ede5vQ8oMfxkt
	 CUfKgZsOGDD+r8FV202ySgCP9+DBB+zS8R7iMGoqlD2NFMrftRx+X5NwwCLljjSpf4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968430;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=31zJHAipSlhPMGedMX5ynsYIkiuZ+8oMTFm3jTUaEqE=;
	b=y43/Yhfz5ZO65kFV7OgsyNhCSZU3FmYQa0GOtPqOMHjg7oF79293vZyLRJLLxl9HKu/G
	 JlM/NZbrFnctYmvIi82ztZ6SnpDiltnGJWFkBwTrz7Vo9yIRHUpkHSU7iWuca0nFnkbFo
	 umj6m/Rvh2R83416+nKdWu2j2SYFIrfoNrH9FTXs4AMQqo21v0hyf2co6r6+gauKiLLoz
	 7AZ57okZTaQOesN/oeOzeOenvJqmI2TNtIq+ewN7KN+hC1qoXv3o+jBkUPTzFzRlgQXlG
	 QwGBkKcWWY8gflEeUmY3+dVm0VEBryfVeD4Rhn/JzLTR6IKns0mh9/9hKgTkoHjI4WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600B606D801
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 12:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C600B606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c55ba309c2so673045b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 04:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968429; x=1794573229;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31zJHAipSlhPMGedMX5ynsYIkiuZ+8oMTFm3jTUaEqE=;
        b=zV32RljqMuPKHA/OMTiJPgruGEIb/jqoUp6tbXoMRCSz+uYxQInxeEGQ/wI4d3DTsV
         3IouQ6VD8w2rZoN4KwAux82V6vTldpYZd5IA7izYqoqv3yNeEHHYDR+75jAqapkcoP4V
         HnneFDqLoDraHvPmDaAAtm1M4Nu+So8cKBMGt7pP3OjqwpY4DOGp5ix/iQWl978bA0TU
         j12Plx+EywnfmsLW64QGG2fTzcISKl/F+yfFM0n7omKJhMV4UUmEDKXiLUVwJIVpaHF4
         EL8bpvnh6bIoD+LDS30Jremt1ygKxhODBOYvXrVMUuDbqxItg1fEp3XLrQYJHfVUUi09
         7cPw==
X-Forwarded-Encrypted: i=1; AKwUvBw3IE2F+NNb2qzqw87DnOoBOHPKgAuea5fydN9WDciG2v5s83qF1SIjwK52lpXypboL7D0Pkj1QhgDojdVS@vger.kernel.org
X-Gm-Message-State: APuU4Z+P9oROPZHo+Gitc2MPOylrzjA63KFPx08S1bP+tNQmJCkc7f68
	WByXl+IVxESV7bLZvG9ZNFTpkq20RL8mJPWcSThJpzLb6k8G3tImg/2XrdhqEMRl9cL0g/+eGWY
	rX6lmqZKAcHG8UTq2ftfxW6haOtm//8fjEDsr6LzjYyawPSllIQEZLjhlX4s=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3ea:b0:55c:836:597e with SMTP id
 5614622812f47-567e14d6d1cmr1493728b6e.31.1793968428769; Fri, 06 Nov 2026
 04:33:48 -0800 (PST)
Date: Fri, 06 Nov 2026 04:33:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aedc92c.a716b02e.a4a62.0002.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Nov 2026)
From: syzbot <syzbot+list1e64672c7831f2f46cc6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 42 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11662   Yes   WARNING in hfs_bnode_create
                  https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<2> 8181    Yes   possible deadlock in hfs_find_init (2)
                  https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<3> 1125    Yes   possible deadlock in hfsplus_find_init
                  https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<4> 6122    Yes   possible deadlock in hfs_extend_file (3)
                  https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<5> 1895    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                  https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<6> 1121    Yes   possible deadlock in hfsplus_file_extend (2)
                  https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
