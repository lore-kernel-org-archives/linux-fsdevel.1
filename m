Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337A4963D9
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910533; cv=pass; b=NRT6RCLQjqwHNgHOcV1vKx2CCcrdAumHCJoZWPx52oovXhb+xUNDcU9tfoAdJV3jWl4tePubcVcb55mUv6v5O+E7144vw9GFNMy/1mR2c54/u234wAH4DfGRiYGqUx51UJSOvVA92OmAReKc52MhRP8X6ExI2PFiJjYbNtTyXmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910533; c=relaxed/simple;
	bh=wA34yog5D3zzm0E4fzCRQgoVkgu33TRvDEqJe+rugrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wiz1hEwmwuxgh0Kqxbq4kTUI5RxTA+DAaLnxrOLiI10e70g/QL+nb+aBYizsXQU+hzZPoSEPp4V6OHbeviYSrJET420CEvK3TteH5F8KlL1vcYPLxPhpL3Gl41sf/mi7dUxztwFM+jJxd3YyzQOU7UcIJzSxGTIVfNGSQjhLyVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XJOeGYL2; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XJOeGYL2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso498537a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 05:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782910532; cv=none;
        d=google.com; s=arc-20260327;
        b=qssGQJy+RpmbyAb6DMVuMFeoxBjYSm9Ejm9oksCm7aGLAtutTA92dXnuBD4LSEgrOr
         nQ/epwMPYzQjH7itQkduMAO1V/rSj6SsEYaXWRoLJTV8dpYBuwdlqSLzIEMvgOykKc8B
         YjH34H5P8skAJdmcEs6OA4Nw08qKE0fmi1X4/9Zm6s62RphnNAeL6iesbP4S/Z552T8k
         01XchR2QYgQ9cCuQKTHtrPRDfgmbnFqnRt0gBJotwQIQ/cen+NgxwEUXaJrjVfuEbcZt
         hOqcZPMtGNwOgZr7jtafm9pHLvKLLPApS6//Qr3oumv6vnEID9i1O3srYzNTAO8Q/AJy
         LI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        fh=exIfCTArZoRyjHJf7N1nDzxIP1/jbTwbGXzky1HATo8=;
        b=JOW3OYdlWT4Y0CzBJJpfzr1nonb3zM6xuFpwv7MRDTHWZmC0rHSTr42sqyB/qAn2go
         8ROblIH7i/90ttCkmL+EaogNjzORTIBy6WvBGt/R4M0qIv4315V6toasyUyfr1yx8itp
         09JeuvB0lWRRrT31jiwrukCuvaRCeFuT+7e3qRnb08BZef7/DjWo6EqnYimynE/wp7NS
         R+0wx4Rqe8dIb4qGVE394CkUCSX3VolZQ2nRhoOnjjHfq/J0+n1PJZmG0X9spfm5iXfy
         P1cFxTu+JRTo9xMHdrY9xic7Ux6rlIi/it6JEYe3M1ZC1RThpiDivu3qk4ASauQcdWQS
         wwVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782910532; x=1783515332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        b=XJOeGYL2vnZ3JRE/Es/sxl+AEl6mmciMEHV8WocRMoqDSpvCRiZLTHCKfagxX0jsjp
         rZ1/Pgg440tx5WIodjMLHp7WFDhpKee6Cw3+MyK+IVYRb5y4DJnUwVWwH2Ykvu0mYEMa
         UuS9z2EawbiuzRBLbcZfqMtjyEMAQ5o9EFYqKgmvlM7vjk1h0rNIvCKNT9iTouvpeSO/
         Ix89Eab4y1vxTcJV/c3YpT8YkT5/p3wXGdYJ8OsgLpf1ypdvzdGRwpjDjpeFcm3F9OxG
         ZrGRMLWMXUdNaN6PvZXcRLBPym5egq3X+PWeqsoM+e4sTqOxKToNcgGXWhzthx5NPnD6
         BdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910532; x=1783515332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        b=m6RwN2yifvFnFEbWntvur6CGut3VZw11elqzugO8Kldq7NkMG48dNPXtg/wvXcBQP5
         lsZKlxul10Y5rnEreBsgbZMetWsy7x6CWoTLh7EJcS+A8/uCr4WypiXv7OKXzbbcwqvZ
         DtXYMXwH71nQKu6UbA8Cre8KH9oz3ODb/oszDQZSD24p0bjl+x/26SCrW1Lmg7fTUm3V
         8bnMRajx0rhKXOSZKnjnlYh2+HcvxxSRa1FUYAItc7gtwd7AZAl3ae4BD+xEbwt589Br
         pRQqwNVnHorpJUB9saorHSaI4URVVI4VOkjY96fnLGMAazy/msQCslksgjnGi2aoax85
         JFKg==
