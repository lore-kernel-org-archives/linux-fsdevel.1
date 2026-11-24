Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515474;
	b=JOrKs3nYXxEnpej5hYjKttCH/1D0aBR3DD9tBf4l2CdR1CKhTU9atPhucjMtg085kSWc
	 aVBXg++42UdszHF+M3nkx8v/ICjD/vn0mD0vpoA6hoqiRpAx7KJJ27/mSrRHRyyJTtIb7
	 /HofYftcecz5bZsbOSwZ4yLnwomTjpWYeOYDVoKOuc4jc+lxfhjZwa40aLFqXJjcr+xlJ
	 oVfhtWj4JPSXgBGzWfuVFjT+WGzpfOfX279r28Qsy7KXi6kMP3LSyHctbZPSHNoD24go9
	 Dm3umnXWtdSdb094qhAHC8nF0AEuGIsmv28Fx/nAEx4ZjR3Wa2cI/XHVkJ1tTVSvzHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
	b=abe79mHB5z80mK3r2xHi1cZwzarDrBPNsd5hbjJH8hy8rRIFKd+cwCrjQ6X+RGchzHf+
	 cGD7QRGoL8FGujxlfqRjEJqf52Pvw2ufV/4xj8+yP6hbW4ScFTV4qltZudv+RT4nWPGep
	 byiTgQzIi44AjduU5nqYdFERPensxQWJSuPpx9O6OhCmAX/TAXyY/yvjbIhNu7ywuJ7QM
	 n62XmcIHsVJEDs8Gp3+u50w0d4ZEnFu7WV6U8wjb5oeIkZUSeymOoQ20RnVyI27TzMbb/
	 ncDFfQP4qX6PHZQsabiIsTXVVWmHUQsk5SjVYQLbqp93lOa9c2eSwFqZkpec15bJ7sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=boQDOESY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7D606A33B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 10:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D7D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=boQDOESY
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso1780202a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 02:17:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515469; cv=none;
        d=google.com; s=arc-20260327;
        b=mKyZpCVxJmQsHuQWuEzPZ2LZ3Cu+1kt81akVG7u2oynk1dFdJyBbH/KXRfeJ3riJFV
         KWgOpL3HDE0vmwUXVOBoyeDcE4jKS/Pf++mObt1hZjc3i31JD2chtKeEszgZ0abeVbT1
         oWYIdfVPOvBthSjojUS60jbAPlibWCwT9xFYyc/nT3t6oOavC9zF9+/NKq6YSdyZo7h4
         MWwJhV4gIW+vVmyyVEDZZsnFro1p6W6zhb1oh11rOxhZLlio3SYUKchlTZOnlAyS0obt
         Pq/9V+b4KrXOAO4HXGbMSIBPZREJt76J1/MC2HJxPyIil6vsYz6B4Bbolvi+NzpZtqHx
         N5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        fh=8KxLQKEQ9rYfr8eg5YNnAuXAtLfJO4396Q8ealCbWDw=;
        b=ACGWMdu5GiIQUsjDdaB3DvklxkRWcY2FiIUmrdROrL2Jf9+MPtFAex4QNgAozzh1dE
         jiyQvWW05ojw27yQrCuNDWxa5m5jGioOYOZugTP/Ib3NL6OQYEjs0TfK2JUkbAocJqvF
         +A2evXz6PuUf7ImYB8fiKK5dkEw82R3T4EMRRekLYlJEwqm78PtInrQYhAVYH/T5Hi6g
         rmV0wyvd3BcNIO89Jv7T/95UUoxcbtfHhKjssQZJ/lQEKtTZP4NclXKWENLHmr9lAtoq
         nONhU8hwMY1Zc2bpugaTLzj/phSgguMrNlD5zT290tYiQHGEPrLhrDsP/neL1iiwcqj0
         4IKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795515469; x=1796120269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        b=boQDOESYfuu+ei6nPbUoODpl/Ek47OYUgvhVk99ETOZyiaz2nZqCLusCouY2MPVsrf
         Lmi4VNPNuXk5gN0d8V16BfTeGNVTHqfHv8lmY2KZWvPzn/MwZzGSASY+bMZQ5SWPoW91
         4pw6s5nM+6RqviziclgIXLw7PFOAQx7tuzf3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515469; x=1796120269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        b=G6AGe6oXaIUzGZ2a560e0u2/X7PutAVeUGNkfnMkFhkqbHgiHDweG7U/2itFAABYwu
         6OfeUUfc14Zu6rcpzu5s0PcICXGH72k0g1tiG7Oxcp6yyvejkd9VCN4VauwQw67IXbNm
         WfC0ypWjESOpHy2rNuJNRaebnpX4JxFmT+oMLnC4s57ulHQfGw7wkbMIJaCQBElhmXI+
         mX0L93YFDtD28HcZSrpoLMljW022sm5V4XSSKQ0ToRhemdg8U7OGByyXsB68yXQaeGM5
         zdWvjXbJRsLAARnyI3ENhSy5jZ1p/aNPieuskPDL15D6XquuKwmyHLunewtFl4uK01zF
         qcHA==
X-Forwarded-Encrypted: i=1; AL+hErEiGkaJ2DfVtM0ssnJ4EEhko2qBSp7+n46qo6u4Q91AjD2l4tumkRvZd2H4qoai96crUFx+XsOAr7gsISGk@vger.kernel.org
X-Gm-Message-State: APuU4Z/bfDOSTn92bEi02aAARZUaMBujHCRBplDy7Bv96WEkJA7q3f4O
	rUo8aqKiAzbuiwcTz07xq8DPCKfeYaJdEc3jYFR/7K7vnWpcXa+uxtroJiDHtN4yOO+hp0eeCFm
	QfaMvENFMwrtseVtBTeAPZxgZ7KxOxIWm48Dr+W7g
