Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EF547073
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293617; cv=pass; b=rQcFYV83HEe1JItZd+rb+FpqlD7iqsGTcdkMsKvHuzJBn13tHKeo0DNC4IHz65SJ9QadFclNLaheHBHqwEGT2zOeCEGQOtUuY1Jx5BXgGb4sG+uR+RXYhEcslXWVYp17F3h1d7+HjcKGtCaLNSIGFHAab/EmTnvgu3nVK514jl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293617; c=relaxed/simple;
	bh=9iCX0iESeq4yIFskD/OkV+PlJHYmhgLyDj7X3xayXVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT2Ftn4PdXzLfbD2jxuvaAvWlpksslMvriqV+1A/4GnsjI60tvq/oEvzDmTTrWA3EcEWfBenqKH6yyY0eXJJAxlL1hqhhDbvS9t8vtPQhA1AV7oAJUHF4l54kJ64rF0MMyCpHwBg54l9R+AgM11UBUsPumh4A/uLqZcvibzsoMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/aju/yO; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/aju/yO"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so1126551a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 06:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791293614; cv=none;
        d=google.com; s=arc-20260327;
        b=bdS1lu/DEiDnhwwiHH5owVrt1QjzJZM3cp1bsOxusNuhOZBhpvWWgjAZgBXBULZG37
         Q6ZKGKaoR3SM2OJ5O4m8g5Z4IVq13s//UI+DdNng6Wjl+orzA7UQNFmsGIlEeinv/WV2
         poIqV+9H3WfyeAFVbG87OvLiAs+2S4xmc6AJCIh9+v6I9zZpTDneniquafquI+OWTU+y
         1jCeJyVoA20y6k2qa1xy1fE9CDdVBDAtVbC676y1vaQdiW1+4jcxNfx/tpKY/y0sywUn
         uYcJFTwBITBaIK1CqAVAAphrnIvTWVOwq7iTsK6bWGZKrenFc6LImEBxondJ0vZb6UtP
         s2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=52wtJLVFhPlj2ORv9xjDobplkPWMGiz+egb/LVNn8JM=;
        fh=l9tWY75S6qEWDI4ae4uLCpkcKYF4EKzn6FVbfJ19Of8=;
        b=hyYgUsX+aOMdTSP1JRXIg0i3r4daTKRlWMgwGAhbWzizY4D7mQuKiQxSvWEyj011DR
         R7RJo+9nknNwnJrgAX82zWZVdyBK4+pF1YkLCcx+XEgPtFXSC/hBfPoeWvzdjvRyiM83
         ItANv8vAVrXIpiHXqv2f8M6/a6TkOI9Te/px+YtdTlrCn40a0XvBtLPKM/1IVktQeuj1
         pCtnBItbv0P1GV1OoTVbe9J6L5VYRYyQO7jp5Bjtb0UPipZW8izuXbU9m32xZeRRZevu
         xN3r/exZtkRa7LmM4VU330k71wtctXrDdHViYekw/P1oBABrf7I5WaNGRvFE4yGoMetc
         +alg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791293614; x=1791898414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=52wtJLVFhPlj2ORv9xjDobplkPWMGiz+egb/LVNn8JM=;
        b=m/aju/yOy2pnhJIf5AGdwGQLfsrCItSEDLmn+HeCfremAy3qo2ShAvo2j0B/DloDTX
         Wdq1O5Uc0ubfmDuWjWJ2OYxl0GXz4BrbHhTLC5JLmmWD8ETq9jkgm92YPewzp6MFlhnk
         9gLb2mQT1gKVnftxqu1Hgxr7N8OqDSiQjhzmb/NQhmHFaqohzoCZ+7MOlNWA4LkSN29H
         d/Z/pt5224wsOKLV8nfyYBNlW11rHcDeFSCmWeV6zLJf3wDT2XPfUQpomEi1ECAO3eV8
         8Ng70SbcR0BAJowBD3LpMHmpCSqpRmi06vHiTVzAQU4khVUfjH3s2konawFEfcYLLzJ+
         i8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293614; x=1791898414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52wtJLVFhPlj2ORv9xjDobplkPWMGiz+egb/LVNn8JM=;
        b=K3x8W0JALNnD3/7t51Cb4TTXDmAmR0sxdbpXwP9yI6bfMPJDljO2H0AdGM2dsXiFVu
         9DzuLNdnYT6MQCzmpE9Msgl5hm2TYzm+bNIeI4/NPwAvetQFjaB1NCbRN+x8NceBSzlN
         Nb6I3qvOSYk3PkAGtGLupm48zC+mfPBQlToTSKYHPHIh3ujVd3/uUfRyIAqPj+imkKdq
         hLiuTzqvc2VO3WGVVoPu5NAj/3ExwFnBgbGl0rW2/+AzsKzwSCG88n0S0vf8JrEVbYn2
         q2Y2rsey7dZT5UNfpwTgsGrF/btsGZYEq4RZRCPGbckU2exCigtXireWfv9s5a6iHwO0
         Bo8g==
