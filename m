Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892134B1A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258658; cv=pass; b=La09mr3T5aYVtXnXjVb5KqESelK95dXXC6h9gf7RbxGSaJQC8VJBABOtFUFeNjSQ/sk6zUrwaSo9gcyHOGAZm9ruG8YAJiMQkJhyfjA5YPw/rz8Fb55frKztlckghlQruKGRz2lDDD5n+qdstps/YdeEEJJLwtIUJNkfvyS6Dpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258658; c=relaxed/simple;
	bh=8dMygFUytJEMs1YRWIK3+Tn4nrEm8XrSROj0X+itmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE56I6NmNaiwtq7agIwO0ORfip3/I57HS5Q/B0hhSuRuSSr/lYmuyLopIeOjwjcPxjx/q/ocfiTAhgbtuDQRKYPwhGJEKKZueC99EyNVNZL0tVYs6xgpp0TihxqB5Idz77WMhIM023U4ui6xFKS0qBXzc8Icu+8b9vuR9moY9pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL4uGMKP; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL4uGMKP"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48909558b3aso96250985e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 19:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777258655; cv=none;
        d=google.com; s=arc-20240605;
        b=P28Y4BCQLfBd5iidT6e3QqheD+e8gztEQtEq2/Atyuc+7ZzadVTX91JaJLrnoQxgd2
         YKpnNhElSJVUlKgfP2lEeBi4yzSlXtIjS8pQpICZLYZ2pbFke0RHL7MykGYi7vKAA8dE
         +Vl8iOmDAl5mu7htUUkY0tffFQNx+nuGHEV0GAywGXgg5ePXmHkqIWdOFxb0blwAbA0u
         C2gJZ7UUnXZpbdEDOhPXEtJra/KQfeWAJHOqJfPpttifNe3YZg7GMGkUo+YOb+cJHJ2o
         3CehescuPLE42K06I+D9+rF9Hb8ng1LHVeBmJSQXuO7vJIPvFyndAZEJlZmUzaJlkk2X
         3buQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        fh=XWCYRtXFWME1HicY3H1wApZQciQsRh/ja1i5VYIrKe4=;
        b=NsDwAz04pVA0UneVEq9BBpSrUsLZd4QtLDg6HB2MdoIJa3D+hLyN53xk/7Mrzq9hMb
         XfSzLZheCug/lt0V1toTyB0DGzcg3RUKjgsRqGIYtmgKhHBXDsD3QxSzGZ+ososcyZET
         taayEcXhDmqF7uF+kW95QosznR8/I9aXv5lGM5V8xGw1qw0bnEDd2tqGqXINElKPboPo
         Iyg5oGrFeOGnvYokB+g9N1NtFrZl/Wpzi/WwUzFslv3ButCnu8XdWjSaYw2UGGFHAH+t
         k5Ih9Bhp+VpmNCk1QYCos8xtf+s0cpO/7nMnQWYIVJyZLqgWdCLgYnBzkSBbZob55HrV
         5xpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777258655; x=1777863455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        b=RL4uGMKPedmGYKsYoiSlXHqEWi6hPR3deTBR+SosuKfBtDMTJ/IYnchiCj4u/8BEgJ
         Zct5GCQ8qup3tnlrekMr60VHRYULH8XE2rU0ctIVw+zBKyCpmP5s5ztlvAOPKYUVzGgn
         qY22EsTPtzOs2ggoQ/130ggmmgFDeAjxy21TNrX+GZrLsUw61sPohNeEeRyv2Pz3UUQa
         ysbyCw+Adi53AhSgyO33KOS3D13XQYfzJjoH79vBLOLYVpKuAv+s/NtsQ1XhOcGGyCLd
         MeBVKmqUX2agfAvkF9D6tAZFNsOcFaCWF24nIBSaCs6y8iw6WIRt+ZioMHVcbRA+XqA7
         69HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777258655; x=1777863455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        b=q1Px3J2dgIUNbYJPr18tpZjDVmrsAsMMKM7YcAF4ghQDwqoTjG0P0myXs28G4xmPs+
         iHylv5Vi0cbeCZ1Sq90buprBFL6yIebawxM9EVo2KN/Ho8bBntPa/GiKPst5bVWsQJxN
         1J66A2I1q6jFPY08Slwy/xsOr0LrrYxoEW70sBVbd6wuGsr2FmT47w2X3oKcigYgnIfh
         B7PHXFUW4dPng5XuGd9oQfwDxDDhmCnf5uMs0Dgo/XNZkqS6nhaVky/bOYEfp6MMFBIl
         Cy2onUVvvyfRFweWnbAK06t/DSZA7Alk0hoJT8Q6nkRSVnBgNKsNHgLEfUfDzi4EpZk7
         lGMA==
X-Forwarded-Encrypted: i=1; AFNElJ9F4tmod8D42hK9KockzYtrvl+R5RmTdskgBk8HK9m/dX0eFBvM1SYjs+JGaRYzsCGuTf0p2v6xWcLDKwpc@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3OSqphf/AGNMbo6q/SJtjvHIYSFDgvUzRGqmG/YzdwbHq8AR
	xdCkS+vrh1CJ9EEjRHpokFTra92uprACwZHWOEU3t2CMcXRE0AaTXPR12S6ZmyqDYJzIYYFCSC0
	V1QffESIex8+tG+PizpR7B3IlShXiqGA=
X-Gm-Gg: AeBDies+AFlHPJ1GRC5najNowUI9eu9W5w634UA1yXCCVDL2C9/jkhIzZpn4kr//GLv
	VmIPD9KQypVwrYUNu37vpfU0FRf81Ax1Jvu6/VJLDKXm9ZR0SrxxI/t+f+LAYvqu5YHzgmBBHDK
	edDDuubBK74nV6p4+rhlqCkAWYiaDn4ugrsEUjA1L8PNXaRKihdkD108B+xFIetnj9kKFcT5u8v
	0R4ohIm6mh4D49W0kHCbVr+tEwIZQu14STtytzwMzNDuFKr10wPy7pjuKfYscBIOj/pOqPCCANT
	rb/8Ud8xdCjZce/zepkWsqdv5IEuZC2/WiTcXENFMecH09bUz9vgqUOu4+vALl0Bho7/zlduEKi
	QS48lgvDKcMIGd+VT+Tp9ME2YZthHY7NqLs9VWCboS8xatCiVbgsi7EP4vV6SrNFGE6Vf
X-Received: by 2002:a05:600c:530e:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-488fb768db3mr597309375e9.19.1777258655215; Sun, 26 Apr 2026
 19:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
In-Reply-To: <20260427001602.38353-2-dwindsor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 04:56:59 +0200
X-Gm-Features: AVHnY4IcRwbwGGwdvR03dSV3hJJNxJUEaPLWc8-Ba8wrzAXUvhv-i_8JYRb3CeY
Message-ID: <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via inode_init_security hook using lsm_get_xattr_slot().
>
> lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> programs cannot do: hook arguments are not directly writable from BPF.
> To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> value), and the verifier transparently rewrites each call into
> bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> xattr_count are extracted from the hook context, which the verifier
> spills to the stack at program entry since R1 is clobbered during normal
> execution.
>
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant. We take advantage of this by
> passing the name directly. Because we rely on the hook-specific ctx
> layout, the kfunc is restricted to lsm/inode_init_security.
>
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---

The explanation and code make no sense to me. Why not pass xattrs and
xattr_count directly as arguments, even if you choose to restrict the
kfunc to a specific hook? Why does the verifier core need the hack to
spill the context and extract the two arguments?

pw-bot: cr

>  [...]
