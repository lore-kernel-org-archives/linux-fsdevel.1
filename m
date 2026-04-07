Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4324677F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589620; cv=pass; b=kTd9jPLMpWxgTapTsSlaoD9/9M+tH7dtWXbHtNemdAekgx49/plV9JwAVsmYRxH6V1EP9it3jWX/bYuRMPovw6w/6ltEAr/JYfp9FWYI1dcMBijc5vNf/7XHsS/t5gKtLhExN/7rTvzxLDHXEjBRV/PPiI7iJULK76/sYqjtgkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589620; c=relaxed/simple;
	bh=i6c6Uhklk6n23W8x1AxzLaFh13KM9OwbxJ2yYTpwf54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frpL8aoP3Sp0uM7x0the83Nfx2Z3ULomVtbE6GI/m1TfZ14+XX4Y1hLRjeZa1qTN9HSQDeamtYPI2iRDJtW7x/kC3Jd1dvwSCwGgV9D2SZaKVi4TJcbQyRafFvrv7MXxfpzU0+8UBNuhQSYyYzdT9Agi5U25DobfRgVWFOSDvAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyZUiWWI; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyZUiWWI"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so5141877a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 12:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589618; cv=none;
        d=google.com; s=arc-20240605;
        b=RUM1y/Y33qnjxbEdhE5nIxug8+lc9rlj30yZixThnNivvhjeYxP2ZHPpuKe6Gp0McK
         P8O49bGG94K+KynhzhL3zv8AhXO/xeg0XeGzoGyzHRrk9Ah3Fcundoqkj7Jx5f5YoLxc
         8TrrkQsJNmPou84/gS7eDPTN2gRj0REeVjCnmevEP5yp4fGTAcLYWtXMdzV0cOeTAXkU
         dt6eET8pEuTkuU8s+Ogiiz7/iBvWb6wJHCrnB2tsbc8qXMB/NgkUjWnsPT3aGA6+Ht47
         5P60cD9FT0gJ+4beaxmweWy743g5EWu7CoiCxbWmDDF9Vv51EbPa6yDU32TKtJOFUuz3
         Frzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        fh=2nprXNvAeenvj6gVu48g5jycxJLGOEXeJfEE/D74kms=;
        b=k511pNqmdd2eSqlNQeNo3k+kbQskHcsW7mWWW0KUrIetTmapDHJJRosh2kVnz5nIeu
         XfbQBL3xcMxd3u2AITBlAXfR3dtu6rnEddjBpJhSgb/3lgCR9vvDx4JLACa+1MaX5h/l
         WQKAx1m+80f4BOrNOdB+r0Qo5TabMc02mCoDELRb2qqEtZMWhmPmNagQXbKItTlPChFi
         f+b9wfzSYYwNUjdXBOQVj6UCPKhwgaEwRnozrgPGPqHz1yTOR/Nh3Hu77yGMqyKf0b9C
         GHxumoLKfQyCVjpfFS9f6GPvXCZIjn+/Uf9U/57zZxOWNFi4apGQaiCMKSTFl0TguoTL
         uipg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589618; x=1776194418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=eyZUiWWILQVMtoM7LN+je344gEOI2bb+oTPGGw49fR/pLvre5XwIY3Y0OQq9XQlglO
         v7pGURmjkXPNSZujNTn/TSK1p3EfZ/5/ErzUyGBS8vgxDCfTWo2s7mBUKa7HRTzS4mZD
         mSGaa+mqRr4mLpoltEgg53+qacArS0qWR0T6VJl1GsbYJRLQal2fit2uyn2S6BBWurER
         dl7wceAy/RmA6U3CKIUbd+We8HdJbAsRml8wBQpatHpRcpBJwpwMU2h4gY9rF5Tpo8My
         FeXEc/FKtXPEp+Sp+foOWr+lrurKCZtmaOIbqepRdcZN2SZ9n0VdOOPEOdLrT9IB7QBy
         WkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589618; x=1776194418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=q5TdwEyfsBc4EEGdNlSgrHjtWr/wgnaJBnpR4dj86qlc9iGipJsZuOgpNVBgUhuLdr
         x1yMYZ3ZU3FdWB/Gca4yAFkKhbjcchyYGq3XBNTvyV0RDHTNaEsedaGeCJaMS7TVVVLn
         Fqu69iiXD0h54Z8uS/suGGOK+ea4zaNOZfCLmvtoZAXKvHERm+/tDoGLgDpYbobN0wv4
         I9/Jh98bpLBZ8GA/zq0gStRAAptfBGMP8v9dHb1nUoL2LB4icksddyWBcuJnLhjih7Y4
         Ai7EE+yFObqsmAOPSB0lQp32jRZqmHz8w8CuHy8z6CEBL6JJfNrFyBzyjBo9J3+B6mkl
         CJJg==
