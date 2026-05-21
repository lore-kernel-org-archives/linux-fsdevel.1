Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF8299927
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325476; cv=pass; b=do4CHWSq4Uhvo1DDspBzIFwsfZjI4bD67m6+a33aj7k+N3NYwcxWYNo6MDt6MeueWwYjqhXbvBbG8s72zq+LzZowFfL/hzWiqLiaKvh3S3e6sWHxfwov8NfR+DndOu0sPUu4awWpM112vhbwWnlsEZFP58io1ainnv6mhSYoBD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325476; c=relaxed/simple;
	bh=0IyN594IgNEvO0uwMW0lto9//FYSt1+uJj/xFF2jT8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igBJa+/99zfZTz+c6j+7GqT/DchnBPkbcZu0v1FILVsflfv45AaoL0D1Iwbf41QmuSJ7cu+kt9owKl5Xl/h7EJMq8iEJ8hhdT4QoFonqGcd2UtiyaRYFhVkD1EKkumAA2B/BzwgeIz4YrexbPYh42m+d0RJPGh+OPnI+wkO1Bcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4yOhPil; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4yOhPil"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so7121560e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 18:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779325473; cv=none;
        d=google.com; s=arc-20240605;
        b=Vj7wcJWL3tUhsGTgvE/DryPoqt5Wp1M5KHyF/LxtM7V1tuRCn6046U5b4+GTOZj8vp
         hooJEP2z8HfKzYuqNip0ThhQBnVvGcop46TOa7AZ0tSe1kVa+JI4wgPJsUe2xfPByd3j
         wmMSv0KCGFTTmQ9YQohtcdp6c3F9ZMyOf9wm0I29QwnPjyZCyrzuyS0oBvQhrTNr1q4E
         HIJJlec1IOWJClC/06y4hF1xg1J3KMQrqcKDH14aquTNbVZ5XHJUOnK6Vh87FNHwxzRB
         d2AnYR/2d0diuyZ1JzMblamJfL5XakBFXk6qY7IlIMLOr/53eQhfxYtBTfUtDMxM5iNe
         W6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vrqhXrgKE1Au02/NkSyM6XFs/nQFlGHaQH6Z5V/fgkc=;
        fh=bhLh3BKjE5dAaKyec5fdp9KR3nmDQV/zFRDm7NDwCkg=;
        b=gdktfmPchYpKlC+DjmcisMhTLb7Pm9bRmIZvQ46vRSvP1vfpIoxWv+4EyEDGFJG2F1
         5DYAl4oJmDBYXvLe/sHeEPY52N2VjtWkfCZy5DB0h5ye3lVhGOrM02du0ePZKfmSc7pk
         1fGwlbUBUy1RqZGtPtQsZUmqlr8rKxvXWsaPzfV8YLkw46o7aluJU8CFR+vhf02FW4Z4
         /fPBAwI029fO1ChjBid7c7ksRofk2HRL8KM9j9OAKih+jM6V5G++NtITE4KfKGMfm+TC
         wFKwlWuzriMLVxg6r6GrHzoEFAkfpjNQRc6sBN1oXgscXD/ZWx22ivm9JwDZCzbeScTu
         xwtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325473; x=1779930273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrqhXrgKE1Au02/NkSyM6XFs/nQFlGHaQH6Z5V/fgkc=;
        b=K4yOhPilikXUaRk6uKdioRvOfKM5bx9S/nOwUS8ZHc5yLpveoEg57MXqgmxCsztEAs
         PKjxSt5yyflLzCONaHPAER0FU0wwGQiL61E5vDjBHFJhT99tjj9eiUu/VRfzYDLzamj6
         L5J0LWfso2MWnV54eII+xmPQW7h0VeS8wi2CKeD3TSaPkwNM9U+OvX9VziwbUg3aHpvR
         rlEB3fqK5HAYQg5a+WnU4eGHf7MZcJp8a6cEitmlbbuLrhH1yfKyIAEBvDzOLcGI+zGw
         Kjz3PHX9vVfHaMMBlpG3EDV2curKUhiMFqK7WkLPCYjk/OrMJ8YGSL1CGW7yXQs5HzzH
         NI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325473; x=1779930273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrqhXrgKE1Au02/NkSyM6XFs/nQFlGHaQH6Z5V/fgkc=;
        b=dYMCIlvx8Q0AOjYZdAGhTIM/ckV+d2SetnAHPOTADAsXzxDvtGyc/NDCuRAONDeRt5
         wVyy7SvNoCwatAQetNg6m2ja3McD6QyGseX5a3viaoeU5aIPAtNvLGpk0u67rNC82NOg
         B2CxR4pCfRSWZbxavUf5ESy4Skk2LI9ytemjNMtQi/uFiCusXDoncys60jxsAvTkGTXT
         s4VD5CRshIiX+hphaNGSEvVU8tkSQwZCmTQSMDbpK6Rmq9EU6CWwcduE8gQl5M5UyH+D
         BACLZWNIiqPI0nlMfwoWPLaD4LcoHZ5I7aaZ5SK9NtK2mqHOXSNVNg09j1NvGIYCKX1e
         ol0A==
