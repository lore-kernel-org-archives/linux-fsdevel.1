Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33C263C9F
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061766; cv=pass; b=tbD+UHTgbnOfANrWVkLqlilVGJhpvzNU3t3y0P7QliCX2J+gwmArxuW+enJEavOM79JaIp/PADx0s1SHLRi2TEbG+Y7Rjq2k6W97cJo5lixq/7aG0h655p++A0ZjXHeHbttttRPIlSZ9REjI15sHhRkT4Xx0sMMUnqhDx7b49ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061766; c=relaxed/simple;
	bh=joDuZ8QmepZUjVoXbJ5ddFjFwM1tbj/p68gjDt4Jorc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpWucoNi/dG4Ip9dUZjYG0wbifFJF6t6vRzUtSK3QFCy9JIq7NCxdzqq3epsNc6MJRGjIk3ZIJTJYseAm/TDUXgtTxdJ6FpBSXagqIVtBqiXyTDrN0q8ArZNnjwEJ3BbS1lnaelq7/dznSRBki7jCpuQ0SgTVwHunIi+sPNeOfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPHp5/E3; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPHp5/E3"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso16436351fa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 16:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779061763; cv=none;
        d=google.com; s=arc-20240605;
        b=lO94ZRap7lQr9G1qVESyIKAcvC4ZC1+aiIEFAEU+wdDE/MbMPEcw4OuCAmYka9N3gE
         6xhGlq4Vfk+aHdWqqxW+mDGriHgE1b7pL9PCY38H9FKK5FmmcMKpaN6YwcdwHVuBXvOS
         TvQbeOTSrlOmU2KshEm3iQxLsT3KNlho5ba95HpLKI5NboFegVs7t+AUqv25lCluqZze
         eOQY/DynWWK8xXezG/jNIgVbM1q36VPFSRm3/VKuExSdGb4SkF0aPnbnBKIhcvNg9i1P
         gznqMa0BFXq/OeM0bKUaafmHoxLvi5vHOsVMkUD4cwWRtCeQ+5jfU3NVfThJt8SrE2pR
         BRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RghAEEXCLBokGjHcctpPpudsSW8cd4bltv6napNVHnc=;
        fh=DFMdo/+JVan0tsVJU1KSngynqKpomby1ynn20KVSRrM=;
        b=P67MjRR5sE/kdudBrgOvPnbV5mdirTo3M9teaoZsOY+WuxHntO0PHuoY9Sc5hVJhCo
         rEXUBoIyFSmVKmymsozmtg2/dnoXMZONFwZaZJGulcQiIAZsoA3IjbY0BWU8GJ0IqdsN
         MKD5K1l6jku9NWVzkG6fMzq8WIucHw6d2F9t4nQb7qsXhoyFrl9NGSsWGRjPazgnOMQK
         xJu16sQwYBojAro38mm8DhWCuEMTWdS9gkjJ+O3zAHhH3CVWRFKIvWy5SZtcz2bkFq0V
         YU1jZ5wL5f1N2p+PsWL/isS9ZBEx5gyxqG63AHlE8VrbdT9EYZ6FvZSWbSokkwaB/ytb
         MZLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779061763; x=1779666563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RghAEEXCLBokGjHcctpPpudsSW8cd4bltv6napNVHnc=;
        b=IPHp5/E3mUybAQYsd76iCo48F991Xr8fpDf6RtR4ai7nYVfWH47iw3szGEss9C6XwU
         Iy2a+jxyhiQ4Otk0RKvabPL9xafvPWGrO0ywQXtK1FJOt/LlrNhRswmJfLoQJPb7lMGB
         g4iyD0ZsTrXQCrYkVLFoiEEMjDFEQHpQT4ZFOemE4tYpiRq4RHAZBx06Taj7EH6Q8Wa3
         R+xpZF92Gx2bDyTfX4pTIGLJsvM8SnkzZUcF+dtpKdjgwQbAFGc0QpwVD0ulFwmXZRJ6
         smKyAKhleXv9m48OSYgplGIIiWwTBnCmRWUISorKnNaXp8ujX2erhxW/Ci0aXmPW3Pvq
         CyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779061763; x=1779666563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RghAEEXCLBokGjHcctpPpudsSW8cd4bltv6napNVHnc=;
        b=sRhfXMQmmvJLvnFR3eaF79Ukm95vKlT8wWkAB9Ecubq7+HfEm1HOvRO32KDszX+1AF
         yYnzuNQHAPPp+2vOJB97f2XyzGTXpr912KB8HoYERR1NC/XE175lpoqyqd7MLctZ+OeL
         WPsos+NSdlPxqVPABXqs6SYXt1eWfwk5pEpHSfpC/70WB1uDsksSnVKwyrNbpB8Opb0B
         g7rSVyxCmpjlKS38ZrI42tom4/jbaMqvBEzq7tn7S1Ep2+0XY7WTu5X5p2t9VqxQgkvm
         ir/+t1trZQwksq189G7/oQ+Lf96o/ZYT58uhBrPWuxUV+6GQ2jG3NI0F1HjSIHjiXLgv
         Cd+A==