X-Forwarded-Encrypted: i=1; AKwUvBwZnnYEiOifV2Avp3mCYSYvnu8jD/wQViGWChwVCkwC/7LuGSPDYpshi+jP4ofDUAfvm/pUTqfan/xQ7NDh@vger.kernel.org
X-Gm-Message-State: AFq9FYKa8s/Dul8j2CGQAq6rzQzzDh+OjmmrEpAwCUEhHUQmP1JRyoDY
	4ncH8aADQGQw5S0EfE1zYPzkaqB4sCQu68c9xrjTMW04NlRgfNvX9l7NCgeiB+54W5ydSQwPRJM
	NZDMzRrV7Tyxfz0qjdGTYUi9CytWqXJs=
X-Gm-Gg: AYBFou12Qw0zHc+9RIMfMUsVjgls/8AfhpcspNiCWowv6OexM9wKGZqxfGRKdXvNLhL
	zoJlJdKNurEs4Nho1J8uhe6gCZiHXOYIwHHyuMa4Bv0hCZImPu9pE6vj/4qMrLEfV51jsi1mt3H
	uFG6xiCUEas5yJFmB72Eye7msLAZOSvpQdaf4+EmoozplocGyUFYF6xklOlbMz3BhcSIZSzoNGA
	grjwcGSOaUFUafpopOj9xhzwHETAYsGWRJlQ0frWPn8rY2tqDkS1ocUqMPHALsjexmD9K1/PRTc
	THu9uLqJLz558iCEvu8vSaBy6xxwOLRTF33MXqu8qA9uztcv2fSRMQ==
X-Received: by 2002:a05:6402:21c2:b0:6ac:8de4:2804 with SMTP id
 4fb4d7f45d1cf-6afe290573amr1300386a12.1.1791293614005; Tue, 06 Oct 2026
 06:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926020851.2938961-1-matthias.goergens@gmail.com>
In-Reply-To: <20260926020851.2938961-1-matthias.goergens@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Oct 2026 15:33:20 +0200
X-Gm-Features: AclHuK_lVje2P1E1oSdROdbL85T36D8Zc-5aAZmEzAoJQF8V4-NDYpS4_O0SpXA
Message-ID: <CAOQ4uxhxDOy1-vTSXGfA2c16e4iop_5M5goOih0pgSCZRvDrfw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: report names longer than NAME_MAX
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 4:08=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> fanotify keeps the length of a reported name in a u8, so it drops any
> name longer than NAME_MAX and warns:
>
>   WARNING: fs/notify/fanotify/fanotify.h:217 at fanotify_handle_event+0x2=
e82/0x39f0
>
> Such names are legitimate on some filesystems.  vfat mounted with utf8
> takes up to 255 UTF-16 characters, which are up to 765 bytes of UTF-8,
> and FUSE accepts names up to PATH_MAX - 1.  readdir() and inotify report
> them in full.  fanotify sends the event without the name, and for
> FAN_RENAME it trips a second warning in copy_fid_info_to_user(), after
> which read() fails with EFAULT and the event is lost.
>
> When syzbot hit this, Jan suggested accommodating names up to PATH_MAX
> [1], the limit readdir() already applies to a name
> (verify_dirent_name()).  Store the name lengths as u16, which keeps
> struct fanotify_info at 8 bytes, and drop without a warning only names
> of PATH_MAX bytes or more, which no path can refer to.  An event with
> such a name can exceed a page, so allocate name events with kvmalloc(),
> as Jan also suggested.  Names up to NAME_MAX are reported exactly as
> before, and the record format is unchanged: an event with a long name is
> just longer.
>
> Link: https://lore.kernel.org/all/20241112115059.ecvomkalee5m4i4i@quack3/=
 [1]
