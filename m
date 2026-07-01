Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F92399CF5
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886197; cv=none; b=j3DmhZrNsHzp4Ix/2Gm9lfsATZoIodHF9GmIEL205bSUxwvMDOBGmHzoKgmc4MyytTsnNpv0qr3BaYi5yHS9foNXZj8kQjCmOl4KyqXyaKTiM+qZighm00MGvzrSXADw3tpXqgFp3Y9BFrHuCyDOKE6Nql9nuDJ20nyl00MDz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886197; c=relaxed/simple;
	bh=6KbUYY4Kud4/SPqyi3x2WMVAQjlqAWpfU8+H8Iqg4wE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SwJ78SGy068oRzeFJagbdjzt466AC59TQVfAu+uHK4NHsyGXd2x3E/M/a40hyRJx9jV/2/M2491Bt9m4XIUiE3d03V7fBMYKL6vC5I+AITB0n97tc9j00s4Af3BvmKFCduzaoMaNfXN4voKc/ZjUH8s+I3vRoumQTE5HxvJI77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPALaJxL; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPALaJxL"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44793168d3bso158242fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782886195; x=1783490995; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHk2CYv9CFjND1DA8+37qjWHNRV+096bhWS2yVE+OC0=;
        b=qPALaJxL49eCojqqTZcH7dHmncs/Z/anbHriboVoEHKtv72PkXZU0V5uGQaQ2N9wWZ
         nMp/GCLkq7cY2sl+E5E/scOov1FYElc45jgJ27fx6ejdC8pkUVS1a/0+34DLXzVHEM5j
         piCjbnymC6RWYRuQmTy/BpHobJ8E4w9cdxFYAabB6zrcMKc/kSO0n/f7+SvPDQPZrjiS
         pUgYH2ZRd2f4sWpr4eWfGsC7+k7w/cp+wVhGIBw7zI2zt8gmGpcuA03TsTLaqDTNoMN6
         JI/BEfzJp4aZSNpJ4DG0p4FeEjjnBQ+gDPdZU1OefWVPcZssIrAYOwE5xiQxMiILwdyY
         urUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782886195; x=1783490995;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHk2CYv9CFjND1DA8+37qjWHNRV+096bhWS2yVE+OC0=;
        b=kw/QM5PX6MzK71IKOb6xfLC2VQBf/A1KfXkXmGg5SbFn9ypcpSkANRbJ68xga4u9lC
         81v8B4l7WEJAdGAOL3UxgVMxz0IJ1LMNYybfl3WE/C6h2hw/w6obIbhLNbtixeMOirlG
         vKqsxwLkfykvkb+Tb0/W+B2tu+mHec5OhstrAGLbaTMEzGNRWe4hODDXGN/o8KHgfQM1
         UwihxVBaExjXCLm5RdxqpwT4OkX+85RoOMoDznP7kGZ/KeD9Yavzrj30hbfGesWjesSD
         XIS5t0lpJNhHnAEctecVuP918AXR+pYFxRBiaps1t19BYX2/ra6twxUQ9Sv0KEsOCgXC
         Alxg==
X-Forwarded-Encrypted: i=1; AHgh+RoQ9ab/X8D7dQ+udFmWavrO7INCSSR1Tdhmvt4/MlLLOND9gB8LQTbSpR5ILtmaB2XcA/X0Ma10YyWVj9NS@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/V888gbjk75fDipj+UmsC5hOl5gg1qJyPsO3v/KjNoA1IoSw
	r76ogcFrrSaUCfVkf+6oIzmsLukeL5gWYkR93XPjIBagFTz1UO7XUirH
X-Gm-Gg: AfdE7cm9xzWmdP07Nzfk0N8GQm6NGDsHngb1MQIcLuBODAxBQ2xPqIYoSBrIpl0inU7
	Vsny+v9gniZdYB8IQsPth7HPKvpA5Zs/00LX/c/rrtD/Qm60+XutEbWQRUuR8Ub06tggVcsjoqw
	M//yzxbRiujd/zmRholhi2E8OPRE1VlYV7zQ6fnkPxZW6YYzqd5jHkUh4WrfPMXHueSpvAxD+UI
	b0W6yD4gwyvvB1Fi+HkY5dI2OzRq0qxiFkQTj2qhc81M5k5SMGb84XhHEbajsMcEfpF0yOmHN1Z
	ppJzBanum3R0vMojAxY1I0s1QuCltT/djQ1dgMDdhuQyXwa8/J/yRHHeecyOdkPNV0ghgCjCqWm
	5wA6CWeqMlDqXAPzHxz1fxF3RiiB1Q3qlMrha2umhVyAOZDW13LFLAnXmpQJKwIoa7HZl6RpVDV
	bcp0Zi3PnPl6g9SIE46MXtBkKyd/uRsfp7O4/R2NUyqByhcWBMSHEhpT+/kSizrt3ZP93dLQ9fx
	9bu8M6BW2iHmQ==
X-Received: by 2002:a05:6870:9e83:b0:43d:5d22:4719 with SMTP id 586e51a60fabf-44cab961fa0mr69097fac.22.1782886195152;
        Tue, 30 Jun 2026 23:09:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c62027e5esm886593fac.9.2026.06.30.23.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 23:09:52 -0700
Message-Id: <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Matt Bobrowski" <mattbobrowski@google.com>, "James Morris"
 <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
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
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "David Windsor" <dwindsor@gmail.com>
X-Mailer: aerc
References: <20260630183956.281293-1-dwindsor@gmail.com>
 <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
In-Reply-To: <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>

On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
>> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
>> +                                    const char *name__str,
>> +                                    const struct bpf_dynptr *value_p)
>> +{
>> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)=
value_p;
>> +       size_t name_len;
>> +       void *xattr_value;
>> +       struct xattr *xattr;
>> +       const void *value;
>> +       u32 value_len;
>> +
>> +       if (!xattrs || !xattrs->xattrs || !name__str)
>> +               return -EINVAL;
>> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
>> +               return -ENOSPC;
>> +
>> +       name_len =3D strlen(name__str);
>> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
>> +               return -EINVAL;
>> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
>> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
>> +               return -EPERM;
>> +
>> +       value_len =3D __bpf_dynptr_size(value_ptr);
>> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
>> +               return -EINVAL;
>> +
>> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
>> +       if (!value)
>> +               return -EINVAL;
>> +
>> +       /* Combine xattr value + name into one allocation. */
>> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
>> +       if (!xattr_value)
>> +               return -ENOMEM;
>> +
>> +       memcpy(xattr_value, value, value_len);
>> +       memcpy(xattr_value + value_len, name__str, name_len);
>> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
>> +
>> +       xattr =3D lsm_get_xattr_slot(xattrs);
>> +       if (!xattr) {
>> +               kfree(xattr_value);
>> +               return -ENOSPC;
>> +       }
>> +
>> +       xattr->value =3D xattr_value;
>> +       xattr->name =3D (const char *)xattr_value + value_len;
>> +       xattr->value_len =3D value_len;
>> +
>> +       return 0;
>> +}
>
> This is not a generic VFS function, it is a LSM specific function, it
> belongs under security/, please move the code as discussed previously.

Paul,
Not quite. It's all about xattrs.
Having "struct lsm_xattrs" in the arguments doesn't make it lsm related.
You needs to study existing kfuncs and tracepoints.
A bunch of them have "*lsm*" in the arguments.

All,
CI found issues, so this set needs another respin.
After that it's hopefully good to go.

David,
you're on the right track. The patchset is getting close.
Thank you for working on it.

