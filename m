Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE00538D68
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058626; cv=pass; b=jvOMuaUYt6S+C2eEdxsLtYy68tvISILG3PIQStzSP1jrwayki1axOi1UfRgvCr+KVwKJO/o0n7/nH5sMrOlXFUkHA0lEtR5UNdOS1g960Z7M57VEEMQylIn5DYDWtadvkcCX0tCVu0O3FrirbT0dhg2kFD3evOpneC85/p+o0ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058626; c=relaxed/simple;
	bh=XSjSfL3MHUiRLRuOzCuGpIIJwn6EVqYHbmmBx0eES68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my2EI5QIfhYS5CstdXVCVk3IKx/JRoaR835xRqA0Vo0p1Ij6BRprukXEBvMm9w/yHgczOxSkLjuLLC6/wul3CNY++lzkUtuAT8jUlQlWos3qbW1beI6/oS0/iRCSD2x1J4rtB/hSsUioa94n0OLf/YSxECaFVxwel1KdeVk1ZqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niy3X+Cr; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niy3X+Cr"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d944747d41so82089665ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 09:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789058621; cv=none;
        d=google.com; s=arc-20260327;
        b=OYNATLXZjzD0JKnWKRE1D95HijIYb9xjexOyHlw8Uo7KVr7Px7+X/TKgYrawElL/BZ
         eXgWcMAsiYB7Vt4XUTSPSo9mFqzS8rmd2VD+eD13QyrxoRpTD5IsR+W/WwbJeAxj78IF
         6jdVN5uauYQ70+jL+s/ai5Q/H3aqXa2VpQL/TwWgIcZ1V1lQFn+7Wyqx7yxXdIdNJzfA
         BNu0MLhkbzz7n4MZr1oV9lUrtCYKTTy0kDMra3nqKOkWxgrwAJbkBz1deq5c19Lbmyi6
         9XA2jwmce8GBsLO50HVcSHBr0au3EkY4jY6v9C5fO15iJAJvc58SEz5fpkE9q0cnKiZ2
         aveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4shC7pjynJ5kG9MuGK5l0xuaNhtj0CX2M7NZMyhYJ2M=;
        fh=qlr7gvIE6GyP4Zrz8jL/xuA/4ANZj/OUlRmLYtVhGyY=;
        b=gZ1vG7NKDvD0ydc6+I2SjnurS4t4D9G6JAD5g20XZpFlc+277WSthVtdog2J+4MMZp
         xv0KpSQZ+HIt3Ke31QdT4F1qxx6RfLQSGv4iem/a4ItOEmrcL2FB8s299u3JU79Myx24
         QqZLtSyjwR7Qmfitu7PJTtUrXhiijkF86YmAKxxoDKJ5ASHmdM/hodfCIXvUnr/S2tni
         H/2FDDAjAlnHUoElZCeCZEFS7ArwOZNlN36bTQ5sV+rrul3UoJLaoSA7qqNzUYqny2z/
         Xn6wwoRF8edX8sIwIuDICgux8HXl2zV2twBTIp/vvzQ9WB/HcqBEwxgspfPFz6pZA0/a
         VVVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789058621; x=1789663421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4shC7pjynJ5kG9MuGK5l0xuaNhtj0CX2M7NZMyhYJ2M=;
        b=niy3X+Crm3HH2JXHAjZSz4fR199uUTHN41gIk5FOI0IvBWmr/CLIvjWwqzqAGC73x6
         MAYpTwL6CxKgShjf+VmZlAsCU3RUD5qLhLFMgmUJrz1Rq8xt8bzJt/oQ01noLZXCCJfo
         pUIvdw0kvs0XZFrIiedQ5e/jQasenxHjm7UbQA8Yt7ihhtPVdGPTcsbZKYWkzBUP7CfT
         03Vx6zwmTWGORMhj7QJp9vL2ZpSpDvpcqEVk6ufwJGV7IR1NgpD78AhTd8T3tNVF5BeN
         sl1h5wmDtAkI23QBbb7x/SGDmICAhB99NJdzn2e2zVloOI19IfZ1g+pR6aHXSXECsElH
         2sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789058621; x=1789663421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4shC7pjynJ5kG9MuGK5l0xuaNhtj0CX2M7NZMyhYJ2M=;
        b=YXBSO8nYJVSNd2D0HKsE95lzDJDI86pXLKMoc7mFqfNUUdKCRtG+kVk0PD3q5O0F0p
         D36KM9QbGcORBVdFdA0sL/ePQz2+1lPRf8Y0kJaptXUdasFxjh1+c9kbRxpAZrtVIwPN
         mdqebe5MJ7VwXdAmU8yjOk6XIViGY0ZEhk+H002Ef6Sy1qxQbzh0NsxpBiz3KbtlG3c9
         zmWXmkw49syhcsudvOQnkxdu4Al629n9OxiVypdQjAIswdZY57Lu8lzRF1CF6B/QRgEY
         VIobeFKRpQB/hH70GmHIvU00m1WqHT6xw3U5lR57ijM/hFYnR8CVHfTl9+33pgqxS+4F
         EIUA==
