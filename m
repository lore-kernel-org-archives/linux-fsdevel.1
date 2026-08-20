Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284F3A6F04
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253182; cv=pass; b=kAQKwDLe/iobu/c6TZVe33bJaMxFoo+ZvOe1evZeYCUJkCMg1Cl7EwcJHAaHQsYNHcT7suswq8atC4FKmajSEaY3V4dN7eg/th4tnLsLoN8Jd6gCXII9Ai5EmQXWQg9aldz0nUm1zogW34oWXXL+r3jfve+Djya1W3JOuv7gQGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253182; c=relaxed/simple;
	bh=EBJqidiCcHqzIqgjqJGYqBp8ou/sDr6lv1shRSRmZ0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xcxi3W0DL2A3XH6fZWz3seR8NW3ErI5uwEBkmbfYtcgyTgCK5q01ImvoH0OMbr/jvmwCz/GiAUchiug76dhAaUZyIm9Fx1ikspdIf1DJhw9gHFP2LBqjxywW5WbzvIi53nrRMVczcnGjZW3jzx92krc5dMKtW3wH45ja+Dy2cGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjtxiRk/; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjtxiRk/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a3e145e1bfso373548a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 12:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787253178; cv=none;
        d=google.com; s=arc-20260327;
        b=RunoATTzZtQOi2C7PKPzzwsff1wJiuiLTCGSL2KyZ53GYRe0UsGm64XTifaH9e0LYr
         hAvX+XASPwR5axUAcrOMVrthcWcnSbdShx3Ju8Mjn6a/hfbXsp7GJvKSPFzSrI/NaAa9
         VHMcpTjYGnEREw8I1hZGsRQhH3M9wkQZ5MZ8W2MyXHb5M4vlhBS672WzxEoeyUE0jRRt
         6d5Ey5lVbKL9gV5FdaybuFPxr0lt4tWBnzQVe8fCcOrRL9H6BfJ8gb7gQjr1dfwdBUcV
         NNWTsLhqirCEF7oB0i9JH+L1a3lH8njvq8Nu61Fs+fOjF03au7qNPsX4cAMpLQPMvPnP
         U1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u+vZFL9QCUrHQWNeywdrmX/CGS7XIPcGZmcJEdaeksA=;
        fh=11Qjg5PL5mC3HhZvQb+R7Y1HIDO1pSZ8TfrejxAe2nM=;
        b=PqEo4QRfjJwTMCVwXkk+3tmGCPitnE555O4ATLAcj7xM8Qk195lRdGDIqRe1q5b+iU
         Sg7csJ/+j2jQbilT0ldIS6uP/RRK4HLw15dE2wQG7xUyaYPYUOFuzpP3Gjd40W00LAnO
         q5gBFSiEhQNjwDprH5DDUvx7ts5IFK8NCzubh0xg8YNTuSy2GWFYx8yFKLYXvkd5xHLL
         0q3QQR9FOO1JGYlCg70MJ94qvExd6Sl+9JXBNE6QYBxJnkEavGPe+p9PhLtS3hJ6Z4Gq
         yV5gfCuK95Y/k/cKJQXYkPwCAazOEpMZ0fvLDQL2zjAoQ37JKLzegK5/k00VwtpEIWqp
         +nJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787253178; x=1787857978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u+vZFL9QCUrHQWNeywdrmX/CGS7XIPcGZmcJEdaeksA=;
        b=HjtxiRk/0YfnOV09MlXe0Pfo0XYkO8wCmAN59X9bYO1GQi35prQemChY4NLZhVlLw2
         HVS/N+fvbYBhFREreghfMAHH1z0MxyrHc3oeDxHPPXpPf/S9kp7qIXnxxqDeNK9hSu3u
         65FwLR7TslEzv/zupeh3ceQTAZTxoNnJGWq5LNx0sJB02AlKQzX0cTPs/c3fg1Z3QpRg
         dXhB9r46Pwvse5Qn2o3mQJfFsqtEA4i7BK+sw1zQqntH5xe9IDvwgHTW3ftE+3wIMVoz
         EMTEH82F4xWv0qD2sq8SsqlugnnMo7DhPN8twOZ1PemNCDBYnHrU5xwzEhF4jrdisLS3
         uP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787253178; x=1787857978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+vZFL9QCUrHQWNeywdrmX/CGS7XIPcGZmcJEdaeksA=;
        b=X2kif0WRLn2t4wzep5na7hGpbnn9B29Z1k5P4bjbZbMP3XyYgg3iqNSsCekHy2k0yf
         ayMXrX1BlELWVGO+3vMCHfDEzWMcvXX/Rpo79P9CCq5jg+QqxJE6kTwZCaL/8n9U5jgU
         vLix5gJFsZWsFxHmZ89oA17n+YZTA4hK2X2J7gv3wupVLDfJgcBl5I6QhfMKSF5WjBpl
         eVbmz0j8QdqPQ620l3IR/iHeTtaVwDhKk1/9N/jaQALrX8h6lDy/+jU4y+20/ILkYRID
         D1qJ8n541xSqnuQCyjs738Qp9gO/F5xgk3aJXwLr653Z6bZZavzKVOQZnyqJl/sFLFlI
         XQAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpz4mREZgSASHKLyjvxbv8+F7dBTBvr770PudBDVLtEW7YfRjbr6aM3ldO41Jy7v5oHJp2+EBnS2ADzwyE8@vger.kernel.org
