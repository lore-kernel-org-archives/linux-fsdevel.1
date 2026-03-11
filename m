Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DB3C6A3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224225; cv=none; b=CJpTGTV9ZM5fSmx0ybUuIzmXFRl0V0UdH2gXkzFYFSk8cibdIA++Da+dvDOkGTy66ib91XmpGJLXHBqU4/6Rtu2y8R+3IIH/GCLtCvLqd0nzOe1n/z0vP51boHRvpzfKLtwhhk6W9iEayr6Om5erlxBPPPJwH6Bu+x1Paxqm7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224225; c=relaxed/simple;
	bh=Vc1MJOOIuW8Y3AXqQBlHq+totTJEdRahkRKm59Jzo24=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nXD7sg8LCFfj4paz+g1REht9otmEpDplbvxvWUYo6VUCWGvrqrKKFkDo+P1HCS0elrLQdYghnGWLOQ83CH6SL+N3nzmYzUwZVF71AcdYccPxQxnbsZZHSwPYTyGeC08dB4lMoWXnDVK3g27WppAxMcAY2Sci6XeTptyoPxSgM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c5ed0942so152880042eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 03:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224223; x=1773829023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnHGnobw61SFIXjoQkpFSTWAD2vDTpEuCDpynbfiFco=;
        b=gayMpBXb5/1MFvAyXygRH1qCHJkf7/UcARH1GMG5ZdqBiGM8rJFYsVBmTMYOV6nLTd
         ysF952aM6MlSCNRawDEPplFOyZaMhWuFKOGIKTmHAb6I00T8/T56birZNPiY90yc2g5k
         3qT4uABsNp6aBTxjvo+8fcVqTbYlaZefsrLpA6AhrbdhHKiZkBplw63QfAXxVBbPce0q
         wmtRarSi5RxIr4MSXv8ps5eJOp1ja1M3h0xwmz0MzuvpPfxmYDlwEWBQ9kEnXfdfgDtR
         JQNysM3Zj5pMlyqMjFOXRjP0Ja4Gh9b4hjkTJpzSwtQRzDK5thkDrdrp5dCQZOUNnwg/
         Z5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVkGM9Ndk4qfn+IuII6bARp0RAX1p2KtY2D9AupkeS0KQS984w1rLmbLMRIVT9uWfIJQYpncyzVYAperzk5@vger.kernel.org
X-Gm-Message-State: AOJu0YyDK9G6mpawBH3NkfUSTEkF11vRS9SiYmRIntL38vWiNEE9i7gG
	IBEllsQR6vWsGHFlff4y9Uvt+O5GRRhszCIJ5T08dSntT5H0CuRS7YCdm53CuQMkOcQrZFjalGN
	RgeD6RuV2ljWNoI93JJvvkXbl1sLqxZ7c8guMSxm30sIuY8ROkFTY1Yxa008=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c8d:b0:67b:c122:d2a1 with SMTP id
 006d021491bc7-67bc8995cbfmr1247313eaf.37.1773224223623; Wed, 11 Mar 2026
 03:17:03 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:17:03 -0700
In-Reply-To: <20260311095738.4177239-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b1411f.050a0220.209d0e.0000.GAE@google.com>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org, 
	jannh@google.com, liam.howlett@oracle.com, linkinjeon@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/slub.c
Hunk #1 FAILED at 2629.
Hunk #2 succeeded at 2828 (offset 168 lines).
Hunk #3 FAILED at 2670.
Hunk #4 succeeded at 4624 (offset -404 lines).
2 out of 4 hunks FAILED



Tested on:

commit:         b29fb882 Merge tag 'v7.0-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14156f5a580000

