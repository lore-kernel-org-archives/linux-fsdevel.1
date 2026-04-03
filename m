Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05402364053
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775197048; cv=pass; b=k/3QuWZhE3kFm15npe+yGglqjW7KohWvTgkZmGh7fWt3eGckXibZLxUDCsGzWFnwaOGlfQL2Kf2JIfj1iWimRrPxnNvUVsgGCA8CW9Z8pBEoWzjmkc5YDR57WFV+MOVRNnZgEqAJS0mXgfirg80A+cNRNAIIzivPDf4ui2D82iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775197048; c=relaxed/simple;
	bh=uleAhNH+oO2YbR9dRTbQ4apX5Z4tQFFheSINmWB7Bm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJT7VUScBw7bp9sE3kjxSZCtbCAvhSQDpO76thQ5/II/eCN0DwrxH2MzKoFOfAEDUXhrPVjvM9M63N8MKZ6e3xUD7R0XFUZkMhmipmTm72e+GE4jDvHENdcGc3YosLlsiUiOkmujjlM1uWjhRxVfkhkLz27sXq83kk/uwW5VByI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8wjxhUh; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8wjxhUh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66e209d03b8so1646385a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 23:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775197034; cv=none;
        d=google.com; s=arc-20240605;
        b=U+ryo7o/9Oeu6V96My0P+Qc4WAtr6vpZ0VVAuCRFi53vT4U326XRgxsO5vFSI/P2T1
         M6Ymp6lqWi02SFE9+mqqbUVxzRr5QQGHNCulgYs1nNb8CqaJOAe1X4M+WKFfB52VWmmO
         hBnlWuh7IBGP+6BG8aGjs0lLk9Dv29h1zsEOIMicle+oVzQ0XOGw9B9CrbcthxZYAuni
         jmOiaeZqrUCe6U4P6A++54IIn+O+U5JGbwoC6f5ZXlEbu3llU2BlhLy55RuBb7kafyWx
         y17JqZaZ0uefeHRj/PQzY/kD1lUXdPwCJIi70psnEWaCjKkZQ1ch3sdW2ZcbD4h49b/l
         QOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2ARNn36t/8nKb8lFPnRUge6KFlcIwa4Ay/uiEuGZEU=;
        fh=bQeA1MyZjlzMsrtigzlnUSNLCluU7n6GHX4DH0qpaWI=;
        b=USGSgBG9L7/BIKCrm6765046rIhPoHgE16kkRoqorvOH/KEcUsaNrW9RJG8BToDVrE
         Ut0xbbqm5WV+7rbHFZbVmmkUrk3zzPhwrMNqsPi3pDmzIBZNAC+vKvqwjPZiSEH2QjzT
         qU5/0Q9bWlT76Msq8OgYB+dBaDEaO/ds3/YoI0loiqrD9dIby90RTkznQ/UeY00GUHIE
         ebl7QTEWiEGc1HZK1gPYsdNc0sMLf1tanQcHMqXf/spvOCx+kivbo1P3WuBopT9Q+Wiy
         D/fak7yEuBakZJRQyyalKIwaY0i8vftlkGivsxWGJLq2+2WbmiYlm91ZXXL/JWgGJKrA
         94yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775197034; x=1775801834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2ARNn36t/8nKb8lFPnRUge6KFlcIwa4Ay/uiEuGZEU=;
        b=a8wjxhUhNzdPsZUs8l6fsF9+dyLlFhZofFJwA+y9Vam480zWn3jb+R5DOShLygKHmn
         DdzoTOc73MY5qH9LYvaEaAxFaFN/h9lI4h6S4FQDX4lnwa4gz2EcV5Qe9RDCpVuXrIlp
         EEWiHn4/0+7LD4Ru6QKIXCvGgCVw0cri83v1Udx51nhH52fK4407Nd7IdtV5ISpiYgtu
         6EoaVPRdz1nbLOxGonocJdYowMnw9gSepOXQA32vOVUf63o0qkxpcFhEgT5RoyvflUig
         Dcgcrvtzb094FcFd0gVZR60s6V1LUBtpD8iDebPTd0QFsmsQLESvi+RpFZPjLYuhwN0l
         TmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775197034; x=1775801834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2ARNn36t/8nKb8lFPnRUge6KFlcIwa4Ay/uiEuGZEU=;
        b=OWW5liM4ecNprlDDcCX8AuBJJ1evV8i8wvbyIEtpdKwfaQ/OG5XyKnFU8Jb7UPQpO7
         6kwFz/36c2L02QR7qXlprN13Km4KzbjBBE6AvTqToNCR0tntc3uHMgrDZgB6JExSHl2H
         6ocoNjIYv6l7POc87XU0Szf4v7leWwSIafjANLhX24cBepYqFXIdNGrugGd4IwFPAIVm
         LfqqEP9CK5CHm0PEEv84Cn0Le50QACNTWTNOAB6Qd6Nx9i0sb1g9/5MRv31kMCDnPzOQ
         FguE/hZeE90s+7fWkQaFXxpqMVne07LDzyyP3SFUo+ykNcx8+aUsn1pO+1MrM/vUhdck
         kqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2yWKjJ0iuoF4ITNYRKWR/Ld51F33+pwj+RMTQoW+yIcm6OitIZ27a1ASj97tYz9xJgVk66S3KOc0DWL5i@vger.kernel.org
