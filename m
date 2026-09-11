Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3349B210
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147944; cv=pass; b=t+qfnOaGNH3Z3+0CTJm6Sf0DxOIdU2RkxGWa6ZFgfeX9syP5F5kSAY+mUg1dQhFM3FKO1pWZKk98FO8QFT4B0Qfv9UKC2Y2deTc/OXUJRodLkovrppgoai5a9zX3rEjIjw407MaldLvYG4FKmoL4en81YIyxKgyh7aL/59iloLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147944; c=relaxed/simple;
	bh=kW8qgpTiEaxSYdpL6zxHLeLhCoMuclZGCtfSmKy5L2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvsFoU5BSDUy5A0dYlt1hXLiQuQAt2Vn8osmLV/eUFjKuNTbLyYMBZpYMTs5+WHxy8p4I0vrnqYm+YyUVLMRkUSKqo+GyQ1EPo4DhLerL+3SCevFU2ytmgvjNGkEuyk46ihabDtqzekzZUIILiqEMqv91NxEDankROvNpjKlU/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UqheGuyi; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UqheGuyi"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so168404b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 10:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789147933; cv=none;
        d=google.com; s=arc-20260327;
        b=lixeHt/1wJDxZ6Zu7DuuzqDFGxlf/mDJ0wHee74fFKSm0mmPmewKJa67IZTLPAdubV
         mcSPWTu5078h3YqfUPNpHyi9190rEpbuCAvNs3Zc2ZKhF/DyNVkIgvVdrV3lNUWIpX6i
         EDyOzFGS/aYlx8ZU3i0gFTar8M/+1tckkUE5lL4LYrj1tSAiNBo+SJGvHQ8ZuDlV1uV7
         d3EZ5ftpAbYKXZbxhdc5QH42jDmWclSnA23qQygsUI3U7rUfKw85l4aVTg4yNnqdIxHT
         A04WkF8gg5ycQMHQMks11tqUDH+NdtkSADl5GhKy4Ihum6mO1ZS2tEs4NtR084D4ksal
         OPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WsPcTSE7tXZ7STQaDrKcB3TWLUFfJE17N5WpFurAIfQ=;
        fh=FoM3UFTzTRE89GQG0WAEdkgv9HG80xEApPLa2Gs6Ka0=;
        b=Csq533MNSX/T9csT/f61vWwBrlFdXdYusuC1gOURZk0/0MFXlfDk2NUes2Zt7KDsr+
         Zx67Li0AkqxD0NFirsoZbGD6e2hXxrAsQwKIWu6iiI+VzB+hQNxH+bq3VplqkfzCFSwz
         wySfzLn1+pD4DZFomOokqI+tRq4mtYyZej+i7LI8AHZXEZKROWtwRrorSjwL2nor8zk5
         dmCgOEniEaJAXivUQVq/ZDWGOy4tkBORNSGmEJIB40Kcs4oOWrjxbqkRDm/pPQvIfLZs
         jclCBMsgorYtPuFQJbf2aSEL/+XnWYPdcLQL+8C7/5bl3ume4+l4ALC3utVl1/NRpE5H
         yheQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789147933; x=1789752733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WsPcTSE7tXZ7STQaDrKcB3TWLUFfJE17N5WpFurAIfQ=;
        b=UqheGuyiMjVVVOGiGccV3JNOZLv/PFYpRUiMDAjQNm8RkpDr0WmuuipgENB9wmjWLI
         d065p0jjbbC6cZl63apUcS3hvWckD9G+9V4dzqEsLmt4gk2jMcEZW31CYrnb3SyIGMOf
         6w+uVr7S8KCUf/LHJbQTFwRxpW33OFdwzs1B5qT3Tr/QyRoxd0WNYGyAHW1PuQBU3SVt
         2rWVculH+MJGux8tqBgkPbUAlKjsRydWlK0w1fepaLF6AYpTCJFAtcU6krEn1U0radqR
         5QOajehVZL7gRzjzpaI3/zDfZomxje84fZVe6Ef8wcenlDyZ6OGMnmPNZ7XyeoMeQpmA
         wuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147933; x=1789752733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsPcTSE7tXZ7STQaDrKcB3TWLUFfJE17N5WpFurAIfQ=;
        b=HGsZWn2o/HFxqtatTKAjQ3L1CuOXT8Sh5bl5Rw8bzr49vO6kEsNr0KT5jWQ5LOVVmc
         KUXCTI33tMf4pJwY3xN+JOvyT+iimDc8Dl95pqGewttop80trA7XDCJ2DR/fQ0ZNbgWA
         wYcBRRa7qX75rOFkC2G1UuhV0KjWQjP0IK0s5oxWMupdUKhb99r81EZvw+oM5pHeVvxM
         G7y8jhxRl74Rj5ox0no2ZfZ/B2FbSUcOP1ejSijtyY2myp3g6eIa3ioel4AVAuT9ujle
         HBoSI3sn/Ia4EJ5b3E9iTDwinJikgunO1CHQKlS6NTXfcrfnfudE38h8cmdisjbugVVd
         ugKg==