X-Forwarded-Encrypted: i=1; AJvYcCXxhRzHuf04FU6cJjfYi94hMFp7gQszgHeBnbI3p8n8aqMZaAwbH7d5zAVkunIA0/LC59IVpC9MuIaC5RFy@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPYKk1dI0D92Agz9I239+HNKCDllrlK657yw0mPokq0EiBkTc
	QxgSZoTDlDh1+PzfLt9jqNpf8z4OQfGKUSmk3pnBewW+pOmkH9U7Vlhd5IsnrR2XvtBoXieAGSH
	vnLTRVTm7rn1JJogaCji8yrKw0sbUCqQ=
X-Gm-Gg: AeBDiesaQMPNPIXCRw+D6eG9BURvirKqu4KjmEaZJMgdgFd/N2w4ZkFjJvo/X/YB6ZN
	D7nAS3bBvnKMoWQaoo8DN1WAi3DVNJRt27qRnE0NYWWICdQX4Wa1geGwguxAXglJ9wvKhx/XF3Q
	f0kqNfjcIb/i06gew1IpPF0Mr9Ff+hRu6U/XE4eMeJA3Ka4UMFVInjLeFEk49mnWtTV7wUAfqI0
	7G3XlOgBfc1IfunkAZZ/pLP/3fPKn7/HgfJQLbYhcPguFM6rTUrYoMb3eG13cViE8+mO+3c5LgV
	kEkVYvA=
X-Received: by 2002:a17:90b:3d4d:b0:35b:aca5:db39 with SMTP id
 98e67ed59e1d1-35de67ee6bemr17005316a91.9.1775589618190; Tue, 07 Apr 2026
 12:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com> <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
In-Reply-To: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 15:20:06 -0400
X-Gm-Features: AQROBzC7o3Va4ubfSL9DMqzx-1hfP9_BswdLqwBtMsXc3haoHViWO4Xh57-I6OU
Message-ID: <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > The existing SELinux security model for overlayfs is to allow access =
if
> > > the current task is able to access the top level file (the "user" fil=
e)
> > > and the mounter's credentials are sufficient to access the lower
> > > level file (the "backing" file).  Unfortunately, the current code doe=
s
> > > not properly enforce these access controls for both mmap() and mprote=
ct()
> > > operations on overlayfs filesystems.
> > >
> > > This patch makes use of the newly created security_mmap_backing_file(=
)
> > > LSM hook to provide the missing backing file enforcement for mmap()
> > > operations, and leverages the backing file API and new LSM blob to
> > > provide the necessary information to properly enforce the mprotect()
> > > access controls.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Do you have tests for these changes showing the before and after (i.e.
> > failing without your patches, passing with them)? I tried running an
> > earlier set from Ondrej but they failed.
>
> A few months ago I sent you and Ondrej some feedback on those early
> tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> I've been using a hacked up combination of the existing tests, some of
> Ondrej's additions, and an additional debug/test patch to ensure the
> labeling is correct.  It's far from ideal, but I didn't invest time in
> test development as I assumed Ondrej would continue his efforts there
> (unfortunately it doesn't appear that he has?), and I wanted to focus
> on getting a solution as soon as possible for obvious reasons.

Ok, I'm happy to look at even unpolished tests - just want something I
can use to exercise the before and after states.