> Fixes: 2d9374f09513 ("fanotify: use macros to get the offset to fanotify_=
info buffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>
> Tested in a VM with KASAN, lockdep and kmemleak: on vfat (utf8), names
> of 258 to 765 bytes now arrive with their name, including FAN_RENAME,
> for root and for an unprivileged watcher; FUSE names up to 4095 bytes
> likewise, also a FAN_RENAME between two of them.  With kvmalloc()'s
> kmalloc() attempt forced to fail, the events arrive intact from vmalloc.
> No warnings.  The LTP fanotify and inotify tests give the same results
> as before (fanotify20 skipped in both).
>
> 5.15.y fails the same way (the same warnings and EFAULT on 5.15.221),
> and the patch applies there and fixes it.
>
> Honza, on the msdos report [2] you pointed at the filesystem, and msdos
> now rejects such names (9d7ed813ee5f).  vfat cannot do the same without
> making files that other systems wrote unreachable, and FUSE allows them
> by design.
>
> [2] https://lore.kernel.org/all/3kzvlb3wpzbg6k6ttzp6rh2cfmz3hmmmlisgxjn5u=
4xmaaqibm@qkre7flkhejl/
>
>  fs/notify/fanotify/fanotify.c |  4 ++--
>  fs/notify/fanotify/fanotify.h | 20 +++++++++++++-------
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index a208a7ec1692..c8289aa8a70a 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -656,7 +656,7 @@ static struct fanotify_event *fanotify_alloc_name_eve=
nt(struct inode *dir,
>                 size +=3D FANOTIFY_FH_HDR_LEN + dir2_fh_len;
>         if (child_fh_len)
>                 size +=3D FANOTIFY_FH_HDR_LEN + child_fh_len;
> -       fne =3D kmalloc(size, gfp);
> +       fne =3D kvmalloc(size, gfp);
>         if (!fne)
>                 return NULL;
>
> @@ -1050,7 +1050,7 @@ static void fanotify_free_fid_event(struct fanotify=
_event *event)
>
>  static void fanotify_free_name_event(struct fanotify_event *event)
>  {
> -       kfree(FANOTIFY_NE(event));
> +       kvfree(FANOTIFY_NE(event));
>  }
>
>  static void fanotify_free_error_event(struct fsnotify_group *group,
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index 3710543dbf82..4aad60d2aaf5 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -43,9 +43,16 @@ struct fanotify_info {
>         u8 dir_fh_totlen;
>         u8 dir2_fh_totlen;
>         u8 file_fh_totlen;
> -       u8 name_len;
> -       u8 name2_len;
> -       u8 pad[3];
> +       u8 pad;
> +       /*
> +        * Deliberately not limited to NAME_MAX: some filesystems return =
longer
> +        * names (vfat up to 255 UTF-16 characters, as Windows allows, wh=
ich is
> +        * up to 765 bytes of UTF-8; FUSE up to PATH_MAX - 1), and readdi=
r() and
> +        * inotify report them in full. Only names of PATH_MAX bytes or m=
ore,
> +        * which no path can refer to, are dropped.
> +        */
> +       u16 name_len;
> +       u16 name2_len;
>         unsigned char buf[];
>         /*
>          * (struct fanotify_fh) dir_fh starts at buf[0]
> @@ -168,7 +175,7 @@ static inline char *fanotify_info_name2(struct fanoti=
fy_info *info)
>  static inline void fanotify_info_init(struct fanotify_info *info)
>  {
>         BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN + MAX_HANDLE_SZ > U8_MAX);
> -       BUILD_BUG_ON(NAME_MAX > U8_MAX);
> +       BUILD_BUG_ON(PATH_MAX > U16_MAX);
>
>         info->dir_fh_totlen =3D 0;
>         info->dir2_fh_totlen =3D 0;
> @@ -214,8 +221,7 @@ static inline void fanotify_info_set_file_fh(struct f=
anotify_info *info,
>  static inline void fanotify_info_copy_name(struct fanotify_info *info,
>                                            const struct qstr *name)
>  {
> -       if (WARN_ON_ONCE(name->len > NAME_MAX) ||
> -           WARN_ON_ONCE(info->name2_len > 0))
> +       if (name->len >=3D PATH_MAX || WARN_ON_ONCE(info->name2_len > 0))
>                 return;
>
>         info->name_len =3D name->len;
> @@ -225,7 +231,7 @@ static inline void fanotify_info_copy_name(struct fan=
otify_info *info,
>  static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>                                             const struct qstr *name)
>  {
> -       if (WARN_ON_ONCE(name->len > NAME_MAX))
> +       if (name->len >=3D PATH_MAX)
>                 return;
>
>         info->name2_len =3D name->len;
>
> base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
> --
> 2.55.0
>

Hi Matthias,

The fix for name_len < PATH_MAX looks good, but since you dealt with the
the unexpected case of name_len > PATH_MAX more gracefully on event record
time (empty name) I would rather that we treat it gracefully only on read()=
 time
and just report the event with no name instead of potentially breaking
the read()
of other events in the queue.

Something like this:

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -579,11 +579,17 @@ static int copy_fid_info_to_user(__kernel_fsid_t
*fsid, struct fanotify_fh *fh,
                        return -EFAULT;
                break;
        case FAN_EVENT_INFO_TYPE_DFID_NAME:
-       case FAN_EVENT_INFO_TYPE_OLD_DFID_NAME:
-       case FAN_EVENT_INFO_TYPE_NEW_DFID_NAME:
                if (WARN_ON_ONCE(!name || !name_len))
                        return -EFAULT;
                break;
+       case FAN_EVENT_INFO_TYPE_OLD_DFID_NAME:
+       case FAN_EVENT_INFO_TYPE_NEW_DFID_NAME:
+               /*
+                * FAN_RENAME uses these types so userspace can tell old fr=
om
+                * new parent. The name may be absent if it could not be
+                * recorded (e.g. >=3D PATH_MAX); emit fid-only like DFID.
+                */
+               break;
        default:
                return -EFAULT;
        }

Thanks,
Amir.
