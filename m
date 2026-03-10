Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E539DBFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179740; cv=pass; b=sBJkG2WV2f0Rmaw6d9fbhS11h/WHUgQAytrTunPOON/ROsRfDLpcVDtNDPjGM3RfWugsazXcUpUR29lu7DLElcSa+tYTR1+GlXn5OFgbt9hBbVJncGlOM3frEc8M9ykQ51aPFWlmd3WMrZfxdt9lFG5n8eny2pbYvx7AfxN4XCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179740; c=relaxed/simple;
	bh=SnHDhjO4ZHtLW9G/VSJFbO6/CSnzcbrJFYmNBZCfmgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKssTp49Nb8dLhvU4Fuvm5Hbm/1NuiVlw1Xccpl5/utEU1qp69b+1h3Pw5vO4Yla68no2kFYfKJJMSbRB98UNmKYLtP3PahADKt/wLl1ajXy06rzIk2PzK1k9IM7KIvhP4tzWRXHYBx8AoPghxSpLmK++Sg7HwCI6U7/3a9e5IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqickQ2Z; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqickQ2Z"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485409ab264so2425645e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773179737; cv=none;
        d=google.com; s=arc-20240605;
        b=ZhOUNlaGZCD/a3QlHewI8uH9EED28+xqRmYMoqlvv0bKPlChMB416UHJcEsp3TkQ/k
         O76N8OyPDetj4NOyz6/NFiHIjmmArw+/r0mClbG8qxB9HFzBHGv/GBCDGeNZyxDnZxWa
         BZQMWi4MGo9/WeE9g9bdb0sgAkFeYIhrTysPHSfQ3XC8W++f+WiH6ZRcc94UjtjcDPKY
         awXO9JCz5gt4Y+b+fZOCwG502l8aFZzLTZ/ArUrVPo0SGGflQI4CwEGWZwI1hQMJmZ1I
         HbQPzO/kW2TLtkqJAJJoCzbjMQB9cbdQcgm5T+qJVRH9TCd5lfSqYALCduXpdO0BFx/S
         ZwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ycaKHoMk/IURW+78dOeL2NM/U9Ps/AIyk2W7D/EP8Hs=;
        fh=h/dfvY/M0fgQSU5sjMaOGS/FGT8IM9WVJs5hcX5Rb08=;
        b=irbesxTMQFmAKNvNkauYpMetNMnjZOeoBirz+5qQsLrSqF9Z8VSXoMALvxwxgW8RNZ
         0ZmmdGt6lCreNW0hh1NZ0Pers+KICOfscuGgWSgWBvTenqhaltHqC3ohCjVhTU5e2Gd5
         Qv0F0bLg/rQanqbb6w/K3uER2sXkwbTQNeDzPfvXtZp4ivJje8Nh1vkDg6vAU3xqhfv+
         dLFOgXbZ22QkJlhf/yZYcJ761wc+DjcKT9W6DF1sctE9eDH3K5vdWB5mHIINWGz3NwOx
         4iZ8x1f/gT09nWkZvnbQqD+GHeYHKuTU+Zpy2Ya3+gP/utcS+NgXlqbjvT7lj2TXRw1i
         AcHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773179737; x=1773784537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycaKHoMk/IURW+78dOeL2NM/U9Ps/AIyk2W7D/EP8Hs=;
        b=AqickQ2Z5/ZRfIxQod8jBPCmiJ7Gl/aGtyghZhKSmwMvrGyI3sAW5873uNf7v+vr9M
         0KW04DjFwcnfNzPD3Zc6VFtgcn4ssrlLJ/oyePe5O/PYYRLpA9w1KGXF8SVymydudItI
         gfSfsst1CYhVB2g6BiFAKMwdZkBJukbDARbk14dJKPd41fXoJrPo4e66v0Gbxe/rtxGt
         55yOA+lVoapr/M0wb0rVG0+VSS3BAENMVCdihMoE4jJ9oCRM22E10+t5ytDh6WD896qo
         h96vCvO4RYJitOwpMlPgUfet60rmwnaoe0vDpDi5+Nbe5cjl/Bid0DT2ZtSp0t9aySIK
         FYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179737; x=1773784537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycaKHoMk/IURW+78dOeL2NM/U9Ps/AIyk2W7D/EP8Hs=;
        b=Sl5wij5Kx2gH2s9ji+PYdbKtS+8oupHB8r1KE/2En/jL8LNTOzhSPtM1VcWbb+7g++
         wAYJ/rlwkKJ4qdGpb44RbKSXVg1Xlepo/yHZv59goL5jYeHeriOrs3yrsAkJKIXj9zJs
         xakkKZ932prUVnjLyvDKcypCexsyf+5XPK1w03pTDzoPv18OiI0MC+ylgOldCLh8Wf//
         n3rRWQ1oYy2mV7s82SDyCFK4eNs0SzBZFvprrWFfIBxF9w05eYAAfpEZfmA4DKikmbaa
         c/8BYJo/bPWqRfCr69/FVfNfSPOc8f7T4RQGBCRztLekIX8l55TsNCeY2QYe8apNcLck
         CLpA==