X-Gm-Gg: AZFdTZcK5Mky3j8GDtDeEu3E/V4ncDa4t20pewY6c4HKjUvW2NienqA8/EgE4z83wO6
	SP2psxQ2KOfxaasTq0vUcfBK0UquZV6JwOK7AdRxC2FJsah2zQ8aQrx9kqUMGkMNq4ystIKLnDp
	1KZXWb3cteEh9tRyoWtKh2SOjC2MYNJImBb6Ghu2B3CPXZZpL7Fi/lTMKc13YOqHTcIYlbzyYEX
	RvD3vgi6Lq3UvEWN+WvyPm2/VerYjbeVqT2qZxpIkN6eXMFfrpFn17pznxybftSaKEujpBTbpGG
	S2X2pqNbiexRD6q/XTcjY3c5et07X+3OMlnyqrJorpCPVxJhT5gkVHc8s9F1rDwf6Zv70mM/0y1
	dkBRPxLmhrEUKRvQNKh/yiWMti25nIXu3Wn+cGppA6tYbPzEDvqtaJjfo1lH0H7oRUmFObZLTy5
	R7XFU2iKHTi7HC5yMA+wT2
X-Received: by 2002:a05:6a21:4a8c:b0:3f2:acd9:132e with SMTP id
 adf61e73a8af0-4014db57e24mr12442219637.61.1795515469040; Tue, 24 Nov 2026
 02:17:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6b051681.58b41460.7037.0590.GAE@google.com> <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
 <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
In-Reply-To: <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 05:17:38 -0500
X-Gm-Features: Aa3M54oAhgDu4a3QN-cUvm8ntTPorq0ToGdV6xzEFC1H8I-IekXAnPLMj4fFDqA
Message-ID: <CAM0EoMn=ZghG5KFu2Nc=W-=KjDv=epspFHZVDY4ww5a9GBUaHQ@mail.gmail.com>
Subject: Re: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu
 detected stall in security_file_ioctl (9)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, andrii@kernel.org, bpf@vger.kernel.org, 
	brauner@kernel.org, daniel@iogearbox.net, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-users_en@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Nov 24, 2026 at 1:00=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@sy=
zkaller.appspotmail.com> wrote:
> > > rcu:           hardirqs   softirqs   csw/system
> > > rcu:   number:     5264          0            0
> > > rcu:  cputime:      138      52351           25   =3D=3D> 52490(ms)
> >
> > It's not tomoyo, mm or bpf. Looks like act_gate.
> > Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't retur=
n.
> >
> > > RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> > > R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> > > R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
> >
> > The registers with lockdep struct sizes:
> >
> >   reg       value             points to
> >   --------  ----------------  --------------------------------------
> >   R14       ffff8880b8228600  cpu_base
> >   R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
> >   RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer
> >
> > act_gate has the only soft hrtimer that can be on CLOCK_TAI.
> > bpf_timer_init() rejects that clock.
> >
> > TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():
> >
> >   n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> >   close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> >
> > With base =3D 0 and cycle =3D U64_MAX, n is 0 and close_time is -1.
> > The timer restarts in the past and __hrtimer_run_queues() runs it again=
.
> > It's there since
> > commit a51c328df310 ("net: qos: introduce a gate control flow action").
> >
> > Jamal,
> > taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
> > The diff saturates the sum instead.
>
> Looks familiar - i will take a look.

Ok, found an abandoned related thread in my list:
https://lore.kernel.org/netdev/tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A=
@qq.com/
I will take it from here; it looks like your patch is still needed and
requires a fixup to the abandoned one as well. I need to reproduce
this first.

cheers,
jamal

> cheers,
> jamal
> > Here is a potential fix:
> >
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index 711cf24..5422d60 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact=
,
> >                                 const struct tcf_gate_params *param,
> >                                 ktime_t *start)
> >  {
> > -       ktime_t now, base, cycle;
> > -       u64 n;
> > +       u64 cycle =3D param->tcfg_cycletime;
> > +       ktime_t now, base;
> > +       u64 rem;
> >
> >         base =3D ns_to_ktime(param->tcfg_basetime);
> >         now =3D gate_get_time(gact);
> > @@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gac=
t,
> >                 return;
> >         }
> >
> > -       cycle =3D param->tcfg_cycletime;
> > -
> > -       n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> > -       *start =3D ktime_add_ns(base, (n + 1) * cycle);
> > +       /* cycle is an unchecked u64, the sum must not wrap into the pa=
st */
> > +       div64_u64_rem(ktime_sub(now, base), cycle, &rem);
> > +       *start =3D ktime_add_safe(now, cycle - rem);
> >  }
> >
> >  static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
> > @@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct=
 hrtimer *timer)
> >
> >         now =3D gate_get_time(gact);
> >
> > -       if (ktime_after(now, close_time)) {
> > -               ktime_t cycle, base;
> > -               u64 n;
> > -
> > -               cycle =3D p->tcfg_cycletime;
> > -               base =3D ns_to_ktime(p->tcfg_basetime);
> > -               n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> > -               close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> > -       }
> > +       if (ktime_after(now, close_time))
> > +               gate_get_start_time(gact, p, &close_time);
> >
> >         gact->next_entry =3D next;
> >
