Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCA37649D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300014; cv=pass; b=RcP2/THdSz/6RnuLgw8IcZRw16mbVSwUVC8lEkthAGZTZSB30cgqU8RvOt7zfN/rdjIM6B6/MvLIAcNtFavELvr/5o40UsaCIeAQlKq+RnPUgJsHGk7IgAywcx7YZ1TGLU4j+qlOmPlP/6+WDE0YxJ51kaWSkuhTwcYgsDqXLJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300014; c=relaxed/simple;
	bh=lj1WSksNK02aO4n5dob09BxWp5H6I1TYco9D2RasOo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAFFWjG96DsAsyZIsbvyGztLj8/x7REPJDMwMzMbjdGAlzi+EuPcCjRGVOIbFxXHuvaHQnRsqsxCow9kiP+E/ozpbfOOn5gwen7nc2iSvB/EXFCgzyFFuV1QW8gUqu2Y47fwuj/yK/kopPW1wZSgtkihmFfdE6YCvCRjepkM+pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBtcS8Hv; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBtcS8Hv"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c742882d2a4so1353450a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774300012; cv=none;
        d=google.com; s=arc-20240605;
        b=j56b6ArONevhOGzqHbq0DFVpFmvB4WdeMp8UmJSRV86KyOwU3JcNJ5IbvzHz/rA5Rx
         LLVv9Bh/4NIQFG3AH9V/uafHBTTzD01ex4+O72ULHzn5sdhF9Ju03+BnwHMsTPFtJbJR
         c+gTyx6VCRWGKC6+39593NRQ6bZQfXcNW4lWQJbZ9XbZeZv+wkX0ZQ6jJhLTLxkWnsBD
         piyDEskk/bR1T9m4n9VOR2/NRj816QMdz4h8B9MjqCAXnhC8qRes/jq8UXDvZ6LK0xu0
         cGZULYx6AdObgYUzRf7RlXUBR8XpqGje3LW1weukR8m0kgTg0g+j+5ey0Mc864KGczoc
         b9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        fh=MQ2/zP0AysStS8HqRgAocYRfDYpDSzT0Av77y0m8IuU=;
        b=GklDYLoVpFlbhy5Z6qadpIAXPmOx4wC26QsMhC6/dGEQN6oFQCaCQ2YaSztNVxfpXX
         +iWPi8dLQ4YzNtsEAF1rKIN3nKiD24AqpXDgpG0fhGrbdKsBUs7rH9U+TLlv7CpnHGUS
         oXEmECsZLSXeiFFa0nAEMXwTCzWe2yjXPESmG+c/QCzJfcyrrqg2bpXM2OqcplargT+l
         dNfTs9obyUHJMcSSwY/hxMoO9i43/eh8/7Q62RzhACQvfd5UOFILO9Q2swoLQUJS2us9
         PiRevKFqRiAV7XTQgftnFoNpjfOeRRCkFAii7JeOPFrjQq3FCTbhYw3xX0ecUWO1eWzD
         mzHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774300012; x=1774904812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=QBtcS8HvpXO9IbViIwHmSUEd1cdHjK9S4SFD+KrQZ8bhDITcqbTe3aRVCdBgTe2A3n
         yPEMyrAXW1HDf/yOqvfhmV0UV6nsguDlNnwsiu12fdLFTcyQQDeLoE4ppjSujK/vYbur
         6Vh4bHjxQOGvJNvQcmIiGYefdfM6j1bAXms/E3+nKb3ABshNU1uhN6kg/vVgaD/GcP3E
         akpfjZl48gVESxxOIaGcrKwYKHddzWZAykOpSpFzHdXM1Jum5FB6rgUjQu+UPGDg6Q7/
         V9guohjp86bKIOaGeatTnM/vNT8vs82Ng13J8AmyBqJbn+u0bMDJq0vLUZtTY+smpY03
         GnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300012; x=1774904812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=TIkf29NpIcJTLOATZo2I7hxOeKozUn9hypojnCHqwLmc9hMpFNQ/YxKk04ZN5zoQeo
         sIsBFWClGAnd3IEkHfZuBV7eCQCACyoo5RQobWvXMEXwnZk3xLbp43kzAQARUDqZv6he
         wm4alSLY1PSiTwZHvh+uc10MJAaht1BuqJaWSR8XLRLNwqlTImPwM92BPg5je7O2IHO8
         d0nPgI5pUDDGMWw0RgOfqd5bY9ySb8tplvwc772o3neg20uTfUUQPz1O9+J9OvyWuWy5
         Hagl9pZEc7rZs4ZzAe8vaSRkER1mUczsbSBhKGF1x9CWjMFz3UxdF8U75n4Utv1dMfiz
         zB8A==
