Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF363C870E
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785690425; cv=none; b=SrUUCKwJSK50ubzjsKCNlBrcD4DHPI3e+RdJUBsoo6O/GdyuHPSuFcbLcEPFAi/fD+hfKrRtyd6TH8DHDTFIZrN6SRTkQh/zTQlu3JboxTxiczDl9OcRA6w4xrF3LXgYoCwveQa7GATOQhmLT8GUv1udghVXfdrujrnLHF594/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785690425; c=relaxed/simple;
	bh=oBp0Qfmvqr3lvLzHIJb49Quj0Z+YoHJbvTkejL88Jqg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=toGRVK3jaLrtXo6Tp0W0pVMlRb+iq7BS782z9yehuUpAPod4nR35nfDSFSVoBdvuH3jVJId3XaijvAZv/mIZw206pGfjm6+wbWxcEWyhXeafxPpQ7fbX+NhmUtQMtLoprP4KBuStyp49/K3LDpwLNXFzz9AybdDISEFXHJBBhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ee50225cc7so3716796a34.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 10:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785690422; x=1786295222;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zxFXnSoB4KgiBC0T5VAyA9bBTcGnRnLoGoYzvYWvSBw=;
        b=FKE8hnkj4PRAbnz1cvheZWF5EptzUmfPbwtTxLNtVs2NyuyvLJgkpLcnIpBRNT4cTA
         C8lAtmid1I+HpUy+P9Fe51YKASlSXwsjEs4YCrGWLGl35zXFJ1//76oLYRJc5GJkX6ke
         aBWmfNKgFBxaJ93xhWzNrZxekjL6R7lA/CDB4fBkYbo86K16+yGsfeKZGXKSmfbXd8ST
         b91Ndl1QUgTvYO64dZhfWpJwwJ+eVrTZOzpNRBGSsvTWfzKN0bc7NW29tVT67z2ovBnz
         Vvb/oYcHyCNqsZldJJn7LYs8IWIQH+I4+sDveUMVAuyiXfQABdVBe5GTqrxy+PgDSbqx
         dAQg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9dQZRNVxa5H0zorw42Pb3Pc4GM3Dlhc7js1m3P+mxrFDncHBqm1frqlwqvBPRia5EPNQkurEo1TMMHSva@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxAS/GwmyJJMsrsM9orvWZ9dvrd6S9U1NXn8wDvBGAJQeM2K3
	fIs+6DMiFZuP3rS1RILu6SFwoG7S9TX0ZdFwl8sXyE+0QxskCtkmHFdmUJlAgHDPYCfaDW71OpL
	gdrR/8Z7atf48e5450fhQKJeGNlCRDXEh7HONIg45CMT8VkzvhWHJh2KyGvc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2228:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-4af5e07d704mr12408667b6e.8.1785690422033; Sun, 02 Aug 2026
 10:07:02 -0700 (PDT)
Date: Sun, 02 Aug 2026 10:07:02 -0700
In-Reply-To: <68dc3ade.a70a0220.10c4b.015b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6f7936.13bfb6d0.1ecdd5.0272.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING in path_noexec (2)
From: syzbot <syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com>
To: brauner@kernel.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, hch@infradead.org, jack@suse.cz, 
	jhubbard@nvidia.com, kees@kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-mm@kvack.org, 
	sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6de2aeffabaafaeda819e60ec8d04f199711e11a
Author: John Hubbard <jhubbard@nvidia.com>
Date:   Thu Jun 4 02:53:14 2026 +0000

    libfs: set SB_I_NOEXEC and SB_I_NODEV by default in init_pseudo()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c53db9580000
start commit:   ba3e43a9e601 Merge tag 'soc-fixes-7.1-2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04
dashboard link: https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a08f2e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1697af2e580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: libfs: set SB_I_NOEXEC and SB_I_NODEV by default in init_pseudo()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
