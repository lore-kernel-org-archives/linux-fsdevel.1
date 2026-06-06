Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9C387596
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750276; cv=pass; b=lbq/kft6G9OmpsgChxPRYXgOBjl4+LRUOoJdanr5XU3ctrLY5OZCAu5j1uX3V3w/6etqk0KRU7xksq0ZPiy5arUPGgGGHNvsCD0EHgq0QfdLFRHTRgAbhcgxTMgPilZ+yfGFLGuN7V8YUSSzzsqcbN46KfO5SXQ8Rus3gHcvUtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750276; c=relaxed/simple;
	bh=qkKEw9gR1J+PhzlOnu/i/2u27LqDRHV/LSK+l0kl7wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G99W/pUVAaJdQAerQfH7QQGEmtgWa3a5/l3i68j3MBw4YgFSpu/si0GnSQA/FMUnNJlzKHUxvUSQ6ncmz6S1bATzuWK8czPxd7WU2UXOBHh9FUwNJlicHtiAtQSwzsqMkMXn7zi9I92LNCcdSZUZryeRB5M6BsYmMPP69yMJJPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/sQKpbb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nPXfmI31; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/sQKpbb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nPXfmI31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780750273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1m5xxZd7fzIZwjMAbL6oXxPh2XRldtnlsC2OOhK1zM=;
	b=b/sQKpbbEyknDWwNwd5V+9XaBJ5O9kgZVen+bP+aSCCrzwsojEEuCCE+C1+OlRbqjddm4d
	oJBD7ISYpkkv5aMtyeVT7NYaUdtVMgKNH/rH4rrcnpb/cqq1ZvV4ERu1yvs5rlOviMgonr
	RJpeJVOdfVda+ojXWzt2fOFv5wZFtuM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-gcE6bTKYOyODeJYnl14vPQ-1; Sat, 06 Jun 2026 08:51:12 -0400
X-MC-Unique: gcE6bTKYOyODeJYnl14vPQ-1
X-Mimecast-MFC-AGG-ID: gcE6bTKYOyODeJYnl14vPQ_1780750272
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7ef69fe0050so496657b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 05:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780750272; cv=none;
        d=google.com; s=arc-20240605;
        b=baf1HCmBdQrr01kpus08q+Y0G7mddY8Xzs/NVWSmkWNopuVVc+UcEylCfiYCnFBl0b
         okvqR9d7OjuxVxhe8Kv7pAv/fOyqhmvfmnnPE63IwEVV03QP/KJVcL7o88dsjFFydgnA
         AO0RcO0ycZ1WN2RlnvW9UKB9vEGGjjPAwxbKaSIS1NKWwpqfBcJFEkbQ4N+QRmwuhwgN
         uqZCHXA+mnNi32L+hQEtnzkajeUh18n2GbPelhEkKbY339iTTPIlNZDwLzNOtNegrrv/
         ZQoCk1A5I2y5aIUXVC0GtBPLs4HfV155WmyQsfV33PK25gT4qAJj8thFS2tIhVxzw8Vi
         xhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q1m5xxZd7fzIZwjMAbL6oXxPh2XRldtnlsC2OOhK1zM=;
        fh=ISycuRQVonFFaQilA/Q815tbtaqRQxMJ50XrdTzCUkc=;
        b=KPqrvoJ7SS0xKAfGDTxgLU9pVhWptmUPsGUlTJ1DooiYZ0qJImUv+LjTcWPY5+Us5m
         VTrMzf+Dg+wZd3ql9+Dov1ztrnRwyodbKrtM2Ck5lXH0NGcVYjGEMJjfHRSEy2WzJFsl
         UXGjt+NSLjgVCj5HgMxHgaAwX0uYN42ZfARRVYKW3Z57F77BzMPRsPJ5r4VgsCIsSurJ
         nAif7BQwPpK06lj1R7F5Gj7wXDTP6R061KFrl2lwiiaCNx45CEdfJrWCkGGDTrvc+H6U
         qZNakGY/KscVdAPipa73SolObOqK3ratzdlV56SPy6A14rM+kljroELWzpKzU2xk4etU
         Zf7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780750272; x=1781355072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1m5xxZd7fzIZwjMAbL6oXxPh2XRldtnlsC2OOhK1zM=;
        b=nPXfmI31DXY/S5RIRBWuNmi6dkDuEdUwnYDFBGFkRhGBSmlD6jKZXgrZJ/dvAjB3r+
         YkTfN3+m1w+IbrXJRBovoxSSE1GZyJgm69NK61dkE5w1KR9azIPdOZe2neOWNYZFJbSc
         9LkepCdY7oTFvymqCSCQ0uOWrblS8vqfbVYqzkOhiV55HMKMWtGhI5wTJ9P8HqeY99Zy
         oaZbsUnTygZW+JmcEhDYQnxDybKNCToNK2uladtL+ccdanKjqAz4buNZbY4dClWUMyKg
         YST3FHC/BQSSWuFH0284oSgvy7QcaBL1hLJ3rU37bXPpdSWpUDVvWC/48FZfw/rP1kDz
         fzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780750272; x=1781355072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1m5xxZd7fzIZwjMAbL6oXxPh2XRldtnlsC2OOhK1zM=;
        b=NP+Zs4cefSrjj03edUasm1oAHA9mmfnqRGNYVkbCBUY5INhHSPXqVqujQyvGcWq0Bf
         maosZ+F2hwfa1KIJFWjYsurq7DDWSJWmWXzWAzsnB0+zXIAh2oA3CMi5+v2kCYPyy+rt
         0HpqxBP0EFPn3JLp8t9wut8YsNC3yc9di9zkLHyI+w1JtUWoJwqN1ZvQ92F2FI90+tt3
         5SP2NeaoEuWVgJOsPX5vPPrUwFZmMOmIrObAVaWmvtAxLNIgkEYQ0pyzcxYUvAbWatCy
         mw7Vh50IqXSIz6dcZakpT42LsbCLqPkI0xAsUepExalYpXimePXgQkAAFLaLBxhZKO30
         z3tw==
