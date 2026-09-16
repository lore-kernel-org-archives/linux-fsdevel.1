Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA23CF95E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588110; cv=pass; b=t6J1EzAy7HQcUZH9KjpEUZtw4eCUGsplHwmTpu8qijgBLbE6Grz4TAigO21Sy8g6KN5oYIq+WF+SEC2fCnf+HeRlIsgUjtukl36hjTw2EwHiXI/tgglRYTkDqdAeoL7Or6Ca50kHsrSVDeulstTJfHGIoqW8solzEyDPozxD95w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588110; c=relaxed/simple;
	bh=E4adBSqv7HljmC3Q1/9aM/vf3Vd3WWU+Kc0SjB4vLi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVY5IV3WmJUin+GaHMcIC6jddWizq68bWOgdJ4DL9kpdGwEiZMX4JRumfgPkGsbZFJW6pAocZ16B2GPQvL44V/JkHBELafP2IaEq3hlHU/VdLHYd9jxwo+gTECgpy8aznGn44fEELOpSRtHEH0F0DdPUyjjKathLRb/syg0Xwao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in; spf=pass smtp.mailfrom=thechris.in; dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b=vSsYgtji; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thechris.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b="vSsYgtji"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d4e39e3d8so4829137b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 12:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789588093; cv=none;
        d=google.com; s=arc-20260327;
        b=WTvWs61leQWbzcq14ZZ/PJa3hvr2yBBbAlrA3gAm/O7HuUyC0BKgp/wuQCT8BlyfW9
         ZxO/MCnxky/YdIHrukR5HssUK8fTjbCcgIbNmCKV9P9vCUpiYQiWtBtV7I7u7wk84R/8
         LBtSRWTKWPJv3COZRbQo047YJdzwlhVUYXnZpPSh7Yqix/xyzCH53fn5BbHu9GhQJo24
         3NSbIFO6szEfOTYpCSehF5PLwXxDfq7bh5nPu/sdXxi2KrR2tShSui4ykzlyK6aXsDVH
         d0IXDPfAZ2Hlf0S5dpvd+Hln7Neni+2IjoVcJXkmHkZ4ArcboZwmGZv0jxFudoYMMkOW
         LQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tXRkNKeKLTM+T8LJe8DD381nxHo0BtKuwD8BY0W8RKc=;
        fh=iF7P/U/w7BS/rhQBUQW+NPMvUSzdwT6PaoMlpqugIwg=;
        b=fsOgyaHqz9K44fNhby8dBsCZ6eDUuBjTbmE2BLh2s49/tvBD6x5fCekADZRupYTLb9
         muq41PgwgahFqTp9EPdSCQvpXi0L/V6Hyin+2egTbYyR9RHMmMyFhhjM+5qnuEgqT46L
         W+rhUuiUQQiQghD6WTGnCbk4YZ3/tr3vVME4Zo1eCUkPnfZ1iNaPMdQb19fN5wiBw3Ly
         MVjzdCmvLnwgkhag2jiBDgcle/HEywMLlb0mWbPKd1p+XY1cHdggeLo8aQk8CqUje4aa
         uBYTNnzLYQ61cCr6WgD8HNs/y4E1omMi1i6rWYBNrbMy4gjnn7MN3hF7crHbTALJnUh6
         Z1aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thechris.in; s=google; t=1789588093; x=1790192893; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXRkNKeKLTM+T8LJe8DD381nxHo0BtKuwD8BY0W8RKc=;
        b=vSsYgtjiUxJS3IqfZrBZ431EgAWxLzltLD9+XqXPb7aGr9F7Sk/hCqKpMnPbUfped8
         Vbh7CjzXhYV5E8jIDiDzvgKAbmszka8c4bEFnyA3nBSxkph4p7RWoFVtnz+9pGAP+sup
         MSl/t1sEDED1HIR5B6AuvsjoYzCprJxTpUVH0qqQgcDGvciU7fh67iBv8Scd+ENCat9J
         0gbjzVdLgZzF3XP2CtQaqWYNBJnTEYXOUZZyODqbcgn00TdSX7lL0zqVRZbQ7JlhrzY7
         25FE4Y8nrkIlKJUpiHNZ6Nl1Mz7FtseFq18SKFBsnOMsky+e6Lk3ulibuR+o9bf6ORi9
         zERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588093; x=1790192893;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tXRkNKeKLTM+T8LJe8DD381nxHo0BtKuwD8BY0W8RKc=;
        b=VTjG/o9pOVekfbArumHuBLd2oyRmedq7flDSdSYPA8ji+WF0ZsTGFztfVyylGQVx0o
         Vkyj4aadykuP2eZdZxEX5vpHEjnroDoVb2plg8FFBbuSpl3gM3BHWmsjauOC5anDp7JR
         utXBQoY/cUPXaMCpPTUZfi1rovzZqzGR7wMaIqrsX4JZ1AVRzsRsf2e7FQjoi1hKCMYi
         ka2/9i1J/FwT3BNFA/29qjC5pLJt3Y8BKffAdLyIS6qm897iazjztWYxovUJUJJK3Brj
         xHEnvFCdz7nT5CxQhfd12CQ4D1hftAXUIOpr00Ui3qcfEIca8PuYeZhKJ2J6+cNq0Ca6
         iLvg==
