Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEA3E5ED6
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787370; cv=pass; b=TowqXC0gMRqHuJfILcuDgwNJPB/XXRQT7+AvrQdV1sj12TrFi5Zcq4lqw6Fr1q1TvHryu5Ckk4aidBcCyGk482S7Q8zT8B/ZFcbD3V87Y1lRYyLwimxZjvmJtFBZkb+fNbgTF9Wf8fH0ccz/AO34C2Hv7eiaFr22D/Qm4Xdb9wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787370; c=relaxed/simple;
	bh=oScUuIjIjb/tZulbsi2FkIBZwopgeujtHsSn1k3PGiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWOmHH9/vv61V0GTtPUjdKeMLqx9SfIxy1cMXtMRCNypMIvkAdEiryhjB7KKK2pxlr233XfacTD5iTNIB8dgS93Z+gT0v/Nom24epdl3U4WeTS5CR5V8Cal2ztcnF2TtAT22Von6DaBcnbruH4gBACWwjGNX8xBMga0F6bLSln8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rp4KChT/; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rp4KChT/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-827270d50d4so5783428b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 15:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773787369; cv=none;
        d=google.com; s=arc-20240605;
        b=fDRKEhnscdOGnBgD3+ledgEhQj89ZBRVGxxwy0IV7uIcwKIe/mdkIMFyTfzvTwDrBw
         Rg1hp2dIXhLJP7Ti/8n2o+xtSwmL4GlqxLTYmpQcY0KWD85yC/TFOLFPjqwVqFQSlF1n
         eypnByAvmzhazZZszmfW4OWpXWmLAOGPgmGNuAnZEXLjGnrH03VKxCvrfDfAhVHTR9TV
         IQKtIU0JQLkBd6CQyq3oY0y1eGbGgWDhzOplEMg/zcsU2hHWIcM3n2nVR9yb59Fag+Dh
         sxspuSmRwzZoG8loLFExXX30yXNNqD059BgprVQBg/Cej/FsU4fWKtkqCWTjKSt/nxBH
         DQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        fh=EPhxLkd5fgAahKmPgSHFMleWb/fm25djFVA2slMqLs0=;
        b=CMyr6VDOVH0EV0UIMlU1i0DT9CsRWVxkmYtbQNjBoit65MZuHXzj0xThNTTZTulXip
         5JHDyBWacHa+43PC4LK3JMNquWtEunAsZDipO/C9fHTBpWLzzsXUzkNOuo+ChwHUfLa+
         uVg6eDkMCyTrfcVlrU8Ae7RrO5BqqXHjv67LuVVKGcfEJvDWpTweuSA+5Ij2K1nz1qbi
         pw6EOnk1Iz8utW/cOSjamuz90ZC6xxxFimQMbMkVGQt51mgJ7HnLt/Co4znB10nXMpXK
         orgEGu3rIYSqeNrAhRrfwxfAEWA7rw1EFNK/3NFbGUTUrEZ5uPWLl1KfgCdXuhYEAaU/
         DXvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773787369; x=1774392169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=Rp4KChT/WWpTu8I8ai/ucT9lIndTLNcnHKlKHGJEhA9cz9/jOtKHRfTj8Mt4k99hLz
         /I89gTL4UvFCXEXQ+emW/vqxpORQl6tRIFW8QI509j2GTSrVZtaum8vUBrpYmpT8jd0A
         wISeWETh5lykScg+b9x3/WRqzlb+SKvIZCRY3dNv6Dl6SFOWy6A033zHv7EsB5rYeEko
         x5aPlsVTKpmigGziLqh1SSMCTlzwf+Rl1EejgXkWvWLlaOaqd9ELuzLTq9ZeivFTN19l
         O/ftWife1HLsD1vxt+eBkShi1+KqmNcKNpSCyVKzgaGVSMOMFeuIaCIQZbGea997OFsZ
         J51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773787369; x=1774392169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=QBAZ1020iPRkTPBwG404PIuEtSKBowoRMHuNPpA8SlIfgMZSn3tj7FrQaEytqaCcR0
         VgmfEP518IkIE4QuE7bsmdzovWuaaj/OtT+BLaihRWa9+jvQl3HDVGiGo/oSYhBMnJmH
         r0XZpHJP4y6+9muhiTife5HYrFoGWo7fmayT3hB67rYgyDb6X5u0TkCf3IS3e2RDuFoS
         tZPMtKhN7/uoaDb6GDQFHC4EGeWqou+8gD2O+OY5d5a440qHdNst88Ow6++QMfl5eWvH
         EIdkJIdhfucdGpVL79yiT2Cm4AlD77S/fQplYZTELO16UvF7ROAq9vLpyEkycCRWi3OX
         SSOg==
