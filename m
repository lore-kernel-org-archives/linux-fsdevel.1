Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E01348C7C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403618; cv=pass; b=fCkt9+QfivhK/oV2JpP2qjwoahjP1s6LVdsk8VJKK4Cp9GlJlR2FG8eCFLJqJzsi3q/FNjhfE3v5BBIuV5WiygsSq4VSTOo+eYz16ddDoo3GbKQaB1qa5ju2D6fjLP78zHuyPkGaw+XPdTsWkLLMI9fL+4mGty4l7pXeMgscIow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403618; c=relaxed/simple;
	bh=agsr2jSOniKtJMF+X0oXwibByddxXJqtF6YncOKFIEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcK2qWTKP4G81i9awPTP0WMEztCNHYp52umsVUF5BvdR6eWe8pk20+IRtzjLqtXMOdrHc95yhXPQq9CWsSXSDZXV0tZlMq+Y7Iv7TD3Pr5ors53wKEWTwk6KTpuy1omX7xoq9OQY1hDJQ6mE3+wECnwkm0agYtl4vcD+y/2ZiNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QvSsjVPq; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QvSsjVPq"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84594492c26so2491599b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 09:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782403616; cv=none;
        d=google.com; s=arc-20260327;
        b=Xkc2FlrhFmWsSfYNEQvj2X/vsAOejU/TMWR0D5LmWuoqXl8cGo47eDGFHhtS9gzpga
         2TG99MxiI0QAaiEzDu/UH1fWNa2Qwg/+FQujAtCiuoi/sHioV7DkOdViyUohqAhLX1wL
         dLlLNhcyXsM2lPM2lWntLv1NMh+RVAm+JFEQBBAjVdRvB3yHFP7txTzcE6AhYR97dO7O
         HDK3GQ8n56ZYHGvQCh9iq0A6T7GT4ivfesQ3EowUkBPUWU92KA5Zr8WUINpskVnxT7g2
         TZ3dMagzYN3RmykbQUF5hyAgyKqdds5QX1m9tTjX2AcNqK6vS/eVbUqEpyKg7oPL7Rw2
         OBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        fh=cJAYzcDnAmWo380GIvqnXk1MCzja+l1efoKsezAIZps=;
        b=pom44Fd+4Et6pYAKMqIkI/MPUJNMGtQjMStOFjFyngZMX0B7Vic0nKoJdEZOwfnj+s
         Awlu3t6eXAHYjaKtdmjGINT5meJ3jBzzhvAFCoQk3pUWtK9b/pSZ3G4W82HFiMb/FI5y
         NnW+y6LDW2nY/3BJ6Z+Ke3jBo84bCCayLmV5wIc/wY0y7X+QHpa+4DSWB85I9hw4aeGl
         g8M7eYt5mqXIP6gd+VJ0KAGgBgo6RJRf0rHkp5Vad3CUEX50LZIQnLO6shNmZSmVAqtb
         sgldxU3hq++9gzU8ytHuNgR8aEncVgMm+5buFen5TLYvB0XEgsxdN5ud9srpw5pbTjGn
         l0Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782403616; x=1783008416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        b=QvSsjVPq3M1JY0gxDJT0dGWAhQEabdh6KoWw3JBpzBtI3rtnb3lWRsn8ta0q85U6l4
         Ua9fc9jZSlTlQCTuDpP5pl3PJpzmygJREv8s5m4jjU/kpKu1yQeSbGs6Bu+QQmxV2ezi
         e6NPDfevXKkBchG/zqVyPXc/kFOhBiI2W3jBrwdKpT5ZZaWOTSIRUKTJNjQJ0AbZcUec
         vgdp30jAhElXeS5k7V28unI7eOz9LvmVrSUmQlBIQCVGaSXpNXiOqN/qFRoYC/XGgKOC
         9iAuA/CZaq2dfEavbG5gNF2LFQUOsab5a9SZvIIiNeh6NvKgnQyIElT7hrMSadP+7MFu
         n1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403616; x=1783008416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        b=EXK2ZGktR6xSx+q7FQbG33LB9d/Qwb+SjvFb3VKXY0CnDyALrf5Eorq/JAgcOKIWre
         qm3RcTRbuCFP2gOfjcojXcWbmSheyGyvTG03xEwzwLgNXIZCVRcZWbVIFWqCuff3X2fa
         pX+JME9IedaXV92vwIPd3K5GWtkVpLRzC7Pl49vJeN31KveqitdJNnbbHgb3oIj3e2oD
         cJslkqNGW2tBa6OJc+NTQskm/9CsjORmkIkfLwm5COk61Rw6qw8bGCK0Vg9xiM8nwvus
         M//Jcw5G2CLtiXeayFKX7xcjsuCaJNqQVlK/WRUXUiBxjhfqQhqaIti69LSaDqAmXH1n
         o7DQ==
