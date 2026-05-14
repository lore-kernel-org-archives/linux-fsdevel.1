Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91438F927
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802957; cv=pass; b=oIhwhyZyvOiM1hT9l/Biwz1MmbLSMJe07QGHg9OLVU3M1NlvHIWQir1bWI5XUHYIjDnxyQxiVyCevDqElCf+ERPjRzgHvdj4xOkYosWWcFm53N3fdaDJa7cQ81hCaqpYGOeHWzdS0UpWgqnSPw9rFkGGztPYYe0ZoDIOQg9lxQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802957; c=relaxed/simple;
	bh=u6WmIjDILO+FXGLXjtsUMbqQ80zS029FkoXprEYb1aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy07Ld3fdk4rE4yguaAYd5tIyF5uLYw6goWjrrUa8CYX8UyhFOc+mt/PFjx/AVX5aQYD6unkb4EBEsxmn9EZ+Gs4sdts7E4VLnoLFxdAGeYWl21913W4Cn0789C3ZK9xiy5lDlJVcrgXHfNuB1cSy9rHRU/IgjJeyj+h34wqCec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNHwwqM6; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNHwwqM6"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8f9841616so1693702e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 16:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778802954; cv=none;
        d=google.com; s=arc-20240605;
        b=d2O+fCTwRw8vud9aU9TKuxbzjD3MhnxEYGn3jAqI6Qkgo7WBb0XY0jwo0msK9D44nU
         WzVYg0o9g1bp2l2w/5f6tFbfYfqphBHkrWnhWCVSJ5Lld8GAtIzpbaaKAiGvtF4NkYbG
         PEyYZsdbI4KJ09ScJKL8+RsG4uYqJD4apouyo85SSlle20q29BUSSqt4oDgyZ41s1XYk
         /njxibITfdjBsuH9BoBBnXUzoje76KgVjzsjKeFy/wLmA7Ia2r+BrUe+7xerh0bsyO/m
         BzmhvkSl9SIEPwZI3AvRo20C+7MIuXoukfcFOHgwh+WATnWYdMlMTcDdnavMWN814h0V
         IE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZeVxBqjEoiqN/WuzjHZ1kw1aMPuyvoi4NsK6EX3js94=;
        fh=YqsdgsbuJkkBXoq9o0oCmDGXhcJGFoSA801yiJQgoZM=;
        b=LthcJqLuhkKKDSr/CLsYFN7+NfjUdZL+bzixwpNd+a71D96jBDMUCpfPQ+Laikjhaa
         V1gZpaiv35lqEHceTPU9I1BDxT4WpgctA7V7OFGyh0XLkPgPG2p+yjAEY233BWsK7jRf
         kpxBM8ePe0DlZAKCg5zezYKsPIYvQEZoB6IoqeU/VRVVv5Ad2Pu4PdhNltl354wOV09Y
         UHEKb8QzLZr8RWUY571gMxJod0gWHZyfeZLWw9DK3TdfUuMncBDdj3Q9fmJ91s6ST3N+
         J7vTEPBFWPl0J0B5gN+nAaJeQllXGDOo5Jz66yw43+C797VClU/wA1xDI/FPZVxwKW1Q
         OCJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778802954; x=1779407754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeVxBqjEoiqN/WuzjHZ1kw1aMPuyvoi4NsK6EX3js94=;
        b=cNHwwqM66BmnI3QY/ihFnM6Jxv5833IYInfevclAcDwCjH/OFaFDI2fVun0zH1dEn5
         TcwK1/1+evAZIfijQUuyYzxgsY0QvDc20xZqASJQLPLbRwbpm/X8Tj3k23jrH5izK/Pm
         y1qfOLjupsBnisMsN6ngSunJl3duTk/kvIwvF8TbW7wzObeqPdMDR4kqnuldOSAmpWTR
         wvJCtYil80AGYKQ7x/GkmRHTIrxwmBWGiIOfA/at0BBSJK8wlPHrmXKoyJnBSEdMh6P0
         piSD20oEj2Pysj/HVvHJ6Ws2bngbjo+WUQQWvAHSqk3RLfBmP3TYfav1PPhAjCdNKSIk
         37yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778802954; x=1779407754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZeVxBqjEoiqN/WuzjHZ1kw1aMPuyvoi4NsK6EX3js94=;
        b=qAmVuD21VRp1g3GggWPMytZTdirJpvapvz0+AWXLQcB32ds9uMg9iPLAU39elOCwJe
         YdeEGVD4+76chOVz5TjhvkMDhTuvTuNYfuJ3zZBlznn7J/1KnY02a4ePLjtYf0NeZao3
         3WNVs6tFR7/hVfOI1wRCGXLnJfVYEH59N4acLyM478BrSjtfyNi5rZzXU/ySNDYdLQuH
         rEEAcljliqX0YRrPmx5LERC6VF1e3fOJmrABVJwjDA2qedq7TYW6DplG9l8jF4EqFGq8
         a/uD9JlMB20D3zcnH+vfhZ4El/a7t+CuXKwt2kpLVAjNSPh/zk05ZZGimeMwNe7Zhmnt
         26Cw==
