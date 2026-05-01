Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344C22652D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640712; cv=pass; b=HfEgS8/6k7ZvPCn2KjzBm2fxnonElr/Ca/k+9IX7jTRcnHAw1GUSXzqmUD3n9vqOHXmxsxx+WIwsT88/sWzG4f2zKAJShvBFQCF9JI502y5Wh610u4fHq8Tmg+XFc1DYVGx5rkJ2t8RS0ttNdusexJUyXgZEcRlY6svIH/uYvrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640712; c=relaxed/simple;
	bh=4uTp5lZOmzULj+EfYozObhtGx6LyvaZco97b2+ajmnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuOFtsRrlFu9EvwFr2V7fb2hhfvcYJK7apARuO3/mPfUefsBDpsu3NwErxuuJ+I9gdaG4IvXoRd/zfV3sSJPimC46Bq85Xgy6MwuFJ4IfT1lUArUS+C3TDbERjooOo2d+bGRPIynNC6B09KIDrWA3TlGgr2oRPN14C9j8A9EvI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVN8E5Cq; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVN8E5Cq"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38def541b0bso16200951fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 06:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777640710; cv=none;
        d=google.com; s=arc-20240605;
        b=CeHkOmkrSId42y5Kn49sgT+7/EAPlg+w3mG6YdN9MYeOk/fAg0FUMs6A1fARPxzXUv
         oUo53hT2p6+6L8L+G3CQSomas7pMx69yhOHWCeUJvaKjYQ1j85WrARwdSYFyCkyzEW0U
         coxy7knvjgNhFJR1jm53UABXp+2tHIwWXkec6gfCQ8kl0m4T2qq5+aAdPvN/ldaGXMP2
         azxGFsVZRhISRMYu11805XMUIIdEcS6CMkIVQGCl5t+ukktLLX5HfkKIQQOecN3E3QtT
         BKWGy34eaKbms8GLSpvtXkYtVuhwHY7k3VNYEYCg712yYx/VdoK3jCK5mRH8xEt4tg5K
         0jDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMjGQOHCZ0IBq982b1rHzuDHs/ZxEkZga3hl66eybBM=;
        fh=Gmxj5jJG9yUk6vwIPRUZ9vM9fZyTEbangy6vPCuaLKw=;
        b=c2IJHEcHPEL6+XL1FJehaeEvJayuQHyfa3j5VMDYLjme97PESPwlZAK0td24OhyO9R
         LZspyufNDD/AqJL93UQp/KHVvSSvpKmEO/XoYZL63Lv0hxwAH1ZJL+i2jDh4xFfcxDzm
         69JXON0wof1hBPbLuGntAs4Rjvlm04D0TF7cK6ydWWhQVgsmKUp8SX77cnVZFBkizR4t
         kPxTINAXx/U0+23E0mfw+e7+7GlwBMaUEX6+IHy/vParbjo0jeYyfRTZETZhy7kCqbhg
         gTeDS25UfSP3KUaZYoeL6BXLc5F3dsFPxH5U3rKIMtDnrZWcIN/eEZSflUhGJhgZL695
         J6UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777640710; x=1778245510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMjGQOHCZ0IBq982b1rHzuDHs/ZxEkZga3hl66eybBM=;
        b=TVN8E5CqNmitqJSuy925HzXh5HolIykHftAQfzkcUghhsz+o0ZXU3ibv6JbHMdvicP
         eA84DNuQlLzzCT9HKg6JXhACmzjxFYm9TjGK0/WD2iDSWXGx6n7VpDQbtv7Bf/kIP6E7
         EOpZIZITy/fllbJ9ifhkQzPxf3ZvRg+SCTbyzhlUjdWPhoJONbt9NCA4JUBhy0rNNXDa
         StuyERlwVWR2NAVnboNcaGr4OqZej/Rk0tyTDwkSh6j2W4GyUWx8KUb0ObkvEoEIhJPy
         HynV4uj7RwM3MXpLsUiV+7bEe2eIJNLuNaZmxtksTeTRSd27q2yXYzZ+n1lR8zbtkzOj
         +UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777640710; x=1778245510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMjGQOHCZ0IBq982b1rHzuDHs/ZxEkZga3hl66eybBM=;
        b=IyQ1zb0aSXi0+R8AgtPe2o/eQLFjI8rShSh4NEGxasOwOWdJgHrzvrCSxD0dMK+JUK
         jQgGh4ke2vF5YM5BfjZJ3mXe0ux0WatRlNK/twK7uhBfcXTrkzRZqgHUxUwCRCs8hMXF
         Q+/WKWY1R/cpZRhVxucpBTakdzX/yTjWkg9li1xk2MvW2rNylTsVv9VvdIm4U5eBSbdB
         2deiayCH8qbiy8tW/QsA22QeB+e6FDR4P3tq4c/IJgzJVZemP93wcc3NAvLSjWaX3PmR
         DQlkIBNwtc+S4a2xlh8ifNgwKoBu9kD8wKbWRw3NP7GZXFxk9ZO8ragimKTTsDxD8yIc
         XqKg==