X-Forwarded-Encrypted: i=1; AKwUvBxrM5PbgODvNVNhixNGSYVT6ARTRyg3FhRj4HwF1xPCjzTgws3l1FQw9bVXIUVKXv2HHsFvLP3ymRN3HSN4@vger.kernel.org
X-Gm-Message-State: AFuF++lRFSJNTafhH4FaPxwak+K3vaJ9Pw/G67+SjOjeNk7Be5JvWgXt
	zqP7PpajXyGllSW28k4eYjbbwOSe2FApgVFwfIL0UldVa6e9Zz9+40knxBz6OcxWRG+GespDdUh
	TCAcZ+zcfCvf9xHqFwL5+HACsAMMfm/ISKLEsRU5g
X-Gm-Gg: AYBFou3EKHlpObNRNLYiCZjtg7vhD0EYKVmFV7z6XYB2CqXc9o9VhWStXLByQcCvlZi
	0PLp1OIyFE37Wyx7RpkV2DKG7f8SLIBoqZaJjMbTnAX4Khcw/WGF20jaRoIl9E5hgkrpbY1BNcb
	gxz4ADeS4PzSNjKDjrisO2KIDBP2yEi8q/NStibXvteI15lOS7phg/1PCfTsZfNtOKbgAtT4Rln
	NZ3G2xm079xoHCqb+0rQIy/TGa7rI7TKusxr+MT8jfkHnveVRifsnZeVtIcg9iaNiyz6A5EEJDL
	iKHPNuGNd0PRuIFI3v/KP31TwZthCqE25lZcXGRcYOpwssxHy+jLgZWRc73hEjVwXbVNfjEuEzB
	ykmrQw1EYv2ejIys987fE5g==
X-Received: by 2002:a05:6a00:419a:b0:845:bda6:574b with SMTP id
 d2e1a72fcca58-86b2e8f6e10mr9085747b3a.5.1789147933173; Fri, 11 Sep 2026
 10:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
 <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com> <312cbf15-71d7-4fac-bee4-67fd237c5f5b@schaufler-ca.com>
In-Reply-To: <312cbf15-71d7-4fac-bee4-67fd237c5f5b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 13:32:01 -0400
X-Gm-Features: AcwNN1VMGI9zz0tqqwR_fG_D5fsVL778Ou1jXQO7hFzumGc64ffvrJMBWIPUuH4
Message-ID: <CAHC9VhShjf770Djx8_unbeWpO_ni0ahMFvrGFpaUcyuHzYgCyA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: daan@amutable.com, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:27=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 9/8/2026 3:05 PM, Paul Moore wrote:
> > On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
> > <devnull+daan.amutable.com@kernel.org> wrote:
> >> From: Daan De Meyer <daan@amutable.com>
> >>
> >> Pass the mount idmap through the create, link, symlink, mkdir, mknod,
> >> and permission hooks. Update the in-tree security implementations and
> >> non-VFS callers accordingly.
> >>
> >> Signed-off-by: Daan De Meyer <daan@amutable.com>
> >> ---
> >>  fs/cachefiles/security.c      |  4 +--
> >>  fs/namei.c                    | 18 +++++++-------
> >>  include/linux/lsm_hook_defs.h | 23 +++++++++--------
> >>  include/linux/security.h      | 58 +++++++++++++++++++++++++---------=
---------
> >>  security/security.c           | 40 +++++++++++++++++------------
> >>  security/selinux/hooks.c      | 19 +++++++++-----
> >>  security/smack/smack_lsm.c    |  9 ++++---
> >>  7 files changed, 100 insertions(+), 71 deletions(-)
> > Casey, are you okay with the Smack changes (below)?
>
> Yes, assuming the 80 character limit is adhered to.

I just checked and the smack_lsm.c changes all fit nicely in my
80-char wide terminal.

--=20
paul-moore.com
