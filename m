Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD803876B8
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372281; cv=pass; b=Gzylwf5ZMCHlNYbh1wQiLEhsiqMd3lKOtm9yaYTsXDf8Rnfy4bzLu9i25EfGTztUu+awJzpiRrPdlotohmNJ3lZkzztKg/rFPClZmrepaik4JsqMOhdiWAQf6tVYXznDpqM+sScIMTDBw3r4r42m7DyVyRijjniXrV7HqaXRl64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372281; c=relaxed/simple;
	bh=AFJSrrQW4gF3ANdPDPC4j1IYpWV3iNda9Tgx0JK95J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpD3EYbeV3Ky6xDtVGzqrL24Ct6zuqtgkKrE8l268LZTyHAQpSPKvaf6so4EsQtnmWOVoQT+D6gbrIs720FOrcLLZ1Y7Wv+LXAltrSmgqh5fqwbHsdaveMPCb8zTFEIYodqufMc9A8K71DIOk56Tsz3Q/rIgz780Q/rdPcu+kcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VH6z/fMG; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VH6z/fMG"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6aso79035ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 11:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788372280; cv=none;
        d=google.com; s=arc-20260327;
        b=ZynpR1WQQE2TC5NcCDCu/Cho6Eu0iAvJYQC/kZ8sKqzGeBvd0BCOxkkS10KRvsbRJR
         25wsl05fOqGmtyfw/FZUtXVhjHGoT48002xjSYuItlu88UKmEE+gTUzVGDOKF/nEYzhV
         4S/k7yVRaw9t0W9GM+3It5agNApiJGUgjqwhd4Mpy0sdS4bFpSlH7NL/+vxehT2iGwjM
         2Z4o2JqAwLbRiHF4VCkYvYZCFA0MC1FvFvaWxH/n6C7PQUcVkWWTcby2/VNpSx432j2q
         1c7DvkzKh5ZtK0L4QOxVl7dHaQZLIKbwxGyoDM+z8iIUuI6acm+vVJJLThDOCnnxSig1
         BxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tW+6wZzNoXEx9aEPCU1H6du91aF9vK1xV2VXmS0iwpM=;
        fh=iVVoyx9sJeARuNZo0gJtQAKHlQ17gs/u14bfyNVHsW0=;
        b=L/p0qVPGqnnYoRhC4slR+XHSJUjgOiCPT9I+LGqf7cK9mInAErOfVlUh4P5x+Psbpy
         fDCRNs6k5FY5DEZk8H82cjNlOeA2Fsvf1A5P8m3wja3UOtmfKshgoxmNEPJjYa1VY+0k
         aZEGitR3Dz3oX/xwiQUpUyn0L+3MQ/QurO7XG3WcMICS3/HD8mV/Jxhnm9v4rmz6U7Pg
         cL0v+hl8zDL8wkMhZXcQVDmOHbrIXpuWM7X7pg5AaFeHgPEevY0fSxW4pzmpoX5//Ash
         M7ZSB5RV6unSSvFY/zVFGT3kPDZPf5Ayd5gZ2CKmQmjXkAtnZb/IbQ9PBl0mP8/9xVPO
         M97w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788372280; x=1788977080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tW+6wZzNoXEx9aEPCU1H6du91aF9vK1xV2VXmS0iwpM=;
        b=VH6z/fMGTargi3RauGgwdR3Rd5VknN7sEy/hmANGxcVauJPu/8cftZ1cnRCvFCtA7h
         qtNQgoLqFbHnxRX2BeKyuIVFv1hefh6yA7G3Fj6kYRsIvk8HVs6xGRRqFqhzx/yF2Tw+
         /GT8SG7+iKFXOunBZ8Y0DY9mE7w/obsRWGrR2pxO0WjUlVHUibH++n5KgEeEFjqvG+pv
         JrFkjrMC12cVLxkxXdaRqzrm2IsvzyHifihGkVEH9M5pmkARNlunK3BybTLEFE2CRTul
         ZTg0vvYauGyd4UX0D5O4dmTmiZTBqBsdjaL0ICq4D4AnJFQzhlGKDEptBmxnspBYYxHS
         Ag+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788372280; x=1788977080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tW+6wZzNoXEx9aEPCU1H6du91aF9vK1xV2VXmS0iwpM=;
        b=Wh9DRfZ7H3G4dZDM/ZUfSm5VQ42JIDf/vGhkihfYptHO2xaTMyotrwyLVnQ/AI2Ows
         /EcRzHLg34eYhlUL04rLzAjxMtivf+pikGl6B+Cti4DqEuazBU8JiecLBojDMqI+IEQc
         ozu3Uw3q/T7ypHQzOY9tpWHmqoTbkU5davijPphxdbBMjl57ED818Wq0U8UH8xZCZWbl
         9w+EYCS+M3Jy2K1N8XCeD9Q7QUWv3Gop6TN17Q10r6VPapaJQ3r88uEHEtBEs/Ib5IkA
         fnp5kGlPgx9EyxEmBWP5j5fhjmjyV4fUe61K860AcL6ZkNpo9NXnFKwr0UM7h9Psg6WK
         Ak/g==
