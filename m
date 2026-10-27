Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136817;
	b=P3zzUw17fLNT/kiUabOxsHZG/Va/IAdfxzjf5GFR8Hfm49E6LaTkURMJMQ9vEQ+SNJvb
	 mL9e+9WzcdE4pSw+3Sap8cudcnXte55aiwJIdd9nwzuhmowxjPJysatDVbaKFSJ4iyupz
	 xosZHHjidSa76jj1J+xPcZQbsNgWv7AvR4zyb9R5XCJ+dVL46/yybME41J4dO/r0Oqafz
	 Y1WP84C7J07qmEE8xIduy6O0YADuAghs/MfhV7cMCyHSTLdNB8kRRjK24aAo0qWF5fMoW
	 j5B1qeI/aJPGZyUJmwesaJ8+WnAxFAejNezTNKShBWdTtCWJomuuNKkO4frjWv89ijw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
	b=IUAqRBPmIN0gIz8w+71UoWdmJ96Eo7EOKnP4URQPJwayHwrlhc/hunKMgooCWfxEBIH3
	 eBvgpS4zWE/CFVEAsU/jR+24e5tkTJhpQtROo9MkH/4l9rZJ6e1BMltygmKXXEz9DdNzA
	 Uz5jGNkWOnE5BO0D7qqTTmMpteAq/eKL3XhFHfgotTL5lE3g3KheHH6pIMCDbQPCXKlDK
	 yOeH8AiRWTf05MBX8S2HRiiDNJQ9Cq6h0nSl6KlvoFkzx/JpHJp0kd/v2OaffkhBGZd1i
	 jtlqhMhnKM8R/DortcnQtramXiipmCr2earBa4FLUh2yOiwIKQbxjF2ffjw7ee6QsiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g7sJnt3w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B68606A31F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B68606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g7sJnt3w
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso45597266b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793136815; cv=none;
        d=google.com; s=arc-20260327;
        b=exsPuYskjCHsLV1nM+FAELyTAHih+OysT2OcgAxay0JNDZ3HxD+hEibldKQU5oP7kL
         J1Xlw8YlWi2PFtc2AaPxW8/AnxZ1t69ZQGmTW5KMB8A7MMFbrmwGeTfvbAOh7Rt9yYyV
         YhxH5Jeao9CEUs/lBRfSbeZgu975Dv8aRp+sZE98sRAGUPb2TvKUPgRP62D0IDDN0BlT
         toEMTkdM/oOyA/jYEs28Zi1UoQ6ermYLak92guJ7iR+JSRxbVzrR3022/XDb3suC5Ves
         OmxeNbHJ2aqQDGJ70h8NqMsyhR5Pev6ZCnnY46dM2Pyt855xDCE9uijJ43AqFmKyj7JO
         pJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
        fh=4iLiIOK6A38GMakLvzCUuypUXrPsPIzuuSl8oHtvJT0=;
        b=qez2KLbRMjmGqeMZRaps/ootGdiR+CtGhFRgpM1voVItvizmzRqfV01JDEFYn02kWZ
         yOGhVrsjtrWOoHCSgO5e9DQaYgeBTp8dSNvBdEp2V48bEeS+NXUGTWNlnMJnLwLYbxf/
         28/casR0YUwOeqmWASjEDqe9fCTHlRHAhVZa/4PVuCEUi+DfMYaW1ioLgi8X21bEYT7U
         Vh+ayNYcERJNI33KDKPOMh0nufdp9p2hLPEGKiInkDkpyesh5xzxS117lo4P36N8q3AA
         K+svtvtt/5d+xyn5KlL3AlsEM3H6WCSG4rvYgLV+5yFqqPSmpNGUb5JXz7/RRaFzuW7r
         LatA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793136815; x=1793741615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
        b=g7sJnt3wPEA2XZ1mAxKwQvnescy/AmvEeggYBV/bXD3MuIPFGWm+VsYptXHbKr61hf
         4FARY3QXaMPrBKchcQp6zZCpKuI/KiCtA21MlAlJWGy2Kd9S3keQy0aRcUWfbZq0cN6O
         t+ZUnNAzQq8AqLVI+7wo+FVX0HtqrVKwSFypfrpl5HPN5xyi3yim1BdvxmiRypr4LfqY
         icHq1yhYo+CH2xebKoxORy5HUyL1KoPxjFvTXCArpeID1YiAuC25SDJHunNWK9AmqdIU
         Y4R0H7+oxgo+7Mw4vZpkb/AlAZHlVFwc006lV1hywQyMv9pBorAhHkU4CzX47qiQSyVs
         5QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136815; x=1793741615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4jBWIH9k+0zevALV8MhMLgH9N4lxeP/UYSIcVzTvic=;
        b=vBr8DCUTxQUaqoTK9NHezuCLjLSWggM1igshpPISq0EdOGbhES6GxfU6GKonzKo39y
         SWJtkYmovZaLxFNxG5cHOoUXztPM5REMg0BXkjKln086ee6dr9zglaLyyJqGRN01fUal
         oW1eFF9gDGFSnUyWZkDNUVuKvclZpFImAitu9nQzuA+rZJ1xpNKFXfzKZOf4tOs771cl
         252kSm42imZdZa0WBBDymxp4JNceu1vcYEPwwKm91YJEFdFViym6k01ITZAlzvmsJwkB
         9oJUYzKEee5P9DSvKmall7nqFAi7i6FUGPKjulV9xU/INnbilYS5xhtyqIsFFBobTO8z
         TeCw==
