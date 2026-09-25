Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04964B95BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348712; cv=pass; b=rm9iMqa59JnZWNB5oyg5RdcONgznViF5lRu6KJ3ZQV28eftGHBGV961N3CsxCVsYxCbzpXUpWjl9TIaVqI6WTmDa/LItpqaaamkFAyokfvJKikLx4rRMGVh7Bjn/BqBFpbDHTAE1nViFasJd60fIPA4bN6c0YiNCMsMQFl1+v5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348712; c=relaxed/simple;
	bh=WAWqhJNmyo51Od5KW8SJ0vK6DSlgvw2LcK3VD7saVMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5u+ZOn4Uev8L3Ce6vTqeIZ1ImzTnrYWvV4F8+hK/L6lHPwRbWImWTl3WNic4UeLEv4R0NsBj/BAJby/U4WllCc3eOCSieXEVmjvvueDJU5hfGOea/3WYCg7yZNs/SrCIkTlk4dJ5NIEl5/G+p5QoAK5kaY8+UO0f1neG/QnQQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjQmcmay; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjQmcmay"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aab5dae09fso1632493a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 08:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790348700; cv=none;
        d=google.com; s=arc-20260327;
        b=o3h8MEM0cAh49o7Nmqcbs+anSzeBzLOpiv+72l2wwwGz9BO5b+lOwOdUetZOik8exW
         n4kkUnnneSo1ZIgt8kZNNSf17SabFr3RAzUWhy0vYKhV2ZETAY8y+kzyCjxODCtpvN91
         6ZeNu+Bjh9DmEAtD8BYl7dLXfquzqpb8Gnz+DQ1R7uwSP5XTXM7KdpeXB7orKqxumwih
         igc/Oqs1O+mS30zLZiSe3dkN6owItuxKOf1e7KsA6g6PLBPNoolYj8n6oMO5nHK3hQIp
         hnJiV6Rs/JhmXq0B3+9FM3ZOouAH7otV5xBqAIebpuGjV4S1B8/3wcPkrJdc4m3cqqtQ
         xFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x6h1BVvc6NlZ/1f8ypPzy3ocqWyFlnaev/ls/pKUnb8=;
        fh=kE8DSQg1P1cAbMPE/HL1423iwSJ4rQXVLF3mNb0bG7M=;
        b=C/g+idAVymkCWbIBrDaItCV3BevUTlhrnA2POqthMFShhD15Fle4rbM80sLTMBL7z8
         RwMUDo+fd8oKpHDkzI6VpFzpp+nGCaVHVjKd7h49EsJZSzOvp2hLrX8SDy2CZ7aylT/2
         v6W3tvMvWknSmd4my+/TeNx5CVbutbTEUv3z/W72bou9UG+sj/G8snNxO/q92uz263qs
         7z/3dPg1n4Hm1SIGrR0BAzSdpNWs506ppS7kdrEMV/N8DshBg5XCrAiOUzEPh6q9zK9Y
         CdIAKa+KQB2LNFDjFaJsnLMjrOup1RM/Opoc3/0s8rwKHECbwK3yYH39kOdyEWArqIth
         UEaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790348700; x=1790953500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x6h1BVvc6NlZ/1f8ypPzy3ocqWyFlnaev/ls/pKUnb8=;
        b=EjQmcmayCVkHHRheUxRBMKhMGxjjSG3w9P62Mo/R5MrPRDrQ7AtdMFociIibDGvO9Y
         lTB8UjLcG90to0VIOsJSOyoOgbWhm8Jbl+3FqPP9uTzEgkKEZYXB9omRzSLOh2VWnB4/
         qVgnSgh3i7vc7m5ApBRXVzyfjoPU3TyNN1n6FVxFwVvDlP2fuG/OrjI4av6aOZQjJtHn
         V+p8BP9VmGllwqsx5kUqGHzDNSdHR08aCI7+UrpTMTRPtFfA2v0nSFxeG4VcrcwVtdHv
         iW6tD0qxn+tsWfoGbU/gUPDrWnWDkUMFI17wxrWnFFU8M1RRzO0K+CINdoJpjohcIITP
         gG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790348700; x=1790953500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6h1BVvc6NlZ/1f8ypPzy3ocqWyFlnaev/ls/pKUnb8=;
        b=Thu2NQBL50i4D38l/w0Zjgp5OtaEGVQOEzjdal+0EvfAJkhaMNdEG5kzmIaCPF5jQk
         rCFt3bA0JtJl+E9j91V+tvKuMyTUqjVMCrIzai3XsYqyCCka/rnfxRRMf0IzOLzyFvA2
         HQniGPl+pOyrvSre4+8TfYA2ZEoIl0Xb+X4cRoiV0p77YL4/SuQwi28VRdVezxtZ0mGN
         cscFQ3OwKvUZyh8FKwhPevk5CFdxk7PIfb/v1ATqrOyOUj8S2eGZy1bv6f+aeML5NSCu
         9dHS3cHqqsvh6+7/HxwTayv15idNLrzn1vfUu0GZSQy32U6fy8EeCjFAxPzCt/EGjb8u
         wxmQ==
X-Forwarded-Encrypted: i=1; AKwUvBznjg8lq+I2OLArE+L0/pWBR3hrAky74vz6exg3abZT3pNZf2jT+8PsnnMu82P9ILWovL3V5t/iCxBfh9i1@vger.kernel.org
X-Gm-Message-State: AFuF++k/o2vrtZSkADtgDzbl//AinPX2dQP0pG4SVzP53Pinq5khHnwn
	A87K7qmtcaCdV/a7cLL5uWsfLL69ZcDemRQ5pnU7zNFPtRCpCyrWE8TCEkXX7hXGxUhgT+85pOu
	OXxaPor1O0tIY7NfvZQd9bmGqsuZHWTM=
