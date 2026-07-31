Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2A40B10A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511039; cv=pass; b=UD6pGzT+nzwB6X0HJMtOaChq9ryABZ/y3h0mTMZQ/GVWhmum6pA5CHvVtQiQ17Vn2hv7EfrIbKDlo4NXTXHeH9y8IdsHu7ULVwBiy9j/oY2qIZA35Z18IDyP6lbvOp3bBL1szb/LrM5LW96mTgTRuGKJyiBWfxqaFFk46schTak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511039; c=relaxed/simple;
	bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8E+0ChGwmlDWjKvFwCGkFmSS/PSB/kYsKZ2KolZ/vEERALCySAVCjSSDlwbu0UMNIPXt4xualpJKCLpOMvw7fQOHYzLUdY75b9nKzpKdlzhksqviBlZtqN8O+F+5IbMxeBV4amuJV4bajsp7KPwNPa8v21VY9+aYfs42dgrpaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C5URBVxJ; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C5URBVxJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so14409645ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 08:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511036; cv=none;
        d=google.com; s=arc-20260327;
        b=PZei82bML55KPIAn7RBTdytKGWCjwQEDNANfIVyE4EO9Vp8QRvCWScJ+VEH2Vl2dIX
         nu1wkwht5AX8Rq3MgtB/v5iIC3mq85HjndxYXqn/hv6oCQVlFYbZNu1r4SxnTWwstP5u
         RSUQ130M8LUjhaD5H0sZ5jDx3FV2zQOzOjsVGL0OVudKKmouIx1K8oFhC3D3m0XoSqio
         dAmxhZliKi8BtJ+zk3ma0gzx8C428hdh6cEwH2ihUKEtNRCZdSPUsF0USveh4OzVB6PC
         cF8Ap8x2QutO2k9YWBa3QaMfQyTvIefFHTZsqswBeoijnFNH8RLPvGUwKQcDRyKybkqV
         2z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        fh=f8dGiyWFlRk/Ez8kxk0sHP9R6s5R5Qn3bIRxDkr6poE=;
        b=NoaSR0gQ66AdUpDO2n2mPtIyb22XZ6ui86IP/8VbLK6QM4pNQWh9xHLe3YlGgTSCQC
         jDyByYuZSsUWCQkm/pboSI50QiTgh/v9YY7Ys4v0HCSr6g6D4hMsoPhURqM0r2819Otw
         UIDWwYCUPoQqJh4Yw6dcgoI+pzLpq6J2k/fASNwRAI8oCCq8r/cwwUyUxxTaD11kAyw0
         iXaMbipetVhvru+uknoYsv+C4wKTXhQR/OBYTQjKlFlLcfJGIcfWAiuHQIWySkikXC/1
         RjTBEfAtXi/47qeUaTY7jKWHE1iHVhbQ/OJFLa98wP3Vs3eEUckMosMN4NhlJvZvmtxr
         Xi4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785511036; x=1786115836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=C5URBVxJ5tERBLgnpI1F6Uk1I8wczA1DgsZx6wU5E29TDJD9OlexQVboj2ikm7m4Vo
         G+DVy29rCfY3z8DteBOBZrGBt0A6NzbErXM1yBfFloMA1eBgxFG47mHi78CJI7hh5MTS
         Kajg4htZS9wNxXJmoOulS7kZUqkRiOhQe3zOkrQpebhQd9lt9YZIF1/aHmfGmxtjhxGa
         rD/2gv7lce/d0vipnWSBIgY6IZW6n4Z1DEk+Iv3wdUrZyhATZdXzysAX6p/yE0ZA9PHy
         G4lifiyT6/Kvh4p2Q7Ogfwx4NUJ17PuYzIPlojAjBifCDzNPoMo0FU5DWkCLgTqj15n3
         ZXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511036; x=1786115836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=AphLNLjc2v/cREjK/CA3uVykE/lnaE8Cbk5TV5FR29Pb2vom53yyxmrpxAzgyDsMFM
         e15nmVSRO36RLqsEpmwiqX13Wk81s5j+vPDPltPGEAFs+AjyqubDBLWI29cZAji+z6Kf
         jyt1TdwSsZAzafMGt4b+G8vx4K3tw7vKYwbfr/qc+BW3+RLgx5GdueVnnL0zGxG5D1oE
         joxLco4VImA/c7h1EfQNbluhG4N58BFZKbzLlAjjuBX5cHlcH4xfe+uSJX7Ejjf2OMW1
         6t+I+0LLWCsKuWdkbtpM/zg6DNcFwi49hiCil/JeSI9/fxUQ1sorwepKcbLzVc/t86Hw
         jBgA==
