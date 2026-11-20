Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203320;
	b=MuoUcEUwO9ftLMoFsCXUaZax6LGLPhQG+IVIkR1a/aNSsX2EcdubPflW9q/ykBRLr04g
	 Mu0tmg9T65dgYySZew7W81dX7zIQ0hrHjgdIcrqF8mb577tjXif+2blX4Mv5nHtU5CDTK
	 bV4Tb8xvK+C11FiVGxe9mmpG9+xcyb8HUR2v7uKJa2uPXmWGPxUSQTrEkbwbUtfln1vcM
	 W7sgT/vs+Z/YhOocigxlvnB5MGX9SIAWGTqatCm0tIqxkYNqFKuNT1fX1NcSrd7jllMq5
	 XKXwXlwNoXFFm8KcGNcVFGm9aS4LPDPA61BXqD/Lf3oGnflAthL5QiQCl6qCGz2hsaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
	b=xPmR3P+hSG3EpngQcK+G5xKrPR2mN1Jf8U8tcYomQ9MIg5Q/ESfTfHqnf63WA5u8smdp
	 owq+udMNY5ELMg/GQE2G7eITawu9w+Qf0MaXrHW8R4OrunxYluAnz0CEFnbhbq9oOXdxp
	 bOY7NxBL7JMRLMwLrk1aBwDBMWUyxcazBezLcg9CxXOt6LDnbY9M1pVYLNOvQx6KZx5qx
	 O+hCtJLFyNbuQYTO9+zSGir7DwqHnZBGSnKjodSii8C6jt/iY5t48fM+R3qKxHUz5KFdJ
	 HzG3wKzQdwmMHnVXcnmeM8xjySRtsp8LU7Vob1kcuI7kgNmvBLewMLmXHkvceWr1POw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mEayzNdI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C660A260E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 19:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B2C660A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mEayzNdI
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c40e30c26a4so512397666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 11:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795203317; cv=none;
        d=google.com; s=arc-20260327;
        b=lo0M+9wirb/1CHZgzD4hUpcUHxk/zI/8oa58U50xVxiQmiTUn+NzpndPIk7shl8zL4
         +VQ5Nhl6j7VezYJ7eAeBEf1rg/Reu1+3w+KEyUMrtw1Jo5l4SYw2qnJv35VcG4luK6uD
         yj5wd8rkNem8k+GYcHX4t3wWVSIyxjS/6pX0WW+NA2Pcvp1iZLbzuj0DujcFj5FpOluF
         iL3FRK/KsPNtf5oaElBIy0Rrkb6jOPR4PpY5GLP9pJyvvdq/wPpIM5C+hltWPSMJAyJS
         Qr1wrLVFSz+/EbWWo1Njf5sBVpqSYfqYx8e9cvJlSF44w15ZPf3Zpu75AK+GrMnPCs24
         pMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        fh=/RS9i7Q8o/C4nOiXY+UzLbFkf+Ljc4zz0dtSYAItGeI=;
        b=P/UTvZsvQ/QRxdTzbmTY1TJ6bkclxbJq3Bnx3GwoljnMcO4x8wmbK8v9WzCL8zbR0e
         FLBMiI8jEJg0Jjp0D5XUSHVTPOvcaQn6/2x8XTG5S6JT5uAoekbDmOEeDn0CPLXVip/P
         V9PgDjuqHIaLpzHOv+nrALrwD0fFgaerRDXN5hoa7fkZfCqJou0bxAp5rw5LXTcHW39X
         myvOs6Cmvs6J7ze8OQFBHGKiODzA/d7RK/3wfU9OxjTPcHDadSY6mk+Z/FYYHEAwvR42
         Be/gSA4AbnyzyA0QWAOc1b2JQ71OSSzR4aLcA/7+G8zzMOkTTT4CXStnkLAiBLQRgvMS
         O23w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795203317; x=1795808117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        b=mEayzNdI3RbBXowLZsBRN9QL9E85SiUM+2Zma239sU2Kh5ksSQzTSY0ziLpiHV59CM
         7SYo/SGHf9f/BuaQcw7L2iv8PrZbptbwejj5saAaosdugF+c/B6mu2N2VcFs3P0J30Xs
         iJONriwUSnCKSsvV3YNuTBiMdGh2ko87iKPSXKaspCKEn8Eg4sIKq9PASEMF25S3rqL+
         ikrtvub/lopTx+V9oIV7ULiuNbYeJREQZANEFrs6J/Ra/Ji6BEJHH9f6CAD3wgAgK2ZV
         tPPXZ4d3w3MMsU/kZaH+NVG54K7lHkycb/em4YaaXq8r36ZApv2ERWimswbtCLQ2nAOA
         NkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203317; x=1795808117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        b=fWIx5tFQ0iLAIrAAZg8GtXuVbtFGwdLizcWJ0jfn7y/fQEjpATMFArkx41GAB6suYq
         w3LxoJgY/iwkm1OPMX6E1yAfVekNaVFLy+ljO7Maoco/D3u/Y4Ya1UkJ1pEhEPcsEAkN
         0Ok4AzG84rIbYRzlWhz5nexCxEYxyYe8aqUsx/DkqeFAK9EJTQblCfnDjeh6a68vDHmK
         k7btKhinIWGFjFgPV50epY4N3ZiX3pHUowELaK+NJSIgRYkvwZecC+DlHl6UoM+381Fq
         nCdgNnJIfFhjoXSEN5AScZzpCleJtZC5cQC8ykMNJsElvPNrMmbUhnKMB7389yA516UO
         te9w==
