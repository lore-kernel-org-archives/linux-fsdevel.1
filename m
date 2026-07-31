Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63955380FC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539657; cv=none; b=f1FOQDqW0CKiTImb9G0Aqe8YccsjcICA6/iln7NAcREAhvBKC7YNyVjzebk0yWmMXbQfp2VYHKkpbmBXZxeGANUAEgAJn1VLOVkSvjR7fe5uCYcbKoLKM8hfKbWmWfBHP+HUvo/N2uSE6nxbMjdc5DBWuWGBPsR4+WAex4KF5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539657; c=relaxed/simple;
	bh=+S0UPkmId1TSZGn0c6a353pKJFNhAIT5tZF6ghKKlHI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kbUQnjXnr2KJP+yF8mmvBRTLw53HinaM3jUSgUsGpHqVGEcicLhhK8ytg5k68asF83IFqVmgv9rRSC14qWZq+UkSz4q59HJuBLZFVaccT4uwjQjMald1pw3JG9iTRD/cFIrDEzXfh1LLo6kEOtV1qXw0hS94++0NcB0RM+k4zws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4/QSP+j; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4/QSP+j"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so773855e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785539654; x=1786144454; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+S0UPkmId1TSZGn0c6a353pKJFNhAIT5tZF6ghKKlHI=;
        b=G4/QSP+j7FfEMdPtuV+R+H08ZbGG2ieGR4LiA0ajPuzDG/88EpBTWuSV5NIptCXm8d
         t8NWyw2o8vK6Ob58RuiKrOemUkDE5uGCYUacLFII5MU6MNkzOhUawT0+tMbdEjB3EYLL
         knc5hCSFQeYyXFqYtYmSDx5cjkkAmJwROUTdEi9kZWXdyzvU4DqLWuYgjS9bN8+f+v4l
         PRWMnuAWsfmgO1lTM5f0lqkFh859bai7amlxSMbz/432AUOkDPM0T9AWH0mG9foVVYu6
         lYHLrvfRY4PBH3E8ejTyAy2ONp21w2dPY2VPx40wgt+ccJ4ZlY4Rp/cra6Xz88c9+hkH
         PYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539654; x=1786144454;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+S0UPkmId1TSZGn0c6a353pKJFNhAIT5tZF6ghKKlHI=;
        b=Kt4vvWiIHtqcBYYY4sF3N825uBQPli5/u7AUKakObf8UNAGOY1Ng6VSe+ZqgmnKQ93
         oRqh9fvsBia4InBTKZqbgqb7D7tgsS1VHeCc7p71oXGXwKBnsd7sKWuJp2ImpVWUlcoU
         wjxlwVyl1uG2hLHSZpGxWzx9R3YCsSPpSHUJ3JO+AEY7zb8DsPuvjNq4vsUFuQbpzkBt
         0LmLlFE7vnDWJ29aFnuxHIJB7elpabH+hbv04iWHG6M/tZZO3gRWGOwG3c3d0jUhMRxa
         L9wdblzW3e50mrp5nRZj5S8A57Kip60YJgg12Y5Ao/kGk3Hl6ruE+rD/ExdkE5iMvswC
         a0Uw==
X-Forwarded-Encrypted: i=1; AHgh+RpLXE7COsj2tQJ4Zc4IWZ11BT8WwGjSkSXxiaO8w69DFXajT0W45A5exM9hsOb2PVrMynjnXWj5dc5uOEpo@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYhvdi/ehE3qioRCW7In47fPaj4m9AY6blPKkTuzQ9ZJ/JiML
	i6lpEXIVsOeDYrtwyjtJJtzurAOZIHNISOjOt25HwI6JGO091GqCOlIG
X-Gm-Gg: AR+sD12yqLHRlXn845q/ZDZbvHTMpPGU5A0MUKMnLWyRxGU6RC5nxcTgQWtp6bFeDPb
	ND/0B0hRRkl1OzfroRuXvwRU+1Wy6ILBzkJd8HtUZc7ru0g6re0RfApQ5iM+9VKCU8ku2pci2bF
	NdM0H12l5aruj2/xjrUiDwyuRwBWr/silc0Ws6z1sbc6+4VyQzpGrsmw8EBR+N2fJXge3Ug+kl/
	V+C8zn4c1dpZV70lbZiQDE8lByQSm/Kyh2OQnu715V2XATcGWMQtZL1prjPnAUscGMTEMDDsl7U
	srfEqvIUK8GMFp2u/VHv+iQwFqPJgHKq+A+9pdJnQu6oZrxRLp9qJD3uH+Vjqy0W+4GWsrO5dvO
	kass6cPzYpqTjRNaKjLnNC5L6Gn6/fEekyyGWtds7O2H4HBgnzFeYx6Ry8lQrq41rMKENpnbhgn
	Bsl8rpkhXYUOsRLmgzPhIo/zmhhaW6US19xNLg05wgVvgMG83LT726Q3iKPQjGXwNEIx8qM1D8f
	pIVgoAbUc3jzXz4L6X8gF6bwdXy0KHHvnjmhK7QvbB47R4MM3lquV/q9BlWDaatpXJJysw05gpY
	M4YueyJiC4FyN1vckY34OB/5zQU=
