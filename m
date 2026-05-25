Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883B2F7EE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703488; cv=pass; b=KGbVYMjcyliiPcpJdn9MdYS52c3daQKEFWEqPTsTfpvpenlqrf71KGnB5Bq8Ru5joWr0Bj45yCSmROKOUocpKc4e64mMXGPEzGHVm9flfSYZhqw2naNqczXh/Oi1uEqHLqg53JCIfsQvxc66IaNakNTFYZhAnoZs2PQLwtJMhVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703488; c=relaxed/simple;
	bh=GuRFkLMKRGGIm3nOOkwhbQ4AYFZiNt8I3a1kzTv3/qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5iKTkRsLDVDVurIdXpquBbmW4PrTF65B0LoPwBfqJm0vnAXEJ2yMGG0hXN2qAAVJV44baNIw10mTAdSg4BlrKU9CK+F0asi8JVnOsMFu0xN2sfhqf0ovwsFkNrzkG3X9+hB2rAXOwgC9nqwpNG1BcuiLWbezKWXcEx4G48vlvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUtM3PDI; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUtM3PDI"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so3586121a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 03:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779703485; cv=none;
        d=google.com; s=arc-20240605;
        b=BHqAeMap3T/ZpVIuKIwLhxBIx3gEQUii/lrCgMQdGlLOrKXpE6106VpSc9mLjCI3xL
         wAonmwidvxx7A4uam3T8+Ow9sX/G8Wo/aUCR/0+rbksZcCfIzOGXnP2rnnDYIzC9i8aa
         dNiH1KNc9/x5CZFotfuLVZcNo046MU11zhrsyqvXl5y75p+2NLfdv6MbCqjXQSrIGbqu
         YDtIyrPaOSrNjNjVJrL4O+CTZayDZ+jvBrY0292p6Tnh3vWwaMDl75LEHarflVKI2YHF
         EucuNrNyK1Hwq0bBLbyvyXVh4K3oQzVVfmM/IsJkjCW8Ptj2jN8pzwqWOy99vvwG0Gmh
         BA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y+DPf6nUP3VD6Nm1csnNgDtZaiH2AYVonALNdC1dCW8=;
        fh=nYgeRz6ErXEybtCyAGiezQgaJFv97bn2TAblm3Ha0Qk=;
        b=RtP1BvKbdwfyUqvYJ7Yh2cTH/OIO7xFw1VwlvM/RyuA0qXw6v4/l15jjXdLo8RtT6l
         qvkvJm7pKSW9L7mwrimx117ii+tkv0VYPfRrIqjYAR1OGmaLp45CBBVsmlT+uPNkU9Ha
         7MHFI6afGZu9h5XoymxQiL6c2+acdlfM+obYfGiXFtu8+d/QgE2hZk8ipLv14RtUGoT5
         VQ16mDYHOtGh88i3yFiftstoDBSl07GfEFs1STv3ijaNG3VHq7bHVqFDzg0lYTaOAHfZ
         Jj9thXNREBFe2hRMnDk6E6LJS5vQfadmwUv1QRjjAX89dKN9EydgDRbs6PurHOERQgv8
         74lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779703485; x=1780308285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+DPf6nUP3VD6Nm1csnNgDtZaiH2AYVonALNdC1dCW8=;
        b=SUtM3PDIgFNkd08IigfFIlLPTI3mPCj6fU6Ex7reevvj+uYtdTutJj4WXA/Bk6dpPE
         T/zQmqEKT1Xn0LuCZHNAtOJKoem+PDbWVRYNPrn5EpGJTBO6RXRsOQTrKOixmcSwVc1V
         Q23KDIIEK4k0uTBYBq550qMys4RE0q8x/F7HCSbIR227+R/qlEd20OY0AIazQJliewMx
         HuKlBLKY9WfHM/CBdO4o/j70HjXFa5slWWPCOMsIjNSeK/w76pqL9RJ+frlOZ56YkfIh
         rahRAAtUfFuDDTRE1Px2g9JRdosp1onHzuMdoH2BFQl9VgxZaFuG1d46vhmtxstES89e
         QGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779703485; x=1780308285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y+DPf6nUP3VD6Nm1csnNgDtZaiH2AYVonALNdC1dCW8=;
        b=L4QfIdVlBqnUdBHlnG6kaSXI6oqQ4k25gyHJAo++0bW1SU3ISwFaDu5ooguoW1gk79
         O7+1mSL0qyothBtsjZI6Yqo64Pnb3nAuYFjK7mKm6Gg4NWZISxO/EiE5BIF6Us4T1+QJ
         RPP28XVhcUaAFz1Osb4yXTopMHKuEZZ/6uLuSZA9tQ0HSeD3XIl3qBIc0GuGv8OfoksY
         GhQVh+zyO6p/G/ReZCNqIP9DCVCbgfjbg8rtwPPBgIxPv4x+LgvOgd+Vnl4WTSV4bVl6
         QbjtTuccAvSAUdy1hkNGPPKjYjj3h5NKUHcbjU0yKAXCQhK6kQ6/UPNpF6vYAFzx7aSA
         vwDA==