X-Forwarded-Encrypted: i=1; AL+hErEctaIc3k7qc2jCBx6R4IqwcvPOmenuo1nNgZpNAgINMjY5Jt04Ef74riVcV66/pzKmb+0wjdk0Bb7UvI1B@vger.kernel.org
X-Gm-Message-State: APuU4Z9O43ggc1JZKH7TinVxf0REtgpHtEpQN+A8aTCWq88CiMqCtr+/
	o9yTIFU1m0kFUGxducjJNVXf5Swk1FYqswRkLztS7NjVWHULsOAxgvZI3JZ/wrIYopVOMgpfKrN
	E3ECoQWPgwbCClAFlTOrp3L25vy9DpTsc/bfEoQi8
X-Gm-Gg: AZFdTZcoq4AA53GQbzzX5S31Qx2T8XcZqPHzEBNZ/XpLBr7lFrOSi+E7sE2uDgH22Ze
	9Sk0Oerh/5/NGoltxV22EzaDwo+V/fN8d2fv/2uzZxITPv05mwSNenXzOrcbhiuMxhQASjFmjVj
	eXQqILirVdyAA129BLiARzYXLA5rE3+E+2IDp18GewO2YaI4MwuqW63ILsPPmogJH6X5h1TNPvt
	tzSGC6IZqGBHx4qGQoDo6vwQII4qlfx4qWwOLW3gXzuEAoi+8HgproRYYry7QHmxC4xeR1hGCrN
	EHTz2OlW6q79JEtj/oQHC2d8PhVER24SYFeqBQIqx4nXy2SAI4iMl/+9aJ+V5nupTIeBEooYBpp
	+wiKcVnyFoYLE0ZDY+YLDcZ6m5IKlZRQoR1MCp1viSjeF4vjHrNCKnVdfNz2ytMYQ4bKw
X-Received: by 2002:a17:907:60ce:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c51317e322amr590730366b.6.1795203316417; Fri, 20 Nov 2026
 11:35:16 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-12-wusamuel@google.com> <20261120-antitoxisch-flott-sense-8c2a09fc9679@brauner>
In-Reply-To: <20261120-antitoxisch-flott-sense-8c2a09fc9679@brauner>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 20 Nov 2026 11:35:05 -0800
X-Gm-Features: Aa3M54pZ23SffgU83N8qfNlS7foyPp12zk6Rc2qBKf5ucMmFiR6202xmw20UsI0
Message-ID: <CAG2Kctri9R6b-_OiKcsabdBmLdeWGVY_zmpqqFgDHLKKCDDezA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] Documentation: ioctl-number: Add
 PROCFS_IOCTL_MAGIC range 0x10-0x11
To: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Nov 13, 2026 at 02:12:46PM -0800, Samuel Wu wrote:
> > +'f'   10-11  linux/fs.h                                               =
 conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
>
> Those are PAGEMAP_SCAN (16) and PROCMAP_QUERY (17) which are already
> in the tree. The two ioctls this series adds are 48 and 49, i.e.,
> 'f' 30-31, and they aren't registered here at all. Please add them as
> well.

Patch 1/9 here only backfills the existing PAGEMAP_SCAN (16) and
PROCMAP_QUERY (17) entries. 'f' 30-31 for 48 and 49 are respectively
in patches 3/9 and 4/9, where their functionalities are added.

Patch 1/9 is standalone, so it can be picked up independently (or I
can resend it separately).

Thanks!
Sam