X-Forwarded-Encrypted: i=1; AJvYcCX+6VilkLKUlp7AFGi7Y0d48jXADdyNAhel/XVXGXnnBiMCZB/bMfUWGbRwO1ykg36eG0uh39oWU7h8hy82@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIiuqwqMakF0G2Y+6GGH78PDQvCfEk2fXaVUzyab5x+D2pv1p
	t2PwKpa3k4i4Uj8or7GjgJ6Wr9iNUFwHp6JFDncj901Nftlm7uzxznIztSTXe+7r4MRYwm33aBp
	8i3pOCsCAOb83hMQuHp2Jz7fcpHRF1EJfPrf9Pl2U
X-Gm-Gg: ATEYQzxUyrTMa8gKebAjJGMrctb2mERUGhQLe7TvuzaNc+VlflgtcpPdZK4mfP3Fp+4
	PkKYCZsU37tfbK9EvCIXw1JEX5eK48CJHmvxZD4/CiIdMN+Bk3ficmszVLSnB/D7mlfWDNQQqVZ
	rG5juk+m0EvGCgD3u4ZGmyoQ0N16zUJRjubhV254qybtw9E6vU0BAaLbgeDUiSjd39f7xxF5KxH
	H6qBHBehkHL5ABV+xByRXr7T1behKcoRI9rd8oKGnu22ihSKdPMsKYejYjzPwRVaArxS024Lwh5
	/IGDN6T3LlG2ZDdQdg==
X-Received: by 2002:a05:6a00:1816:b0:827:2ec9:e1bc with SMTP id
 d2e1a72fcca58-82a6af3b680mr1004833b3a.61.1773787368885; Tue, 17 Mar 2026
 15:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-7-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-7-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 18:42:37 -0400
X-Gm-Features: AaiRm51ktGDW1-usZMxMHsT1xbcaRYx3q6Ml_vERE0ki9AcWlEliFtDWBIy0vmI
Message-ID: <CAHC9VhTiB73F9fB1o3K4NfJ-Fa50MsVA_=79kn6X34L62J_TwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] lsm: add the security_mmap_backing_file() hook
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Add the security_mmap_backing_file() hook to allow LSMs to properly
> enforce access controls on mmap() operations on stacked filesystems
> such as overlayfs.
>
> The existing security_mmap_file() hook exists as an access control point
> for mmap() but on stacked filesystems it only provides a way to enforce
> access controls on the user visible file.  In order to enforce access
> controls on the underlying backing file, the new
> security_mmap_backing_file() hook is needed.
>
> In addition the LSM hook additions, this patch also constifies the file
> struct field in the LSM common_audit_data struct to better support LSMs
> that will likely need to pass a const file struct pointer from the new
> backing_file_user_path_file() API into the common LSM audit code.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/backing-file.c             |  8 +++++++-
>  fs/erofs/ishare.c             |  6 ++++++
>  include/linux/lsm_audit.h     |  2 +-
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 25 +++++++++++++++++++++++++
>  6 files changed, 51 insertions(+), 2 deletions(-)

...

> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 17a4941d4518..d66c3a935d83 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -150,8 +150,14 @@ static ssize_t erofs_ishare_file_read_iter(struct ki=
ocb *iocb,
>  static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *v=
ma)
>  {
>         struct file *realfile =3D file->private_data;
> +       int err;
>
>         vma_set_file(vma, realfile);
> +
> +       err =3D security_mmap_backing_file(vma, realfile, file);
> +       if (err)
> +               return err;
> +
>         return generic_file_readonly_mmap(file, vma);
>  }

The kernel test robot helpfully pointed out that this patch was
missing a security.h include for the newly added LSM hook.  The fixup
below has been applied to the patch in lsm/stable-7.0.

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index d66c3a935d83..f80925b66599 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -4,6 +4,7 @@
 */
#include <linux/xxhash.h>
#include <linux/mount.h>
+#include <linux/security.h>
#include "internal.h"
#include "xattr.h"

--=20
paul-moore.com
