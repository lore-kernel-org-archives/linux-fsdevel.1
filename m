Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E72AF1D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351365; cv=none; b=Shy0c70/kE9y/pEYgvjyo0MmbKeclKlSIG9dBevs/3Ut7e8hraGYcs/+KfU7IzN7u7aQa+UmLYJvYov5ysX7mXr25bchackfkRZLDSUSOEqmebQl8dT0+XWQZakOrucEVafnaHw0jaNvRD9hqqx/GHBKZsHtc52epI14YZB6bW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351365; c=relaxed/simple;
	bh=hr3W/AM8zY1xVbmyKhwprP1xRsFjnuTTNhS9swqb9NM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q9Y0Ud/86K7oQ8M/1QxKC20h+39b5bDjkumYVB2o5LI+grkGYMdWreNruSgRiSZFIgHIyPVpT/DEPNvPwMpC+EmquAFYYLiosvc9at5hdt7/7GGCOaydsE1NSwK+5A6YRvAowgEcifi6M+ElIHj5Bq1vVj8kaq8vEB3MmuBlfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-662f839d680so370164eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 20:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351364; x=1770956164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/+oy2R46Fnx4+wB9Hhk2uiq/Unz2ea+if9sMHfpzpQ=;
        b=G6DxtFT9T0hBWR7KYmGvHzbsGfwDftNF9kwXpEJqwXaFWoj7m9UBk6rkMh1MIdl9XN
         qO/NrMt6EUcGo9/dSH9eg0iqRzSZjCWTefqlXxvBMov+hFTMuCw/sk0UkLe1RazlkABR
         hIcuPq+8ZxaJAP8VW0PoHvqkiK1In8oPQtBNHhHCFAIMm2tIVZ5zfmtSRCtaM/bY34ku
         T/sdcHt32B0/dNSSI82OZHi48hpjIqMqVyp0iGDJnu4ZdWsVU0mg9jUty1ZFJSnSoqKe
         rq5FDI5rHiGTyBk0Sryxbcy04W2ydRPzobOUxlyniGxym3UKFuUz6c3Edw7xr2Y+EiX1
         nF9w==
X-Gm-Message-State: AOJu0Yzux5Ylfzju64IUJF3ZqNXytAtW5u+IDsLoe9nugA1x4DEJ/RGy
	5sJHOGVpJWPLxPKR0WzQbaWfvFwD7GA63YNTjbDLFcqhg6WEMe2MskLGM093eTiCo+Z/aO3pOX/
	FXBS+UR6R2Cf/weDM9B1HrlNv+Yus8zjWWuIAS5pMwGuy1897EMWuklu7Fwc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160a:b0:662:b608:d5ae with SMTP id
 006d021491bc7-66d0c667fc0mr694903eaf.57.1770351363956; Thu, 05 Feb 2026
 20:16:03 -0800 (PST)
Date: Thu, 05 Feb 2026 20:16:03 -0800
In-Reply-To: <20260206034631.1189468-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69856b03.a00a0220.34fa92.0023.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KMSAN: uninit-value in fuse_fileattr_get
From: syzbot <syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Tested-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com

Tested on:

commit:         06bc4e26 Merge tag 'block-6.19-20260205' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1498e402580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9682a42d8ec8b05c
dashboard link: https://syzkaller.appspot.com/bug?extid=7c31755f2cea07838b0c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f0e402580000

Note: testing is done by a robot and is best-effort only.
