Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED13AB292
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946713; cv=pass; b=RlMJg3xgZzZYsUHbenFGiv5HLzv7Y9BePexxHpfPW1OfpfESu6KBqxsjzxlr3inmOgEduC9WEHoc0aoUz8BgxyfPN4/TUOqc2ZICcDOB3x6LIVwpeUJ9M8onRhUCwqlSCiS29eZI5Muht3XfVHB9eklHhHzD6+aip2/pJkvbEMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946713; c=relaxed/simple;
	bh=v333IQ17seFPobRriFVv9irQiGfOh08ZeyJ80kHbi8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsQ2zR0BF+tgk2xd1eKsFwKHEqiwP4exMcBHSiLn2WZYpeCdO56VtIPRdKxZrx5QRT3hvpdPQ9tlBADb+qp+LMrMCzGhwLh/RdCwEvR7GLfzTsbjIzqNQTSYuVYVqdXT9S3m9mi2Eha8v9Uo6vc9xtzQHiAONkSzml1L0K0s1PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFMFLejt; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMFLejt"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ea70ca4fc8so8921146d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 15:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946711; cv=none;
        d=google.com; s=arc-20260327;
        b=axL6frwXsNkteG23vtRIYLyIKdhwjUKpl725Ue/CvnBxRHZTulFTLxxnX5tZVynDyx
         eyD2yoRIRHqAXPAhFH/nw3ryrFrH3Uv0wW+byGfcZ9Rc7yl1mtjOZIfuIAz/q/M77vq0
         Gu9zV98yi2YkaSo8gtXh6V/pYmW66kYD0/2GlkFZmzyt9T0tIrBBspqOhQ6w5sJYzqaH
         49nxM3TKBxLbMHh1HbxIcBgSyDxdFowZtIfGnn80BhL3RsqNfsZ12/47cou4T9fFNKBa
         anu+YUsuSUg6+3mpPNqM583SnNDDspK9nawwAJW8iOVS3ldjrUt8RsO9ow+iFxkF1i90
         b5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        fh=HFgHM5tVodJC+GEpu3DRgcgbSxZqIDpMJsZ1V+gunvs=;
        b=cqcyDmvbEmwJSDuV39opDxY+AcmtJT2cJ8O8aZHkLOqUrlPHAsQB284BNYRi1C0QSk
         97Kl7UIkMLy0sBpZDC6Mhc2Td4LK9NPbf4DEAsx6t5HxHOEcXfSvEKzjh7X4RAAKXqGZ
         LSVEjmCIViA8FQF6zXPfR3tw682q+5/V8hp2z/kVOrd2neX77ORBh/GXKDnBaNtOq0mu
         TbyGMsLeZIIuWg9Xh1viOItrTyA9tjzi7M9K0OWNsxJCr55Afb2g8an6yO0iLDR0eVW9
         PitVXoNlrQ/2h9pA8mS/CzTyBxAe6BxFCBJS4lFcLEz0UTTLcv+ASbPBQqYB0RXAu55x
         l81A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946711; x=1783551511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=FFMFLejt7D9ehe+p004hrq2XpYh/HnFijFKVfrm8olTlbQQ7Q7yb6sS8daedUAOGKB
         6ppRzKfwcFgKnNWKKZCE6lRbSrfVChgXrJ2eDvBGCtvSvvffEJgsf/boiPb+ZDxXdvM3
         jEmUVryajCTjqPWMW4oqmFlumVnrN9HEaI5FyMjkJl2TwZxGCHXsx/IhjQjvDSRsdW8y
         ci4HYwBhSnUhNKlgPp2+jbNcb7bE9UE9b8PV15OB0S0VWPHeifUM23eKuQT5ZR2Jwm4+
         guR9YrxXCt6E+5bP4RccjNaIhWPN5J4t5uV62EOTkayWIG7vRIM5AgvE/c5wYCTy8lnT
         rJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946711; x=1783551511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=ll/NJ24NnD9hEoF+TX1KTj8LYTH+QavNN5ogFaDZckU5couM7zzjj+zQM/k6uOFdjz
         rSlMx1Krw3lslx5S2lHZYAyDLkiWhi0PIVv7/lnbQUlCXb+hfkYNycxKW/J77b3hI4Da
         ks1mA0QMgWxtGMVxaO7GFHiDKIzB2jGVjTUQd740jXOPVdJjwpYVXS6Noika+xyxe+lm
         6+CoYdk8FwG9Fglj1FWNmxb4mHm82EH0mrfqAwW4u5aKsfQ8ei1Xs00AWYRwhaKiNCzn
         MkjvtMxM0rWLxJLD6lfGaK93mYlojfAFN44nSpAj1FHXtYSfWny6Dowl07wAZOXyqvLh
         HvKg==
X-Forwarded-Encrypted: i=1; AHgh+RpX4+z0PqO2+ogdVhXaoz39RWGwiWFlmaC6PE+NmRlN9ekMAPD7c+v7AdECsPOTKPyIiYdZpbmuFdel3VeS@vger.kernel.org
X-Gm-Message-State: AOJu0YyrW3+pR5uUah2n4bJKvLkMhuZNopFh+tC+ZTTqr2XtW1oHsNuO
	Uzmrr+hwYf4t/7miCTZOXwUilen5ScyduA9Ix/jC/TTVwu6Vk3XxF6ALj0kjuWt3hvkifWVShcT
	lyNjutHg9kvCHf5sAK4WBIrQUySrPS18=
X-Gm-Gg: AfdE7cmetunaIAJ1H7xlgFcE5ZSgEAUgthQyDCx/vnAJNkrZtuqTrlnbUQYfT7Fb2xv
	mJtPO5a2aLRSYzhJDpYStDZSt1dJ0EbCDq7gL9heJkv7LG2GZxTb9+zL/ALkuvmBnk5YzqXgc7B
	Y4CCO/ifbKwx+h2W1bkEbhNO9wZfPv3Bzg367I+Wjz4rkZ4ckgczhr0H7iFYg1QTR7zUGBW5Mke
	CgqoZ0SR0qR9JMy+gDb8OslkzBo4zFM2Gwp/xo7ayf7at1b/Ueqq2xif/2IeNLgwEC6h6oRSIqU
	eztAAUxbT86OgBeKkThAamj0qS8=
X-Received: by 2002:a05:6214:55c1:b0:8e0:c0f3:a2cb with SMTP id
 6a1803df08f44-8f24ead200amr108961456d6.0.1782946711091; Wed, 01 Jul 2026
 15:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
In-Reply-To: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 1 Jul 2026 18:58:19 -0400
X-Gm-Features: AVVi8Cd--WxIEfBHVAG_4saw_HtYaBPqRNY7ATulZIzQtiR23TCVwYiJaDu_5Wg
Message-ID: <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
[...]
>
>   kfunc bpf_init_inode_xattr(...)
>   {
>     /* sanity check params */
>     if (!xattrs ...)
>       return -EINVAL;
>
>    /* get value/len from bpf dynptr */
>
>    /* hook will check for LSM specific xattr count/limits, allocate,
> copy value*/
>    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
>    if (rc)
>      return rc;
>   }
>
> David, if you like I can provide you a patch that implements the
> security_lsmxattr_add() hook above if you aren't comfortable writing
> that, but if you want to give it a shot that's all the better :)
>

Makes sense, I can do it while I'm fixing the remaining issue flagged
by sashiko.

I'll route the LSM preparation patch containing struct lsm_xattrs and
security_lsmxattr_add() through security and the kfunc and selftest
through bpf. Does that work for you?

Thanks,
David