X-Gm-Message-State: AOJu0YyztgfJzNNl2zPr37QDDw8ptgS7jRkf6jDIg7P0r8HDVc2UkPZL
	fV/WtDdS9uDUr6MkRdQhnebcD8pgFqaGDHxgVsjG/ibf0igAZpIyjHZoLF/yEc/PFviO9v9YglN
	mR7i6Kb+1WpIBwo5j4akpZplkB+QsK5w=
X-Gm-Gg: AeBDieudqkpmlpOPPCNcBVWb4m7yqu/yqEd6NynlmrrKSxpgfRJpHylT97J2xMDRHnJ
	WCMcGdwR9GGIA9Xb6QgtkpFSRMYoKByLaI+zDuO/TlVc5FLolKhXIfWH7t4kg4nrKYjzknPQrLr
	hjjkY/y21+ELNIHXAIEPqbn+6butUpvHdW7EZHgfmNVPda30RwbAFkoV4nKNwac1pfF2OK9UcIJ
	tPdjNWV8CLucaeXqSL/BdqjKHX7hS194R8f8kLcCHo68AdsJKwyB1Emdl5jSasGmLw0FlU67Ndz
	lfcl0BnlBfddMc55r175afLb+o/Pzy9kh8jTpp25LA==
X-Received: by 2002:a05:6402:4449:b0:66d:d077:d18a with SMTP id
 4fb4d7f45d1cf-66e3f4da943mr834911a12.12.1775197033329; Thu, 02 Apr 2026
 23:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
In-Reply-To: <20260403030848.731867-8-paul@paul-moore.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 3 Apr 2026 08:17:01 +0200
X-Gm-Features: AQROBzDmsH9YGllMb7aE-zIYe-TTbvJvK67fkAXHUx2ZVad9dbe5P_NGte21nOI
Message-ID: <CAOQ4uxjr=Mc5wQizyhxW3=esCLQvZub1xm3G3SRkUwUPBbPh_A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:09=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
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

