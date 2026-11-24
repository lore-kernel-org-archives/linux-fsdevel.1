Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795514621;
	b=Ut/T9OIt/HNBw/guD3R7n2hezHMBy5azNjrVHLCDO7/rONNL/mBm2VFme/NzOoTc4HSB
	 fulYTysiEPWmsQcET3Sl+a+gLzgTUwLoAoLJm7JIch4v1XzBIOOcMhMRyaLRvR8fcZZoe
	 xj1LQotI5fuawCDjft376ikSWaXmpsW8Ix24n2iQuCOo6YAqAwrH6KzOVQ+PImz9j+dg+
	 cJUX+g3EcPVmkO/20QoFmbX1nO+KlE5sHFP6ZoxkxvbMGFFd3AVJSL/z4vmN5esDP5eXZ
	 AhpaIMQjrkBOCFP9BhOY5xSpMUJ9DOtJyCRnU7uGzshF/7tMNGGo/NV09s70p+9jRRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
	b=5PRUFYzXm/hQr+R1w5SMYjlV2/eByFNPNVe7EPwHxfn8a3Kv+jDmEx7qRGh4dViBULUr
	 v4Zgu0mIkSHdI/BfheJY+gP0uGfZVy53o1j+aqM5fYHVF9NgDzwIRuzQ1pdZIWBpmopNt
	 RlCLw3Mtf3m+8NIUtDbuUJbEFe2eHYbwDcgISzEveLMje4Fcb1GmBYDHvKjWTIdZ+90st
	 A2ZDQE4BH5ftNVZo70ADC5Z+uqBRlye/unVo8d3V+63QpfrejinRkNcni1Qhgmxv7YZkB
	 MMKcXT5k/g6OdTP1CCqBkqKoUhznpeNOwp39T/q8vLUos226JZIbL5MFFrTWXzYopMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VmWAs86N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D795B606A327
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 10:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D795B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VmWAs86N
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so2065511b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 02:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795514620; cv=none;
        d=google.com; s=arc-20260327;
        b=O6nC1puRyFhDqA8tq0MM3r+6XBQYk2t37+yr7BWoQqPnJbglAvglae9zZKiQclJZKY
         8qWZncR1AKpuAROb1RkJDPz2Fzwr/A8kT057SkITowwYJOyAC6sm5HaTgk/Hs/JNnQg6
         5nQ4ADpjR6aAoHE51Hq994ilC2Bo6o5++TS2Pq9bRTMRpETsrF27kfrskY+FQiJk8MTi
         ehHO78S3WYyo+Rh56bQDR2FaY3dIq+oFshSL2+zTHE+23gZ3h02fe9La3tPoeqnUK2IW
         2Rraghz2SDOv+l9QXVxRwbz86Ts4ksHCtQ+vixjInIuc2il7Z4bqn6jcavm9HUmFl/4h
         jLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        fh=rClbBqULCcsYMPs3pZIWNXyYjPI1I+1Hm3mdny5pUw4=;
        b=Up8RVMB6GwQGbBGOu/cVu1AE+0x27uuY8G9gODfbTIEewQzAFTf85R6jl9qihUU1y2
         QsPa2mlZjrAM4F6jvMtTVEONcA9M2fiVK/VUmQDPpIrGJ//57HWevBNoxUDQg0im1Fsm
         7ihMmM0gAd9Qq1NKScxHpqRDIOhya80Q0AVBSPsRVpptrvEgYde35c501Xv+9q2B/ELH
         OHZ1XpRZTuL7CL2qT7zldcx1uAAnzqiwPvMH8Av067issmKv1ivyYLbrD5ItzM/6hPnD
         n/m+pWGbz2D/8OswmIuLPmwtxXWBhoNJMRZrK0GuuRGTJMnOoKRcdXDJ8gzEVW5sjawH
         VmzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795514620; x=1796119420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        b=VmWAs86Nz7sib60O4izbmOD6cZh1oJHcY4TIr9SaP6pD5C0G2T6As0XqGlZXCid52l
         D7UokUSGtJok+76yw43RikasNHy7al4rTLqNt+q+izWEJlO4nwef7uYHHiWgKe9yWWTM
         I5j2coA6k1F5B5uggw7O4grg7Mi+N5CcJvy20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514620; x=1796119420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        b=2GqQ80s/mzUa4xqj0hcoQQRtsuA4Aft7rxlI6dRouoUEq1PHlN4Yu9fxs0YgSfoP5N
         LLsRjyl7ZVtkoywIu4ffqX1x8NiNfFuZoyfSEvMxW7zpp7rQo+X+9hoLIZNsFLpZD2em
         PhrCo95yiph+zym3bG7kLfjEPP8UU1KuX39ovTbPYGUN0ezaznF25OauPyiXGY101Smg
         emP7GMJg22SYNV4JnDab14SK1bYsKOPd+POkQd9S/cniaXQEBrwcoqpcXuTbWVgUDFue
         e9S/X/RsFT/77hWy6ZSRSCm/VtvIe9VhTP0POk7T3QrvWKk4Da3BUZ+pcOl+V5BJ/Uz/
         Okxw==