X-Forwarded-Encrypted: i=1; AHgh+RplgDC38Br9LFypQmczm3Fb3PfudjQipj08hPypMmw2mfpVeXTJSi24aKYDxoAi9yMNG3VGnotY2DhBHUip@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNV8+Ys1iAk+Rsk+hdW89TurHFsW64dUNnXfOEcHIDJ08XwqR
	XRDCS4OCyRJPOqAicJKVbKfTSHncXGQI7RXNeX4kFZoymMSSAc92c/8174LtadMo6Z/4M/C5YlJ
	euE4uRgdytUsVxT7JcsQJ4qk0C1j9wd0+AWxFLvXG
X-Gm-Gg: AfdE7ck6lZjtkqVECVS+WwYMfNwKIJmjk9KjbuIZKHb2vBjH4WsBunPxh4nE+9IpwTN
	qEtj1+zhs2kqCS7galZWdSk9D2Iksz2lCKDl60T8fevRGv3FCUQ44XTxbgFfQFJEPi4gqFFyB8j
	pF9DxMjpt3wMjplOfvXuwT/w104CQz4pFuKJ8V/4XHaoiM34ZfYCsAqPsT5xz9Ne+FhV0zhobWc
	F7FFRz4/EOwS/fufYMg+uak0968yz81PN9se9v+D2PRV+QNhuqT9Vkp3K2oddoTthSONUKt
X-Received: by 2002:a17:90b:2d90:b0:380:9d0d:7af4 with SMTP id
 98e67ed59e1d1-380ba86979fmr662539a91.12.1782910531759; Wed, 01 Jul 2026
 05:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com> <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
In-Reply-To: <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 08:55:19 -0400
X-Gm-Features: AVVi8CflgdtI8eLFled3oYp6VOVsv_lBHqIjUE5-aLf2A4hxkcukFfwR6m0D7v8
Message-ID: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
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

On Wed, Jul 1, 2026 at 2:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
> >> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> >> +                                    const char *name__str,
> >> +                                    const struct bpf_dynptr *value_p)
> >> +{
> >> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern =
*)value_p;
> >> +       size_t name_len;
> >> +       void *xattr_value;
> >> +       struct xattr *xattr;
> >> +       const void *value;
> >> +       u32 value_len;
> >> +
> >> +       if (!xattrs || !xattrs->xattrs || !name__str)
> >> +               return -EINVAL;
> >> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> >> +               return -ENOSPC;
> >> +
> >> +       name_len =3D strlen(name__str);
> >> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> >> +               return -EINVAL;
> >> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> >> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> >> +               return -EPERM;
> >> +
> >> +       value_len =3D __bpf_dynptr_size(value_ptr);
> >> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> >> +               return -EINVAL;
> >> +
> >> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> >> +       if (!value)
> >> +               return -EINVAL;
> >> +
> >> +       /* Combine xattr value + name into one allocation. */
> >> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> >> +       if (!xattr_value)
> >> +               return -ENOMEM;
> >> +
> >> +       memcpy(xattr_value, value, value_len);
> >> +       memcpy(xattr_value + value_len, name__str, name_len);
> >> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> >> +
> >> +       xattr =3D lsm_get_xattr_slot(xattrs);
> >> +       if (!xattr) {
> >> +               kfree(xattr_value);
> >> +               return -ENOSPC;
> >> +       }
> >> +
> >> +       xattr->value =3D xattr_value;
> >> +       xattr->name =3D (const char *)xattr_value + value_len;
> >> +       xattr->value_len =3D value_len;
> >> +
> >> +       return 0;
> >> +}
> >
> > This is not a generic VFS function, it is a LSM specific function, it
> > belongs under security/, please move the code as discussed previously.
>
> Paul,
> Not quite. It's all about xattrs.
> Having "struct lsm_xattrs" in the arguments doesn't make it lsm related.
> You needs to study existing kfuncs and tracepoints.
> A bunch of them have "*lsm*" in the arguments.

Alexei,

I'm sorry you don't understand the basics of the LSM concept, but
please look at evm_inode_init_security(), xattr_dupval(), and
selinux_inode_init_security() for some background.  There should not
be any usage of lsm_get_xattr_slot() or BPF_LSM_INODE_INIT_XATTRS
outside of security/; you argued a similar idea to justify your NACK
of Hornet, I'm simply applying the same logic here.  We also have the
very recent security issue caused by the BPF subsystem which failed to
acknowledge that the admin disabled the BPF LSM and then walked all
over kernel memory when it shouldn't.  Moving LSM internals outside of
the LSM creates an environment where flaws like this can go
undetected.

As I said previously, if you absolutely insist on the kfunc being in
the VFS kfunc file, the LSM specific bits need to be abstracted out
into an LSM function.

  kfunc bpf_init_inode_xattr(...)
  {
    /* sanity check params */
    if (!xattrs ...)
      return -EINVAL;

   /* get value/len from bpf dynptr */

   /* hook will check for LSM specific xattr count/limits, allocate,
copy value*/
   rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
   if (rc)
     return rc;
  }

David, if you like I can provide you a patch that implements the
security_lsmxattr_add() hook above if you aren't comfortable writing
that, but if you want to give it a shot that's all the better :)

--=20
paul-moore.com