X-Forwarded-Encrypted: i=1; AKwUvBxWucqDq7KQhrJFIzfEOF0mZfGgr/lQZdfkbYIEEWBmxISexKMPFUeC0VCFbZ7A1V2YmASZ0LvIweYpvWm1@vger.kernel.org
X-Gm-Message-State: AFuF++krxzFcJDWCt7x5Pp2u+17OQDBo8L1DClfsN+T7CJdB/Ly7py06
	J5EN9+SFrZRfdiuAn4qU/0CrWEj9czws5k8Kjdmkw4HbQ4qVi2KGTEHV6JzTp+/fJy3guwETctE
	YY8u5e971S7fx3GNrzpLD7J3Xwl6yc53qk4c4DYZr
X-Gm-Gg: AYBFou1npk0bJsq7MstLSPyM/FlTFU/71XeAwVx1309HY6fNruOH1tKP1/G/HZgREmA
	4kTzikEWl12VkQgZBazqOHfcWivBtqqW+eZ0/Mt1SpPKvCMWBfm50DLHhNBlGqWRMLqov4E5ASj
	4FR+vmnFdunbGZIErawKOlOLM8d9vBHDnmJBv7LCndv+sSJOS41ieJKOuc7t0pU97RxTt48iWVD
	vSG70w9Vr5gLqToNZGJR+n/+8ctZLovXm8ZI7DpYiMEIZtA2q4nvEGLfQDqNRb/pgbInqWWwQFX
	VlydoLdnBB8XcJCI+KT7mUQiD8ncH7Hp+53pKung1BxUrzzObpOhMKmBltHDq5Q+oDvarEu+xGc
	FkyuNuCz2QZROy6kUWEoD9w6Grc6is1ayH2DTeIdwKRl6bAu3vUCpg6Nx7SQeWUak+f7m7hIU54
	8Y4HrEgMgjYuW7uOuDCLGDHQ==
X-Received: by 2002:a17:90b:35d2:b0:396:d28e:bd8 with SMTP id
 98e67ed59e1d1-39b260fe242mr65737906a91.3.1789058620711; Thu, 10 Sep 2026
 09:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905233819.1064529-1-kuniyu@google.com> <20260905233819.1064529-3-kuniyu@google.com>
 <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
 <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com>
 <skrtuyahssx5tvphmvo3kbkqy475re5yeb2kdl6luf7kmmfqad@2gsivqhqwtvw>
 <CAAVpQUDOXfiVyuSgJ5HqZ=xX3aBM+Bar5i2Gmf8ur+jBT-74yA@mail.gmail.com>
 <yjcicbo7okgpkd6gh4exgagt2gkklnkbivq34i3ypksmnooxb4@3t4jfy6grwog> <l6n6b4hq63qvrefys4chliyip5kezzxuqrjz5wbtg3ulb4dyyp@zvfh4mov2q67>
In-Reply-To: <l6n6b4hq63qvrefys4chliyip5kezzxuqrjz5wbtg3ulb4dyyp@zvfh4mov2q67>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 10 Sep 2026 09:43:29 -0700
X-Gm-Features: AcwNN1W0Tharu3ivOESzUz_sjvxbrqFSJKW2g6zBClxbUrTOIJlBrlqyxCcbNuM
Message-ID: <CAAVpQUDtfWQVBj6Vhtn1wGUZz4H46XXuit_G=YyxrJHUxT_=_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:45=E2=80=AFAM Joel Granados <joel.granados@kernel=
.org> wrote:
>
> On Thu, Sep 10, 2026 at 11:04:12AM +0200, Joel Granados wrote:
> > On Wed, Sep 09, 2026 at 10:07:53AM -0700, Kuniyuki Iwashima wrote:
> > > On Wed, Sep 9, 2026 at 6:44=E2=80=AFAM Joel Granados <joel.granados@k=
ernel.org> wrote:
> > > >
> > > > On Tue, Sep 08, 2026 at 11:44:08AM -0700, Kuniyuki Iwashima wrote:
> > > > > On Tue, Sep 8, 2026 at 5:15=E2=80=AFAM Joel Granados <joel.granad=
os@kernel.org> wrote:
> > > > > >
> > > > > > On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima wro=
te:
> > > > > > > Since the cited commit changed proc_doulongvec_ms_jiffies_min=
max()
> > > > > > > to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax()=
 no