X-Gm-Message-State: AOJu0YwxKZPGLtepT82ttajzXx1QRgXeuULasNbmR2HTab0rfT0GBO9w
	5F0uiLyyYZSAbHwioJTqMCCe8Lcn/+VeCFT9BLu24vEW8FKblpHdF/2qXsczWM9LMbXTcVQydzR
	S92K9wI2RQ3hE5YwtrW96UCTgzwgFfL0L9ICCGowX4NDVOTXE/CH8Zu0zWgD1U/qZZTG571/RfP
	rez2Fw5CjQoAKtoJenQEeb0xi+X4IQKxuzOhOJh7uf3g==
X-Gm-Gg: Acq92OHtyG2oHolARlAzmZ8CwZJ1e99vy5xEeBOsC7bz4t+dEbTmCUCZJHuQ4fDjV6V
	KVtpWiee1RkF6V6r6719f6iUAdC1kh7RJpWhrgQGpCq1FDs8PbYege+pe3PmxNxJ1i/GtasUaHX
	6fsDmNPAidFfSjYIoIR36/4XjSSDEjnKLUvcvzwGQf2cbTZS0hMJ7fMedAf1nEnC0ZV12VmmmVE
	MDBQN6MBHJ9skK0V5/hFVGIDh2s4DcPkUl+6VrslFReowNOooyFYMP1btG/E1ByjmsTnEBJs1O1
X-Received: by 2002:a05:690c:45c5:b0:7d1:b184:5407 with SMTP id 00721157ae682-7ed0b871b0bmr74246147b3.18.1780750271892;
        Sat, 06 Jun 2026 05:51:11 -0700 (PDT)
X-Received: by 2002:a05:690c:45c5:b0:7d1:b184:5407 with SMTP id
 00721157ae682-7ed0b871b0bmr74245857b3.18.1780750271441; Sat, 06 Jun 2026
 05:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 6 Jun 2026 14:51:00 +0200
X-Gm-Features: AVVi8CfWOAw6AzOrpTrmxXH9Tw6_25DD14ve85a8cz3_xS22j78mUGbUjJQYZVg
Message-ID: <CAHc6FU4OrWx08hrzcY5v9303F=G__MVnMxAbvz2pbAXAFxax0w@mail.gmail.com>
Subject: Re: [PATCH 0/6] d_add() misuses in ->lookup()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 9:11=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
>         This series converts a bunch of unidiomatic uses of d_add()
> in ->lookup() instances to equivalent uses of d_splice_alias(),
> which is the normal mechanism for ->lookup().

Thanks.

>         The branch is -rc6-based and lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-d=
_add
> Individual patches in followups.
>
>         All of those are equivalent transformation - we used to have bugs
> with d_add() misuse in ->lookup() instances, but all cases dealt with her=
e
> were actually harmless.  If nobody objects, I'm going to throw that into
> -next this weekend.  If any of these ends up picked by the trees of
> relevant filesystems, all the better - just ping me and I'll drop
> the commit(s) in question from the series.

I'd prefer you to push this gfs2 fix if you don't mind.

Thanks,
Andreas

> Al Viro (6):
>   tracefs: use d_splice_alias() in ->lookup() instances
>   configfs_lookup(): switch to d_splice_alias()
>   ecryptfs: use d_splice_alias() for ->lookup() return value
>   simple_lookup(): use d_splice_alias() for ->lookup() return value
>   ntfs: use d_splice_alias() for ->lookup() return value
>   gfs2: use d_splice_alias() for ->lookup() return value
>
>  fs/configfs/dir.c        | 3 +--
>  fs/ecryptfs/inode.c      | 8 +++-----
>  fs/gfs2/inode.c          | 8 ++------
>  fs/libfs.c               | 3 +--
>  fs/ntfs/namei.c          | 3 +--
>  fs/tracefs/event_inode.c | 6 ++----
>  6 files changed, 10 insertions(+), 21 deletions(-)
>
> --
> 2.47.3
>