Can't say much about selinux implementation, but
for the use of backing file API and the concept solution

Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  security/selinux/hooks.c          | 256 +++++++++++++++++++++---------
>  security/selinux/include/objsec.h |  11 ++
>  2 files changed, 196 insertions(+), 71 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..76e0fb7dcb36 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1745,6 +1745,60 @@ static inline int file_path_has_perm(const struct =
cred *cred,
>  static int bpf_fd_pass(const struct file *file, u32 sid);
>  #endif
>
> +static int __file_has_perm(const struct cred *cred, const struct file *f=
ile,
> +                          u32 av, bool bf_user_file)
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
> +                       return -EIO;
> +
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
> +
>  /* Check whether a task can use an open file descriptor to
>     access an inode in a given way.  Check access to the
>     descriptor itself, and then use dentry_has_perm to
> @@ -1753,41 +1807,10 @@ static int bpf_fd_pass(const struct file *file, u=
32 sid);
>     has the same SID as the process.  If av is zero, then
>     access to the file is not checked, e.g. for cases
>     where only the descriptor is affected like seek. */
> -static int file_has_perm(const struct cred *cred,
> -                        struct file *file,
> -                        u32 av)
> +static inline int file_has_perm(const struct cred *cred,
> +                               const struct file *file, u32 av)
>  {
> -       struct file_security_struct *fsec =3D selinux_file(file);
> -       struct inode *inode =3D file_inode(file);
> -       struct common_audit_data ad;
> -       u32 sid =3D cred_sid(cred);
> -       int rc;
> -
> -       ad.type =3D LSM_AUDIT_DATA_FILE;
> -       ad.u.file =3D file;
> -
> -       if (sid !=3D fsec->sid) {
> -               rc =3D avc_has_perm(sid, fsec->sid,
> -                                 SECCLASS_FD,
> -                                 FD__USE,
> -                                 &ad);
> -               if (rc)
> -                       goto out;
> -       }
> -
> -#ifdef CONFIG_BPF_SYSCALL
> -       rc =3D bpf_fd_pass(file, cred_sid(cred));
> -       if (rc)
> -               return rc;
> -#endif
> -
> -       /* av is zero if only checking access to the descriptor. */
> -       rc =3D 0;
> -       if (av)
> -               rc =3D inode_has_perm(cred, inode, av, &ad);
> -
> -out:
> -       return rc;
> +       return __file_has_perm(cred, file, av, false);
>  }
>
>  /*
> @@ -3825,6 +3848,17 @@ static int selinux_file_alloc_security(struct file=
 *file)
>         return 0;
>  }
>
> +static int selinux_backing_file_alloc(struct file *backing_file,
> +                                     const struct file *user_file)
> +{
> +       struct backing_file_security_struct *bfsec;
> +
> +       bfsec =3D selinux_backing_file(backing_file);
> +       bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +
> +       return 0;
> +}
> +
>  /*
>   * Check whether a task has the ioctl permission and cmd
>   * operation to an inode.
> @@ -3942,42 +3976,55 @@ static int selinux_file_ioctl_compat(struct file =
*file, unsigned int cmd,
>
>  static int default_noexec __ro_after_init;
>
> -static int file_map_prot_check(struct file *file, unsigned long prot, in=
t shared)
> +static int __file_map_prot_check(const struct cred *cred,
> +                                const struct file *file, unsigned long p=
rot,
> +                                bool shared, bool bf_user_file)
>  {
> -       const struct cred *cred =3D current_cred();
> -       u32 sid =3D cred_sid(cred);
> -       int rc =3D 0;
> +       struct inode *inode =3D NULL;
> +       bool prot_exec =3D prot & PROT_EXEC;
> +       bool prot_write =3D prot & PROT_WRITE;
> +
> +       if (file) {
> +               if (bf_user_file)
> +                       inode =3D d_inode(backing_file_user_path(file)->d=
entry);
> +               else
> +                       inode =3D file_inode(file);
> +       }
> +
> +       if (default_noexec && prot_exec &&
> +           (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
> +               int rc;
> +               u32 sid =3D cred_sid(cred);
>
> -       if (default_noexec &&
> -           (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) =
||
> -                                  (!shared && (prot & PROT_WRITE)))) {
>                 /*
> -                * We are making executable an anonymous mapping or a
> -                * private file mapping that will also be writable.
> -                * This has an additional check.
> +                * We are making executable an anonymous mapping or a pri=
vate
> +                * file mapping that will also be writable.
>                  */
> -               rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
> -                                 PROCESS__EXECMEM, NULL);
> +               rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__=
EXECMEM,
> +                                 NULL);
>                 if (rc)
> -                       goto error;
> +                       return rc;
>         }
>
>         if (file) {
> -               /* read access is always possible with a mapping */
> +               /* "read" always possible, "write" only if shared */
>                 u32 av =3D FILE__READ;
> -
> -               /* write access only matters if the mapping is shared */
> -               if (shared && (prot & PROT_WRITE))
> +               if (shared && prot_write)
>                         av |=3D FILE__WRITE;
> -
> -               if (prot & PROT_EXEC)
> +               if (prot_exec)
>                         av |=3D FILE__EXECUTE;
>
> -               return file_has_perm(cred, file, av);
> +               return __file_has_perm(cred, file, av, bf_user_file);
>         }
>
> -error:
> -       return rc;
> +       return 0;
> +}
> +
> +static inline int file_map_prot_check(const struct cred *cred,
> +                                     const struct file *file,
> +                                     unsigned long prot, bool shared)
> +{
> +       return __file_map_prot_check(cred, file, prot, shared, false);
>  }
>
>  static int selinux_mmap_addr(unsigned long addr)
> @@ -3993,36 +4040,80 @@ static int selinux_mmap_addr(unsigned long addr)
>         return rc;
>  }
>
> -static int selinux_mmap_file(struct file *file,
> -                            unsigned long reqprot __always_unused,
> -                            unsigned long prot, unsigned long flags)
> +static int selinux_mmap_file_common(const struct cred *cred, struct file=
 *file,
> +                                   unsigned long prot, bool shared)
>  {
> -       struct common_audit_data ad;
> -       int rc;
> -
>         if (file) {
> +               int rc;
> +               struct common_audit_data ad;
> +
>                 ad.type =3D LSM_AUDIT_DATA_FILE;
>                 ad.u.file =3D file;
> -               rc =3D inode_has_perm(current_cred(), file_inode(file),
> -                                   FILE__MAP, &ad);
> +               rc =3D inode_has_perm(cred, file_inode(file), FILE__MAP, =
&ad);
>                 if (rc)
>                         return rc;
>         }
>
> -       return file_map_prot_check(file, prot,
> -                                  (flags & MAP_TYPE) =3D=3D MAP_SHARED);
> +       return file_map_prot_check(cred, file, prot, shared);
> +}
> +
> +static int selinux_mmap_file(struct file *file,
> +                            unsigned long reqprot __always_unused,
> +                            unsigned long prot, unsigned long flags)
> +{
> +       return selinux_mmap_file_common(current_cred(), file, prot,
> +                                       (flags & MAP_TYPE) =3D=3D MAP_SHA=
RED);
> +}
> +
> +/**
> + * selinux_mmap_backing_file - Check mmap permissions on a backing file
> + * @vma: memory region
> + * @backing_file: stacked filesystem backing file
> + * @user_file: user visible file
> + *
> + * This is called after selinux_mmap_file() on stacked filesystems, and =
it
> + * is this function's responsibility to verify access to @backing_file a=
nd
> + * setup the SELinux state for possible later use in the mprotect() code=
 path.
> + *
> + * By the time this function is called, mmap() access to @user_file has =
already
> + * been authorized and @vma->vm_file has been set to point to @backing_f=
ile.
> + *
> + * Return zero on success, negative values otherwise.
> + */
> +static int selinux_mmap_backing_file(struct vm_area_struct *vma,
> +                                    struct file *backing_file,
> +                                    struct file *user_file __always_unus=
ed)
> +{
> +       unsigned long prot =3D 0;
> +
> +       /* translate vma->vm_flags perms into PROT perms */
> +       if (vma->vm_flags & VM_READ)
> +               prot |=3D PROT_READ;
> +       if (vma->vm_flags & VM_WRITE)
> +               prot |=3D PROT_WRITE;
> +       if (vma->vm_flags & VM_EXEC)
> +               prot |=3D PROT_EXEC;
> +
> +       return selinux_mmap_file_common(backing_file->f_cred, backing_fil=
e,
> +                                       prot, vma->vm_flags & VM_SHARED);
>  }
>
>  static int selinux_file_mprotect(struct vm_area_struct *vma,
>                                  unsigned long reqprot __always_unused,
>                                  unsigned long prot)
>  {
> +       int rc;
>         const struct cred *cred =3D current_cred();
>         u32 sid =3D cred_sid(cred);
> +       const struct file *file =3D vma->vm_file;
> +       bool backing_file;
> +       bool shared =3D vma->vm_flags & VM_SHARED;
> +
> +       /* check if we need to trigger the "backing files are awful" mode=
 */
> +       backing_file =3D file && (file->f_mode & FMODE_BACKING);
>
>         if (default_noexec &&
>             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> -               int rc =3D 0;
>                 /*
>                  * We don't use the vma_is_initial_heap() helper as it ha=
s
>                  * a history of problems and is currently broken on syste=
ms
> @@ -4036,11 +4127,15 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>                     vma->vm_end <=3D vma->vm_mm->brk) {
>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECHEAP, NULL);
> -               } else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
> +                       if (rc)
> +                               return rc;
> +               } else if (!file && (vma_is_initial_stack(vma) ||
>                             vma_is_stack_for_current(vma))) {
>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECSTACK, NULL);
> -               } else if (vma->vm_file && vma->anon_vma) {
> +                       if (rc)
> +                               return rc;
> +               } else if (file && vma->anon_vma) {
>                         /*
>                          * We are making executable a file mapping that h=
as
>                          * had some COW done. Since pages might have been
> @@ -4048,13 +4143,29 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>                          * modified content.  This typically should only
>                          * occur for text relocations.
>                          */
> -                       rc =3D file_has_perm(cred, vma->vm_file, FILE__EX=
ECMOD);
> +                       rc =3D __file_has_perm(cred, file, FILE__EXECMOD,
> +                                            backing_file);
> +                       if (rc)
> +                               return rc;
> +                       if (backing_file) {
> +                               rc =3D file_has_perm(file->f_cred, file,
> +                                                  FILE__EXECMOD);
> +                               if (rc)
> +                                       return rc;
> +                       }
>                 }
> +       }
> +
> +       rc =3D __file_map_prot_check(cred, file, prot, shared, backing_fi=
le);
> +       if (rc)
> +               return rc;
> +       if (backing_file) {
> +               rc =3D file_map_prot_check(file->f_cred, file, prot, shar=
ed);
>                 if (rc)
>                         return rc;
>         }
>
> -       return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_S=
HARED);
> +       return 0;
>  }
>
>  static int selinux_file_lock(struct file *file, unsigned int cmd)
> @@ -7393,6 +7504,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after=
_init =3D {
>         .lbs_cred =3D sizeof(struct cred_security_struct),
>         .lbs_task =3D sizeof(struct task_security_struct),
>         .lbs_file =3D sizeof(struct file_security_struct),
> +       .lbs_backing_file =3D sizeof(struct backing_file_security_struct)=
,
>         .lbs_inode =3D sizeof(struct inode_security_struct),
>         .lbs_ipc =3D sizeof(struct ipc_security_struct),
>         .lbs_key =3D sizeof(struct key_security_struct),
> @@ -7498,9 +7610,11 @@ static struct security_hook_list selinux_hooks[] _=
_ro_after_init =3D {
>
>         LSM_HOOK_INIT(file_permission, selinux_file_permission),
>         LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
> +       LSM_HOOK_INIT(backing_file_alloc, selinux_backing_file_alloc),
>         LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
>         LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
>         LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
> +       LSM_HOOK_INIT(mmap_backing_file, selinux_mmap_backing_file),
>         LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
>         LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
>         LSM_HOOK_INIT(file_lock, selinux_file_lock),
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 5bddd28ea5cb..b19e5d978e82 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -88,6 +88,10 @@ struct file_security_struct {
>         u32 pseqno; /* Policy seqno at the time of file open */
>  };
>
> +struct backing_file_security_struct {
> +       u32 uf_sid; /* associated user file fsec->sid */
> +};
> +
>  struct superblock_security_struct {
>         u32 sid; /* SID of file system superblock */
>         u32 def_sid; /* default SID for labeling */
> @@ -195,6 +199,13 @@ static inline struct file_security_struct *selinux_f=
ile(const struct file *file)
>         return file->f_security + selinux_blob_sizes.lbs_file;
>  }
>
> +static inline struct backing_file_security_struct *
> +selinux_backing_file(const struct file *backing_file)
> +{
> +       void *blob =3D backing_file_security(backing_file);
> +       return blob + selinux_blob_sizes.lbs_backing_file;
> +}
> +
>  static inline struct inode_security_struct *
>  selinux_inode(const struct inode *inode)
>  {
> --
> 2.53.0
>