X-Forwarded-Encrypted: i=1; AFNElJ+zeEnZUSYKOyZ+Aqul5sUYFVQtYMY/8YP4CrGoOfep2/Bq9iNWGmdj02rJjGtslXjiUjaKo7zDVRxeGG5S@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGLuQs6LJypPbkiQCivBdrZ0P2MEyIqw2MSkblWs8PlXXhfZM
	1/kzxjMli1LsLvap5viyLedaitMTbRUc+QatfXO49opzjCNGOoTHdu+/VNXP716bgfKmMHzuAeY
	WJTnMidyXYW9z5anrPGbtA4zQfoHBxOk=
X-Gm-Gg: AeBDievGuC4EjECxCpjVSeUOXiGT0VpmT9lx1ROrqmxM+lZHBumupSOxzsFYF4m4keO
	Y9SAmi0tLuLyyBRmJSha+2SKGBZPYWQpXzXVBU2ozZOGImra3Ld4/t7w1OwNd39GF+QS6JwgJyp
	2KT8CFCcQ0yioYPwCx4muT17pvxdOqjH2kdXb9DozwMN37n4MSkEajccIQwnLOZmjtdaxCnomdq
	4uhY5nQ9ZHAHfeqHZ94IUmQI4d76VO47IWlJZrt7FK03S0At7IuTtlqVxWBRdTL3v7BaVJTyIHH
	/ikqWLiX/M2Hb6pZfve00lHOcHoKwA==
X-Received: by 2002:a05:651c:1106:b0:393:5ada:4605 with SMTP id
 38308e7fff4ca-3935ada5645mr19258261fa.25.1777640709579; Fri, 01 May 2026
 06:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777568957.git.charsyam@gmail.com> <f83cb152b97cbc98a4850caf0a23a229db5b9e98.1777568957.git.charsyam@gmail.com>
In-Reply-To: <f83cb152b97cbc98a4850caf0a23a229db5b9e98.1777568957.git.charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 1 May 2026 22:04:58 +0900
X-Gm-Features: AVHnY4IyW2eoKqh3LUQa0mR21drw8Gf0BUOgsHWF0wDAwiTTlNGH1P31CYRU--0
Message-ID: <CANFS6baE_bDUB3cyt0pSvetiO6Yv5rbOaKi-TLCs7OMeJGGhTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: capture mft mirror sync errors in ntfs_write_mft_block()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 2:21, Da=
eMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> After ntfs_sync_mft_mirror() became able to return real I/O errors,
> ntfs_write_mft_block() still discards its return value at the call
> site inside the per-record loop.  A failed $MFTMirr write therefore
> leaves the volume looking clean from the writeback path even though
> the on-disk mirror is now stale.
>
> Capture the return value and feed it into the function's existing
> @err variable using the same "first error wins" pattern already used
> on other failure paths.  The error is propagated to the caller and,
> via the existing tail of the function, sets NVolErrors so umount and
> chkdsk see the volume as inconsistent.
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
>  fs/ntfs/mft.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 00f172fd1b21..866816f710b5 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -2862,9 +2862,13 @@ static int ntfs_write_mft_block(struct folio *foli=
o, struct writeback_control *w
>                         }
>                         prev_mft_ofs =3D mft_ofs;
>
> -                       if (mft_no < vol->mftmirr_size)
> -                               ntfs_sync_mft_mirror(vol, mft_no,
> +                       if (mft_no < vol->mftmirr_size) {
> +                               int sub_err =3D ntfs_sync_mft_mirror(vol,=
 mft_no,
>                                                 (struct mft_record *)(kad=
dr + mft_ofs));
> +
> +                               if (unlikely(sub_err) && !err)
> +                                       err =3D sub_err;
> +                       }
>                 } else if (ref_inos[nr_ref_inos])
>                         nr_ref_inos++;
>         }
> --
> 2.43.0
>


--
Thanks,
Hyunchul