X-Forwarded-Encrypted: i=1; AFNElJ87azlTUl8CuYoLvti2KIxdc3eJpLUpYD6EEbla9I/oXQ/C1CgqmR6+WHL33oK3781SwW/2QNhXYx7zuExX@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWYGavzLj2yrcQiguuzU4/hXrtliHGg+TqvxRTI2Te+SwMCWS
	oz6KZfvvRLVUz33GCEOcWzl6nEoCFRx0QsKwzcX7orZRCfcjGEHiDHltKGYVvkRPT5g5c3FSDam
	BIpfvyDjoc2i+h89QqSZahPUFTOJ4j+c=
X-Gm-Gg: Acq92OE7wMMZlim00JVDgAbBD9YNfcI0l2R7H8eePrDbNZcw8vDO7S0tGi6DDL+k3Dn
	h5ZwGZbBRz4+nib7PG/WNKNaR7Jrki+0Q6NE2ox6XVE5zh1cyR7lCuTrAH4EV1PvK1ilAxdzuZ9
	pWRvG1F7Z/nvKeQziBSSETpGYyxViEiqv/T3qAUvRvGOEUpNfITVeIeFWNfSERycmEWfERM2jF/
	9QEi7ffXsq+Om0c0RUe77+q3oF0qdmGyh2bU6cdkdJ9jwOu9vmw8+nm6wXiL4YGgN79dY1/U505
	MlQZI1JkE5NQcfWzYkbHOSUiup9KFr74SpiJHuWeBiUMpuwW
X-Received: by 2002:a05:6402:159a:b0:687:5157:1d4f with SMTP id
 4fb4d7f45d1cf-6889cc7d497mr7040848a12.26.1779703485281; Mon, 25 May 2026
 03:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524102439.44642-1-anonymemeow@gmail.com>
In-Reply-To: <20260524102439.44642-1-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 May 2026 12:04:32 +0200
X-Gm-Features: AVHnY4IbXxRs9SxS79EgIPpcdjG47RUIOeYhLs3T4DNg1rDHwbirCGGEABljIEM
Message-ID: <CAOQ4uxgrLEJDskC8Ku8evT21un=AMnMgrKJwAN5ceUFDrJY=GA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: report thread pidfds for FAN_REPORT_TID
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>, 
	LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 12:25=E2=80=AFPM AnonymeMeow <anonymemeow@gmail.com=
> wrote:
>
> The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> exclusive because by the time the pidfd support was introduced to
> fanotify, pidfds could only be created for thread group leaders. Now
> that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> this restriction can be lifted.
>
> This patch allows listeners using FAN_REPORT_PIDFD | FAN_REPORT_TID
> to receive the pidfd referring to the thread that triggered the
> event.
>
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Regarding the legal standpoint, as far as I can tell, commit d4563201f33a0
("Documentation: simplify and clarify DCO contribution example language")
explicitly allowed pseudonyms, so although unorthodox, this seems to be leg=
it.

