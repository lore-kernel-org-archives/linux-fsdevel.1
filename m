Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF33F4101
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632796; cv=none; b=DE8bBBQWptlTMz2yZfg02sy+cE6atkpray+DyxQ6bMwiL2lckpKBy+dG6MRhuN02N6OoRM3+RQ9QKTuudGFd3AXGhLOG6DFPDplUVLbdyCGFxh6OB7FWvaNf8WyUmOOeCzHOM6ccIPrJW3TN4BOOW6hhzznmtSvr8ZVLj8uzHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632796; c=relaxed/simple;
	bh=Hs68hwnq6v6JB6u5yjPs1ot3/dTWyi3j667K22UbsPk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U0yFICocQMQEIYGJw8Zwp+oBfbpQnsqWLc25rOzT3AxBV0BJ5PAM/r/+X7aRDUEvj0v2oTNKrP9l+q56s8+WH1jq33cuJddx2kKTu7fXzSlVM5oeclZuLuCY6gDyZDBudiuuUXs6riQHXF3jVUNgIBFgF9u2hxduKiYdmE0ETXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cbc77da654so597040b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 01:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789632785; x=1790237585;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jLd9W0G+g0fEhC1pzO8g1eY0KUSU+n4SflMsM+Hy+ss=;
        b=XcR9KKNDYqxvTKbiy91BMt3b5Hr33PDq6VIPGmkOjupYE7rLvZhZtwx9FO9zNHfpbX
         7tpS8mg+ms/nvicn8CpEW0u06plgckIaGr1UY3Qyq3OebZ7zwftadQMkSF6A9pvh4r0+
         Qpa+KTMvzMZMikd81nQwF8jKzLa5QuEDkXACjm2zR6GXAZnJ3YjxrvTewcg+IizbRpdX
         FRrgUVI5l+ZNAUpBfRVBrKp2W5tESg3mLs0X5xwq3uboA0AtM1kGQvM6sSSVpuDSsRm0
         +3Dqdr+r1baNKpwnpUQZNvBXBZToUs6kvkmOBv4ae8kfe555ER/Tg6J/5HqpXGPiDdXM
         bOpg==
X-Forwarded-Encrypted: i=1; AKwUvBwLTMVK4FE2QysQXCnqgsqPIhEnvHkUXbHR/vVy5C7kXEIFlK2HGJxHfbJ/YoW4+93dnl5oLEinWe2HSBiE@vger.kernel.org
X-Gm-Message-State: AFuF++mz2xvYIbQMbZDrXPsdw3djtf/lOVqxPTxHt/DeNHFF2+Y1nJ6k
	/+YcamUO7OSrSFT3FHr6PgvTU1BVY80HwPYFW7kj5v76rmwhAUovivdq47Z+sn1egOHIQSiNQVS
	V0WCrpUiEbQeqatbUFNmAVgYHrLAGUQA45RW6GvsoN8PjpzXQfKTuhgMwFwE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:470c:b0:4b9:a829:f016 with SMTP id
 5614622812f47-4ca4c6aaf9fmr5278837b6e.34.1789632785213; Thu, 17 Sep 2026
 01:13:05 -0700 (PDT)
Date: Thu, 17 Sep 2026 01:13:05 -0700
In-Reply-To: <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaba111.b398a7c9.1f86be.0013.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
From: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	iam@thechris.in, joern@lazybastard.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	miquel.raynal@bootlin.com, rafael@kernel.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com
Tested-by: syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com

Tested on:

commit:         238650ef Merge tag 'powerpc-7.3-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165358c9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117a3bf9580000

Note: testing is done by a robot and is best-effort only.
