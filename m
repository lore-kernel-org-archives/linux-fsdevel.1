Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45266377AA7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377699; cv=none; b=fTjwrtkZyhgtW1tXrYQ/2uXT+iUenCsGpipu6nfMtn+WJuUusustOjqTuA5F9unVb+G+ieidYR6DJaM7aS0zgMVSozPFopkb3mZr4EumXQ2e/2NKspzlVZCPd2r/2Atdv/f/52IzEN44UTTVIjRF4P2YR5xK/fBZ5jcnBmqEuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377699; c=relaxed/simple;
	bh=eh+it0zb54ufEP/JnblEMEpySL7Prj/F5s/H28111ro=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tQ8ENKRErXgmdC3USFC7Q1wGPhZh0n65pOGRN0OlyTE56Lt1oja/ctVlmmUYiKjQAyPALdqYCOr7rkz9/RnK7JM7dyg8q9rsIMkNq/trUVhw2HvNf4mXNPorX39wRPFAm/+kmSbgjiA9S5RwT+2+Z9Ondb9n9U37XaKKndXsVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BApmi94N; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BApmi94N"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90cd0e6fd80so14514166d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377687; x=1788982487; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=BApmi94N0haia63+fWtF0lO8gtf7CPbnhyiBUjO2IH+nYwAJb4uJXYRK7Cr6JJKpFk
         YxGptCgPyiA1YZmnPhS3FOGlqVAlbkwTb/eVF5NtLCuLuSICFUx37nq/Nns4yNA2zgH0
         CFYc13B4d2J1cC4nKVeZUp+yNmFJrn0DoYd6ScYOlVDpCIQWM8wV9IJ51HJQi6KW+GVF
         nI2FzCFnKFMfXHpWkki8P6hmZ4q8a2BhC/Xez0+PIPWLa+R4Uc0B91tXHiwfcP+6AsP1
         FRMH/M4HjtVOxsSROaRN5mJYZjmLY8FnTjlOzEo1VRpzChFgoAHEReRUhVrJL43U/Yma
         Kkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377687; x=1788982487;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=RgN8La8MMzMagkMc0OYN0XuFGIwJSCZy3A/s21nVWHgM593XtWgIh32vAOv8ZIm3Oi
         OJoMR+LVavLgjjHMEcBuuZ5+hO+9c6w0RM46hjyLyJiJP8rP9jO2GJk5We6bai6tqmAI
         z7Vm1tKsaAxUv9jrkliW30wKYGw0bjlVkw+sXo6Tx+u4f71D7ubCDnwIsp0CFIyEneIK
         GHgV4yDVRdvkzTmGipejqbRbLsBco6AWHWlCRHvLxNYFoy8d0oi/qLZGuKtqsEum1FhQ
         qPchxmb2GEMtv1j7UzivHZkfk/MRcxBOkKFHLPLQk5YA8aJRbJ6JPRwzu8zbcMhmv43t
         R8ug==
X-Forwarded-Encrypted: i=1; AKwUvBxPGJhBaIGYGf7Orvd9cb+TMNcKS8Vet20DQ5jCwRupG9VqPtEYQamsvWN8Lc5vvLhlpsHPMgy8XkqoFfqM@vger.kernel.org
X-Gm-Message-State: AFuF++nN9HnTiLdK1gcWTpcu0yAz51HbYFXV/7v38QN13KJESn1Sog60
	t5jA/zoMlk3ti6YkZfAq82AAIZYZuF42CvJOxY+6BY5A6YFXkQWsOSMz1RT0hTXdNQ==
X-Gm-Gg: AYBFou20Kss8IRbeuFGu3isRqZKe/GZD7UHxCjnPbvh3Lm9jMDdxq52ifn3t5a677d+
	TPMUshqOpPHxrK/vsQDAsknW9gs5rdVfS+XbcA3KbDdJUHZR4FwJDbwC5Slr+K0nXxAJzSrYGAP
	JdU555PUmuKTMziZesKhK5VG9/kFLyXmys9wQ7zIiTywzg7XfIiZHCcKosqiVo7mf/yMi0oRaSu
	U0rMksnmuUVgVgUr+H5l5jygXW7z1Mrpi3Xo4Nhglz7h0aW3XxePsStvIRO8AgrGjAKV4IXPp7P
	eu0qymVKhfvJzcwNPJG0fAwkLJOi4iJP5FlpHbSFJZLzUkVxkgF8LJu3hlvIpbW9qGVhx0qR9Io
	pvUzrGEKFXVSJtjph+tymH912SHOZ2sKZIU0U5an5lhDaxwSYJtnYmvS6W28y3EsNHLgAH9JWBC
	uAfgzvcxvvXwblPExKGmJdw6TO1s83kTZeZ7mWWB4ZBDjdoeGez4moq4mdilEWRIB3W627ocxts
	FsrpF9TCgygXq9VjaK2Mw2T4j4P8VWqtw==
X-Received: by 2002:a05:6214:e85:b0:90e:7de2:d81f with SMTP id 6a1803df08f44-90ebabbac8emr90744936d6.20.1788377687526;
        Wed, 02 Sep 2026 12:34:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm25176366d6.2.2026.09.02.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:46 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:46 -0400
Message-ID: <e266759fa7a20e9620b16c1b5a717744@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260901_1604/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Seth Forshee <sforshee@kernel.org>, linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 11/27] fs: port acl to const mnt_idmap
References: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>

On Sep  1, 2026 Christian Brauner <brauner@kernel.org> wrote:
> 
> Convert to const struct mnt_idmap.
> 
> A mount's idmapping is immutable. The only thing that is allowed to be
> modified afterwards is the reference count and that is hidden behind
> mnt_idmap_get() and mnt_idmap_put(). Everything else only ever reads
> from the idmapping. This is the same model that struct cred uses and the
> idmapping is also rather sensitive.
> 
> So make the idmap argument const wherever we can. The conversion is done
> from the bottom up so callers can continue to pass a non-const pointer
> to a const parameter until the conversion is finished.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ntfs/ea.c                          |  4 ++--
>  fs/ntfs/ea.h                          |  2 +-
>  fs/ntfs/namei.c                       |  2 +-
>  fs/ntfs3/inode.c                      |  2 +-
>  fs/ntfs3/ntfs_fs.h                    |  4 ++--
>  fs/ntfs3/xattr.c                      |  4 ++--
>  fs/posix_acl.c                        |  6 +++---
>  include/linux/lsm_hook_defs.h         |  8 ++++----
>  include/linux/posix_acl.h             |  4 ++--
>  include/linux/security.h              | 16 ++++++++--------
>  security/integrity/evm/evm_main.c     | 10 +++++-----
>  security/integrity/ima/ima_appraise.c |  4 ++--
>  security/security.c                   |  8 ++++----
>  security/selinux/hooks.c              |  6 +++---
>  security/smack/smack_lsm.c            |  6 +++---
>  15 files changed, 43 insertions(+), 43 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM, SELinux)

--
paul-moore.com
