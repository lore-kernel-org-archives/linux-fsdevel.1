Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2149379C50
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535479; cv=none; b=HFlDp+QFqmckFRnFY0SFfoOIlvhGS7bdBdGzADqaIOFF3CxTFZnG7sHs8JjBLyS1dKeGM+G9vfPDJdySFn26hTjGsL916J43Cin0TVVrwEl8JroO6Znq0EqGRxr68nP1JVYg6lXkKGidfE0UPDpiRXWA2v6RtH6fwX/6f8//aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535479; c=relaxed/simple;
	bh=i2mO12QQOJ2mz4UuDmayqPHsK2P8n8l4gan0qKokjpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q3HaswKrymlLAaMFpwd7TSE5bQy/D33IrvMgV3AhBrnev2m/YTYEmCPqzLSVM+7Q3wnIpjk487ZiRCrfvZr+FzaUmM3RTTttt1/FVrTO0YVP2gF+CTDLX5/Aqux8W4Pn8ORa0p7wPWAZYH3B2j0F3nFdMSEGyL1hbTt5y5roH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIYc7LW1; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIYc7LW1"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-472365266f5so780897f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785535476; x=1786140276; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i2mO12QQOJ2mz4UuDmayqPHsK2P8n8l4gan0qKokjpE=;
        b=PIYc7LW15LqbZkuMZDZjDpDgb1MFX210iD/B31BuAI42dM5EYfOBbO/Fh10jSoFIY/
         0u1l8A5Hx7/s+GvcEcBhy8cURVeHM5Mo+PR2U7rr73gqoB0XO+TXH85kpIDxV9MxO2iF
         u5ejd1oHvPWQcEiG7F/4S55oI4uG4XLG4Fc4TUFTmrClQjiESbHEt1YOsgEWzsglrFRj
         cfYQblJxRtDV8yHUAR3tZg0wJFtDXzgtj5vCiP2rW7j2OTqYYiQy3oAnl8sPTXBC3Vgd
         TNwm9tvwJZIo2J7M9aGAO+ZMMIfT6tWgpS1BgGWNZrZbwtFrUtc2kldvKC34K9wz5nQC
         kzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785535476; x=1786140276;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2mO12QQOJ2mz4UuDmayqPHsK2P8n8l4gan0qKokjpE=;
        b=dTgtcTpLMJ3A/P5+4M9zD9KXWr9h9Eyh6mQtwXpB/2zzFe1SbnlKX0qAeIZ9WEapsi
         Ze3X4y9qJdst5eNTt/JW9/XXGI4XyUrL2JOpAoiidrb/gFodHjOujVleucvyAc/q2jON
         tzNbLN0c+ATzO5zMUDNRv8+ZCcDwXlH/hRHfc0jfWX3Hc10/Zl5W+/fHp6rRRfkf1YjN
         c+wxCCxLEJnx2zT/r8D/S2ypCaeWp02Sa8dWtsip5+iYG4EWuT0fqKJ0z7tbq9WY9wbi
         hsF7R/dDIo9RSAt7mUOKQOFs2ijs8uKyCABT0FvJfqNGao8h22S/KQQgWKRH6VYe11OW
         PkVg==
X-Forwarded-Encrypted: i=1; AHgh+RoEdRk0jZ0T+FpW4ZFkosFvlXguNIvFyR9l9iAvepd+oFa5ghCNTkCuM8v3UzPul/WuxUrK8viuRpA8Lbmx@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFGt9gd7+uKwJ99v5udnKnr4WvIZnGSxIy9lfGiFj5w0Dpmxb
	mjB9PfgACnJ55bOZKpfCsnddmJZuQ3+StzcNAkhb5RAQ77x236cWJlqv
X-Gm-Gg: AR+sD11+gGAz7AUwA0CaD4eH4eSVwE3qH532A3MvyUFQVAG5r4g9tG6fH87huYUpZEV
	rd/FVvS9ofDmbAp9cx6bLC/ZXzVvmWifGf7tWKYcYYelXn9uLJocgK8Q+OA2GnylDCvmFrVVJn9
	0+DsNQoZKL/yXbWe3dFOQMIgYrODQ5jW021YFYx1UQqg4IuyOFFrqRD3YYoo5JTb3VAM8VaUIia
	NMkQV7jVIY9bVRof+lnrdQJMWiNPKjR1uPCJmokEQ3rOIcdTjToA9dKthKu7eeqyP+2191kJ0DC
	Rje6vhyhpRLF8RsrxxAik+EoEkVhCq0tptHQwZ8D7P729A5oPSLkVV1bn78Oa/OD+98oQcA+FoJ
	RZpB0N/JE1VhecwWKeWNXTJikkBuVOzlKH7WBe8rJe1SER0aXhxeZKib7Ay6oYQXV8UtQF8cgWq
	CscbLc60XeYEtWkvd7J7XelM9SIE0mEq0doKnb7lq+z0DIYYCTgSbN3JsA8zytnT+UOKMjBFm4C
	QbxQZX69Kj+XNNHuippeGScfFSnFsMK2x6uFmR67PN28bcVJ8adSht1JojHt5/4K4pxqlv9nRLU
	0FTUNpphyQhdrhJVfOOoUaAC9MA=
X-Received: by 2002:a05:6000:2707:b0:47f:7005:285e with SMTP id ffacd0b85a97d-47fd72f988emr1633857f8f.53.1785535475666;
        Fri, 31 Jul 2026 15:04:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm9623006f8f.36.2026.07.31.15.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 15:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 00:04:34 +0200
Message-Id: <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
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
To: "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
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
In-Reply-To: <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>

On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwive=
di
>> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya D=
wivedi
>> >> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikey=
a Dwivedi
>> >> >> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wro=
te:
>> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore =
<paul@paul-moore.com> wrote:
>
> ...
>
>> I think you keep forgetting that you cannot unilaterally decide this. Bo=
th VFS
>> and BPF people have told you that it does not make sense. What was clear=
ly LSM
>> specific code has been moved under security/ already.
>
> I'm charged with doing the Right Thing for the LSM framework, and in
> my opinion it is in the best interest of the LSM framework that the
> kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
> VFS kfuncs live in fs/bpf_fs_kfuncs.c.
>

I think the "Right Thing" would be caring about your users and the project
moving forward, who want this functionality, and figuring out the best way =
to
make it happen while working collaboratively with others. Life is full of
tradeoffs.

Instead of dictating how others should bend over backwards to agree to your
arbitrary rules on code organization, which they don't agree with.

Everyone you've pitched your idea on code organization to disagrees with yo=
u.
Yet, you remain adamant that it's the only way forward.

Materially, both you and I know nothing of consequence would happen if the =
kfunc
stays where it is.

As a consequence, everyone suffers because they first need to satisfy your =
whims
on how all code and kfuncs written thus far are wrong, and need to be moved
around ASAP, including the one being proposed.

Not only is that a disservice to your users, but also people who've reviewe=
d
code (apart from you), and more importantly the person who worked on this p=
atch
set for several months.

At least a month ago, you had the good sense of not dying over this hill.

> [...]
