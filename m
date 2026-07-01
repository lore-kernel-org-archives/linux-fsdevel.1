Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731D42EEAD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907968; cv=pass; b=gyR+ps/H1Utb32Sq/vw6R1+z0c8b1f2WyxkfsJfhoQOmA9Z/4+mVd8wTocB8TFgZmyR8Q+UCy6uxCCcl2IwfLaXoUXigaowVeu3QtIxyMs+uZ8XDdZ1rUkt+Z2IWnhyGtV2JhXAuKlAX0aEjDXr82Ol683lz6UJjoqjtDSegYkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907968; c=relaxed/simple;
	bh=Fk8PD7DHIxYkylROYr9KgJtjNuKi7EFq1m7jUmi/2yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOXqdgoB7NbxbwhJUHHTzOjUepcERI5n4biYKLiRlUCzHXrQDqoBTSttImL+Uw5hafLzkSaAcx8EYJ2h42dp/uqL54QbgjCW170BFHuiLkQVgMkPZPGM+8EBTbbEhFQM8mfbCIaGbal9uFzBsM3HiteAkL70O/h7tHOfPfD8eMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HWNFwAuy; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HWNFwAuy"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so432699a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 05:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907966; cv=none;
        d=google.com; s=arc-20260327;
        b=rUbVQ8JF8/8/i9RszxQDD4xh9XCgIj83Ye98oEi4IzcbHF0XsYQdZxe8vtUAqci/IN
         62z09roBGDO8BKZDzIavoc8qzTQRV9XIkORkP0q4QTNiq13RFErQoNN+qZzoyUPq0uTN
         bllk2hg6NG8Jc/Gb04Fml1XRvfc0NtCPqwMcoqG2sD2jKAJJQVUjauW1r9452EluT1Tx
         kWtPKCOg2qgSROez6k+BfQ4hMT0fWtvlbYK8CCS7orT+zZBflcyd1sevl3ME+sPyBrr7
         aeCenUhlMeoEUgO2JTiQZIJ5lGtCIRKVoZZcZV9UXsuwJLd5kKjbAeT+2E87729l5m97
         5P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        fh=5uPrX+7+RCjVfcC1FvYPTtPHDYgDMvALQg7lvaK48Tg=;
        b=cHQzvYrydzlQe0QOXNZ7srEiEcZzH+hDJClxl0n7jUFz89Le9zc2OnXr7zYC4U9rec
         dukLgOGN0tMWo49fbknY1GPUwtdW8lyFU7rbxk+Jhg9fCAP+mqUSNY2uUwTNLhgA2uGZ
         imOErrBYc/7cqOPkGbcxZe7IWSBR0eFTf+MeLuWQm4TEFwCBvKNSBLOt5d2TpwLwZhJ8
         dYRmv1FGKghCloNZ9+jKpWVYUkVgU/l4q0eLzF66bMc/sN0AhcQrPIhZoEteRAjJjOQt
         zgjvKWC/5vgCJV48qcbK76wfdqSMGDq5R8D7cMNYS84XllYWzkGhAIHdUnezKmGAGshs
         3wKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782907966; x=1783512766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        b=HWNFwAuyF9faYBiKPwy/0ShIU4GCX4wa8/hc/SOe9F1q6tq9fkzadaCiz8K7nKYUps
         NpttmbGGEfEuTuLNSy8f4TGD7jG0Zpxg0iAE9BzzCM3xE8Voz4C/sKSlXqrbtPC0NFb/
         ascm4R4G6ggQ/8xtWBrJMlGiKNK+4pHnswraCYIM2tZuaj5rZ6GgCXYl8u9qerzeER+Q
         ZRZexYuBnlnePZ8w/f+27PT+QqZf9f331aWKtJrU6Oi7oHSiJU4FNN9o9jB55DuoblSO
         Si6/GSNg/N8/pWcI6bl2bpqpfdWah69vJTFIJ9WOcKR7J8D8npYORHpmI1VFRfzjZ1D+
         5LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907966; x=1783512766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        b=iPkzk51AN/3+p+Lf+Xel2VDgqsqMSAGIPWzDcquSTX3udV2b9QNd3WE0T4QPBwWqEo
         nTNO+DNjqxQJlvOh261Yo0JQzvpSD/PlDhA+IwXaC4gwVycNbiiQnQRlWe7zQlvzmqDk
         MpEUwoGKtjA+5LQAWoAukKVjDRmUDCB2RZv+t+leHO7zz/yyHOIEi+QO129Lk66dTNcd
         ASGEmFZSDfc/d0TUdEVl9BzFgxN02/SGJ/d26AhGw454n5ELvWUfytwz2QQzbRY2GOmF
         S8n1IQCTMrsYge3HlevVixAEpDGPdiTeOc1Wv1uMr+8+doUTMC+CO65s/zA7n38QwIo5
         Emtg==
X-Forwarded-Encrypted: i=1; AHgh+RrGsLn5gweMhUQPA93zf/s+GThrA4qOYnnN14ZRbmC+UuJWtBdoU4JKVqSMgtp8Oa3uxLVr8vmnJkPeUmbp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9dVeprAEI5/KfNYrhp6nQI5VBY1/6KhqWwSkV7pGXT/qH6PW
	kNhDgXemQf7IeyDpK7XUeAgpFDpwNrOau585VOsiReTmAmtpaswIpwtHK6CgWlN3JlmXT0Dn58D
	E12HaJjw7SJeR8tuiX4+9zi9wOdb7Lr891B2orugI
X-Gm-Gg: AfdE7clo/y+6znmMadfSWl77AMLazYPw3qWVsAOydhYE4gCatkdnEkmtKP0EczzUwPN
	WMzniU0ZFWFg5z+k4APx8roA+aaHAttkQKuL+8SgAdzg9Q1Vr0iAHfvsYYBCXmIpvmR/CfUFQTE
	EWbMg8jYTJSb8JuyI0EiSq4EGGbeCWcyYDZt2IChxt0osGknxBRwMaM4HiTBHbUQv9iyD2C77TP
	3hovvWcSERb/YPd8X3Gj0Kt+JbOPlqw1IfxjV+I2cNRqx9h1u3cOuW4gCcu0WdtxIja5Esf
X-Received: by 2002:a05:6a20:5484:b0:3bf:6c08:2842 with SMTP id
 adf61e73a8af0-3bff42c92cdmr553443637.49.1782907966065; Wed, 01 Jul 2026
 05:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
In-Reply-To: <20260701.ze4eph1eKo7a@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 08:12:34 -0400
X-Gm-Features: AVVi8CeqewfdSkYjjmrhNYrv7bEJMOVzvMagAf7bsF5eyhzqBn0BNZSrdfQn4sM
Message-ID: <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, 
	john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > callers. Export an opaque struct bpf_landlock_ruleset preventing caller=
s
> > from accessing unstable internal Landlock fields.

Generally speaking we don't want to provide APIs, either in-kernel or
at the userspace/kernel boundary, that are specific to a single LSM,
see the LSM syscalls or the security_current_getlsmprop_subj()
function as examples.

Yes, Landlock does have its own syscalls, but those are
"grandfathered" and not something I want to see emulated across other
LSMs.  If a BPF program wants to interact with a LSM, it should go
through a LSM framework API.

There have been some initial efforts to develop a LSM wide policy API
for userspace, and while it was put on hold to sort out some namespace
issues, we could move forward with an in-kernel API now.  We don't
have strict API stability guarantees for LSM hooks/APIs so we have
some more freedom to do something now, even if it isn't perfect, and
refine it at a later date.

--=20
paul-moore.com
