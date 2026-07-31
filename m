Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26545A293
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523334; cv=pass; b=h0kILpmz+Yh79JOmHEWtqxKuIZj0smj5+bygd+1WrUZGgiOkn8585AmboOGOehB+brbhq+dBGPEN/D/87ExPO15OR6JHrzO/UnyrZKLFZ7EslpSpGh4qo81zrUlRH+EXtC5q5mykecNKePk99gaAjgK6N9EVaeJOVBrT49vIQmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523334; c=relaxed/simple;
	bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNKyI78DcQn7ZgBLsOCmiJ9gpHXydX6a1sx0QQL6XifTofD6iOMwX6T0w8lZfWmjJrKZ+q+N1Z5JCCgXg/KOnDbt6ezmAGpFhVNZK+fiuD/JRIyIqK0nlfiLuAj9AfpEP8LJoCXwijgv4H7N+DrafcIzys1BHailyB8+RfSpmOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RnJTn1gs; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RnJTn1gs"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1104826a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 11:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785523332; cv=none;
        d=google.com; s=arc-20260327;
        b=cu4NLl7Q0fQm317UYPikWRrxN6N1ACo/viRKuzXSROod9C9WiRZW2DxZhZqvh+eEjT
         VDJiJYmb7igIOYXD69WhAJKC1sRG9ZxckHF64tzxBtSVbC3wXYd1iOhz6EMAdWD+vjLc
         fcxeVyfKdit1rxGMJ48aVOpTFDzS5tg7/JZXrLvgIzp7/YnNP5anQWKLfODsg5xh58GK
         Dh7rcVawM7EULjFL5kBm5y9n+1Am7jMoJx+m5+7rcWQRySmL/MkiqNrjyP96Tj3Zgsri
         Hff8n/7poefi3a1b3q42hSyMyOCJXioz88uzZsqWe1lBSa3SKgdAo0BXhI3D6yiSv80K
         iqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        fh=OyXZ63DoHdQEeQZL1dMMkSF2EdPXKwr9SH+RQxfH3zM=;
        b=KDGD9hbKfXsbQHGRJFFhCXCgE0elCRxwqg/SW9hDVM5sBmy7HDvI/AaxKwVbbPcq23
         UHZ1HthCqaZG12ZBkhLf6m1tsTqZF4DkdiJ0F91Tyc9xK2PlfbQlWfjYQfyIIyjHvoDf
         MUBxLjhiFAAJGPX1+5n9qfAgw1GiLb/oVoCsX39Bhwbe/k7Y9nT0ZI5Pei3ZfURzX8AX
         FVMHOWGJiC/l95oJhKcbGUHxHSQPLMbicIFawXStY01h+331WNb7M4pM+9il5iz2e/Nw
         PIp59Pg9RjBOMYMZwJtjFVlC9bU8kw6hUFF5GIfGmeF/NSMbHG1zQ+9WJjypPH2wboDJ
         fO1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785523332; x=1786128132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=RnJTn1gsg8Uvh+FH/JN6RNrus99YZFL8IUWO8gsTbGhi7g5TdULCt76g6yFSun3eam
         /fzTn46vxP0Z0X2fnq7JigzVRr/xdX/XHA70QC1cy6h1utGmvhKCDLCFoQ/RNBGOckvg
         97y1yBejqtJ65K2/0EWVzZaebgnnON2raioNwo1ai9KoWhm+MWWt5xCgxgPjfqBM7qFe
         QNakghMFv/aMxbH4adDhNvmjTErcD+whz8nvTCoYiABhrlNcPPUHkFIIUASoypBphT6V
         5dD86q/GjkETaPz+Oh4RXhVxtcD3gzD/ealPGd28IbQNTXDVihOUC/6CdXG8SsU4bL+x
         ODBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523332; x=1786128132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=jyo02AIlXw22VLBu36VQKmagLekmT2sfJeuwug2HMp6mLxi/w5MIqO39GjLI9OaRLH
         r7g7pa82BDKHooFnldRtKZVpQrJ59B+vPB601uGIts7yLUIWU20FyTboLMyuyolx+/g8
         bwYZVzUFs6yYlPZWgcVz+QR8nipZJUj90dsP5q/78x8EB+z99QWzCctGCKbtfZoIQN8d
         Xfyeco1kF36S+nWfYcMaekUC/jkZKJcKfgQE4jVx1BD0y5dmNxjOedJrTa8TgqBWxpXF
         huHB7H8vV+fFZyREjIZbHLmWgJfohFeoBbfmfjwOA0XQUjRh1o8cUjpHDozkjDqTbEgs
         wooA==
X-Forwarded-Encrypted: i=1; AHgh+Rp15Avck7/b3ByTNQsHNEXx0Y6NGxnl+/CdXmKrh4nB52pbdTqVi7ozraJ1L1cgnQJzdxlBNSZniZLEMcfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyoaq/NW4AvaLdtvjeAbLoRkMTpehnzZ2qA9AfOT5UkRyLsAF0
	zG57qV5LxEzugZ6ns/j2pJCNO8sBw5duel/3MMBdP+mp1pPWsJCR6M2QFslNSjWWFRNiiVa9FQy
	sGoDlWrbQLdpgHIgjahleVkKHaCoBT3BXr2qxyR9z
X-Gm-Gg: AR+sD13f4J8i72TBQ7TVm+uhlxBaGMGr684YJzBkjWHbKXYlW2UB1CQCQPxPUXML2qm
	BAWf5tUrT3PGuBxNBO2it84YEgJKjvQXEyP0myDj44ysesUZQhTP2mMltlm/zavbIVwe6LwqnHS
	s53zupguihNz6LVSjkoUSNv314GzzB4cppDXGyUMAxyxX93XCU+46FXaJVQOB3zlnLJiU5FSjwH
	v5a8cRA5hx3/07eoaxpgA3tzo2IVQndMHNrrkjbQm58z/BbmkcXhCXdsDGlND5X8NR3Vl37bKfl
	8DiyCJrPAfrE3l/gaSGjXVUimPlMj4s+RAZTpLcvjiouuCEjwtoG2DU=
X-Received: by 2002:a05:6300:2208:b0:3c3:ab31:3d1e with SMTP id
 adf61e73a8af0-3c92a8d3125mr777248637.56.1785523332205; Fri, 31 Jul 2026
 11:42:12 -0700 (PDT)
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
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
In-Reply-To: <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 14:42:00 -0400
X-Gm-Features: AUfX_mxuliCX4ORjmGWbiior9WDlNPKrwS-oHeLLni0oyboDwl_jDraty6suaKI
Message-ID: <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:

...

> Yes, I understand you feel it should be placed under security/. You are e=
ntitled
> to your opinion.
>
> No, I do not think the newly added kfunc is a big enough layering violati=
on such
> that we need to do it ASAP, disregarding everything else outlined above. =
I am
> sure you see that too. There are several other instances of similar kfunc=
s.
>
> Therefore, please attempt to meet me halfway here.

I'm happy to work with you, and/or anyone else, who wants to work on
finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
