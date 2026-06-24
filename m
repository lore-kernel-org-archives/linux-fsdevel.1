Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A7343D72
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321702; cv=pass; b=tt94yWDFbqc2iJd9gOPrJxVRsl/bAf77A2rY1GRbBAhx5QURFFk/IRJB2IV0NTnGY8liuZU61DqV0CN9mP+Zaj8mOQPV5aJN/TUh22FzTHUhZBcLFgJMkn5MMdPRnS9RoHBa68ld0IuJSoIBQIfmRjSN2DISDiCCT42m+UGJDj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321702; c=relaxed/simple;
	bh=VYwfjIyBlUVMpGzw5rbnsNCF6qa5v1n2a/4+jSEq0OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3tJua+uD9BSNXgtas004gOjv0+fE8AYnkwaTJ2Zi8OQ+//z35cDQjlY5B+Dmr2lsVmCnpU3wGKpk3iVau0R+keEw5bzSYJwPoAi3Kdp1Kyezm8avGmc/RV87oAFUWvTolpQl825JBQbDfvWAaJUfNAsBobF4YRI2bmkxMLIgsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BeOWyks8; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeOWyks8"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69565156c06so591a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 10:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782321700; cv=none;
        d=google.com; s=arc-20260327;
        b=QhaCmJCnfnPaOyIU7xqDvs0uA5SA5oOcrfYYAFiT+/VSIOtL9sEGBc5ExPwHm5gPmk
         fAWdsiMM7dVu/GQE1e7AHFE78AilCcE1aNHq7WU0pmPGkMJp79tRmaSlXOOoYIXw91qV
         hgs2HwueUq2lMIaf3GcAKx3gAs9449vl5L82XTsVo3Lj97mOr/gznylAL6PJu7H+ZBvR
         lGIAuWwQJGJx5d7Pagh9GPMLw9CgxtxMmFNN/p4MmY1WDzZ+yHeQvwTPtcQ8QYtF1nLS
         J62GVWUXhXnk1Pz4381LKNMKTj988czwrqbfnOoddU9oqNEwbHhWFYB1NFatOkKkTYJa
         OwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RZeC/udB9wkBiwvW9w6mrNkA1Z2HNikx3hwYtFc0XRw=;
        fh=25Tl/CYp5R5BZ4FNHoJqhipM5WhS77kvSqeZUtXU878=;
        b=RPOcKgz615FwNo9wOPGgcG2EtaForKfKOHsJd0dK3FJIjsFftbm78GSTvUP5t0oQOK
         sUuDJWIPjqMmHK/mgB61JFfqmMTtVLL6XoDZbH8O71Zs2N6VJQyFVYUzaKlXv/vjEp1y
         vsXE5EsW9JuifM+CrFUZWKK55q7mCWCWoMAKi1sPZsrjS9QKLLsKYNtjrfC+NS6/iDUY
         Tf59TlPQ1pE411XRslbgykN4v8gIt4tDLbH2hq0wdzdL1nb+3Sei7Y4652i5uwJt/eaC
         2oHAetwFUTwA0nvPQR5vMk08JG6zMA1wwUztYfysyq7ob7X+Wx0IMIfxZRb6GiiICMKX
         gopA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782321700; x=1782926500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RZeC/udB9wkBiwvW9w6mrNkA1Z2HNikx3hwYtFc0XRw=;
        b=BeOWyks8jvBszQPtPnPO6aJgiqXHXdOM9HkQZIex2RBA+WpC+4jp4K8BrVJhslo+ih
         8RIfDwXwXOuvnw1+j24UbxaAaRbcs8Yiht5QV/F4RQvr+BAWX2wK0ZBo4KkpkPdNjATj
         X/nK1YhypV8Hg4jBRczNDdYMrZD7DkFok+OQx45xNSzjdWR0M7HFdJJ9snMKa+WRNru3
         4NFxVI+Y7Zx42qVvKvOjH1W//PRISzQXvDwhbthnruJ8oGuTirySTsQUh4lF4r0JLb/j
         oiLWKUXCihzAi1wwgnFfUgIAYUboJQgmcetvRuLu+GVWSxAAgTd7ujUN8pd+FRWFHYks
         ssiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321700; x=1782926500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZeC/udB9wkBiwvW9w6mrNkA1Z2HNikx3hwYtFc0XRw=;
        b=d8XaRKVsgok8BDr9WikaKrkXiStsE7gNhu5Dpebd+Sd/Y4qZQrs6uagDzSQv0pzjCr
         3cn2Q5VHDATlscsnqmPcVkKvznEcKDOMZV0pMO8bSHUeOR6RrD4w/6mRlRc6sfPhqsaz
         DlU28vJm/oRjx9v2+0CaETFjxLEhV07guAKyWcNFXDsfoRR35PU10xbyAaImBi4Dq/XA
         8N6gCk4ei3k3d/54AtkxkYItoZwN+zIaN+DaXmwzrp1LIhlB1fePOpSLzHQ9Jyp6I+TO
         6bqa6Z6Ml0kXjH6IqodrWp38o4bwZDdKqprNBPNnyE4hjP8I10qKaIUsR8Kz0upZgu+t
         oRZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiL7EeBz4L75lx1VUOaSwE5Q218PDpkP1kttYauzfB8MgxRBGIlXwKYu/Pvpd5jMWr85lGVlJPw8fRcrQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy133uWRGshb7odLAPdAJpdv82NVPesN36MMMNyTuzNn1hcoj2r
	2WX73ZQBmBVc4aI1X5loSs9ogTJW14ZpPIdee+dpW2hyJ0e7nxkv7sjk0up4VOHkkYjS/lgh3al
	k6Yv55KJDXkE5eJRCldEZm0k7ie2Kq9mw5u0B+BIh
