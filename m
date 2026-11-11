Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362876;
	b=Esep+mFF9oHxnHCy7xR+d98XuqEf1wxRwwNYtw5ccuX7n6Fp5Sgn5kEcrGuVYhvLOk/t
	 KFY2IGTLKvi8/RVo58uJ5SgTTM3AbT8OwIrRpTwHUq1bFHP0UtH5F114Kr6/R4+AB1OXX
	 pdkTzuOhWYkZ3zpUmqrM5AiZHIiSVBWA5kqykRVY/ApMzCIlWDnXnaaulEVHyLOoMMsk6
	 YH162izUuCTGGyllgoDKdrK6Rj8jTkIj5SE28bzxiCH4eK9wsyhTWSeufwJQAXg8s2WLW
	 WDpC0iVGw8DVizMaOAFZECdCd2wB8lfqZ+nhxz8/S2CNgUOcdtrG7u5WkotfQnmcIPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362876;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=bs+aVi1+6hDy1HNy6v6dzYMiqPyVoyHt4w4ufaPFezs=;
	b=alzS5lvXUNVQGcVSO3b0XUW4ww19ggdnV6+19npYRcX56jb0oXHKtGKD+7EUT4kz3gYK
	 3ZkOBjAomIg6XQpVjgEiO8BEg0eYlsKY1gn6+iRTJJQ6F3rcUdDtj0i7DZmTRgRuLwMAk
	 yDicjs69OFrcptgtMxalvxvmObMqVY295gEVLdx/iKLG3EujBWC8jof/Zh+QnTjinu7DE
	 aNUjjxUpWerElMxAnYtlF7bgNUk+Rj3pySGZOElVskFLKh9W6IDrPhDG6w8R3xqWXdE7N
	 u3b0lW8UkTJVBTwG8c2uj26wyNJvLn28OvT1eZb0MNFzWlLzdgP+SD3nkcdIWQov78Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShtsgSig;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EC606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShtsgSig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3291F0093C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362875;
	bh=bs+aVi1+6hDy1HNy6v6dzYMiqPyVoyHt4w4ufaPFezs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ShtsgSigYIYS02Dgo3ulYttIR6NWLDZHXsS+qvuEfybQsNYFpMApFz42nPGouZlP+
	 pjIHBRIBjBgcAKZpeqgyvk2XANMh2uei0s7EbTlBt5GZaoprhHHvMpuhhJW7xW2wpQ
	 B1+AP8fzjmifGmgoTWoG56L25HdHLlw6PKCs57hPQOVxx08zgpjtBx+oxFKjlPIPem
	 d5md7EN2vVJKGaZyYwr2bR7wgfb6yqOdKBr0VPoz7vfbWTc9hukUT8Tc8XjSvSMi9U
	 DOt5i1Eoqid5UDTlPGd//SwVBMLr5wxW/8KUC23jzT/ghYgy2LEqDh+pHcle+9xuYe
	 CgbFYE1dzYerg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso3200113a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 18:07:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHXdjG6jJEN0edWUQRigLs1/p30LvPQsxhoBIk+UZaDYwoI1xzfJg/BVt42vzRLwy8O5G9UvV82IUXNQ5ts@vger.kernel.org
X-Gm-Message-State: APuU4Z/F7T3UJHewrV5KdDxnZQvLpmKHazV3eHmDMDTfV6PBpMIi8iM0
	M966FvRl5iZ9wb5jRaQWe1RZuwr5UupNRr8lfSLp/kQ7dx4ZdskLbrqFE5GDcnUQOGkqrMwNdmk
	5niik9nxN7UeAUvIJsjys4Ao5FOB4gfY=
X-Received: by 2002:a17:907:728f:b0:c50:5e10:71aa with SMTP id
 a640c23a62f3a-c5066afced2mr70360266b.14.1794362874533; Tue, 10 Nov 2026
 18:07:54 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109142429.1741882-1-wahidzk0091@gmail.com> <20261109173229.1921147-1-wahidzk0091@gmail.com>
In-Reply-To: <20261109173229.1921147-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 11 Nov 2026 11:07:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-n+zGBq4i7rfLyX+_Y6zEMLTCCqb2vAgcnmavqKxtiHA@mail.gmail.com>
X-Gm-Features: AclHuK8X-dE1jij8Odw14OGuXlOkUvdVf6LdzFcz6clCkOfLe7qi0UBLqneoZto
Message-ID: <CAKYAXd-n+zGBq4i7rfLyX+_Y6zEMLTCCqb2vAgcnmavqKxtiHA@mail.gmail.com>
Subject: Re: [PATCH v8] ntfs: convert a named $DATA stream safely when making
 room in a record
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -4895,8 +4922,19 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
>         /* There is not enough space in the mft record to perform the resize. */
>
>         /* Make the attribute non-resident if possible. */
> -       err = ntfs_attr_make_non_resident(attr_ni,
> -                       le32_to_cpu(ctx->attr->data.resident.value_length));
> +       err = __ntfs_attr_make_non_resident(attr_ni,
> +                       le32_to_cpu(ctx->attr->data.resident.value_length), true);
> +       /*
> +        * A reader holding folio 0 waits for mrec_lock, which we hold. Do not
> +        * wait for it and do not look for room elsewhere either: the reader
> +        * keeps the folio until we drop the lock, so the attribute can neither
> +        * be converted nor written without waiting for it, and the loop below
> +        * would only convert other attributes for nothing.
> +        */
> +       if (err == -EAGAIN) {
> +               err = -ENOSPC;
Please explain why -EAGAIN should be changed to -ENOSPC.
Thanks.
> +               goto put_err_out;
> +       }