X-Gm-Message-State: AOJu0YwqceQ3En42CmLs85askPwSDsPIoUSQfOyk64t2vsS7un4Jsd42
	8s5igKpUhqVc+jV4F6m6fD3a10r9IGYQbhQdI2thBbHcphHRsbJg3qqOuq7W0xNexCd0mT6DInp
	5u7Uk5H8e3lxNySu6/rIghfjZSIzltt8=
X-Gm-Gg: ATEYQzz/CNa4iV5tBHZ2AcfVDbBT8nGhOM7vVGNepBoER8lexu7ahp0KqvfYvj5++In
	cfonJ+o3d82VEjqL5lt651VmkvqZE0lDhSmzfT6LztEGTy8ii3cMzk4K3pz9hih74A6UMwuwFrW
	uTAV1t2T6XMSciu/eLmXAt8LvXDh4BwSTsb9zXpJGQ8F6cCJcqDecZ4WGAJH4L40GO6n1rHpsoj
	K4At9TJGaiAqcZ71GhWSnivXGtgcQTaH5FgNWXhORTQl7nRco9AAPyMKZPgbjjDjPHQU8ZuTlo6
	1dXqFg==
X-Received: by 2002:a05:600c:c084:b0:485:3038:72c2 with SMTP id
 5b1f17b1804b1-48541a70200mr76191325e9.17.1773179736714; Tue, 10 Mar 2026
 14:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com> <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
 <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com> <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>
In-Reply-To: <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Mar 2026 14:55:25 -0700
X-Gm-Features: AaiRm53lqdqxIJFqMxzqo0QctlYkxErVHq-joKyQvEvR9vq9Tvkl_lvGFIskxTo
Message-ID: <CAJnrk1ao_0tp9oe2kisPPgY43YRqrQV=-GHSkgiwx_+WPUPD2Q@mail.gmail.com>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:08=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Mar 10, 2026 at 4:44=E2=80=AFAM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 867e8ac761c8..03a97361570f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -543,7 +543,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>                          * helper, then the helper owns the folio and wil=
l end
>                          * the read on it.
>                          */
> -                       if (*bytes_submitted =3D=3D folio_len)
> +                       if (*bytes_submitted =3D=3D folio_len || !ifs)
>                                 ctx->cur_folio =3D NULL;
>                 }

it should be this instead:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 867e8ac761c8..b803f518adaf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -497,6 +497,7 @@ static int iomap_read_folio_iter(struct iomap_iter *ite=
r,
        loff_t length =3D iomap_length(iter);
        struct folio *folio =3D ctx->cur_folio;
        size_t folio_len =3D folio_size(folio);
+       struct iomap_folio_state *ifs;
        size_t poff, plen;
        loff_t pos_diff;
        int ret;
@@ -508,7 +509,7 @@ static int iomap_read_folio_iter(struct iomap_iter *ite=
r,
                return iomap_iter_advance(iter, length);
        }

-       ifs_alloc(iter->inode, folio, iter->flags);
+       ifs =3D ifs_alloc(iter->inode, folio, iter->flags);

        length =3D min_t(loff_t, length, folio_len - offset_in_folio(folio,=
 pos));
        while (length) {
@@ -543,7 +544,7 @@ static int iomap_read_folio_iter(struct iomap_iter *ite=
r,
                         * helper, then the helper owns the folio and will =
end
                         * the read on it.
                         */
-                       if (*bytes_submitted =3D=3D folio_len)
+                       if (*bytes_submitted =3D=3D folio_len || !ifs)
                                ctx->cur_folio =3D NULL;
                }

Thanks,
Joanne