X-Forwarded-Encrypted: i=1; AKwUvBzU9slA5nqWi+Sk7/WcO98uwR+9MHYZjcMRzGlNh5rG+BepXOF3PZHlDzgwS9XaP75s1gCWbQ1oYQPePVzg@vger.kernel.org
X-Gm-Message-State: AFq9FYIj6shoK5LAFuOxG86mdvnoyKhh5RA5iOZiEL62TzH4inRImWIE
	gWYrbcFRVruJw5VMWlMjGRNTNqek7Qp4dRCMXuseuIk/sTz0LieAu6pbGLpnAJ2hN8mtS2scAoh
	BhMSHbUV0wVq5l/LpCbggLSsQv36DvZ9zioy9/HMM
X-Gm-Gg: AYBFou1jwUj59KZvgtT5Lt1xyannfppXw4IZfhY3Uc51mtv+F34EOIUZ0wFmJpm1sq6
	vaPew5sg86TXcnVaWIxnAfKYMIuU8LOG+zfMA4+4oAp7rwX6GrVJOPBF6M3tGeStq3rIplh3BnP
	z30o5n7918gBZjALitDE9uxZINiLh+S1hcoHaTh6TWKYzdG8TSdSUBft0v49nvcOVBt7bczNxyH
	JJr2OlCTBM6yTYnRP/kWsCcC1cvncIv8DxYsPviOf2GTBC80gXBejsxUaGOZeVK2rxuB6FrY6A7
	oazXw/JAOhUIwWN/LtQgQ5vtvo83bW5cig0SHxKgMEg3Ukkor5rZUCYzTLDE2qI7DZn3fSQzuIv
	5v/nmSep1570HLm8upP+VOUN5vZedLyEiNGIXGFIPuQhmxOa0nJvpOzNKA64bTIDRfd0=
X-Received: by 2002:a17:907:6e8f:b0:c41:4c20:5a80 with SMTP id
 a640c23a62f3a-c49be03be8amr44212466b.44.1793136815046; Tue, 27 Oct 2026
 14:33:35 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <94b36a91-4fe8-480e-a49a-23a81cdcdc60@infradead.org>
In-Reply-To: <94b36a91-4fe8-480e-a49a-23a81cdcdc60@infradead.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 14:33:23 -0700
X-Gm-Features: AclHuK_RVByZe0xeoKYD7y86VR2bYrI5dalonw-UmAvCLqjMUtZYQFJax9TZsKU
Message-ID: <CAG2KctpaX3Hgbnw4iXqrddYPJoqtVBFq2QO7tvEzhHDjgU_KAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 4:29=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 10/22/26 5:16 PM, Samuel Wu wrote:
>
> ...
> > ---
> >  include/uapi/linux/fs.h |  41 +++++++++++++
> >  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 173 insertions(+)
> >
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 34c6f219462a..b43f227dad0e 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -674,6 +674,47 @@ struct procmap_query {
> >       __u64 build_id_addr;            /* in */
> >  };
> >
> > +/* /proc/kallsyms ioctl */
> > +#define KALLSYMS_QUERY       _IOWR(PROCFS_IOCTL_MAGIC, 18, struct kall=
syms_query)
> ...
>
>
> Documentation/userspace/ioctl/ioctl-number.rst doesn't seem to know
> about PROCFS_IOCTL_MAGIC and what range of @nr values that it uses.
>
> Please update it.
>

Thanks for the catch Randy! In v3, I'll add a 'f' 10-12 entry for
PROCFS_IOCTL_MAGIC (PAGEMAP_SCAN, PROCMAP_QUERY, KALSYMS_QUERY) to
Documentation/userspace/ioctl/ioctl-number.rst.
