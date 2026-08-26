Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F203101A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743768; cv=none; b=fifwIj07r+mg02xIHWaIDk1LgKb5r5YNvF2oRkaik6CP2VQYDUKzwk86UiaPO5DXomlKvJ6zWV6dsCYkO85kxdz6dkV+/TFzMGHTbraUMR2EjTag7GkPFR6A2Hf+gYR4G2JWCwwOm6m7ZSYSp/3Io2oLuBgyqyBlVnt2BUhU6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743768; c=relaxed/simple;
	bh=3+O3SOPkhmcuHAkuexZD4cGe1Nktd41KvZzfxI9Hgho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSNF+J5lIAfYd/FN5geeBQhZ2ac/NtGinY7pckWZiNwo8FiqjyWdMs20NH2fMwMrAEq7gj64EA+dGbtQayv2WjrfW3ulYmyOhVo9T1zThbAuNHfQgpbLNG0/aQ3S50qxWEFcOLdl+IW+CoxOC2qU7Z/nfrhh5WgfyPE8zAqc4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt8PUOOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt8PUOOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FD21F00A3E
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787743767;
	bh=iVPA/Rb76X5mSRKvP/690rlPa9al3VVPJ9WMoWejkL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Wt8PUOOQuVcGUj7hJUxKw5UDqCwfhB90up1R7EOkfXxxkV594Ef5jwXbZ+WU0nrLA
	 XYyoG8Hiw4tI6Qj16Mj5Zio4V6p8W5DE4Q7AQsDrhX+ipr23VchKaErOS12lzCPl5w
	 P0G+MFbrMugfhw/fIcVoyLe2RxE258soJmbFiIGMVsOVV2JZPaP1srhl77dDeDlHU2
	 ekz1OjVuPmkHn2ls9h+RdHA3SBCLDuF1LdSDT6zaKLzV7vSdLuR5IDhqxmyNJ1pYCj
	 IUWiTPQ4g/ELQjBgCAfFWnLFAFs83VouewAElVmh0iDmPR5HkBL7z/FUgwDswq+A/q
	 FJu8RwHuvQI+g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a5e866bca0so826705a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 04:29:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoQtvyj7GxHu2x1VoWIGZLMMR1NVe86zVdgX6m9Gce1YmunmF/6qJbYWhZqo1HrU5r93hhFqMLLXiJFMzHC@vger.kernel.org
X-Gm-Message-State: AFuF++n2OhunSmhoyJtxiEsLMqRwIQjEDnaWqSzrHHk1STSDpFpqNgfW
	05HLJ6nAQoTVESNVWdHiUedvz8hgan5BjvXyeYfT6xa9ObBss6K6/qnvddPWNokoPpC87SO1gQk
	89peKbO6nY6gLr5bHCqVrcjta2v6rn6c=
X-Received: by 2002:a05:6402:5cb:b0:6a3:f74d:6a20 with SMTP id
 4fb4d7f45d1cf-6a5df5d73abmr6706129a12.4.1787743766206; Wed, 26 Aug 2026
 04:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825054659.3967694-1-guanwentao@uniontech.com>
In-Reply-To: <20260825054659.3967694-1-guanwentao@uniontech.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 26 Aug 2026 20:29:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_FgeM9ka7HsCkqQb6az0rfVtNYe+E1qVSvz14ZQEJ0oQ@mail.gmail.com>
X-Gm-Features: AcwNN1WX78HcIneBScOv_ZCW0KJycvqaicApyEqZIEwrVfWeFZvR4zbb-gXS-gg
Message-ID: <CAKYAXd_FgeM9ka7HsCkqQb6az0rfVtNYe+E1qVSvz14ZQEJ0oQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: treat any nonzero dio zero-range return as an error
To: Wentao Guan <guanwentao@uniontech.com>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:47=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> ntfs_dio_zero_range() returns either 0 or a negative errno from
> blkdev_issue_zeroout(); it never returns a positive value.  The
> zeroing failure check in ntfs_attr_fallocate() therefore never fired,
> so a failed zeroing operation was silently ignored: the loop kept
> going, the newly allocated clusters were folded into initialized_size
> and the write could succeed leaving stale on-disk data.
>
> Treat any nonzero return as an error and abort the allocation.
>
> Fixes: 495e90fa33482 ("ntfs: update attrib operations")
> Assisted-by: atomcode:deepseek-v4-flash
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Applied it to #ntfs-next.
Thanks!