X-Received: by 2002:a05:600c:5248:b0:495:518a:d95a with SMTP id 5b1f17b1804b1-4980c6a71f7mr1306545e9.29.1785539653622;
        Fri, 31 Jul 2026 16:14:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807ba13e9sm4158835e9.13.2026.07.31.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 01:14:12 +0200
Message-Id: <DKD4ZCN7VD1S.35BTQUNWCDS96@gmail.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek"
 <omosnace@redhat.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Casey Schaufler" <casey@schaufler-ca.com>, "Paul Moore"
 <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
 <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
 <45d2738f-de04-43cb-b37f-4370e6232678@schaufler-ca.com>
 <DKD4DITNPLI4.3FIHRN0PC58RW@gmail.com>
 <53a2d62c-fad0-438d-91de-a17b5921d61e@schaufler-ca.com>
In-Reply-To: <53a2d62c-fad0-438d-91de-a17b5921d61e@schaufler-ca.com>

On Sat Aug 1, 2026 at 1:01 AM CEST, Casey Schaufler wrote:
> On 7/31/2026 3:45 PM, Kumar Kartikeya Dwivedi wrote:
>> On Sat Aug 1, 2026 at 12:27 AM CEST, Casey Schaufler wrote:
>>> On 7/31/2026 3:04 PM, Kumar Kartikeya Dwivedi wrote:
>>>> On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
>>>>> On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>> <memxor@gmail.com> wrote:
>>>>>> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>>>>>>> On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>>>>>>>>> On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>>>>>>>>>>> On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwive=
di
>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dw=
ivedi
>>>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya =
Dwivedi
>>>>>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote=
:
>>>>>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <pa=
ul@paul-moore.com> wrote:
>>>>> ...
>>>>>
>>>>>> I think you keep forgetting that you cannot unilaterally decide this=
. Both VFS
>>>>>> and BPF people have told you that it does not make sense. What was c=
learly LSM
>>>>>> specific code has been moved under security/ already.
>>>>> I'm charged with doing the Right Thing for the LSM framework, and in
>>>>> my opinion it is in the best interest of the LSM framework that the
>>>>> kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
>>>>> VFS kfuncs live in fs/bpf_fs_kfuncs.c.
>>>>>
>>>> I think the "Right Thing" would be caring about your users and the pro=
ject
>>>> moving forward, who want this functionality, and figuring out the best=
 way to
>>>> make it happen while working collaboratively with others. Life is full=
 of
>>>> tradeoffs.
>>> It certainly is. Paul has taken a stance that supports the ongoing main=
tenance
>>> of the LSM subsystem. It does not have a stable API in support of the r=
apid
>>> development of Linux kernel features *outside of* the LSM infrastructur=
e. That is,
>>> people like you. If LSM hook implementations were spread throughout the=
 kernel
>>> code it would be much more difficult for poor hobbyist LSM developers l=
ike me
>>> to track them down when making changes. Changes like the ones you requi=
re.
>> I would recommend reading the patches before commenting. All LSM code is=
 under
>> security/ (patch 2), as it should be.
>
> Pa-lease. I have in fact read the patch. I disagree with you assessment.
>
>>> This is about being able to continue supporting the latest and greatest=
 additions
>>> to the system. Like yours, io_uring and the network protocol d'jour.
>>>
>> I don't know what you're on about.
>>
>>> Please don't lecture us on collaboration and trade-offs. We live and br=
eath that.
>>>
>> Paul is free to take a stance for LSM code, just like the BPF maintainer=
s get to
>> decide on where BPF related code should live. I'm sure you know that.
>>
>> Thus, please avoid justifying his overreach on where others maintainers =
should
>> keep their code.
>
> I have been developing kernel code since the 1970's (UNIX and Linux) and =
have
> a fair bit of understanding about source code organization. Without ratio=
nal
> layering and co-location chaos ensues. The BPF developers are newbies rel=
ative
> to the security maintainers, and would do well to pay some attention to t=
he
> wisdom of the aged.

I am certainly more inexperienced than you, granted. But I don't think we
resolve issues by older people forcing their opinions on younger people.

We do that by providing sensibile rationale behind technical choices. I am
constantly doing that and receiving unsubstantiated wisdom in response.

Common sense suggests related code (all xattr kfuncs) should stay together =
in
one file. If they need moving, they should move together.

There is disagreement on where this file should be located between Paul and=
 the
BPF maintainers (even VFS maintainters), therefore Paul does not get to mak=
e a
mess of our code.

Having one kfunc stay in one file (Paul's suggestion) while others are in
another file is the worst option.

There is no layering violation, all LSM logic resides in the LSM subsystem,=
 with
clean APIs exported for use elsewhere. I am sure you don't consider BPF dyn=
ptr
as LSM logic.

The hodge podge state you're arguing against is what Paul is suggesting.

Thanks
