Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A7442B08
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511856; cv=pass; b=FoAGA2dseaPgK+NnyyR0tzHMQt8qNFuoX1UB8zIV51qI0sslvyxHsEZKLJzjNxKABDzBrT1jJB85T2Hb41E+nuNAPZus24HEGiMj7Pp3BvQN19WmbD7qMu49M37Jx+6BWUPyHRtC9lOua7hwA2Vg6nH68mJXYlCrRRWKhamj3uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511856; c=relaxed/simple;
	bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoW2kNsujitlyF41vrUNZHInbZ+Q0nMcGpsW3cEeZNFsKFNWEPNZUSHT2qsdpxh0IP8otlEDZga4+6yWbAEIycLfPnFC4T0Wdtu7Z3MmHGWWw4UBcBOH4PnJzEw0dhZcTQxpvKo/PU5hiRKrhDfrKVL5lhtvVP6As/8s8OyWN/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv7almrz; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv7almrz"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52b4e988c77so3246831cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511851; cv=none;
        d=google.com; s=arc-20260327;
        b=UOZNyq08EIrHxTF7LDftZvaojq21vXzUMdhjY25C9ieIZbYaZ4DCBCddqROrUStMXl
         uN4gXSvVz8XbVKPfUwjY00PS9CSZmBS7YPOG05GUU12/qzlw6Ogjf4jjTQNxls+yJ1MI
         046iqQJDLe6C/VFpcIaWRWeegnSSwxOkiGn7X92bOcfCWaKw0cYdqdgebSjQbwudZy5a
         wZ1Wnh53Qmm/kvi6rJWj000JeOi0xZqV2n9V95TzLzycUvLMf99KLVqNIf3VVZCnA3x9
         UXVoa2LC+xrPqTKMZpdNpGnYP1Xv4xTk12JLB/cQAg+iblSk91wIhurn3TwOQENY+paM
         DKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        fh=5TKO+2Sdz/5rkg0iPk07iWG6wY1QbnMC7DhCxVFrJR0=;
        b=m1MGNSQMu3b/gEbcNNh221o1s+II3QJCuGNxmPPpe7Os2iCF1tw2VfOzHYc7xbgC8d
         XD/mACX9l+P6OX8GYbyxhir0ynwUTXYdMtFp0w8mUIE3G8RZPj12rdy2hcdhkCbmniB5
         tQrwzV7bQvud5iNjAGoRu4mAlT8A2z0gQJcftNJOv8LZDAtyhKddg2DDI+zeiNXSS9gy
         QpjQ9dQ+4Gmww6vnxw0pekRvfjitQkqBRCTr8HEHRk3C4gSn5dMJ65bwnva80Y5BFVce
         +iWPn/MrlSUEVCBobu6/3/tYo38s+6Fphez0k2sFE1mb4v2gfk6KNjC0WynRyMOoljV0
         5r+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511851; x=1786116651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=Dv7almrzLgInu2aUvUTgDuu+AvSYoQPoJXwtqMKfNk2NvNgNV0ChgtOEbKITkDLxY+
         IK3lol9An0jJKwGRheMIA+9coU1UPxmoAQXv745nA3ijvQYWSKJZRN8CRoniQeol38ty
         TMd53QOjEyExUV3Dj2NhzYMcIEB2SYh1p/oTzzwX2fZkKSSZpAtVpZs4neDvUFx3FpTD
         vXMdnAtoW/r+VnbMyBqM44EFfSx+s6qUJbqq9+5447JTkLT55aJd+QYldBMRk5bXcXUS
         vDUN4pPibTIVAwUfmZ6U2mv9dGMTQrLPcQD1aCC+5XDH/zI3oiiwu0b/0yey5Qx8xxjK
         0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511851; x=1786116651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=WaXvF6Xq+MEN06hqMz0UBmc2Vv3qHVSaNAO3TrURG9M4Mm3em5i3QLzhwHU5d8cL4i
         ZihOEsL4PeAicalYGV4DGaelmGquANWIy9fbrhI+AjF4L3Na0RwscHMvR1FrGZst1kHW
         YtbFr5OVV3bx+f0kG/Y7xfBuRJYxi49QMfjA+mNYNUUImlzY9PaRjxVX2niFYjSdSdQn
         A85mHbOruGe16erMpSMorHFxyY6FRk1ezO3RIRWTliKcehMBfqnfQ3gRiDz0kfkJxeM+
         Hoj72nWToeNOPqWVYqhDs1hzzSM3N0QnjJZqTQTl/J7v4flHNJGIa7P9RWNa6zGR1G0B
         L1rw==
X-Forwarded-Encrypted: i=1; AHgh+RpqJUPiW4usLrRfj4BRjtIaGqeiMILvsMZYRANos1qVfCQ2wLutC7iMQLmHQvC8dUSnHSuul5SOClcBeMzb@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmCZys/AAadA09Of7HfSokkxSx1lfNfHT6/QEZVXlN4lfCcVk
	eriG/6bXBCRCrPWAJ5uqf1hhClAH0+eJ///W4dOYOgxOP1rWe5cu2MgGfrFjPo0ZRDl50/rq6r1
	GeKuC15paXDV2xKeGSUP+ZfaLgfBTl1Q=
X-Gm-Gg: AR+sD11RgPTTB7Oe/CsBLHOHdKvz6IKOgC1EI+wnJsbKCZdjE6QH5G4nheZ8WB3xBNG
	W5Ei4orkPlogI6AoTUbZ7mYi2/r1zVxQc3qjwxKfJ+G0erFS0eOP88Jk/t2wQrY4NcSlgxK5Glj
	nKkgNoJMjD8d+uqnONBzQFeR3YpnlUtYdMOvceBGYSjRaCWBNwymPRzzhVlNKt3N6NnYlFOenPf
	mGtvONYTukheQzD1tZfHPP+d/uI1QtG+kZ+72oPKkY43TpkZhLIBoKZNBqnzeFLmZylPms83ZPt
	H+sy39AAoiq2GJbQx4SBU/9DLhIWntEs13AG7TSWtBrEuVIZ8PhIoHSeGjaNBm5ExpTSYQustYk
	=
X-Received: by 2002:a05:622a:2590:b0:51a:8c79:a2d with SMTP id
 d75a77b69052e-52b56673ed7mr13843131cf.1.1785511851030; Fri, 31 Jul 2026
 08:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com> <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
In-Reply-To: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:30:39 -0400
X-Gm-Features: AUfX_mwCzstzsX_jENhs2p3EGP2HH7m68AkpKrdRcMR6AmexYou-kWEv9wNOVLk
Message-ID: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
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

On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
>
> Okay, it looks like there was some confusion/misunderstanding.
>
> My understanding of Kumar's comments was that he was referring to the
> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> not necessarily the new kfunc you are proposing in this patchset.
> Kumar is welcome to correct either one or both of us, if we read that
> wrong :)
>

Yes, after another reading, that does appear to be the case =3D).

We'll need v7 anyway to fix the ocfs-related UAF the bot found.

> However, regardless of Kumar's intent, speaking as the LSM maintainer,
> my stance on this is that the kfunc you are proposing must live in
> security/bpf_lsm_kfuncs.c to be acceptable.
>

Ack, will do this in v7.

The Landlock series currently up for discussion [1] is proposing
placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
go there?

[1] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gmail=
.com/

> --
> paul-moore.com