X-Forwarded-Encrypted: i=1; AL+hErGZzIvkRwDVxrs1kzs0xptDwzSDxBBWDcAccwFz1IHVop4YY50kXM0aJnjCcQLVbtaw/pPa1bNZqNHH0G74@vger.kernel.org
X-Gm-Message-State: APuU4Z8wb6RHFej8TxuIGJCdo6AvftDlQqWxG3j+p/8LzdAJvXnJlI0D
	90QQg9XHNm6N+xhaRSip3AB2O+b4rIhD83ZaUZWePCnVs6e6DJ1Nr/2IsErZ++LOpNfUe1XybT3
	Z2wgu2UQ0cKi3wbzLvSwqH8CIAOJx8wnTImr7Sfjp
X-Gm-Gg: AZFdTZdDtwi+4Ds/UU8/P9tA7zrqByQTulMKURdTNj/ElVryFGzOxKGa29MGP6kmoiv
	mnqi0LEEGFwQBaj54NO/RKqHnXrS40cMAkvvxo/8D+QayZj2nl5mLcL6BUsP7ssST5ADKMefDbi
	7g96eRmN3EVJo4+OgYrxhn+CotG0E1nHTsuU3Uetv7ENbWcLv4d/2fgsdVzB6NqznbzNdbq6DWi
	h/k8aaid1C2FWuTBv/6cnn92K6h3WvCVMgcwPiNKx2+gK0szlu+HDfOphZKtYwqYdgXyfOD9Eb6
	aldRpDMdrOiuJjC4YGpFuR3XqJXG0XFdPUY4ooy93Ee0Gx0hhxKAxIytuPHdLfBvp+8Hl+upqfv
	78r4A323rU6iYodH7nL45k10mJYobfWGaJUbuSh58ELCITvyBw4EqlXg2TqrpQCtfDtmCeo+IJA
	dBridaMOquGQQsnurpX++Y
X-Received: by 2002:a05:6a00:3c84:b0:89e:ba55:119a with SMTP id
 d2e1a72fcca58-8c87d123bd5mr13499490b3a.47.1795514620227; Tue, 24 Nov 2026
 02:03:40 -0800 (PST)
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
In-Reply-To: <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 05:03:29 -0500
X-Gm-Features: Aa3M54qvcfjcRlRGJK01N9tkR68vSDtEhX-HABSVQSN3K_q0am-4DoB8x5iA1ls
Message-ID: <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 1:00=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@syzk=
aller.appspotmail.com> wrote:
> > rcu:           hardirqs   softirqs   csw/system
> > rcu:   number:     5264          0            0
> > rcu:  cputime:      138      52351           25   =3D=3D> 52490(ms)
>
> It's not tomoyo, mm or bpf. Looks like act_gate.
> Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't return.
>
> > RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> > R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> > R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
>
> The registers with lockdep struct sizes:
>
>   reg       value             points to
>   --------  ----------------  --------------------------------------
>   R14       ffff8880b8228600  cpu_base
>   R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
>   RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer
>
> act_gate has the only soft hrtimer that can be on CLOCK_TAI.
> bpf_timer_init() rejects that clock.
>
> TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():
>
>   n =3D div64_u64(ktime_sub_ns(now, base), cycle);
>   close_time =3D ktime_add_ns(base, (n + 1) * cycle);
>
> With base =3D 0 and cycle =3D U64_MAX, n is 0 and close_time is -1.
> The timer restarts in the past and __hrtimer_run_queues() runs it again.
> It's there since
> commit a51c328df310 ("net: qos: introduce a gate control flow action").
>
> Jamal,
> taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
> The diff saturates the sum instead.

Looks familiar - i will take a look.

cheers,
jamal
> Here is a potential fix:
>
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 711cf24..5422d60 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
>                                 const struct tcf_gate_params *param,
>                                 ktime_t *start)
>  {
> -       ktime_t now, base, cycle;
> -       u64 n;
> +       u64 cycle =3D param->tcfg_cycletime;
> +       ktime_t now, base;
> +       u64 rem;
>
>         base =3D ns_to_ktime(param->tcfg_basetime);
>         now =3D gate_get_time(gact);
> @@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
>                 return;
>         }
>
> -       cycle =3D param->tcfg_cycletime;
> -
> -       n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> -       *start =3D ktime_add_ns(base, (n + 1) * cycle);
> +       /* cycle is an unchecked u64, the sum must not wrap into the past=
 */
> +       div64_u64_rem(ktime_sub(now, base), cycle, &rem);
> +       *start =3D ktime_add_safe(now, cycle - rem);
>  }
>
>  static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
> @@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct h=
rtimer *timer)
>
>         now =3D gate_get_time(gact);
>
> -       if (ktime_after(now, close_time)) {
> -               ktime_t cycle, base;
> -               u64 n;
> -
> -               cycle =3D p->tcfg_cycletime;
> -               base =3D ns_to_ktime(p->tcfg_basetime);
> -               n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> -               close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> -       }
> +       if (ktime_after(now, close_time))
> +               gate_get_start_time(gact, p, &close_time);
>
>         gact->next_entry =3D next;
>
