Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB93CC315
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861105; cv=none; b=JtHr51YaR6ITeFI4JOQ65WNqgFwVSaVB/ZCAP51C6dUNTTP/Mkv5vd90ZIVBm61wV8w9K9zxDSXxFFx5CM7i+XeE57iIMEMvZ2g6Yegxf1Mkr3Ns5OtrASZh3HOWYYU4j32eHssMpjZjPlKhp4vn3k9nbFhhw2LZdvUqa0Xyi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861105; c=relaxed/simple;
	bh=Hjq7y5xwF/o3OITGh831QTeK4BuPW2gVe2ffDx8V0XY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P8SZEk0hJOTctP4lTvt2swQOAFeEAJF8v4dwmUvgQQEmEDRwUBlY4XrziSeDxSzsrjm0xek1A+LrSB/qRAXxyrs75IUCGxcznpv36WsRx0ueNS2/XowAjsU2Cha5WdMeGKUjlIpeik+NJVqAihDIzZI9/zZyc4BjnC5yu5Dfb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cc89e86e9eso9525877b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 06:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790861102; x=1791465902;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zGC8eoo7sqBg/OF81st5hi1IyHpdEbJJnULEgfNzl9o=;
        b=pMyFexnqzbbzch3Gnm4MCa0eawt/vZHLArK2rIIAwn0+TJWB8JwARehK3fc7jPTNpI
         mqmno1MTwNaPkESx7zH0uduy+uvb5/NuLntbUmOXPoYETGL9o9IgTXRHn1QrjggRH3k3
         4lBYxQRG3V9k5utrenOxye0WFqp4AvmZi1fKlwY54OOXDkYJ2VTw++pyDj9Xo+jdX7w7
         mN9mtOa7IttfJMrU4Au9jQqnJe7Zu1W8Wb7f/mXgnZvFmmtq/oHuqIvDDV6waZ6guTsR
         azw929liz6lgIc4LEGP5EQ/xeQjpCqoDIZbVDyTHXOwF+hZIL2Y1eOZlJnxHqn2MCiA4
         N4bw==
X-Forwarded-Encrypted: i=1; AKwUvByYzxtFo0MYJXACJCCA/hyyjF1v8/PGPO4TSPH7gnWbwg1aexNeRrOQ0UdqIbSr1yxJ30hBhZ779q19k3Jt@vger.kernel.org
X-Gm-Message-State: AFuF++nZS61zMiss1zFatvcsFlSnS8YgZNQNWKwug/z704HhxM97rYOo
	BvrnPNdj9HOIWG7O7/jeKBI0ywary0BjDELz2mZj7i+wePQnnsrWx7+PkeBt80ylCq9CDWpD6UP
	CNzZuUfEPzwZX0/x2TnbBXISQiSWacbYzYGHwDJSIUZ3BIa2EjgfpeIcxr7o=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fd2:b0:4e8:bce4:993d with SMTP id
 5614622812f47-4f1b724c7ffmr5141948b6e.11.1790861102334; Thu, 01 Oct 2026
 06:25:02 -0700 (PDT)
Date: Thu, 01 Oct 2026 06:25:02 -0700
In-Reply-To: <CAJnrk1Ze8s8EGJqy62_mLbgvzW5fVVWMdeq3zSH0mWu_HRfpcQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abe5f2e.f32479dd.202a09.0003.GAE@google.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_iomap_writeback_range
From: syzbot <syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com
Tested-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com

Tested on:

commit:         fd179f8a Merge tag 'ata-7.3-rc5' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1036c035580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d4242cb1c54cdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=e8200299b0556976e13c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1483a6c9580000

Note: testing is done by a robot and is best-effort only.