X-Forwarded-Encrypted: i=1; AHgh+RraJo8smfd24pryBLYl0rNETnSIzFgkFI7ChIaly9SGU+0nag+4einidQI3D3yUC5r/Hr95YDtMBgO73uex@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAgbngYTFDpYjb2yt6iPHNKwKdnAnbfNoT2lq6x5tMOkfbecs
	8X4fQfQHthkY+r4oivVrIBt3BcDpl65748CBg9EGEIxpvPMcGmazfL1ytJfs/twM67LVHXB0dgp
	Deo77TXwlXy1+DcPMGVHpXFF6+v/VIl73PyLgH05K
X-Gm-Gg: AR+sD13rKeMBmmzTggdHRrJGjuKY1g8JDekzbKwsaVIp2yJvxyaw0oXqNrSP9wcSxIR
	F+yjYSrBAFVJyeyinH8U+pDlLC+AcE9s6ROupZmVMWNduHTBqGgpGMj93DNAvt+EMXB5FHu0zFY
	QM0v5iPnokAo/95ZKyjyugG+f1NsNqx6gkDdkQJAiEKP7q3PEf3SCuprpuTPrRiALW2/fNv/9aC
	s/fhb4TXdwqcCmevhmFyUoRH7haNkwUvKWC8z+us8CoVPk4yYU+AYagDcj4FZ7GPqO9wzY5VGKl
	BpKdWNu4mw708WOVYSHtlU/OE3zfJQHs8JS915w49H7P
X-Received: by 2002:a17:902:ecd1:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2d0523b96d8mr3879785ad.22.1785511036384; Fri, 31 Jul 2026
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com> <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
In-Reply-To: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:17:04 -0400
X-Gm-Features: AUfX_my_07XA5O156m3d-t8I3fv7r1HuUVA6nIPOKrM8LOdCX7kqs7sLBvl0mUM
Message-ID: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
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

On Thu, Jul 30, 2026 at 8:01=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Based on our discussion in the v5 patchset, I was expecting to see
> > this under security/; did something happen, or was there some
> > confusion?
> >
>
> Nothing happened, perhaps some confusion. I was basing the placement
> off of Kumar's comment in v5:
>
> > I don't think we should do that in v6 though. What you're describing af=
fects all
> other xattr kfuncs. That's a broader discussion we should have separately=
 when
> folks are back from vacation, and more importantly involve FS folks where=
 the
> code currently lives. As you say yourself, the lines are blurry, xattrs a=
re as
> much a filesystem concept.
>
> My take on this was, leave it in fs/ for now and then litigate the
> placement of all of the fs-related kfuncs after bpf_init_inode_xattr
> lands.
>
> Happy to place this in security/ in v7, if that's preferred. Apologies
> if I misread the thread.

Okay, it looks like there was some confusion/misunderstanding.

My understanding of Kumar's comments was that he was referring to the
exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
not necessarily the new kfunc you are proposing in this patchset.
Kumar is welcome to correct either one or both of us, if we read that
wrong :)

However, regardless of Kumar's intent, speaking as the LSM maintainer,
my stance on this is that the kfunc you are proposing must live in
security/bpf_lsm_kfuncs.c to be acceptable.

--=20
paul-moore.com
