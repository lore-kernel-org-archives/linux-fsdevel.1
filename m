Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2138360ED6
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536595; cv=pass; b=IH+MDwO7LUZbVaslowwY4EcBB91HHJOsA1UKtxCX/JXOh1XAyaCaSjnuyj8ilaxEAFREQiMqrGINrCHj/2HUz5xdRE1wZCKhzh+Eo3tsB0d+gZ3lteJsnL92sVv4HSKQE2WRbax3iwj4aPKw/9qT8XympNBo3Hv5o8/qdEdpt+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536595; c=relaxed/simple;
	bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WETIkY3hlxAH1pTrkBqB4dMY7Mr6wRJUzTGHYlx8Bl7BDy+4Ph8bh960sRZrLQ/f9jawfjHulPMnJtafYlctTnTPc1e7oP6ZdgkK1SYGQj3r+C/TwTVcv8jqzg15ZuCG1p0um4uZhxlsg5eF+mUanEhFhnVBkhNTDEPhYJfuWfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=azYAMVWj; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="azYAMVWj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso1123290a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785536593; cv=none;
        d=google.com; s=arc-20260327;
        b=FmQKnbBnaEd9cFwUgLULIJx7Fb0PB9ffrJRqLxwALnRjFkgo2bmuqAz8L4edUh261+
         ICxbxW+02y+C4G26//p/kUck+TjWu2kdrfiPWB2Bb+csNtiRNiPdVCuTeVGHCN2o7ay7
         6GuN7eicP6TldT0v25YKDHJbxAzB+jh76gYeFaK5Yr6hSmxguVm6MdWKJEy5cQZUSrtm
         veUpf+Yklv0lx8pNg3kLIv0/ljlRoQ5Pz71bVQUYzDvntqATmB0oBmwHpvJNENLWauzm
         qRqLfAAsrqJF0nxb4OaAe+xEXX+9nA7K1/2W0NKKjgDlkychMLrthPpBltqQCNODOev+
         7hIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        fh=PB8k3MK3FcRJFtr/3MNO/GkRPbINsJ3lRbrk+YWVO7A=;
        b=HMxS4iuqYJTNlj7/hiNMDe/xfMAr49bxtRetsZ3s4hHaGYqprXdbsUXQIeHaE7t0IR
         vRReFfoIfBlxUl5A7iLeAoqrZtcSQl1Kbxk9mzL0RNCRKSQXMBcND8lZLKAbzPskj1/n
         WypmXZxFMi0u1o5AlZ4wa2jWI0wpFX+SwZk/13oqRHggMn6TfYXEk3pT2XSlgw6h4bxW
         6Y0fhufkLdqD7I6CJ4iuelvOLcBKBnwnRVsufrfnQlxwlFd17WY9GlFKDDOfddqFo0li
         hxXPRvCWigBtH6/+EMQ5+RdRtfnRjHMfUr93Q9Hedv5NYDvWWSMGglW69OFYM9jHGPjh
         IrkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785536593; x=1786141393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        b=azYAMVWjhYdwMzeWcI05q+xknmIUABIj20r9StipuVxCW9z+9th7XSxJqAvVXfLmGe
         kwiyItVFAYt+/ueem29u5RRBWGKKVb/wEmoj2QlgXoncZDuBe7sHY2+mO9KYLJQkzMyP
         eZzNV/8pcDHq3R1KiUYE5q4288oLsAtCZCxriuDmXBAyNDhifmb+sHXOEmyYaL22lye2
         BMRteaBReo5RF62tMgo4B/Fz0XbfFvMDQqUJBYYrxNMBbIc0v5bNJQh42DHKyBp4+gev
         EPWOPkGDeGFMIo+IqbnsjD4/JzZJmej3g8N9b4AvPsvs9jJVId27rbMrogTfmo7xAwdr
         2akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785536593; x=1786141393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        b=HE5YRz29YNCOmjDfKOuuzfJ0XIyXPWfQNvgoFaVdzVkiJmZ2cds/RD4jClNjDLLZ5p
         2U2znVxtGpMleTZ5n1AuxdfFjsLfBS6OYH54R1jZxs09hoRNIDbZ0pmDdlCWf9fLn5oq
         M6OZgTDkU7JdxceV92vNgp7nZsJGc8FcFdFop6tMVOVasW81RE5YPNDcIMkSpcv7qQZS
         6718gI6PwQ4jkOpfLPcb75CfvWu6BRrJ+hVwOJTgafbPzo6kTahFgRXi+JTIk+SZTpq9
         YbYkU37+nPDQ+uXIW8/n7+ng4bC5TYKaDEBWBa9Qbdl7Gjn2Qf0UNqaxYot8ZRKHEC9x
         cmfg==
X-Forwarded-Encrypted: i=1; AHgh+RotvhRustCNSsOnU7GY6eWlDD2ABNAPk7bFMQt7E0h73P24lAn3dEdmsSLNKMcWnjeHqoeor7nXhe0mLgxc@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGGqDt7RxQNn4a1FFOLhWn6QvlI9L7jzM9X8Xand/rKWursDh
	9bqF5/ew2BLXEQjVsZjm0TNpIMCiNRr5ixTE8Ddn158JSCacW0CC8FiXUA5jdQQXYLsN9p1t06y
	vzsBDg9xZYjLvgKr3G5Ozbk+v6iOAZL4YYHj/AHrWK23TbUOXTdp8Sg==
X-Gm-Gg: AR+sD11fEtEDeyspzAmlZxiPWsxTap4Q3e9hHJeroXs69Yp/Rm4jeCkGeW+pyYAxJJq
	QGr6vanPgaHtKmV1wvUOCz6V9qsrDIHOtu91o/bpI7clOINl+5SJEPTQY6pHXeML283BqBmMO2z
	Y2B2fVjCR2xahIzxQk/LHPioWp8jstdPIrYWx2EMavVhqgCayPSioSCZ8LmHh9PiSNEf6AaIprk
	hxDfBlh3gDnWlZ7eamJPJy3CD9C7Wpcq6QXZ1ZgRhet+8qmlvu5RKE4xAgesOCkSd/zyu34pLfi
	/Ft1R8hxOzQ23GNN50kchW6uId+yNpiOG+50yyrkeW4o
X-Received: by 2002:a05:6a20:e20f:b0:3c3:c3fb:2473 with SMTP id
 adf61e73a8af0-3c92a53cb12mr1339830637.20.1785536593141; Fri, 31 Jul 2026
 15:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com> <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com> <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
In-Reply-To: <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 18:23:01 -0400
X-Gm-Features: AUfX_myDvAP-mn0LUSqkiSdO37b1-jlQ3lFWXPwWxDYV3yXxAuKFWzBHOxeX2Yo
Message-ID: <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwived=
i
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwi=
vedi
> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya=
 Dwivedi
> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartik=
eya Dwivedi
> >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor w=
rote:
> >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moor=
e <paul@paul-moore.com> wrote:

...

> As a consequence, everyone suffers because they first need to satisfy you=
r whims
> on how all code and kfuncs written thus far are wrong, and need to be mov=
ed
> around ASAP, including the one being proposed.

That's not a reasonble or truthful summary of things, I've only
requested that David locate his proposed kfunc in
security/bpf_lsm_kfuncs.c, I never suggested he move any others.

--=20
paul-moore.com