X-Forwarded-Encrypted: i=1; AKwUvBwxLezOewHG51WjmLEPXEirm0Wsc4DUk28VJ0k0oJ8KkQNB4trjGwoVbHFTqOO74MrOdTTWhhX/vQZ/d1bE@vger.kernel.org
X-Gm-Message-State: AFuF++npw7WoeobSKg05O2N4dZaY7+ntu7y1yjiyOPAbMpeQxtEECh/j
	JaopMqoD+gl0KOTBvgPx2ihKTP29ixli5yKdk7nJEaITdAr/5Tn+QzojXS8kZzPj6LWxtxi00ni
	a2NhbyGcEYofDSHbQl/xx9c+2cjESmordMhwWq/Cn
X-Gm-Gg: AYBFou3VzOWSdmxeclJjTpu+KvLcMc4DD8FBKRc2QZ88bPJ5BjrGhIfqPWD8tYdCDxM
	PpX1T+bDKL1Zvui9EVv7v545iGRJOOlLeT/4AgRaMmBPjhRReDBsWox3GIhMrkim5kb5e0wmiyy
	tAI/4TeQAFBmXC6qXwOdaMzOVOCcrL3GdPXiFnJtCNygDDpzQEbbxSwv1klRpogwcxm86W1HSu/
	TbvUupqo8szATFFslIWuyeP+KONSWEYow6eAozqlHmHTXqp2CqyyHD/HSUTLnPPmK2RvdOXsuzl
	OV57vwI6xZAu9K2iPbbQPB8DO0TZviRq5cPdMxsi8lGYqmW5tF+if60+rdbCuwg8IGmPsKvt3yl
	Q7+tBmtvPrZ87tSo6ynRhFAb0Mer2pvg=
X-Received: by 2002:a17:902:d58f:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2dafc04d92amr701505ad.3.1788372279277; Wed, 02 Sep 2026
 11:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5e8166a-88be-46c5-8939-1e5227ffe4c2@app.fastmail.com>
In-Reply-To: <f5e8166a-88be-46c5-8939-1e5227ffe4c2@app.fastmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 2 Sep 2026 20:04:02 +0200
X-Gm-Features: AcwNN1UioYI-6aY2FlebIGmb7OnaSV6x_bEiOULXJCzjw3r7BAMamy4lB3uuGTY
Message-ID: <CAG48ez3AYt=dYMYLEEhkrzO740wNsD1_3zZbKqo7MXThqEA+Zg@mail.gmail.com>
Subject: Re: deadlock from exec_update_lock and reading procfs
To: Benjamin Peterson <benjamin@locrian.net>, regressions@lists.linux.dev
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:50=E2=80=AFPM Benjamin Peterson <benjamin@locrian.=
net> wrote:
> After receiving a kernel with 6650527444da ("proc: protect ptrace_may_acc=
ess() with exec_update_lock (part 1)"), we encountered a new deadlock in a =
FUSE server. The FUSE server reads /proc/PID/stat in the file flush callbac=
k, where PID is the pid of flushing process. This can deadlock in exec_upda=
te_lock acquisition when the flushing process is closing O_CLOEXEC files.

Ugh, sorry about that.

#regzbot ^introduced:  6650527444da

> Specifically, a process running execve is blocked with this stack:
>
> __schedule+0x505/0xc00
> schedule+0x27/0xc0
> request_wait_answer+0x158/0x2a0
> __fuse_simple_request+0xd7/0x290
> fuse_flush+0x1a4/0x1e0
> filp_flush+0x30/0x60
> filp_close+0x13/0x30
> do_close_on_exec+0x114/0x160
> begin_new_exec+0x553/0xb50
> load_elf_binary+0x2da/0x1770
> ? load_misc_binary+0x275/0x390 [binfmt_misc]
> bprm_execve+0x241/0x5f0
> do_execveat_common.isra.0+0x182/0x1c0
> __x64_sys_execve+0x36/0x40
> do_syscall_64+0x87/0x180
>
> while the FUSE server is blocked here:
>
> __schedule+0x505/0xc00
> schedule+0x27/0xc0
> schedule_preempt_disabled+0x15/0x30
> rwsem_down_read_slowpath+0x25c/0x480
> down_read_killable+0x48/0xc0
> do_task_stat+0x7f/0xec0
> proc_single_show+0x51/0xc0
> seq_read_iter+0x11f/0x460
> seq_read+0x12d/0x160
> vfs_read+0xe8/0x360
> ksys_read+0x6d/0xf0
> do_syscall_64+0x87/0x180
>
>
> This problems seems to have been acknowledged as a theoretical possibilit=
y in the original patch review thread [1]. Now that it's a practical proble=
m, is it feasible to move do_close_on_exec outside the scope of exec_update=
_lock?

I will take a look at this soon.

> Best regards, Benjamin
>
> [1] https://lore.kernel.org/all/CAG48ez2pmuoTCZh_AVKDDLeQEYmm=3DgLMgThnqF=
hRMFfZvABpdw@mail.gmail.com/