X-Forwarded-Encrypted: i=1; AFNElJ/pn/VCrPEtK8dO0bFRq5F6OFfif8nfbYHkgn7a8GU9UXoX0/u4X2xnVcky+kRXA/qzZNn+PoWVMuKsU2jV@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfIJKypuJaQ1LxAnmEHHFnmcwBP+EQtQYr3RfqBrBXAgTIhj/
	/XItmBbJvPa2GUGVg2XUJumab+OObN9RSAwiMe598xsScB41y9/iU7U+//UmwSqTpz9P6hA7hr/
	nrWbq2s/LdCfs7+HAZed9bMWDMHLPo5g=
X-Gm-Gg: Acq92OGnmc7H3dO6/KWa6snV/paUjP7nDjNoMZoF3NJ+PbEox59vxXqq5NpxtwAERu5
	RlIRowEoOFRSzcsrHFsHDGr6/fyENg/fZfCLR6tC+6VW33CpYjSNkqjibWCqGegrzwsL1C0rmem
	VXWtO5jANHPjbr5FEanEB/vQdgK57gIihm/GkqyqXOIvDzl+OkGj+arxYFoaQYFNWp++6RNfWc9
	wEI1QczutYEtq8HrkiNb8qOK8fzLZP/P8a9JEZVAgHA8OQyD8QggRWAi73lS9rqOm0NRo1IgQaV
	y8xeGPp7NKMGyPkM9w==
X-Received: by 2002:a05:6512:3d07:b0:5a8:896c:8989 with SMTP id
 2adb3069b0e04-5aa0e73c260mr3504428e87.30.1779061762583; Sun, 17 May 2026
 16:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517034447.1330941-1-charsyam@gmail.com>
