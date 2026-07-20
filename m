Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CCB3C3F5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587679; cv=pass; b=PFpDufiEWhX3p4xAGnLmaVsxuh7oZjAyQ2ZitkeSu+xxO24Q79EB8u98mFZLRwaxCZunOnsgqjBGZ7AWNH8UGWlugCV9l68rFMuexAEdUAlqoMXdRaFuglPehtileXkiRD2ZIzq+1fvua5IpGSUZLhxd6s4z2WRlNnuQlHCO6AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587679; c=relaxed/simple;
	bh=j218zC175OIjPULuI/NKHO7aTKDJQ2ZX3WjZYu5fHhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlJt2QMINI/aBxH6/i+PKQY73F6TOZUVw4kYYxiRr4db3M1XxbRYdOvdP5dRNT88oi2N7Gm2xl1qhNItwR7Yb8JRVVtYwCkhG7ruhHd2rqtRStvcyNWtv6a/PyzeTDmsrWYpoYbCF8NChgcZHSsT3ONet2UO6QmaZsa2pOysZ60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YnExVDM/; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YnExVDM/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so8342954a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 15:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784587677; cv=none;
        d=google.com; s=arc-20260327;
        b=LQmIZoqozE/2AHumbNtzkioDcl0Y8lwxCPCSELOdq0F/DHs3KFiz0ZgC+LoH35P4gj
         qbLJZ4/JfPbIruSnjY4Qt/1s00YVE2KwKQ2629hVcpgyP6KmG1PbM90GExevDEvbiiTd
         UzmOKVfc7yogy0u483eqYJhXInxtpmdczvNXvzhrBMk17Jtl8MXlT2pYXDtzrWMq8rYw
         TNSkKjb3aLLDhstjUKzu0b6ZXX+vy2qIqvxin8ltbQvof6HR1zc87H1iYkt7MpO+yWVD
         9XC2AJ5j6WUSpk35HXz7VdTQbqvgr8PWfZ6suODVId7qbgjJAUTfxrX8F83zRjA4SFIa
         dxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jBcBCCBCmHLnCiyc438pf1e9jEwlaZNqcasfh2fW7yI=;
        fh=EzIabf25dcAnw83qli+wvqqSPCRPORqBdNmExwfh/Dc=;
        b=LrASTjXSkTxHOxa/S9sdnDnvfj0WA8+bagdARlIJxtnVyP4z+xkJiP7XkghARxHLGm
         gh1dKs+Z3T2bbwjhONZALv44BFxV9zW+tN2Ca66fQaeYzbchoiC63TdrQDaZD3Piij/q
         8MxhA24uh75guoqH4cDkwzKgQoQqwIDNH4Nuq8LlfwvJfaGw7azgjXh6mln4UeGuwqeI
         uA0QxyP00KUW5OLy2+0fNK1WXXCpSd70Nejzl+BHvIK9NvFFtlt89B80rqxvp1OeLUbx
         9if9j/xjWEVgV7MBChjy26RY2KzHAiecZORS6Daj779jDI3lXczHUJ25EPEQqrisfRf4
         o9Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784587677; x=1785192477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jBcBCCBCmHLnCiyc438pf1e9jEwlaZNqcasfh2fW7yI=;
        b=YnExVDM/uQ21So2D/O2JFPZsYtJk6EyXiuoaMh3FGKl7eZTm4eRapKhI00hRmUqjUd
         xsdhU+t8BznC/UG8ct79OBVA5eXMZPPXQwu2Mi1st4891ApwoXn8zvpO1FCXwgOYfhMa
         q4yB6fjg0KM6w3NcmXkaj6AX5/qZr+v1QHvcPHWAKbeG5DcM2WWVx7L79/duSWExk44j
         kt3uoGtnmC1mZiixh1X4K1211xFoLPM8stfZjmFjpOF+FYf1HZyjYQWM/7z6dMRMZryv
         B5eHv2D3InPcnQSxZRctubJx6HgAGl0hA2paZfI1EiZV3eLpatcUleQwGe2Oe2/qsDIg
         io6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587677; x=1785192477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jBcBCCBCmHLnCiyc438pf1e9jEwlaZNqcasfh2fW7yI=;
        b=lgpGBekhVt7jph2Z6evqweJU7Nx2ztn+nzr6A/SGJLnyIgty9h6vBj0cq6DKWRJzBP
         NsicrLTUTa58SenJZwz7z/AONy9VfeD8Nmrwru8MTigX02YhEWJ2I6nog4GdxwKcXwNy
         STJKjkGkQfBzHiaOGJnIZqnObaNjXbx+sGO4cTRRd2w5OXQUaQWS+aUchfjAfka8As1/
         LlmDeJjNg0ip8v1Gzu/703hFCu5GwcTreHvmnf7qFrXxVyb+CfZy36rrygb5j0UxDDQU
         yyDMIsgS9yQsQw2Wy9dhErhVeEAlapJYunxC0Pg3obx3PI4G3yMN5aTcQUqZt6fMCLUl
         y4+A==
