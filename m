Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1B389116
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018016; cv=pass; b=T8u1YQRXYTjl1/xlGQGN8adm50dQO5doTkLenjPUvvx+rtgAxmBRbJF9bEitDx8euqvVCEK4Jol4ija6Eacpsvg4qfdgK3k0bUOE/EqOQArZv2dAMNaQFKsQakUVEi+cDqz5YAKWQrS6JdmTf4JiO5PawwImyf15xgURFh+PQZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018016; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n04lUrHeLyWQxi3CnlB7fx8ym9rADWgaMtCvtBG1nWP+121IsOk0ztAHQe5QLy6PZePqkSIv3k/2Sux8D9WwR3N1Owt5SmHUwaPZ3IYhSqoTtH1tA1B/Y56kS090RBo7ZoBKsHdGaQJmw9uDCxKDCY8yvcVbXhXqMJ5FBmxRVPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb9OcfD2; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb9OcfD2"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3114650a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 05:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786018013; cv=none;
        d=google.com; s=arc-20260327;
        b=Z6d93cKuUOQxjdstNVvOyEQAXreS80mgZ+6gqTsAQahzVOhcNfarA109m/YBw02mJ3
         42pUo++ERRIUu46Bfufb4v4uqep56uBpNxogfvKz+EWwl8Ys50PU+5mIBZY0VBQ/6Dqa
         GdbwOU8hxn6I/Gi3IN/De8JLpbLfidSU5VlbQJ5BCif+60raOGjno08SiNXnuc3dICMm
         8+IuvqWBnGYZ3QdDex96g/8QAPzVZPlmFYL7Kf6Ru6Ot/TZLhUcLfRfm7TZSpbiXF22+
         DxuLim1AFkhmIGAKAKxd1UHH8WI2ONtI8esf91zNsfc4yzXcWrox7M33jc9mgdor66mQ
         Z8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=5mZcV2o1PCuUZLCR953OjXkcY5HtmBEbvk8FahsfMsk=;
        b=qyVfymMJ1wp3Ea8RTg898fSa+RXS9RvDakZ1PFmwx3ZqFG33C3U+NQK3itlWQslBK3
         HUAbkV4rZLBxsiDYXxpIz0IoyQjwj9pvLT+mtYvrtchYpcAl8ZjRLhQgLlSBh7Usaxpb
         R56Hb9Bsu9619IoWj5va5GGCHNhIIHDCHdL96Dzsrn3p9myw/J5s9MCzh2J0cmZifiKA
         BqPj0xPq91eZ7AZGK6CuhozwQ8jDU/rppYgPunWuh7nKSL3ZJ0IieJtrVM5ujxvfZyP1
         leRUg8izRvkAenVcY9EOQrmjfBWRuLaAOJqWaNBH2ofTqY/RtronOPaiDY9wjANrC4ky
         GRHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786018013; x=1786622813; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Vb9OcfD2g8B7FhOXE/AxFlnYBkhDF183dFcMzXv2kuf1SS8I37i+IFfOe6S77yUMmG
         Emb8Z55urXxFw6EGHGXqyCyuNbDatEtz0PzWVtbfWAVSiTE8Drm+dkL5MMzUvPqWoBrg
         WJ4mWq46MmIk2PRXcAo2wJy+mIBEB3LW1jQI1mjEnZ4sD3ZCFpgLZhBWFKpokwslMwzN
         cR2dS7YkiNUoyCkJ9mMhbC+D+04BiyzgG5RE9sGtMJhSfKbwXgHCgpCu71ishch9hCYv
         ReORnkzajc9hfut/s2k+uFlFL9aThR4q36GlVmapzaALmIxbhlTRQdN5hJjhUYYP/Yva
         rF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018013; x=1786622813;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=plYW+wLAknQQexe2zm3qYJmsehb335xGzawngQeb3lgX+hwwxLUOsVncJuQvs3dYTz
         O5zcf7XbWRwt/ZjfhoRvMvltLlJ4otJ5kXji888V0+r/mz2Ox5P6ApW3ib4VZyYgDsDy
         hfX0GTpCMAbYhnrH/tLw/BvYo57XkjlCl5/XtTB5Pd5ocXg9W480WoIOY/FnDmsvIozO
         RVJZ7b0zeVslWVNdQrMUmqro3D/g0DZS+EdMg+JtUwn2REKMBINIqbg13L4WHF/6qN0t
         JGGBXTa0odFl81SduFpHvPhUFA974Snzfv+8F9ekpSNprf0hy1wFmGZhQouRgJq1IOtn
         w7tg==
X-Forwarded-Encrypted: i=1; AHgh+RrUeT3Hkj4pR5qPnwLj204LibztBDCOZKrU286I1I1rxWmsAamMPrvzaOtMHp6Kgx1xZtHHE9eZlQEjZufF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gG0uP2gVhMe5WTNqrCN+rUyj3xZ7E9L6tCzYocxdZKKv8J6k
	y2gDWEW1wcUsXEb24zsO86nLdf6KG8xhtqvNc7rotq69xfD3V4gp1B7U/evMRNyOGqr9FYd8eKi
	ITmfLv8OylmDmOcY5OGXPM3Kv7qnTpw==
X-Gm-Gg: AR+sD12WiHGFLnurxy0BeXlRjNwJiaMH/Eac101Q0jBkTDzOlG+GMMxdBzO8IadSsgM
	DpNxD4YNRkevUpYefNplvMS9hg+svh0pQ0x4/JsHjl3EzCM/BLZCp0Wr6LfhNJEhz08+FZrNfNC
	lSRYImmwEvmHw0QgiVmKXokQiQDXSBFvDtYYjA2pHnz58b6tGZ/1SaIXIf07VwC/fK0KSweNg0x
	efR+XLVx+GMExKbRb8Ck91KlLyIJuoixpVGEwzqUPFRiRc7K3plGdiqqQZaSPAbK/cVC9oz/nz+
	a+rWGomErmgBGKjvPLhU+Jq8/AxtE0uQUSl6kG0VWyy4n1+tQAUqCU2i+T9E4oC2HfLxl1J2a+u
	1XM5g8Ln+aamN55BI6A==
X-Received: by 2002:a05:6402:42c3:b0:696:8f45:4ae7 with SMTP id
 4fb4d7f45d1cf-6a14f138aa8mr7034271a12.13.1786018012568; Thu, 06 Aug 2026
 05:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804124404.737145-1-hch@lst.de> <20260804124404.737145-3-hch@lst.de>
In-Reply-To: <20260804124404.737145-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 6 Aug 2026 17:36:14 +0530
X-Gm-Features: AUfX_mwpy12o3SwOUSv8lriL-YCkBG9LDIBCAyExEhQS8ZsJ_vNr_t-bxK4FRbA
Message-ID: <CACzX3AvRWQ1qGwmQxvH8xeZB7cyky9k716PO8MgSM9tvOo=KYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: iomap_bio_read_folio_range_sync is missing a
 call to bio_uninit
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