In-Reply-To: <20260517034447.1330941-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 18 May 2026 08:49:10 +0900
X-Gm-Features: AVHnY4It_Sp802lNft2hAY3M8EXDVa2Iib4keqm2C4BNJcq4h_VwVK29Xb11FZ8
Message-ID: <CANFS6bYpgoPH=eGq5gUKZwZixUUP3UBDmbn3ifUVok5Dcvf2bw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: remove unsupported quota handling
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 17=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 12:44, =
DaeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The ntfs driver does not implement quota accounting.  It creates
> new inodes with the NTFS 1.2 $STANDARD_INFORMATION layout and does
> not maintain the NTFS 3.x owner_id/quota_charged fields or the
> $Quota usage records that Windows would need for meaningful quota
> accounting.
>
> The only runtime quota path left in the driver is the remount-rw
> code that tries to mark $Quota/$Q out of date, plus the mount-time
> code that loads $Quota and its $Q index solely to support that
> marker.
>
> Since the driver does not maintain the per-file quota metadata,
> setting QUOTA_FLAG_OUT_OF_DATE does not make the quota state
> meaningful, and failures in this unsupported path can unnecessarily
> block remount-rw or force a mount read-only.
>
> Remove the quota marker, the $Quota/$Q loading state, and the
> unused quota volume flag.  Keep the on-disk quota layout definitions
> in layout.h so the documented NTFS structures remain available.
>
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Link: https://lore.kernel.org/all/CANFS6bYTzioqZjYt=3D51Kb9RdR3MKXaez_fh_=
WCLoym093VxFmg@mail.gmail.com/
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me. Thank you for this patch.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> This is the standalone patch agreed in the discussion (see the Link:
> above): the earlier "$Quota view-index lookup" fix series is being
> dropped because the ntfs driver does not implement quota accounting, so
> the unsupported quota loading/marking path is removed instead of fixed.
>
> Tested:
> - Applied on 5d6919055dec (Linux 7.1-rc3).
> - Built with CONFIG_NTFS_FS=3Dy.
> - Booted the patched kernel in QEMU with an mkfs.ntfs-created NTFS 3.1
>   image containing $Extend/$Quota.
> - Mounted the image read-only, remounted it read-write, created a
>   directory and file, read the file back, remounted read-only, unmounted,
>   mounted read-only again, and read the file back again.
> - Verified no remaining runtime quota references outside layout.h
>   definitions.
>
>  fs/ntfs/Makefile |   2 +-
>  fs/ntfs/quota.c  |  95 -----------------------------------------
>  fs/ntfs/quota.h  |  15 -------
>  fs/ntfs/super.c  | 109 +----------------------------------------------
>  fs/ntfs/volume.h |   7 ---
>  5 files changed, 2 insertions(+), 226 deletions(-)
>  delete mode 100644 fs/ntfs/quota.c
>  delete mode 100644 fs/ntfs/quota.h
>
> diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
> index 0ce4d9a9388a..e120c2e69862 100644
> --- a/fs/ntfs/Makefile
> +++ b/fs/ntfs/Makefile
> @@ -5,6 +5,6 @@ obj-$(CONFIG_NTFS_FS) +=3D ntfs.o
>  ntfs-y :=3D aops.o attrib.o collate.o dir.o file.o index.o inode.o \
>           mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o =
\
>           upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
> -         iomap.o debug.o sysctl.o quota.o object_id.o bdev-io.o
> +         iomap.o debug.o sysctl.o object_id.o bdev-io.o
>
>  ccflags-$(CONFIG_NTFS_DEBUG) +=3D -DDEBUG
> diff --git a/fs/ntfs/quota.c b/fs/ntfs/quota.c
> deleted file mode 100644
> index b443243b58fb..000000000000
> --- a/fs/ntfs/quota.c
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * NTFS kernel quota ($Quota) handling.
> - *
> - * Copyright (c) 2004 Anton Altaparmakov
> - */
> -
> -#include "index.h"
> -#include "quota.h"
> -#include "debug.h"
> -#include "ntfs.h"
> -
> -/*
> - * ntfs_mark_quotas_out_of_date - mark the quotas out of date on an ntfs=
 volume
> - * @vol:       ntfs volume on which to mark the quotas out of date
> - *
> - * Mark the quotas out of date on the ntfs volume @vol and return 'true'=
 on
> - * success and 'false' on error.
> - */
> -bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol)
> -{
> -       struct ntfs_index_context *ictx;
> -       struct quota_control_entry *qce;
> -       const __le32 qid =3D QUOTA_DEFAULTS_ID;
> -       int err;
> -
> -       ntfs_debug("Entering.");
> -       if (NVolQuotaOutOfDate(vol))
> -               goto done;
> -       if (!vol->quota_ino || !vol->quota_q_ino) {
> -               ntfs_error(vol->sb, "Quota inodes are not open.");
> -               return false;
> -       }
> -       inode_lock(vol->quota_q_ino);
> -       ictx =3D ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino), I30, 4);
> -       if (!ictx) {
> -               ntfs_error(vol->sb, "Failed to get index context.");
> -               goto err_out;
> -       }
> -       err =3D ntfs_index_lookup(&qid, sizeof(qid), ictx);
> -       if (err) {
> -               if (err =3D=3D -ENOENT)
> -                       ntfs_error(vol->sb, "Quota defaults entry is not =
present.");
> -               else
> -                       ntfs_error(vol->sb, "Lookup of quota defaults ent=
ry failed.");
> -               goto err_out;
> -       }
> -       if (ictx->data_len < offsetof(struct quota_control_entry, sid)) {
> -               ntfs_error(vol->sb, "Quota defaults entry size is invalid=
.  Run chkdsk.");
> -               goto err_out;
> -       }
> -       qce =3D (struct quota_control_entry *)ictx->data;
> -       if (le32_to_cpu(qce->version) !=3D QUOTA_VERSION) {
> -               ntfs_error(vol->sb,
> -                       "Quota defaults entry version 0x%x is not support=
ed.",
> -                       le32_to_cpu(qce->version));
> -               goto err_out;
> -       }
> -       ntfs_debug("Quota defaults flags =3D 0x%x.", le32_to_cpu(qce->fla=
gs));
> -       /* If quotas are already marked out of date, no need to do anythi=
ng. */
> -       if (qce->flags & QUOTA_FLAG_OUT_OF_DATE)
> -               goto set_done;
> -       /*
> -        * If quota tracking is neither requested, nor enabled and there =
are no
> -        * pending deletes, no need to mark the quotas out of date.
> -        */
> -       if (!(qce->flags & (QUOTA_FLAG_TRACKING_ENABLED |
> -                       QUOTA_FLAG_TRACKING_REQUESTED |
> -                       QUOTA_FLAG_PENDING_DELETES)))
> -               goto set_done;
> -       /*
> -        * Set the QUOTA_FLAG_OUT_OF_DATE bit thus marking quotas out of =
date.
> -        * This is verified on WinXP to be sufficient to cause windows to
> -        * rescan the volume on boot and update all quota entries.
> -        */
> -       qce->flags |=3D QUOTA_FLAG_OUT_OF_DATE;
> -       /* Ensure the modified flags are written to disk. */
> -       ntfs_index_entry_mark_dirty(ictx);
> -set_done:
> -       ntfs_index_ctx_put(ictx);
> -       inode_unlock(vol->quota_q_ino);
> -       /*
> -        * We set the flag so we do not try to mark the quotas out of dat=
e
> -        * again on remount.
> -        */
> -       NVolSetQuotaOutOfDate(vol);
> -done:
> -       ntfs_debug("Done.");
> -       return true;
> -err_out:
> -       if (ictx)
> -               ntfs_index_ctx_put(ictx);
> -       inode_unlock(vol->quota_q_ino);
> -       return false;
> -}
> diff --git a/fs/ntfs/quota.h b/fs/ntfs/quota.h
> deleted file mode 100644
> index 4b7322661a32..000000000000
> --- a/fs/ntfs/quota.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Defines for NTFS kernel quota ($Quota) handling.
> - *
> - * Copyright (c) 2004 Anton Altaparmakov
> - */
> -
> -#ifndef _LINUX_NTFS_QUOTA_H
> -#define _LINUX_NTFS_QUOTA_H
> -
> -#include "volume.h"
> -
> -bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol);
> -
> -#endif /* _LINUX_NTFS_QUOTA_H */
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 22dc7865eca7..a518dd1802f3 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -17,7 +17,6 @@
>
>  #include "sysctl.h"
>  #include "logfile.h"
> -#include "quota.h"
>  #include "index.h"
>  #include "ntfs.h"
>  #include "ea.h"
> @@ -240,8 +239,7 @@ static int ntfs_reconfigure(struct fs_context *fc)
>          * flags are set.  Also, empty the logfile journal as it would be=
come
>          * stale as soon as something is written to the volume and mark t=
he
>          * volume dirty so that chkdsk is run if the volume is not umount=
ed
> -        * cleanly.  Finally, mark the quotas out of date so Windows resc=
ans
> -        * the volume on boot and updates them.
> +        * cleanly.
>          *
>          * When remounting read-only, mark the volume clean if no volume =
errors
>          * have occurred.
> @@ -274,12 +272,6 @@ static int ntfs_reconfigure(struct fs_context *fc)
>                         NVolSetErrors(vol);
>                         return -EROFS;
>                 }
> -               if (!ntfs_mark_quotas_out_of_date(vol)) {
> -                       ntfs_error(sb, "Failed to mark quotas out of date=
%s",
> -                                       es);
> -                       NVolSetErrors(vol);
> -                       return -EROFS;
> -               }
>         } else if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY)) {
>                 /* Remounting read-only. */
>                 if (!NVolErrors(vol)) {
> @@ -1154,73 +1146,6 @@ static int check_windows_hibernation_status(struct=
 ntfs_volume *vol)
>         return ret;
>  }
>
> -/*
> - * load_and_init_quota - load and setup the quota file for a volume if p=
resent
> - * @vol:       ntfs super block describing device whose quota file to lo=
ad
> - *
> - * Return 'true' on success or 'false' on error.  If $Quota is not prese=
nt, we
> - * leave vol->quota_ino as NULL and return success.
> - */
> -static bool load_and_init_quota(struct ntfs_volume *vol)
> -{
> -       static const __le16 Quota[7] =3D { cpu_to_le16('$'),
> -                       cpu_to_le16('Q'), cpu_to_le16('u'),
> -                       cpu_to_le16('o'), cpu_to_le16('t'),
> -                       cpu_to_le16('a'), 0 };
> -       static __le16 Q[3] =3D { cpu_to_le16('$'),
> -                       cpu_to_le16('Q'), 0 };
> -       struct ntfs_name *name =3D NULL;
> -       u64 mref;
> -       struct inode *tmp_ino;
> -
> -       ntfs_debug("Entering.");
> -       /*
> -        * Find the inode number for the quota file by looking up the fil=
ename
> -        * $Quota in the extended system files directory $Extend.
> -        */
> -       inode_lock(vol->extend_ino);
> -       mref =3D ntfs_lookup_inode_by_name(NTFS_I(vol->extend_ino), Quota=
, 6,
> -                       &name);
> -       inode_unlock(vol->extend_ino);
> -       kfree(name);
> -       if (IS_ERR_MREF(mref)) {
> -               /*
> -                * If the file does not exist, quotas are disabled and ha=
ve
> -                * never been enabled on this volume, just return success=
.
> -                */
> -               if (MREF_ERR(mref) =3D=3D -ENOENT) {
> -                       ntfs_debug("$Quota not present.  Volume does not =
have quotas enabled.");
> -                       /*
> -                        * No need to try to set quotas out of date if th=
ey are
> -                        * not enabled.
> -                        */
> -                       NVolSetQuotaOutOfDate(vol);
> -                       return true;
> -               }
> -               /* A real error occurred. */
> -               ntfs_error(vol->sb, "Failed to find inode number for $Quo=
ta.");
> -               return false;
> -       }
> -       /* Get the inode. */
> -       tmp_ino =3D ntfs_iget(vol->sb, MREF(mref));
> -       if (IS_ERR(tmp_ino)) {
> -               if (!IS_ERR(tmp_ino))
> -                       iput(tmp_ino);
> -               ntfs_error(vol->sb, "Failed to load $Quota.");
> -               return false;
> -       }
> -       vol->quota_ino =3D tmp_ino;
> -       /* Get the $Q index allocation attribute. */
> -       tmp_ino =3D ntfs_index_iget(vol->quota_ino, Q, 2);
> -       if (IS_ERR(tmp_ino)) {
> -               ntfs_error(vol->sb, "Failed to load $Quota/$Q index.");
> -               return false;
> -       }
> -       vol->quota_q_ino =3D tmp_ino;
> -       ntfs_debug("Done.");
> -       return true;
> -}
> -
>  /*
>   * load_and_init_attrdef - load the attribute definitions table for a vo=
lume
>   * @vol:       ntfs super block describing device whose attrdef to load
> @@ -1638,18 +1563,6 @@ static bool load_system_files(struct ntfs_volume *=
vol)
>                 ntfs_error(sb, "Failed to load $Extend.");
>                 goto iput_sec_err_out;
>         }
> -       /* Find the quota file, load it if present, and set it up. */
> -       if (!load_and_init_quota(vol) &&
> -           vol->on_errors =3D=3D ON_ERRORS_REMOUNT_RO) {
> -               static const char *es1 =3D "Failed to load $Quota";
> -               static const char *es2 =3D ".  Run chkdsk.";
> -
> -               sb->s_flags |=3D SB_RDONLY;
> -               ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> -               /* This will prevent a read-write remount. */
> -               NVolSetErrors(vol);
> -       }
> -
>         return true;
>
>  iput_sec_err_out:
> @@ -1747,10 +1660,6 @@ static void ntfs_put_super(struct super_block *sb)
>
>         /* NTFS 3.0+ specific. */
>         if (vol->major_ver >=3D 3) {
> -               if (vol->quota_q_ino)
> -                       ntfs_commit_inode(vol->quota_q_ino);
> -               if (vol->quota_ino)
> -                       ntfs_commit_inode(vol->quota_ino);
>                 if (vol->extend_ino)
>                         ntfs_commit_inode(vol->extend_ino);
>                 if (vol->secure_ino)
> @@ -1799,14 +1708,6 @@ static void ntfs_put_super(struct super_block *sb)
>
>         /* NTFS 3.0+ specific clean up. */
>         if (vol->major_ver >=3D 3) {
> -               if (vol->quota_q_ino) {
> -                       iput(vol->quota_q_ino);
> -                       vol->quota_q_ino =3D NULL;
> -               }
> -               if (vol->quota_ino) {
> -                       iput(vol->quota_ino);
> -                       vol->quota_ino =3D NULL;
> -               }
>                 if (vol->extend_ino) {
>                         iput(vol->extend_ino);
>                         vol->extend_ino =3D NULL;
> @@ -2455,14 +2356,6 @@ static int ntfs_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>         vol->vol_ino =3D NULL;
>         /* NTFS 3.0+ specific clean up. */
>         if (vol->major_ver >=3D 3) {
> -               if (vol->quota_q_ino) {
> -                       iput(vol->quota_q_ino);
> -                       vol->quota_q_ino =3D NULL;
> -               }
> -               if (vol->quota_ino) {
> -                       iput(vol->quota_ino);
> -                       vol->quota_ino =3D NULL;
> -               }
>                 if (vol->extend_ino) {
>                         iput(vol->extend_ino);
>                         vol->extend_ino =3D NULL;
> diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
> index af41427ec622..e13e1423b2a9 100644
> --- a/fs/ntfs/volume.h
> +++ b/fs/ntfs/volume.h
> @@ -76,8 +76,6 @@
>   * @root_ino: The VFS inode of the root directory.
>   * @secure_ino: The VFS inode of $Secure (NTFS3.0+ only, otherwise NULL)=
.
>   * @extend_ino: The VFS inode of $Extend (NTFS3.0+ only, otherwise NULL)=
.
> - * @quota_ino: The VFS inode of $Quota.
> - * @quota_q_ino: Attribute inode for $Quota/$Q.
>   * @nls_map: NLS (National Language Support) table.
>   * @nls_utf8: NLS table for UTF-8.
>   * @free_waitq: Wait queue for threads waiting for free clusters or MFT =
records.
> @@ -141,8 +139,6 @@ struct ntfs_volume {
>         struct inode *root_ino;
>         struct inode *secure_ino;
>         struct inode *extend_ino;
> -       struct inode *quota_ino;
> -       struct inode *quota_q_ino;
>         struct nls_table *nls_map;
>         bool nls_utf8;
>         wait_queue_head_t free_waitq;
> @@ -165,7 +161,6 @@ struct ntfs_volume {
>   *                             Otherwise be case insensitive but still
>   *                             create file names in POSIX namespace.
>   * NV_LogFileEmpty             LogFile journal is empty.
> - * NV_QuotaOutOfDate           Quota is out of date.
>   * NV_UsnJrnlStamped           UsnJrnl has been stamped.
>   * NV_ReadOnly                 Volume is mounted read-only.
>   * NV_Compression              Volume supports compression.
> @@ -186,7 +181,6 @@ enum {
>         NV_ShowSystemFiles,
>         NV_CaseSensitive,
>         NV_LogFileEmpty,
> -       NV_QuotaOutOfDate,
>         NV_UsnJrnlStamped,
>         NV_ReadOnly,
>         NV_Compression,
> @@ -223,7 +217,6 @@ DEFINE_NVOL_BIT_OPS(Errors)
>  DEFINE_NVOL_BIT_OPS(ShowSystemFiles)
>  DEFINE_NVOL_BIT_OPS(CaseSensitive)
>  DEFINE_NVOL_BIT_OPS(LogFileEmpty)
> -DEFINE_NVOL_BIT_OPS(QuotaOutOfDate)
>  DEFINE_NVOL_BIT_OPS(UsnJrnlStamped)
>  DEFINE_NVOL_BIT_OPS(ReadOnly)
>  DEFINE_NVOL_BIT_OPS(Compression)
>
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