X-Forwarded-Encrypted: i=1; AFNElJ9PYE8dTq7jtkLSb/8bbq5C7NvkAGCkHOpMsM7nWWEIG7ep5JJF5hOQNlOLJK4PjVtgaqcy7odL44ZcIo/9@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3yaWsSYDEHCl/w8gOuQ+O6zouSvFAehIN14qmbU1uIMIHsQm
	qtZsgDoHeyDfYxsbWXnHvyj9kQRfJt60D7F2DHmHJmGNr49nKBVZvEBhgs6KqKdJDJ5KI89XtyT
	Cex/ZDHSFB1BOp5THMUJF/OghA5dLAic=
X-Gm-Gg: Acq92OFRMUTOMa14C9CevHrOW+8fYK24lFtB9vGLg5ElxSqEpld3NqP3OWAbii69PsP
	5BH4tlMIJpUmm8nQ3qy5vClGI/314KhymqnYt4FgQquzMUQTHga2o5Ezb4rov1oryrfSors8ffq
	Z9aefFYW4BtgxAZ3/dpaVsAVqF8QR4cc+3aaVJcBZ98odC2qWxpK1Pu0Q+ec+ku4mIKFKnNabe0
	6mFg0yjcJWwjBA3+JmnymeWzQBWF/WU1zWdp+cqWE+Zy4RsL+hMINiieBxIgNRz8rC+e2Ky5e2q
	xsTT0Vy85GMWDek2zw==
X-Received: by 2002:ac2:5205:0:b0:5a8:73c2:c90b with SMTP id
 2adb3069b0e04-5aa2bcdbc37mr121574e87.20.1779325473306; Wed, 20 May 2026
 18:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260520170151.4115308-4-charsyam@gmail.com>
In-Reply-To: <20260520170151.4115308-4-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 21 May 2026 10:04:21 +0900
X-Gm-Features: AVHnY4L_zRW0LrPuP4XXRtc2SPVfLHg0KJeHtzDVFUUyVdZ2DM60NTLp5zttLRc
Message-ID: <CANFS6bbf960Cr=ebqk6HHx4fL8Zev85Jb756sh0-2NpbJiqweQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: only alias volume $UpCase to default on exact match
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:02, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> load_and_init_upcase() currently aliases vol->upcase to the global
> default upcase whenever the shared prefix matches, and then truncates
> vol->upcase_len to that shorter prefix.  The result is correct only by
> accident: upcase[] accesses in name collation are gated by upcase_len,
> so the prefix-equality alias produces the same fold output as keeping
> the volume's own shorter table.
>
> Still, prefix equality is not equality: the volume table is logically
> distinct from the default and should not be replaced by it unless they
> are byte-for-byte identical.  Use memcmp() to compare the complete table
> in one expression and drop the now-redundant upcase_len rewrite.
>
> No user-visible change is expected for compliant volumes whose $UpCase
> has exactly default_upcase_len entries; shorter volume tables are no
> longer aliased to the default.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  super.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/super.c b/super.c
> index c90cb5673f98..811640cf5669 100644
> --- a/super.c
> +++ b/super.c
> @@ -1344,7 +1344,6 @@ static bool load_and_init_upcase(struct ntfs_volume=
 *vol)
>  #endif
>         pgoff_t index, max_index;
>         unsigned int size;
> -       int i, max;
>
>         ntfs_debug("Entering.");
>         /* Read upcase table and setup vol->upcase and vol->upcase_len. *=
/
> @@ -1405,16 +1404,11 @@ read_partial_upcase_page:
>                 mutex_unlock(&ntfs_lock);
>                 return true;
>         }
> -       max =3D default_upcase_len;
> -       if (max > vol->upcase_len)
> -               max =3D vol->upcase_len;
> -       for (i =3D 0; i < max; i++)
> -               if (vol->upcase[i] !=3D default_upcase[i])
> -                       break;
> -       if (i =3D=3D max) {
> +       if (default_upcase_len =3D=3D vol->upcase_len &&
> +           !memcmp(vol->upcase, default_upcase,
> +                   default_upcase_len * sizeof(*default_upcase))) {
>                 kvfree(vol->upcase);
>                 vol->upcase =3D default_upcase;
> -               vol->upcase_len =3D max;
>                 ntfs_nr_upcase_users++;
>                 mutex_unlock(&ntfs_lock);
>                 ntfs_debug("Volume specified $UpCase matches default. Usi=
ng default.");
> --
> 2.43.0



--=20
Thanks,
Hyunchul
