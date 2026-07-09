Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E42D8378
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570080; cv=none; b=DM0EAWmi0P4aTVW0RAIWdzBXRj1BnJQPQXR2Pr2rUKt/OOqLv3L83OGEqGrBy2XMtkLZcIJshdwCaygP6yovarbxuFuua+RA0BZRPNjuwRoVH9q0MjQ2rYHpyYPYf1XAemdJk9kuks/rFKfQ8peKS/oaZOdEAzeAhAgm01tFzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570080; c=relaxed/simple;
	bh=Crtfz5KV1Al7PMtvIhrkTgnEZORSLTlbXnKkW2fA9FY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gc93/cWTiYYqx2OQpehG5EDcpXDvLO+5UkBLSLnK8vooySHUHXQ/4cXyMx4q2ruRpb3AsoAX2XgyaOJPOiss1OhtOpbezx47bRoFvFiNVvNPa2G10R2rvyO4FPIY76BhAyFb7L2yizohgnbvhHLuDfQxXXRbIVjXvfNQdWh7/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oy0Ly8sn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oy0Ly8sn"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c96c92c0980so866499a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 21:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783570078; x=1784174878; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HyZ+lDUPV2qqTCzi6+PUCRvlBqToBMfsYAo+J6mLUsA=;
        b=oy0Ly8sndgAs8L5ihF4YwVqkhMvfxEWnBxhWZAgJHduZnywoeMJos6nSs9oNKk/aOK
         GgC99jD2Jb0JM8t78/qL7pwBxNjPoqUVIm6zit75VdB34UVVFTnJbNX4Iz2Aq72emlp7
         6citr+t1WHpxJe0HHN1dyVrZdMHAC6MO1/8X3FGi16vJ4xF3JZeqxbAbeWjxTI+lwyHg
         M0ucKnP1OC9FCimv+6Mhz2u2jgz91m6D1Kg45XFamw+jNlaPx2SBkQ2cDcOvYePlWYyJ
         BJE159/DjZj0hi3vrPKrrw4t6aAwya++YGirFayUyS8OhxpgOy9+qme8QfIFa8EF659Y
         3TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783570078; x=1784174878;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HyZ+lDUPV2qqTCzi6+PUCRvlBqToBMfsYAo+J6mLUsA=;
        b=VFwS8WrHVWubeOV6xoBN/j9UJ21crfShvQAQvCR73Iaj+CLOi7Cq6MShN7j0lp1nby
         j/LMx78LhUm339GTBet9Agw2iGJg6CR9TZqypFkKaZ+in/D/7mxcwdu5hLrBr0tuJYOh
         PsOOmuANBboN0JWTUE6Eyg16JDyWWaxu6LOOolkBkZzencqml6ouQP3dqbMNwb3dVlRs
         cc2kHweRgexfL9qVxDNI8AjCmmMpxmsMrsMHp2zI5vjUsKCOp0q9BYmj4HftIABJx+WB
         T7ESwQ8EfJRHxKXfKD8Nr5JvIErhyt7mw5zmRa8WP2vOxNugvQJZDHHjfKlfznFo17q5
         HFUQ==
X-Forwarded-Encrypted: i=1; AHgh+RriFwcBZR0ZzdpIqz9Wtn5+OIVL/dusUKmnzIQEyzpWB9ZwpDijXPg+KyLMdiybZYuiQn62vTpOMxMYRq0G@vger.kernel.org
X-Gm-Message-State: AOJu0YypZKjD9jriacLbj+4tA2cVH5XNOvaH1PNMFpq38UkiphGHP0d8
	ADmcrmdyVM/zjtRu5H3KR6N26u3a+uVip+mGSe86uaJFeDmUR2AKEyI2
X-Gm-Gg: AfdE7cmKbOCJef0Du/XNub7VPBCvJrTWKyp4o/ANpJq9LH7yNlUYtYvEJ6accJ0fXcE
	+En2EPUskPuPUfF7IznaYBYGh7aI5paGYM1lTk4qkAlOpJYWEIWk9+rhOkulTvhZD0x699YjVf9
	v9q+uazLeAnpoDUb8Ji5Ni05aaxoUmQmLQmYvEM5iwkOjzFC5YSuWruja+ld9P69cpOG/iuYff+
	7M2LmBW05WzCeO0zmH9LPVTEFkRDSTPdFv7ylqihNqu9SBWgI1TDra3VPJuLG5FsbrDz5vtNa6K
	c/uVwA653ltaCUD+R/uW2ss/EpnZzk9ftO2zHpRn/2kOgyHknP7VNWrm5b/jc8t2bFnyJveqGde
	jwdR0+fJSBzl9Xg3x0t64MjfNPec/RUkscTuG4aBqLJvvGJDkdx791128HFdIxD4LmRDz+Q+R/3
	7/4LPBf3EI4lIqhw==