> > > > > > > longer applies the range check.
> > > > > > >
> > > > > > > It happened probably because do_proc_ulong_conv_ms_jiffies() =
does
> > > > > > > not have the _minmax suffix.
> > > > > > >
> > > > > > > In addition, sysctl_msecs_to_jiffies() casts u64 user input t=
o u32,
> > > > > > > and a truncated value could bypass the max check.
> > > > > > This is something that is orthogonal to changing to true in the
> > > > > > proc_ulong_conv call. Please put this in its own commit.
> > > > > >
> > > > > > This also begs the question: why not just use an int converter =
if the
> > > > > > range of the values is going to be u32?
> > > > >
> > > > > I guess people wanted to use ulong just because jiffies
> > > > > is unsigned long.
> > > > >
> > > > > Looking at these users, none of them need the ulong range
> > > > > and it can be u32 actually.
> > > >
> > > > Exactly. But changing those calls from ulong to uint is up to net a=
nd
> > > > parport.
> > >
> > > Agreed, it should be done in the -next branch of each subsystem.
> > >
> > > And later, we can remove do_proc_ulong_conv_ms_jiffies().
> > >
> > >
> > > > I'm more interested in defining the behavior in
> > > > sysctl_u2k_ulong_conv_ms.
> > > >
> > > > Here is my train of thought:
> > > > 1. u64 values will get truncated when they pass through msecs_to_ji=
ffies
> > > >
> > > > 2. The range of msecs_to_jiffies is:
> > > >    [0, INT_MAX]          --->  ceil(m =C3=97 HZ / 1000)
> > > >    [INT_MAX+1, UINT_MAX] --->  MAX_JIFFY_OFFSET
> > > >
> > > >    Which I interpret as whatever that falls out of [0, INT_MAX]
> > > >    milliseconds is just infinite jiffies (MAX_JIFFY_OFFSET).
> > >
> > > nit: for HZ > 1000 (IIRC up to 1200 ?), the max of the range
> > > gets a little bit smaller.
> > >
> > >
> > > >
> > > > 3. All but one users of do_proc_ulong_conv_ms_jiffies are bound to
> > > >    values under MAX_JIFFY_OFFSET. The exception is net/rds/sysctl.c=
:67
> > > >    that has a max of ~0UL (is this too high?).
> > >
> > > I think this is just set as the theoretical max of @jiffies,
> > > but not specifically for the knob.
> > >
> > > The default of the knob is 1 sec (HZ), and even INT_MAX
> > > (24 days) is too high for RDS reconnect.
> > >
> > >
> > > >
> > > > 4. Since milliseconds to jiffies should be capped at MAX_JIFFY_OFFS=
ET
> > > >    for big values. Should we just return MAX_JIFFY_OFFSET?
> > > >    Like this:
> > > >
> > > >     diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
> > > >     index 213ae1d6a014..400353b0d6f9 100644
> > > >     --- i/kernel/time/jiffies.c
> > > >     +++ w/kernel/time/jiffies.c
> > > >     @@ -136,6 +136,8 @@ static int sysctl_k2u_int_conv_userhz(bool =
*negp, ulong *u_ptr, const int *k_ptr
> > > >
> > > >      static ulong sysctl_msecs_to_jiffies(const ulong val)
> > > >      {
> > > >     +       if (val > UINT_MAX)
> > > >     +               return MAX_JIFFY_OFFSET;
> > >
> > > Given the nit at 2., it should be like this
> > >
> > > if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
> > >     return MAX_JIFFY_OFFSET;
> > >
> > > as done in _msecs_to_jiffies().
> >
> > That is even better.
> >
> > Please send a V2 of the 3 fixes discussed and I'll push them through
> > next week.
>
> I have created [1] to test the fixes before pushing it upstream.
> If you are ok with all my changes contained in [1], there is no need to
> send V2. But if you want to change something, do send it out.

Patch 2 has a typo "incorrectlry", but otherwise looks good to me.
Feel free to push them with it fixed.

Thanks !


>
> Best
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.g=
it/log/?h=3Djag/sysctl-fixes
>