X-Gm-Gg: AfdE7cmHmbqoiGnWxepZelh2exaVWThHaAYt3+HrGC4mEhNBzx6xxtjty6SxRG9ghLR
	kk7XqAj1vl4o/+Xl+NhCCfJFtuf9svsJvpwHUW76cG5+cyYLiVl0B2JsDj8T9P5QJk6pe+xTW27
	WqmPDJyVJfLed6kn+Zs1g0Iz6byauIk1uzzTZMb4KhZd5WottiII/sCNSkqKNowVRmwfpmOQkwo
	uQKawyWNIOrmMEgZ21QEE9LjeADfAKJodO87fXicek5Tnwh4qDNcyHbS2z9/LBOWnQEuxPMv+Vi
	2f/bxjKNH+rQ3wUTgQCC8I1qC4858hRmdKMlX89GmDTE2xbDD7+PnqwTpQ0=
X-Received: by 2002:aa7:d9d4:0:b0:695:4751:c044 with SMTP id
 4fb4d7f45d1cf-6980c44448emr578a12.8.1782321699316; Wed, 24 Jun 2026 10:21:39
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a35d725.280d05a0.1060c1.0001.GAE@google.com>
In-Reply-To: <6a35d725.280d05a0.1060c1.0001.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 24 Jun 2026 19:21:02 +0200
X-Gm-Features: AVVi8CeJZbZvQ959HAmGvPdYiPL4HsQtCGjWmHCcCmFJBfYbyWx8uS299u2u6fM
Message-ID: <CAG48ez1afLn0yd+H1iLv7AQACk21aBkSU2jxWhz+q+di=UXxsw@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in d_alloc_parallel
To: syzbot <syzbot+bcc49cd0a89969bb101a@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 1:56=E2=80=AFAM syzbot
<syzbot+bcc49cd0a89969bb101a@syzkaller.appspotmail.com> wrote:
> BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/=
spinlock_api_smp.h:132 [inline]
> BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kerne=
l/locking/spinlock.c:166
> Read of size 1 at addr ffff8880273bb728 by task kworker/u8:2/1377
>
> CPU: 1 UID: 0 PID: 1377 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEM=
PT_{RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/09/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description+0x55/0x1e0 mm/kasan/report.c:378
>  print_report+0x58/0x70 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
>  kasan_check_byte include/linux/kasan.h:402 [inline]
>  lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5844
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
>  _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
>  rt_mutex_slowunlock+0xbf/0x8b0 kernel/locking/rtmutex.c:1430
>  spin_unlock include/linux/spinlock_rt.h:109 [inline]
>  d_alloc_parallel+0x103d/0x1630 fs/dcache.c:2826

This is another case where a spinlock is dropped on a dentry kept
alive by RCU in an RT kernel.

#syz dup: [syzbot] [fs?] KASAN: slab-use-after-free Read in shrink_dcache_t=
ree