X-Gm-Message-State: AFuF++nJ/M15hgOxAmPt+NswADUGz8Muc84tU30BBQ3iJUrCLusvsO8g
	/nPwp6ObDyYgLcp2YnFRNJIpeRUFyg2CxLujR/KFXgd3H6VyI1kpNLbNZRe/L/yWMl9/juPuNjn
	51kUHVOYWap/vQeJ9xC+V0VBddnj8wpY=
X-Gm-Gg: AR+sD10zHiruXUrdclnqaGtGwGtSLaQr/1ahw4UlfstsUkArpEUPAfMjkO4kp/V08eX
	KIBE2F+IHTTTiMD1EOc2oOhBbWHuDbdTHA6y7EaBPpuU4jcsx22r4n0tB/JinmrbpP7XWYeQzYb
	CA5Lg2Pcp0n3HsLOL1KzTrk966wMyzU/jXMuKZAj8ONeYQtbrGY13WDW+WvB81mI1zgiDOET1nU
	VCkv7VKgy6XtHFDdvcCzZMfAZTttll5JAofPIe74kDz8HX/nq+2CF6XDS18QsZHe1DkAvH32fG3
	8KifaypYVd8bXna//j8OYIcjkZVebzcAUjHLMorXXEOnCg==
X-Received: by 2002:a05:6402:e09:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a42f14d945mr881033a12.1.1787253177867; Thu, 20 Aug 2026
 12:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820175832.44512-1-kmehltretter@gmail.com>
In-Reply-To: <20260820175832.44512-1-kmehltretter@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Aug 2026 21:12:44 +0200
X-Gm-Features: AcwNN1VoTb8-Y4yAhAEdExFUOY6_E29SmGdgjuOoDLFC6HRxDrS8gXBvh8R9q5E
Message-ID: <CAOQ4uxj+uFAR3YjE+XX98iJAdxNNqnaM6pptsqPaXnqJk4OXWg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:58=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } agains=
t
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
>
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
>
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v2:
> - Add selinux_file_user_sid() helper instead of open-coding the lookup
>   (Amir).
>
> Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
> nested overlayfs mounts. The policy omitted only
> base_t -> mounter_t:fd { use } among the relevant cross-domain allows:
>
>   baseline: mprotect(PROT_READ) returned EACCES with that denial
>   patched:  mprotect(PROT_READ) succeeded; test exited 0
>
> This patch fixes SID propagation only. backing_file_user_path() still
> resolves to the middle layer for a nested mapping, so the audit path and
> inode do not correspond to uf_sid, and that layer's mounter is not
> re-checked. Preserving the full user path likely needs a VFS-side change,
> such as having backing_file_open() store file_user_path(user_file).
>
>  security/selinux/hooks.c          | 9 ++++++++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944..171b90412ff1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct fil=
e *file)
>         return 0;
>  }
>
> +static inline u32 selinux_file_user_sid(const struct file *file)
> +{
> +       if (unlikely(file->f_mode & FMODE_BACKING))
> +               return selinux_backing_file(file)->uf_sid;
> +       return selinux_file(file)->sid;
> +}
> +
>  static int selinux_backing_file_alloc(struct file *backing_file,
>                                       const struct file *user_file)
>  {
>         struct backing_file_security_struct *bfsec;
>
>         bfsec =3D selinux_backing_file(backing_file);
> -       bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +       bfsec->uf_sid =3D selinux_file_user_sid(user_file);
>
>         return 0;
>  }
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 3c0a16ec978b..853f7266ed18 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,7 +87,7 @@ struct file_security_struct {
>  };
>
>  struct backing_file_security_struct {
> -       u32 uf_sid; /* associated user file fsec->sid */
> +       u32 uf_sid; /* top-level user file fsec->sid */
>  };
>
>  struct superblock_security_struct {
>
> base-commit: fd6e2388a3ea55e58cbbbef840c1d8aa2067dbb3
> --
> 2.39.5 (Apple Git-154)
