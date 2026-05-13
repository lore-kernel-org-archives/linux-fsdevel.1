Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FC38D687
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684004; cv=none; b=taHjasA5xvFW1HrDsxi76SsY+82FDRkcJxJYzrzRLUV4c6MJuq/aZ/7DSE+DKe/NnCPV02ky8BJR3XMkx0OyVfoBad9K5bJVvalS4z5BgNl5oXY4y66Shve913Lci0JyZ7De9vN7Nm6Zy2nZRCYHYcsNByXQxF8YlUA+CzTAYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684004; c=relaxed/simple;
	bh=s0NYlfptE24gUriCvi5WTNx1h/eWXvvFSemzwTBvRRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjOGplvMJJtFTbt34SxUp6zF39YqNWHzMasFZo7+HsfoUyboDnTaVQzET6+ykT5HijoX9ZVZKpj9jkkPM+LkvCMGHZ/+e+ZzL83uxe5N3JxxcU2OWXlHCYm5QUfSe2MptRiatHVs9ga7J0UaHe0clS6sMBbCNnhH2GeWRbUcJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he4TK2Rp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he4TK2Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92213C4AF09
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684003;
	bh=s0NYlfptE24gUriCvi5WTNx1h/eWXvvFSemzwTBvRRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=he4TK2Rptnwr18TbtlUyWx0wqIhs+cYMAci/3So8T1gXuCr+dlHwxoR6mYXLjMiW7
	 OBtbixvBLrv0YlOno1PmkuEo7DK1YpBWlwLGcYNdqfqc1F7/tY2aHLctC/SWgt6yKo
	 YxIJxD93g6EVURgfkMq7x1o2BjVLVeAFWbs5glmu3rvYMHODU7tGQQ+hrDV6o1H6hY
	 6RVMx+EfgxTd2vlJol+bZ9NC1V8ltR5gqTL5Cr/xeK/ygX3IT+YY/y7vanP4HGfo1Y
	 PqoQ/08uwUL+d8W283sq3NJhBiglX4AcFb02/pQBNpJYfoYz4RPYTM8o2P/2fY1Z74
	 y86Q2gAONFlbg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso5785844a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 07:53:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/AWTqrqyYnIny4KsX22MPJtafRFqSzJUr42hI32g3vVLg8R8zRQzp+2+mVWu1bYfSiTQArh86j2wMdJGdh@vger.kernel.org
X-Gm-Message-State: AOJu0YzTM1wVwrSLTiMprDC6l9NG+Xb7ofyu29VuvioaL6nyCtNUgsFU
	ru6YgMnULRt5Z5YCYPIo6t5PFiW3h3iC3ooMQADbKCx3zArgpAWTon69cNYkQYPsy3jFehYOtJb
	eqTWIgGvRf4OQ+dcNjMO84P/fFzh9FRw=
X-Received: by 2002:a05:6402:5358:b0:676:20c8:5420 with SMTP id
 4fb4d7f45d1cf-682579f58b2mr1760096a12.25.1778684002205; Wed, 13 May 2026
 07:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-3-charsyam@gmail.com>
In-Reply-To: <20260511160626.1268612-3-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 May 2026 23:53:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9=rt9sMwA+BpwomUT3ZdxA0YPKM1S6VyZMiYk3-9NqDg@mail.gmail.com>
X-Gm-Features: AVHnY4KTy4NXlXPJvL5I5-f_Z59ugZZNAIPahYJuC8OtNkOzk-Ga4vk4fWk3hVw
Message-ID: <CAKYAXd9=rt9sMwA+BpwomUT3ZdxA0YPKM1S6VyZMiYk3-9NqDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntfs: use $Q when marking quotas out of date
To: DaeMyung Kang <charsyam@gmail.com>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/ntfs/quota.c b/fs/ntfs/quota.c
> index b443243..7086951 100644
> --- a/fs/ntfs/quota.c
> +++ b/fs/ntfs/quota.c
> @@ -21,6 +21,7 @@ bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol)
>  {
>         struct ntfs_index_context *ictx;
>         struct quota_control_entry *qce;
> +       static __le16 Q[3] = { cpu_to_le16('$'), cpu_to_le16('Q'), 0 };
Since Q[] is already defined in load_and_init_quota(), it would be
better to define it in quota.h to avoid redundancy.
