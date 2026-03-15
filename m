Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA022A7F0
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547839; cv=none; b=AoNEsRlixcyIUBXcDY37XU0v0y7SpcaFVPoRMWD66J1BX6FFxCYQxyeXfvhz3LkWQGE+DkMXM7n4YiUUIKym/4TcW7UOdNllCZhx03hcfD+aK0e0CS1mV4HqvWK0JWUtCgBhFfK00JW/9OFD69GNLUvfAy1EVY8pqxmrBpYzKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547839; c=relaxed/simple;
	bh=eKI+YqwJwuQjw262CBFVWp4TrJeGSGv4OI3cEOIx48M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF13qmZJqWm94Jyc4YDoMiunC7qWZJy8mMh+cTMIm1oDmUtSqEPwSp+dg604VBB8yf8qC5mb9+/D3LfF7DRO4LObDuXEIa9Q9LOlEeRql/nFe7GM89HbAWWKQnhanGEVIKYWVKDIYJfDMtQ9gdBVuSyR5KBhTgnw0D1Op9kP4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=u3sa5uap; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="u3sa5uap"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-827270d50d4so3312212b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 21:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773547838; x=1774152638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKI+YqwJwuQjw262CBFVWp4TrJeGSGv4OI3cEOIx48M=;
        b=u3sa5uaplUcxgeUs4+VhKFaHrjgy7kHniJpxfLyeTz3UdtnD7j6gvNhQ53+ol5vKaO
         uJ3eVQlAeF3N05xVB9L0LfrtzdXlE57HyU4P9z4WbpvQHkF0CkpaSOPhuGJ+NyU1sjCv
         HVWPC4t/kEn6EirKgCWgUUyWUXtLR/yANm1aFpXpYK6L/5oGGjgTEc3FPbj3FBIAqZWu
         CnIN548OUA4m/dIMLuku5fUidyDSaMVBbA8NG7WYaEP0nhXIPfmSwIx/196maXgRwuaT
         qjjJXvSNam5/VHnnFmoqmqqW2JeGUyzGtQRbwZ9KQMJNaLB+Uorc7+i34fS46tJXOFGU
         zEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773547838; x=1774152638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKI+YqwJwuQjw262CBFVWp4TrJeGSGv4OI3cEOIx48M=;
        b=NCWy6D9P9tuzCeyKgOO5x8WbGPLXwc1oGxapOClRsRfHud9WLX/b0DMAFCAZlHYXS5
         tjVmxNfstFt7AX6jLbPbwsH1wzKktCzI5BHl1jr8nWNs+Lf7kTUvm0FVxHe0hf5z6eBi
         EJprscJLxY0p8D92ORnCltIgYtflp19UUnSNSh+yATwQMPJ9OIXQfRZjJuDD8cd7oshK
         8qVeCmcv9IwPtubXOphXOLskSEkt05DVFmsDHNec9O+RvBX7dv9911AoX314Ift419Xd
         MdTIeva9VAfMJlnL8ZDo/oj8OhvDvPkp7OkA3kOJc0zFgqwHlFrgQOjgl/7SC3hJji90
         tjNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaY4yQqqFqcWaVthiNALKgZuwZqoBLu3qBOAzSouRQg3MgeLQdkL3UaqEJHkbgkHP7veyX87JueXdBSfyP@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXixouaP/OJsc2S6RWdUyyMGWT6b+xhdQU9teCXFa6FgBhvil
	cad70JEGGk6fzKWVutQLnuhtsipRuXLZTkFmbTTgfWQS+aTfU5laCd3VNjbjTmAEtPI=
X-Gm-Gg: ATEYQzyR/wDmNhmrktQd/nmkKQ0Y6X+Yfxf+HMWq/EgaL1hcoRQ8QllbTslyeHD4JyE
	9NFnQqGcPuhYdKAGP5N62oNk+9BZmF3D+h2JkAtvduCy+WnVqYdjeUs8Boh6y6dqEUV/EQHkEo5
	53pJF6jSBlIBEsl5cyx5HM5duIcxK6AFfcHedMdKwwoG+Ye5n6JzE8qA9GaMS/+cbvAnaBwMjlq
	DZGbAVCYqR/zvSe58B0jCh8bdbieil0o0vWomb/Wmj7AyHixMr1qEytNCOxsyq7vXLRKnoig/oY
	c3XEmvgp8EanO3Vw2vIWzxQ05BMeS2PLYiRJ4h2sLV76vPtM2mrrINUxUnOM5WymO4dAGJQqtMG
	lpeGipYSDrBdSfA4N56Lg7wthtSYjEACs1QtBSyI3GJYLcWni0gRJ7jmqz+2TCuwfCHcz753SQg
	ny
X-Received: by 2002:a05:6a00:6c81:b0:827:2dbc:27d9 with SMTP id d2e1a72fcca58-82a19907f86mr7927525b3a.48.1773547824721;
        Sat, 14 Mar 2026 21:10:24 -0700 (PDT)
Received: from gpc ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727c1d2sm10079491b3a.25.2026.03.14.21.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 21:10:24 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: lance.yang@linux.dev
Cc: baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	david@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	r@hev.cc,
	usama.arif@linux.dev,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH v5] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Sun, 15 Mar 2026 12:10:05 +0800
Message-ID: <20260315041005.11682-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315034647.8462-1-lance.yang@linux.dev>
References: <20260315034647.8462-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lance,

> It would be better to keep earlier CC list across revisions, especially
> for people who have already reviewed or were explicitly include before.
> Otherwise, they may simply never see subsequent revisions, and from
> their side the discussion just stops there ...

Thanks for pointing this out.

After addressing David's feedback on v4 [1], v5 no longer looked
mm-related to me, so I only sent it to linux-fsdevel.

But you're right, I should have kept the earlier CC list, especially
for people who had already reviewed it or were CC'ed explicitly in the
previous rounds.

[1] https://lore.kernel.org/linux-fsdevel/60ba4311-01f8-4ff3-a2df-e1b3fb6db699@kernel.org

Thanks,
Rui