X-Forwarded-Encrypted: i=1; AKwUvBx8jJZZ39VSmTQAbl+3F1LTJ4rpH+gnNLHmtO1OBDcQoaQvQTn4fQmn4Tc/s50kKcqxNTfQiKISqI5OaROY@vger.kernel.org
X-Gm-Message-State: AFuF++kphtvpbk3aKd4LNcenHH5dsCxMR6kzLAfPfOfDe+7CJjtZliio
	tnmDTaR5ai7EYSxk8r4Ylp/z3M5kqNJ6eNoyyiMhejMnvVz764mVPZ6n4bVpmLwNIJLvgkyIqsj
	RVR55/OOTVJUPSyAcwSm/BLA91VwOpHx3mFrqiUZryhO3WhETIWnRwczG
X-Gm-Gg: AYBFou0cPympa35x7x8pxKMClCnLELhNCXcykTs+q7+XW0jmM422lDDqWnmOfPTR50t
	KK90qnTCo2k3J8WR265TGydrThsvx5Z8yGYZBocTR2rdKCTF8ZKcCWFQXRx1NfhLa4H9Tnvy7On
	AQGX/gYZojaPRDZdiZT5llMUjrbmbEY4GuzuoWiyopvgrzD0xVC+66DhImik9uddz8Yk8yMOhbV
	+h22NEyK9i+Ym1hdQRATYZF+zlVHb2jn2w3MSqvfFAuy/M7Atxim250tck5F+5HWOkS3UNDig1+
	jewIIujjseM8o98QCWG+2gG0s2vcNrO3c6fio2d+gE323XKsquGBL8hXJH6tdQfxKdzY5utxCx9
	OkcHuMRjMw+dAUb8MvZDwFzzxepblNWLb/vJdb9A+1dg3
X-Received: by 2002:a05:690c:60c1:b0:892:63a4:15d0 with SMTP id
 00721157ae682-89445e46c1dmr2084807b3.18.1789588092839; Wed, 16 Sep 2026
 12:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6aa178fc.f2639fcc.29487d.0008.GAE@google.com>
In-Reply-To: <6aa178fc.f2639fcc.29487d.0008.GAE@google.com>
From: Chris Roy <iam@thechris.in>
Date: Thu, 17 Sep 2026 01:18:00 +0530
X-Gm-Features: AcwNN1VYczLI3qfzeZAdglwAACuJwuh2m1nqLPTRyKkEDS7QJFj91KjCu4jH1Mo
Message-ID: <CAE2Bdm1nss=2F4rAFo8_AjZJ6XwBiVnCmfvaZmjBd7=ZYvouKQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
To: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
Cc: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 01:10, syzbot
<syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    654ae5d73c05 Merge tag 'drm-fixes-2026-09-05' of https://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11860cf9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
> dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>
> Unfortunately, I don't have any reproducer for this issue yet.

I am investigating this report and working on reproducing the lockdep
cycle and identifying the root cause. I will follow up with findings
and a proposed fix shortly.

Regards,
- Chris

"But how could you live and have no story to tell?"