X-Forwarded-Encrypted: i=1; AFNElJ8wep6lNfrVp3Ma+JRp+iMP4vifSqR+bzBSA8YuPhrfg/wBXIUYelznn+FmFbgBNV13l4nKfqFQRXH/BJP5@vger.kernel.org
X-Gm-Message-State: AOJu0YxngQkj8gBPmFIuvGfuJbtDua9NVMQ4Rilufps4teSd1Dqdmcdi
	tRG/YBbM9JCEqSzNVnXREIYH/12Hb8HT35vKukhP6VwuE3Nars+XPbbRi+h8ncezwNyGdxBRkUY
	U3fEu6NFoGUb5nibceLxFsHqAIN1AA7Q=
X-Gm-Gg: Acq92OF5NNWmVIsdvhJ8z4uQ/hQUo0hZf7khEM7S/npHLoM+ipAzPxNJGPRobFQaLqI
	dKtZBjKfiWzk0NMgPcYrG0yuWvUsirlWJ4q9q/wLAg6jHYimZ4+BLiPaBtIx0WGwoJjVuq8eW4i
	ji1wzDI/QnwPOTyKg5ig6t+1waYbXrfWVxAzbEkCc4PQvKlrDbHJrPWH6E2KlpkS9tuanOo95uF
	3WKAAO+lKL+vtrW+dDxxEmFqMbBL4MQVANA4oqniSC8fm4CO7m45aKfENQfsf3uPbnW+VzdUr7h
	kgP4CFM=
X-Received: by 2002:a05:6512:32c6:b0:5a8:8222:7fbb with SMTP id
 2adb3069b0e04-5aa0e73c491mr351172e87.34.1778802953833; Thu, 14 May 2026
 16:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514135408.297659-1-marco.crivellari@suse.com>
In-Reply-To: <20260514135408.297659-1-marco.crivellari@suse.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 15 May 2026 08:55:42 +0900
X-Gm-Features: AVHnY4JxAWyl4icGx7jwf_NsTFYViDD2NaJypMfWga-IdzbwkRF_DrDnIx3g8vo
Message-ID: <CANFS6baFgNUzLVnb7GDkM_05ZANsMv9RypdH_iRDqUaSEmPkzg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:54, =
Marco Crivellari <marco.crivellari@suse.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU. For more details see the Link tag below.
>
> In order to keep alloc_workqueue() behavior identical, explicitly request
> WQ_PERCPU.
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 22dc7865eca7..3a25e4dcfba4 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -2628,7 +2628,7 @@ MODULE_ALIAS_FS("ntfs");
>
>  static int ntfs_workqueue_init(void)
>  {
> -       ntfs_wq =3D alloc_workqueue("ntfs-bg-io", 0, 0);
> +       ntfs_wq =3D alloc_workqueue("ntfs-bg-io", WQ_PERCPU, 0);
>         if (!ntfs_wq)
>                 return -ENOMEM;
>         return 0;
> --
> 2.54.0
>


--=20
Thanks,
Hyunchul