X-Forwarded-Encrypted: i=1; AJvYcCW9R5E28YM4P531MQ4byUQLTHjsx9rkpKsfHkLE/6vr1N4w4aXKxzhK2EskYlW3bJLNIHi7N0QszTfjh9n4@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOcoSEZ9K+X3CXnYciJEJzUJctAeVGbeNPpgGGL4Ha6AwDLRd
	1il9d3wi2dPVotGUJhiFP0rbO97zB0bY9AY6HiG7Ofiww+ixfFl4baRWc5w/jb3LLeYuIFLNRS8
	OIAx4dPbe8nD9g1sErUU4UU+9AlKCDOB7mAcmTid8XzVjHAZYRmE=
X-Gm-Gg: ATEYQzw0TJpE8uqvnn0h3Zi8Kb1pnPXlxjIt5OmoYZmDQDzmAvOtDEFbXCeYCfBs6kH
	83ZPrcr8MoLbsRHmsbjvAZVTyMDKP5y5+U3ghrjT0zKPgRPsJh8J6krYSCleLKGVWVXooHv9nlE
	yzEdKzQ8GPZXBP3NP7+4l/cMe4nuINZM8pak8/1rdTURNUtX4bSZGQVBE2b7MJfZ5pyNYMM7q8D
	GsQUDnMJxmy2UdQ/nXv3RmdX6Yq7jhZQ2wlHm5LnusQkGVSPvNW4DC03ocAf0p4xQHTXNG98o2O
	qW20awU=
X-Received: by 2002:a05:6a20:a124:b0:398:9923:749f with SMTP id
 adf61e73a8af0-39bcea1d2c7mr12205176637.20.1774300012580; Mon, 23 Mar 2026
 14:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323042510.3331778-4-paul@paul-moore.com> <20260323042510.3331778-6-paul@paul-moore.com>
In-Reply-To: <20260323042510.3331778-6-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 17:06:40 -0400
X-Gm-Features: AaiRm51oMol5rD-3lC5JmUxYQEOgP29lPad5MhWEYDTptj6N_TPcJrob_X8Dy0s
Message-ID: <CAHC9VhQJcuA0VTpGSD0-x+Z5a__SQBiYfwc9zWwLMDa6THfKPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:25=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c          | 252 ++++++++++++++++++++++--------
>  security/selinux/include/objsec.h |  17 ++
>  2 files changed, 200 insertions(+), 69 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..2a3d524dce24 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1745,6 +1745,60 @@ static inline int file_path_has_perm(const struct =
cred *cred,
>  static int bpf_fd_pass(const struct file *file, u32 sid);
>  #endif
>
> +static int __file_has_perm(bool bf_user_file, const struct cred *cred,
> +                          const struct file *file, u32 av)
> +
> +{
> +       struct common_audit_data ad;
> +       struct inode *inode;
> +       u32 ssid =3D cred_sid(cred);
> +       u32 tsid_fd;
> +       int rc;
> +
> +       if (bf_user_file) {
> +               struct backing_file_security_struct *bfsec;
> +               const struct path *path;
> +
> +               if (WARN_ON(!(file->f_mode & FMODE_BACKING)))
> +                       return -EPERM;

Based on other code paths, we should return -EIO here.  I've updated
the patch, but I'm holding off on posting another version for a day or
so in case anyone else is able to take a look.

> +               bfsec =3D selinux_backing_file(file);
> +               path =3D backing_file_user_path(file);
> +               tsid_fd =3D bfsec->uf_sid;
> +               inode =3D d_inode(path->dentry);
> +
> +               ad.type =3D LSM_AUDIT_DATA_PATH;
> +               ad.u.path =3D *path;
> +       } else {
> +               struct file_security_struct *fsec =3D selinux_file(file);
> +
> +               tsid_fd =3D fsec->sid;
> +               inode =3D file_inode(file);
> +
> +               ad.type =3D LSM_AUDIT_DATA_FILE;
> +               ad.u.file =3D file;
> +       }
> +
> +       if (ssid !=3D tsid_fd) {
> +               rc =3D avc_has_perm(ssid, tsid_fd, SECCLASS_FD, FD__USE, =
&ad);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* regardless of backing vs user file, use the underlying file he=
re */
> +       rc =3D bpf_fd_pass(file, ssid);
> +       if (rc)
> +               return rc;
> +#endif
> +
> +       /* av is zero if only checking access to the descriptor. */
> +       if (av)
> +               return inode_has_perm(cred, inode, av, &ad);
> +
> +       return 0;
> +}

--=20
paul-moore.com