X-Forwarded-Encrypted: i=1; AHgh+RogHnnxNfj1eywdMXgfVJgOdaluup+dAUj43gusFFTcsDgqXHjVcYt99UC3K1urK6ej2Nbrc5L5M8gpUJ/6@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2/CrdAMNrU7JkZKONYnltmCFGLcy/NhULNpnGnpvNIIAmbT9
	eSSjrnlLita7gGJHk9uPNnSxKMtei/9AZsYM6lsSGldkAysi5OTLlbWy4l4s2YxYdh2DXCBAqeO
	mP4YN2W2xVQC6RHeQNO6f7YI7tnI1TOCdywMXp9Yp
X-Gm-Gg: AfdE7cktRf7ldDUNTr0lKYZTQsu/JPxRsn5toX1WIWkaAaOg8h5gTLOOQbBQE+tp89f
	TLVvhqE0fiMz6q9h1pQ09AHlRPfFsBEL67tIH6oEBInjHcJoeGm0giPPY1s4pobDkCpwBiTRike
	U++Z9XVCZMvPaFoYdkZ+9x0+hVcDdOhP3vEXSax0Z5VfWtbZpqVYVv0vQwG8lfe4OWTop0mAqHH
	74vHJ4VZtcotRdPiD94fQQ6qw3r6xIPVxZ6Oi56bVBYzOuRLLONgIQ9OwgqzQ+gnohAlY+p
X-Received: by 2002:a05:6a00:1a8e:b0:81f:5037:a317 with SMTP id
 d2e1a72fcca58-845b39d39c6mr3865503b3a.11.1782403616175; Thu, 25 Jun 2026
 09:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
In-Reply-To: <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 12:06:44 -0400
X-Gm-Features: AVVi8CfVp_1nha_FxdKkksJCUmgb3NBLBVh62tn1q5iqee01wbI4MgNkgsJUBlQ
Message-ID: <CAHC9VhSP54b9UZLJ5RRaWfnV5J6mD4iLCFXxwwv9pFqDrCAH3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Christian Brauner <brauner@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 10:23=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > The inode_init_security hook previously took the xattr array and coun=
t
> > > as two separate output parameters (struct xattr *xattrs, int
> > > *xattr_count), which BPF programs cannot write to. Pass the xattr sta=
te
> > > as a single context object (struct xattr_ctx) instead, and have
> > > bpf_init_inode_xattr() take that context directly. Update the existin=
g
> > > in-tree callers of inode_init_security to take and forward the new
> > > xattr_ctx.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant.
> > >
> > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > restricted to lsm/inode_init_security. Restrict the xattr names that
> > > may be set via this kfunc to the bpf.* namespace.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++++++=
+-
> > >  include/linux/bpf.h               |   1 +
> > >  include/linux/bpf_lsm.h           |   3 +
> > >  include/linux/evm.h               |   9 +--
> > >  include/linux/lsm_hook_defs.h     |   4 +-
> > >  include/linux/lsm_hooks.h         |  16 ++---
> > >  include/linux/security.h          |   5 ++
> > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > >  kernel/bpf/trampoline.c           |   3 +
> > >  security/bpf/hooks.c              |   1 +
> > >  security/integrity/evm/evm_main.c |   8 ++-
> > >  security/security.c               |   7 +-
> > >  security/selinux/hooks.c          |   4 +-
> > >  security/smack/smack_lsm.c        |  27 ++++----
> > >  14 files changed, 166 insertions(+), 38 deletions(-)
> >
> > I have a few specific comments below, inline with the patch, but I want=
ed
> > to make some general comments too.
> >
> > The kfunc additions really don't belong in the VFS kfunc file, please
> > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> > kfunc code to this new file.
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there.

This is really LSM specific code dealing with more LSM bits than
anything else, it belongs in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
