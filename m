Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2313A9618
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884364; cv=pass; b=YEcE7AKbzyIABwQwCV7jQvWrp6YMb1rOji+qTQYzUujFZQ9EQ4TRAVmf5W2ABTcb5WRGCANVC4Ev0U0bQjMPVCHnvOqPvFut/SJmQdD4toSd3khH8OCLqUgQ1h6WLWVzrXCDw8aGc2BBVIRzuI8RF/RvMbTStGz+e1SFzsuuXVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884364; c=relaxed/simple;
	bh=KEy3rXHuQwUA3D6zy2MyoIddwUAPoFRAdsVTM7rcQDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0m1P9TSo1KZIaKqT+Gyr73ruSxeg9ZAcZwLdg6LNqDKNx6PlqLbziLpdsgYoCS1ANWvjvRt1cFJEw057hGLWyDom4Kj9yQM7oTl56ptwKcDomwgclGbgeI0r/IJvpXOePTw8dbeAx8uBrE62a/ToBPJ+do9JaiXdak5H0Yrk2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ3hP44/; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ3hP44/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48d146705b4so2938405e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778884361; cv=none;
        d=google.com; s=arc-20240605;
        b=isBUaA8LTDAgy7YzkIJljXl7ywL/b4GVFWpyW8yxNrbmA8g5Hw8ijKkzNvOJZr9ybn
         OPASlb5BUyBP7RjoGVznDGI619Cg+YRUQoooqJ+czmjRnTrZKRgT3FJkvxRx+5kLfQXZ
         gtbFl8BlMnqR1P6pdbYTEU91yK3p0+EdH9YunDCX/QDAY/jiLRoWu3JpY5hvJtDwM5Fy
         LWax4jU/+8Tk4TerIw7PcJoOYwiM/vfzKptUFnO5krBfZ96sM55n3SAjW1wqBOxK57uF
         QxV1nvgevNclSU0HOaQn+ABL8ahoxK8ulOTfF4geVlOKQ6p/yhyTLfxigXrAOLyed34N
         7XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NWItuYfU1D2m9f78r2wyOhs2jk9CgDDgSslfDxDFGI=;
        fh=HFE81QuBocTuN3FpCaQJMUVFM20gaJMlxqh4vTcUjiM=;
        b=SebgILPO9hCtOzXjGL9Uhc1mtrL8+W4voBJaRwBPlu3xiG/zJFhwQAlvzXObtrkA/g
         DLx9I5naDw7DjyVkBGwLz3wqohsGJUAbs8yAA9To+G3VckiqrkPJWhNRvqWJFsME9P0K
         MT1FZZNTl9i4dK1Peli0v7txU5JgRLgqy6z4EwB2OROzbB25Vl/SNbHq2GcStphWMqDV
         Qq/YX3kcf7x46TTc04LBtLd/ePuwd4svAFblA+PWKU27Y8rhnIlRB459RoA9zOC1rMfo
         IBWvDPJtcscIQAYWWKX8++dgAitYEHdcH38H+g2j5Em1l3NOLyMNN4UcswgyYrZ8vd2f
         edFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778884361; x=1779489161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NWItuYfU1D2m9f78r2wyOhs2jk9CgDDgSslfDxDFGI=;
        b=dJ3hP44/Jnwd0Q3/ano0vVyk002zJ/PZa+2xZkPlPhbSAwiMMsANvdHmI/BUsigrI5
         7I2ODsBUskocwwuRd/6/q9CEP4+ay6SSVEMOfPaO90XsdhcEyq63gdyckXVOGQ21Hyx6
         qNj4Ic8dvkzfx2/mW0k6Fay44xl9aPglCQ5kcOhaiQOmTYwAqGBQjjFi9WlIaH5K3sQA
         N+gprbl180b5ZeKMNql2YLiOaVmnxUknF78/bs9UjBcAV8zQkizR2blrznf5VA+YaVuA
         DyrP1mhhzPRM1vkeequAJJ7dYA65gwrbRaThzioDImDnRmW1KLYNHcSUAU5+BKgotIfn
         kTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884361; x=1779489161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NWItuYfU1D2m9f78r2wyOhs2jk9CgDDgSslfDxDFGI=;
        b=XDfLx1lLx2b9Zx5oyH6dDASbTXQNtTt2FGRAxRwijVkGZkOugERIE36LXPnUtMGMKN
         NY8PWHHCT7Zh78DScmQWWoDgj7fFAY+r8sgdzTMbxov1PKSOsasO6TMdAVUWYPWhuYlr
         Mo6EwT6YRIhaBCMCj4868e0U1ahF6XJd3n/7vetWfmjpHFomfVEyVliY5afsznsv+H5x
         T9gATLjM7nMXlanQ0vHX1JUlafWHP+0lor1EFDlN7ETJtjJrO4Y5JzlCFeus5LCIYph/
         pJLVxCF/NweGR1i3rmjo6ZuOpSWOQfJtZflCDUHnutUOOt6F0EWZU5tKaUhLHJT1Q5Vc
         9pCg==
