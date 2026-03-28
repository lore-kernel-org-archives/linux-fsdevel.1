Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BA1AF0BB
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734065; cv=none; b=O7sCdoGT5l/i5Kj81ig2XVz0gRvQqdPRztZAMb/JBHQiymFps6v815iczOZ4GcVR/29TI30QUMct3zvFCUmQW0kNDS5DzJqSTRMGnb6av1Ka1AnJG4mZ2nvq7/pf9tdetLrAu212njZx7CnKCBynRyUZR5BfXc4WT427OiecbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734065; c=relaxed/simple;
	bh=bL12h10HEpfGfdWgtsZvGQUfwVYvfG4d4PsXyhpn8Dw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZEKl7N0muwqNcBcTcyo07jZYvz5zON7E6Zx6kiOmTMJ42roMYpMuFdlS+eojBrP/XS8CTeKu1YzLGRZLWe77nlbzRY+j6km4opq29tlaTbfW18LNO/GwVSvanFhHjq9g1cBe7Tw8HnVZMwtKU9LAM6/iku4IUPmYQtlZ/e8uf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67e0f16975dso10276243eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 14:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774734063; x=1775338863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wL8+eiT8AbffLq91m61tYTd+b+pEPJaA32/D7HSsGjY=;
        b=oBbX7eFYXuZYanZOEnUKTyUBJy8bZrmEtdqZbYGIeboq/f/8NsaG+xdFKrOCUrWpdp
         wf2gV9i2miSAFVGstpGbdhmGoV79E65vCghM853jIwrvCz5S+bJEwPTJsqMXbit5ykDh
         RV1YukSmqQZfXF4Sbtod1PNXgERgBLq/tLrXGo0efMVIdQX6xYc1rJFftzcK60Go8Eh2
         Eam+rDNMM+4wqZcBrDgSDDxt4nMFONFiWXZResZDDnOyTwEzvGBv4MpCam8Knhn3wKvU
         Q1WT10MnraaiHC0Pt6o5aUaqt/M1vXGACr4SbU+Bf/LoKk+phzjSJaYc4uZCvYNGqPyB
         26mg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ98xW9oPZ+hJLtY+9Ew/frdNQqIoNltqi379qSjgE/k82igvVKSuNsH7LIxnzw5/ZfC0a1Jw48kG4UNZr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YuJkB07dmgz2HkZOOOP32g9N9yQXNefj8aaAD0sYiYNChr3Y
	ys2zuezPR2dXmuieBvRuyJp7aZLbnPH9/e1cZN+NaHWuCgYilCmpxDCPWLXYc5K9z8sbEh8yA82
	crDHTkuheMmx5LUTz05k8qCYAx9pjo68f+hCxb2gNFs2PzHNydJ9QBURtFgA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6008:b0:67e:1e75:7f5e with SMTP id
 006d021491bc7-67e1e758528mr2056912eaf.33.1774734062997; Sat, 28 Mar 2026
 14:41:02 -0700 (PDT)
Date: Sat, 28 Mar 2026 14:41:02 -0700
In-Reply-To: <20260328210912.1571-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c84aee.050a0220.183828.0008.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in __umount_mnt
From: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
To: brauner@kernel.org, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
Tested-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com

Tested on:

commit:         14594a14 mount: always duplicate mount
git tree:       https://github.com/brauner/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10af36da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f75584c428d66f3
dashboard link: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
