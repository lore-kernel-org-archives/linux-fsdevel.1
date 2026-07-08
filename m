Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F340A93D
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502297; cv=pass; b=I57piBEwQri95IPqG+lVTkOCe01lQG8PTORThN3WDX6Rsf1hxz6/kAKepkZWM+6qO8Pou8bTgNL8cbUi5u+UplkOqrQPIEipAM3l6EAnctnkeEADdBEf+c3nN3NhWGzwt2Vb4nKqCvibQPPZfOKNsHPmmIZENYd+n/09gxuhFbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502297; c=relaxed/simple;
	bh=LhkN3iZ8M1OtywKaiY4DSFBrC/VxDrZxiRrnRPrISBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJKyGY59tG2kSnmEDeW/CA/wgOyGmvEzsHmjDkAN2X1Fem9aBHAr+FChnoVDwM2K9Ja8rqBVukEsMobO7yEyXoIK9JJrlQxiNYDWCrEo+3eKEKNx5+BYmAVcnrX7VIfdcEQUNmeUR8r9wJ95WP9kjraEtJOkxBXmpRa/oyqBSLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YU2JH3dg; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YU2JH3dg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c16ac21acso2161491cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 02:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783502295; cv=none;
        d=google.com; s=arc-20260327;
        b=fru9Skf7/GgHBgpHsRKsbG+sip1idzQu2/X+qJKGZiAtCWLOUwpVMZ8lkZcxfVhnp/
         GbHtP9diOO8xfxq2PWebmt8qbvS9T9zt70kdnJHs2OA3zEVerpOV+gud7Ln/aWXMfMCV
         L1qAAYkMSzZPJvXOwf08lkkalK5C0xFZHo0irY4gNdaGNneAzAEzYRV1Gjiji8p44H29
         aEWiAFB+xT4mGMRMmeugWkNoz1In9M0VkT2yD40gHmPKCsFQ+A0DLPckYvSAAcxuM6lU
         tASJrqSnHCKX7n5Ps2g2sJUpPghbc6uQsYOLIotc4bhDQIeLhukjwSCneV5Ss/I7Tk+3
         CYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LhkN3iZ8M1OtywKaiY4DSFBrC/VxDrZxiRrnRPrISBA=;
        fh=EiJrv4ZdVAxqlfKGprEC0ElqWDnXpTkYxcnDI1gcv+c=;
        b=YUrf33fa51RSm6JZH9pZZUeaTA3iMkLEl6sNnQNrGVQN/D1750YEpC9qO4PYacFm8f
         XOuJq3qwXrbf/6P3XTDQgkvWNVjpSNT5knHVupceG0OA3BhlREIt60NuaRjOawCFDCnK
         4YGNioAOWb38qy72lZq8N+wJxiS0CJDuYDCcxfRE3rT0SrWWWSQa7aaLOkxrwvdQzBxC
         cXJizqmZZgKoAAWa7TkBtcE6FaTDOmMQYX9GH9wvqe90xLWDmyXlqxpkFhrfL4RpXnYS
         MfbFwGloUtWCPIkrAbzfsvlk8Onn6yPns0KwcjnS435I918iooNTIZk37rLktSDpz2WG
         6zng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783502295; x=1784107095; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LhkN3iZ8M1OtywKaiY4DSFBrC/VxDrZxiRrnRPrISBA=;
        b=YU2JH3dgJfP291w0KATYzVcTkSQVl9Gs6C6uNaHq986Iki2uViNTnApBUQwRBa9eiS
         2Ksw3lomA91LFrvbZQBxj8vKR/KeHk0uJXA79y1Y41fkgTuAI/7c/DD3jbSb7fTj/PyO
         ddFF3bTSRuEuLeN5SVZh1mj23kbqidlMuJEMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502295; x=1784107095;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LhkN3iZ8M1OtywKaiY4DSFBrC/VxDrZxiRrnRPrISBA=;
        b=XZITodtR8Y+M/dgWJtjB5Fya3ol/Gz9pk/O6O4Jymnp1YT+hKXONZTQjzv8ykYQIJV
         9gpr5ymU7Hf8Lun3erry531XpuTvI+3iCOc88umOGg063fEYjjVdQBN8csKE8i7ivexr
         BjNdvVdaxcPuZci5JR7B/ht68AH/78iTHH2578omGUvU0ONBDD05A5NkLjUlkO8qzEBx
         kyjzuHzokxnz5xvjFHYJHM/+UvJSNfYG4cGHqqKw0A8A6vgG+mwio2gD7+brjY994rKD
         XkT1ixQf1Dt9oRqR71DqAoVpCHFp6TuUx2mWMRCXut6MBMVHvkb4uWw9tGrOkwXqJh3f
         Gt1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrWB/yfvgBauo1TGob1ckEJaXD4bCXbbAmyyNXqAaq+GmxIiSZVlOf7RANQkjDlYrRPsVYcIoO4fPGoLcDZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/kOoSl0f5gPpAhhThQXOEXkgXBti6JNX4Y8Az5jzl0Hyqc9u
	1jPwBZY2I3q6pMgluZz6UQ2RzKmtC0pT9RYKb0Aula9A6b2E+GcC75Qot0FHhLfwpD/XJhO82JX
	oFIKOVK5SNjEAxaNunygbs7RuC9UPZsmltZBk/mH7WA==
X-Gm-Gg: AfdE7cnqCBCW6HTq7mrDOu+KGD0ivpfRX1sd6V0cVp5eQlcarYugS6vpgh+tJvm8mtq
	NYme4DVU3UyN4KM9XJYpvOGXArKZKxIJx5aTlPco1INpqtjhS/GgyB+r0dJuhmV9K/TzjaySO4Z
	YqTqIQid8s9WtdQNvdCkiPfh6bt0OStmWMqlWubReLt/se9lxDVnn3yjXw67mz39P/fjtQHxsl7
	pecrDO/dkquTP6s9kWe4fNv8iugMN+u/OiMntZEd3UXJfQHZfbFMC32dcvhaOjB7wpBUtHzkKmF
	u55Mrpvtd56aPPQXMa0vMsAWOho=
X-Received: by 2002:a05:622a:1b24:b0:51c:811:b36e with SMTP id
 d75a77b69052e-51c8b420cd6mr15996231cf.72.1783502294657; Wed, 08 Jul 2026
 02:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707220450.1200943-1-joannelkoong@gmail.com> <20260707220450.1200943-4-joannelkoong@gmail.com>
In-Reply-To: <20260707220450.1200943-4-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 11:18:03 +0200
X-Gm-Features: AVVi8CfqJrO4vJXlyAjyK8zVSXlpZpYiFP-m-ylheDpu9UwDsy69JM8rigq8gg8
Message-ID: <CAJfpegvk16zMX3sYgNK4Um18dhd=W7TLoCOnCsEePe2pD06pqw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fuse: use iomap helper to mark folio uptodate
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 00:05, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When fuse enables large folios, a large folio will be backed by
> iomap_folio_state that keeps track of uptodate and dirty state in an
> internal bitmap.
>
> Fuse writethrough and notify store paths currently set folio uptodate
> state with folio_mark_uptodate(), which touches only the folio-level
> flag, but on an iomap-backed folio, that leaves the uptodate bitmap out
> of sync.
>
> Use the iomap_folio_mark_uptodate() helper to update both the folio
> uptodate state and the iomap uptodate bitmap.
>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