X-Forwarded-Encrypted: i=1; AFNElJ+/vw3gZYhuV9eGu/yR/KXqtXkSq5vvWA5VqMeD8F7beIZjXMdbFL4q7AhEBEFbQZchZVVe6Ztgwn8ZcXX6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3lVkd0PUN59gQckJ7aticRC6tW3XGARA1AYZhRPSRM221nif
	gyYMthS1p45xtSdVyu+u/D0fNHWpA7uzF2pV3NLi52xKxkeaPcnTz01odO4JiLd0K4xs/c630Pd
	TXd1HoSL0LhCElcKcBKqjaKtff9D6LnY=
X-Gm-Gg: Acq92OEZzL1yvzIEhHPA+GSuJlPx69OBuvSgHnCUxApHsy2ru12ZJOmC4rlKyacWOsm
	OGqCl3/bY/O3GORFFU3LFYarg8n/f4YXFyc0pujdMW86bIyeR+USqjHlPCxeOaPF7zCp/AGTEXH
	GiUui2UyX5LmkuQwhxKD+dujOhKm2ZEaMDWaaQtCbMqiat70DwOO8EFEwAo0yLr1ec8Elr9kcKy
	clF/tBOtf9CVYqlYE4yuHsRo6dD8nsNoLIv99/cnkW3mGJ6QANwR9qTfvh5HNZGM+CFZ6rZ2u5k
	Vph+gY+WoNm3nx7U
X-Received: by 2002:a05:600c:a11c:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-48fe61f27famr58024205e9.14.1778884361132; Fri, 15 May 2026
 15:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
 <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com>
 <CAJnrk1ZvB-R3Szn-VxOZvPRgX_dXwMLouBphnT9_URCE8SxTvQ@mail.gmail.com>
 <CAOQ4uxidwSn69A08Urue7S7n8wrGQcyGuvRL387pD+rpSFP-Ew@mail.gmail.com>
 <CAJnrk1ZJ1pVWn21HZATRes55RJD0F0+6SHbq-8FojPutQTiW6Q@mail.gmail.com> <CAOQ4uxgDGuFq=Szw8G1BMuhuBhZ029kf+FrVq6y2Oq+gaQ78sA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgDGuFq=Szw8G1BMuhuBhZ029kf+FrVq6y2Oq+gaQ78sA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 May 2026 15:32:27 -0700
X-Gm-Features: AVHnY4LNM2kfTA98WtS7ujLuT4FWn5GAgg_YH63gClGBZqE1ZWJ9NzSsXR_V2zc
Message-ID: <CAJnrk1YpbLMCM0oUWBBp1t-zfwneWhyv35ckc5JeNxs=SXFePw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wOn Fri, May 15, 2026 at 1:17=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, May 15, 2026 at 1:24=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> ...
> > > Cool. Let's get this rolling.
> > > I need to get my test setup back in shape.
> >
> > What is the test setup you are using? fstests with passthrough_hp or
>
> Yes. *was* using while I developed the passthrough patches.
> Didn't run it for a while.
>
> > are there other tests in addition to that? If there's other tests
> > you'd like me to run besides fstests, please let me know and I'd be
> > happy to do that.
>
> Nothing beyond the libfuse test_passthrough_hp sanity test and
> fstests with passthough_hp.
>
> >
> > When I ran fstests yesterday with passthrough_hp, I saw generic 683,
> > 684, and 685 (dropping suid/sgid on fallocate, fpunch, and fzero)
> > start passing, but beyond that I didn't see any improvements (or
> > regressions).
>
> That's the last report I have on record:
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxh=3DcLySge6htd+DnJrqAKF=3DC_=
oJYfVrbpvQGik0wR-+iw@mail.gmail.com/

Thanks for the link. I had compared my test results against runs on
passthrough_hp --nopassthrough.

Comparing them now to baseline passthrough_hp (no inode passthrough
commits) on the tests you listed:
   - on baseline passthrough_hp, I'm seeing generic/193 and
generic/355 now pass compared to when you ran them in 2023.
generic/080, generic/120, and generic/215 still fail
   - with the inode passthrough commits, I see generic/080 and
generic/215 now pass. generic/120 is still failing, which I think is
because the backing mount doesn't have noatime but the fuse mount
does, so getattr passthrough to the backing file will fetch the
updated access time.

Thanks,
Joanne


>
> It speaks of some tests that are
> "failing because of missing mtime/atime/ctime updates" and of
> "failure to strip suid/sgid bits in some cases"
>
> I had imagined that the passthrough of GETATTR would fix some of those
> failing tests and to some extent, this is in line with your report.
>
> Attribute cache and passthrough is an unfinished business.
> If we could force passthrough of GETATTR when inode is
> in passthrough iomode, I wouldn't mind.
>
> Thanks,
> Amir.