X-Gm-Gg: AYBFou3cNZ109cKSx5WN4tA0aIXVUQKEIO/2olp9M5ASxM9vPysQslvmV60Dzf1nbzr
	iraRWwYSbMyyoANcWvDKjiq+SkHtJHLEqCfTUama1Ppqc4UY4GiV5gfPalVc4cbh5IZQJGve0Rz
	LxmSxE7dA4Z37tzNp8FlIFFdlm5M9QdpwwprAuNlVy/M/4u7v17747zcDXksCS/M2cej0f3it/h
	v1gTbDFZdyWx1vdY1MH/Z4eWV8fieDZ75FjhV/eflKkPPopP+Eyts/2EczH+D1bfZyaEt45/Xcz
	G8e0xjRm5iSdcnNnFiJ7HAJCPGUP7NXMusIktCNG6NXZ7m+Rgq+aCY5gXQ==
X-Received: by 2002:a05:6402:304f:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6aac8f0fb76mr4307366a12.10.1790348699463; Fri, 25 Sep 2026
 08:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924112858.51392-1-disgoel@linux.ibm.com>
In-Reply-To: <20260924112858.51392-1-disgoel@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 25 Sep 2026 17:04:48 +0200
X-Gm-Features: AclHuK99bcpAkghS0fUG2lImCTNfTZaz5pVDj1Ros9PGZp_xBJVRQl4OTsgjcsA
Message-ID: <CAOQ4uxh+VbTTUTQxRZ6jxYCLyBedKEPOQAPEkrJwhbiL32eGPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ovl: fix mount setup failing when override_creds
 drops CAP_SYS_ADMIN
To: Disha Goel <disgoel@linux.ibm.com>, Christian Brauner <brauner@kernel.org>
Cc: miklos@szeredi.hu, viro@zeniv.linux.org.uk, jack@suse.cz, shuah@kernel.org, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 1:29=E2=80=AFPM Disha Goel <disgoel@linux.ibm.com> =
wrote:
>
> When a process drops CAP_SYS_ADMIN and calls fsconfig(FSCONFIG_SET_FLAG,
> "override_creds"), overlayfs saves those restricted credentials in
> ofs->creator_cred.  ovl_fill_super() then wrapped the entire mount setup
> in with_ovl_creds(), switching to those restricted credentials for the
> duration.
>
> Mount setup calls clone_private_mount(), which checks CAP_SYS_ADMIN
> against current credentials.  With restricted credentials active, this
> check fails with -EPERM and the mount fails even though the calling
> process is fully privileged.
>
> Mount setup is a one-time privileged operation and must run under the
> caller's credentials.  with_ovl_creds() belongs only in post-mount I/O
> paths.  Remove it from ovl_fill_super().
>
> Fixes: 539a0879de47 ("ovl: allow to specify override credentials")
> Cc: stable@vger.kernel.org
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---

Hi Disha,

Thanks for the report!

>  fs/overlayfs/super.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index bd0a3f9039d2..29f9489b8242 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1557,8 +1557,12 @@ int ovl_fill_super(struct super_block *sb, struct =
fs_context *fc)
>                         goto out_err;
>         }
>
> -       with_ovl_creds(sb)
> -               err =3D ovl_fill_super_creds(fc, sb);
> +       /*
> +        * Mount setup must run under the caller's credentials, not
> +        * creator_cred: clone_private_mount() requires CAP_SYS_ADMIN,
> +        * which override_creds may have dropped.
> +        */
> +       err =3D ovl_fill_super_creds(fc, sb);

Without ovl creds, the name of this helper is a bit odd..

>
>  out_err:
>         if (err) {
> --
> 2.45.1
>

Chritian,

I see that selftests are failing on upstream:

#  RUN           set_layers_via_fds.set_override_creds_nomknod ...
[520332.680688] overlayfs: failed to clone upperpath
# set_layers_via_fds.c:516:set_override_creds_nomknod:Expected
sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0) (-1) =3D=3D 0
(0)
# set_override_creds_nomknod: Test terminated by assertion
#          FAIL  set_layers_via_fds.set_override_creds_nomknod

#  RUN           set_layers_via_fds.set_layers_via_detached_mount_fds ...
# set_layers_via_fds.c:711:set_layers_via_detached_mount_fds:Expected
layers_found[i] (0) =3D=3D true (1)
# set_layers_via_fds.c:39:set_layers_via_detached_mount_fds:Expected
rmdir("/set_layers_via_fds") (-1) =3D=3D 0 (0)
# set_layers_via_detached_mount_fds: Test terminated by assertion
#          FAIL  set_layers_via_fds.set_layers_via_detached_mount_fds
not ok 7 set_layers_via_fds.set_layers_via_detached_mount_fds

oops, I thought these were running in CI...

Apparently failing since v6.16-rc1
c28f922c9dcee ("clone_private_mnt(): make sure that caller has
CAP_SYS_ADMIN in the right userns")

The question is whether doing the guts of ovl_fill_super() with checks like

int ovl_can_decode_fh(struct super_block *sb)
{
        if (!capable(CAP_DAC_READ_SEARCH))

Without the user provided override_cred is the right thing to do.

Could lead to confusing state post mount.

Thoughts?

Thanks,
Amir.