X-Forwarded-Encrypted: i=1; AHgh+RqcCLXnngnDUNMVEYUx/WxpznEUkvP+0DfW8TXpPHNq/5Qfd6UTMEwDYGsO8/DGOgOtxCtWK1/ruYQzk7OA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyad0SK71W7e8PDmrqtqY31I2jVRKj2KM8Kdar/ZzhWrxSN4Fia
	+ui4WkpNhLar01w/yeuYDcmnsh+LuukefuG45lwZBR0TAEzKdFaLauK1t/7HirhidrBuOK9PUBn
	k08Qmmdf0f1/5PzHm9ffmiAtz5Nlh7Mx9muF11Wg8
X-Gm-Gg: AfdE7cmVusmpQIndqrcT/JAImCSLm3J0fAW94fOijvEp1LwizulAwq749PJlTz1glBz
	Obv7RTeNMf9Ph49JxPbyIeEQwvIM+620pPJZNnahOz8tYNugUk7OfswClhFPdw8v/muDI02KRsf
	QjOFIjvE5Ny0bm/GM3YduQ5sGMY7HCMlrfWwjSgXuMq7OAzQaQ+r+n5J3aclf5iZh+wqznJ4s9w
	znxkd6K+RRasCQ2HAJwaRix5adIj6nPkw04sSbDmu/F+irqPYC7DwhKAF4I5Q==
X-Received: by 2002:a05:6a20:c70b:b0:3bf:7c02:c46f with SMTP id
 adf61e73a8af0-3c3ad5ffb90mr16486972637.14.1784587677211; Mon, 20 Jul 2026
 15:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com> <CAHC9VhR8n_TBPGLGq-Pray+mHrUCdcmqGXi9wTXyeGa2Dc4m4g@mail.gmail.com>
 <DK3PRLXZFGKN.GES64J05HY6B@gmail.com>
In-Reply-To: <DK3PRLXZFGKN.GES64J05HY6B@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Jul 2026 18:47:44 -0400
X-Gm-Features: AUfX_myc5k3-eepFI8wiBLb8aQXZE1oN-cQyoKyDkS4G7UoPqGpzL4qDyO8o5wU
Message-ID: <CAHC9VhSLMf4vzWduSfA67DDqB+s2wrAZ5AMr=0A08uybQpuRxg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
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

On Mon, Jul 20, 2026 at 5:24=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Mon Jul 20, 2026 at 10:15 PM CEST, Paul Moore wrote:
> > On Mon, Jul 20, 2026 at 2:27=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> >> > On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> >> >>
> >> >>
> >> >> I'm sorry David, now that I'm seeing this function again, especiall=
y
> >> >> with the LSM specific bits extracted into a LSM function, this abso=
lutely
> >> >> belongs somewhere under security/.  It's only callable from within =
a
> >> >> BPF LSM callback and all it does outside of some BPF pointer boiler=
plate
> >> >> is call right back into a LSM helper function.
> >> >>
> >> >> If the BPF maintainers aren't willing to accept that, then we will =
all
> >> >> need to find another way.
> >> >
> >> > Where this code lands doesn't matter to me, so I'll stay out of the
> >> > decision of where it lives.
> >
> > Yes, you're caught up in some territorial wrangling that goes a fair
> > bit beyond what you're looking to accomplish.  My apologies for my
> > half of that, it is an unfortunate part of upstream kernel
> > development.
> >
> >> > If this kfunc goes to security/, would we also want to move eg
> >> > bpf_set_dentry_xattr similarly?
> >> >
> >> > I'll roll v6 of this series meanwhile and we'll see what the BPF
> >> > maintainers say.
> >
> > Thanks.  Fortunately, it should be easy enough to move the kfunc
> > around, that's likely one of the smaller changes needed in v6.
> >
> >> I don't think there was any preference expressed from the BPF side.
> >
> > Look at the second patch in the v4 patchset, you'll see a preference.
> >
> >> Logically,
> >> one cannot be faulted for adding a kfunc to set the xattr for inode in=
 the same
> >> file where similar kfuncs to set xattr on other FS objects / entities =
exist.
> >
> > First off, I can't say that the existing BPF kfuncs intended for use
> > within a BPF LSM program are in a good location.  Unlike every other
> > LSM which locates its code under security, the BPF LSM devs have
> > chosen to locate their associated code all over the place.  Some of
> > that happened before I was responsible for the LSM framework, and some
> > of that which has happened afterwards has likely intentionally avoided
> > traditional LSM review.  Unfortunately, this has muddied things with
> > respect to what is possible generally in BPF versus what is possible
> > only when the BPF LSM is enabled; we just recently saw where this was
> > arguably the root cause of an exploitable vulnerability.
> >
> >> The question about bpf_set_dentry_xattr is thus valid.
> >
> > It's a very valid question.  It is my opinion that kfuncs which are
> > only intended to be called from within BPF LSMs should be located
> > under security/, just like every other LSM.  If there is a kfunc that
> > is generally useful from other contexts, that is a different story,
> > but in the bpf_set_dentry_xattr() case, it is explicitly only useful
> > for setting 'security.bpf.*' xattrs.
>
> I don't think we should do that in v6 though.

Yes, that would be a separate effort and it's one of the reasons I
didn't bring it up in my review comments, I was simply responding to
those who raised it as a question.

--=20
paul-moore.com