X-Received: by 2002:a05:6a21:690:b0:3b3:fc6:622d with SMTP id adf61e73a8af0-3c0bcb7e418mr5738391637.38.1783570077959;
        Wed, 08 Jul 2026 21:07:57 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b65960d88sm22118188c88.6.2026.07.08.21.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 21:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 21:07:55 -0700
Message-Id: <DJTQTPG7QZSH.1YIDYKL3O985U@gmail.com>
Cc: "Farid Zakaria" <farid.m.zakaria@gmail.com>,
 <david.laight.linux@gmail.com>, <jack@suse.cz>, <jannh@google.com>,
 <kees@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-mm@kvack.org>, <mail@johnericson.me>, <shuah@kernel.org>,
 <viro@zeniv.linux.org.uk>, "Gemini" <assistant@google.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260707-wortreich-kanal-zensor-9386ef4f38f7@brauner>
 <DJSPBVXTF02G.3SKLB9EO89GPT@gmail.com>
 <20260708-welken-dystopie-ertrugen-56a3b5f7ab66@brauner>
 <20260708-kordel-laben-kopfhaar-1c0dd234aae5@brauner>
In-Reply-To: <20260708-kordel-laben-kopfhaar-1c0dd234aae5@brauner>

On Wed Jul 8, 2026 at 9:47 AM PDT, Christian Brauner wrote:
> On 2026-07-08 11:14 +0200, Christian Brauner wrote:
>> On 2026-07-07 15:44 -0700, Farid Zakaria wrote:
>> > On Tue Jul 7, 2026 at 12:45 PM PDT, Christian Brauner wrote:
>> > > On 2026-07-07 13:34 +0200, Christian Brauner wrote:
>> > >> On 2026-07-06 09:47:53-07:00, Farid Zakaria wrote:
>> > >> > On Mon, Jul 6, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner=
@kernel.org> wrote:
>> > >> >=20
>> > >> > > Ignoring the blatant bpf abuse here I think this is quite worka=
ble. So
>> > >> > > this can be turned into an actual design and patch imho...
>> > >> >=20
>> > >> > Glad to see you think this proposal is in the right direction.
>> > >> > Just for my edification, when you say "balatant bpf abuse", you m=
ean
>> > >> > how it abuses the socket bpf type?
>> > >> > If so, do you have any guidance on a new type or should I just ta=
ke a
>> > >> > stab at it.
>> > >
>> > > I drafted a POC for you that should be closer to how this should loo=
k
>> > > like with the bpf people in Cc. I'll let you lead from now on. I jus=
t
>> > > wanted to help you out and illustrate a more viable direction. Might=
 be
>> > > that the bpf people want it done differentely. Let's see.
>> >=20
>> > Cool. I just saw the POC.
>> > (I'm trying out aerc to view the patch series. I will also try b4, I'v=
e
>> > never set it up before)
>> > I will rework my qemu demo to use the struct_ops and go through my own
>> > testing to see it work.
>> >=20
>> > That looks very similar to what I was researching with an LLM. I was
>> > just going over the idea of struct_ops bpf (a new concept to me) and
>> > using traditional bpftool load, a new bpf program type and kfuncs.
>> >=20
>> > You put out a surprising amount of polished code -- thank you.
>>=20
>> I would not call this polished and it also lacks any tests... I've not
>> given the locking much thought and maybe there's easy wins on the table
>> I haven't been considering.
>>=20
>> > I would have had to lean on an LLM (heavily) and from the patches I've
>> > put up so far they still have quite the gap to cover in terms of polis=
h.
>>=20
>> This isn't my first bpf ride in both kernel and userspace.
>>=20
>> > What does "take it from here" mean in practicality?
>>=20
>> Bring it over the finish line so I can merge it into my tree. :)
>> If the bpf people have no comments or worries than we're done. If they
>> want changes I'd appreciate if you could make them and slap you
>> Co-developed-by onto the whole thing as necessary.
>>=20
>> Also, please ensure that this works for all the cases you're
>> considering.
>
> I have another cleanup series for binfmt_misc btw. That code is quite
> old. There might be a few additional series coming out of this work that
> we base the bpf bits on.

Sounds good. I just saw the patch series.
My plan at the least by the weekend is to:
* apply your binfmt_misc cleanup series
  * I will try b4 with aerc. Here  is my config if anyone wants to crib it =
[1].
* apply your POC series for the bpf to validate
* make any changes if necessary or just add selftests if it works as is

[1]: https://github.com/fzakaria/nix-home/blob/aaee67c3a6d035d06a62cb753926=
57563de58f4a/users/fmzakari/aerc.nix=20
