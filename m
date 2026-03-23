Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87D3BAD9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279144; cv=none; b=UgYsbWMnRAab7WoCEUOsd49fa0UtppKt4nXaQMwabwUc1/Ho8Ycji+yDlV4yOBuaXhWZLMngbo2LwovNkn8c5SK4pDdzt1hf0Mc747ZHni+/u7X5qJ8nZ2YewY/A5teByIRG5oNrL90g3LuAyHKCSYInY3SuRuJ0fT409k8+mWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279144; c=relaxed/simple;
	bh=VVJBS7Ndm7M2UFZxdwt/ix54OGHSZNMfQljOMt0Wh2k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k2oCIt7zXIfwEEzEF+8p0X0JTuKz1DYUp+gichxlWY3Nu+GgkEJ339Z+bCgUdmELmOkcBLuhCEVPiHAaACm6dms0H9JEIw/uHQji2hrIEQfMu8ydUOqsJw+80pCNh1OrQl4XeLsAE0Hz4gSZpRizX1Sx/Op0cPhR4y4JemphCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67bbb4e5f24so26933853eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 08:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279141; x=1774883941;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA5m4MGEoYwjydOeY/anSc/nadPkiL/BMeot/RULQVg=;
        b=TW9to7suF8L2Zp8sodQgmPHojPtmSlmFU2qspwfjWRAydcvUS5EnJJSjqquscYn5nZ
         XUlaPpZ2UgKXXiATdcIXEiv49St+j27eWtY2RAjUuO3toi+GW8FOM60Oukd+AF+Bkvma
         DDDfcMpW2lRcX+e4XEUBNkZv9SHiwQmjXhaSPhOjic5I+PF0cluvivSSbPVsgwOqniUR
         2EFw2W5PqwBFWN7kd1UGRKk+28SOPIp0z3JIwwXWbZsRQR/LmCFNL3d0hOMonTKl/otx
         FtXlf+NdcV8cp6yD5I5EbdbH8wj75g3VO2M0A5zuL1qxvp28C2LivL0ZtDMWnWAW7CnB
         KRNg==
X-Forwarded-Encrypted: i=1; AJvYcCUotoK/SvzUNxOFI05gp8MPg+ans0p5n/GIbRubHAHO6rOGg3+IRuOApUseHahM0VSoCdImAEjer/OpVRvO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lxzMofxoEmmYrbM0aNxSpdEz3xr9P1H/oFx/2EtB9VmLOt9O
	aduRZpF8AlOs63TtVMHLjM7TlsGJHseJU/z9f8ttrO/W60XZUUFKvwEtXcSj6FW51y0zOhN3SBo
	UOvu4zC0cAH1AaL+Jdlu9bX5fI7EY1bFgBovBkTx+46iLEETJeJXJXvClUVM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1a04:b0:67c:1d0b:d652 with SMTP id
 006d021491bc7-67c22f93b6fmr9120672eaf.52.1774279141552; Mon, 23 Mar 2026
 08:19:01 -0700 (PDT)
Date: Mon, 23 Mar 2026 08:19:01 -0700
In-Reply-To: <20260323-nieder-blenden-fdae2cc3cf38@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c159e5.050a0220.3bf4de.009f.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in __umount_mnt
From: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://github.com/brauner/linux/tree/vfs-7.=
1.mount on commit 14594a141c760dd4c462b38d73406e1b48e44b84: failed to run [=
"git" "fetch" "--force" "--tags" "f622b72ecc2091e74994c3e0f0d417a3c44b5855"=
 "14594a141c760dd4c462b38d73406e1b48e44b84"]: exit status 128


Tested on:

commit:         [unknown=20
git tree:       https://github.com/brauner/linux/tree/vfs-7.1.mount 14594a1=
41c760dd4c462b38d73406e1b48e44b84
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc584910d0d74158=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3De4470cc28308f2081=
ec8
compiler:      =20
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11abacba5800=
00