In any case, the contributing itself seems legit to me, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

But before merging this, AnonymeMeow, since it is your first contribution
to the Linux kernel (right?) as well as a "I am not a robot" challenge
I would like to first see that the tests have been dealt with.

The LTP test fanotify20 explicitly checks that this flag combination is not
allowed. Need to discuss an acceptable solution with LTP developers -
remove this check depending on kernel version or whatever they choose.

The LTP test fanotify21 tests the FAN_REPORT_PIDFD functionality.
Please add two new variants for REPORT_TID:
        .test_variants =3D 4,

#define TST_VARIANT_FD_ERROR (tst_variant & 1)
#define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)

The existing checks if (tst_variant) become if (TST_VARIANT_FD_ERROR)
so bit 0 represents the FAN_REPORT_FD_ERROR variation.

in do_setup() need to use if (TST_VARIANT_PIDFD_THREAD)
to add FAN_REPORT_TID and to use PIDFD_THREAD for pidfd.

Follow the footsteps of fd_error_unsupported to skip the
TST_VARIANT_PIDFD_THREAD variants on kernels where the flag
combination is not supported.

Good luck,
Amir.


> ---
>  fs/notify/fanotify/fanotify_user.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index ae904451dfc0..ebdd48942029 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -19,6 +19,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/statfs.h>
>  #include <linux/exportfs.h>
> +#include <linux/pidfd.h>
>
>  #include <asm/ioctls.h>
>
> @@ -903,25 +904,21 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>
>         if (pidfd_mode) {
> -               /*
> -                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mu=
tual
> -                * exclusion is ever lifted. At the time of incoporating =
pidfd
> -                * support within fanotify, the pidfd API only supported =
the
> -                * creation of pidfds for thread-group leaders.
> -                */
> -               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> +               unsigned int tid_mode =3D FAN_GROUP_FLAG(group, FAN_REPOR=
T_TID);
> +               enum pid_type pidtype =3D tid_mode ? PIDTYPE_PID : PIDTYP=
E_TGID;
> +               unsigned int pidfd_flags =3D tid_mode ? PIDFD_THREAD : 0;
>
>                 /*
> -                * The PIDTYPE_TGID check for an event->pid is performed
> +                * The pid_has_task() check for an event->pid is performe=
d
>                  * preemptively in an attempt to catch out cases where th=
e event
> -                * listener reads events after the event generating proce=
ss has
> +                * listener reads events after the event generating task =
has
>                  * already terminated.  Depending on flag FAN_REPORT_FD_E=
RROR,
>                  * report either -ESRCH or FAN_NOPIDFD to the event liste=
ner in
>                  * those cases with all other pidfd creation errors repor=
ted as
>                  * the error code itself or as FAN_EPIDFD.
>                  */
> -               if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID=
))
> -                       pidfd =3D pidfd_prepare(event->pid, 0, &pidfd_fil=
e);
> +               if (metadata.pid && pid_has_task(event->pid, pidtype))
> +                       pidfd =3D pidfd_prepare(event->pid, pidfd_flags, =
&pidfd_file);
>
>                 if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd =
< 0)
>                         pidfd =3D pidfd =3D=3D -ESRCH ? FAN_NOPIDFD : FAN=
_EPIDFD;
> @@ -1628,14 +1625,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>  #endif
>                 return -EINVAL;
>
> -       /*
> -        * A pidfd can only be returned for a thread-group leader; thus
> -        * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
> -        * exclusive.
> -        */
> -       if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> -               return -EINVAL;
> -
>         /* Don't allow mixing mnt events with inode events for now */
>         if (flags & FAN_REPORT_MNT) {
>                 if (class !=3D FAN_CLASS_NOTIF)
> --
> 2.54.0
>
