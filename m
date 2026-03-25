Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926A23BCFD
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471764; cv=none; b=RPh9Aan6fEd7MrrrtoK1pbNJn5n5HzDwTiplGNL2Nz/jA6qmfd+r8UjBDUxAcK7IjvAgE4TKAKHUwMN8iSFwzdP8bUyV4IIyd6artWPqFU7IUYm3YlUHahSSv1qiPNMWYarvdn4AlAjm5yFKv0sM08xincy8TurWp/6p678ORPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471764; c=relaxed/simple;
	bh=5WnoGtPSMWV4Viq5c2WoNMPTP3OlXM7DpmHbQUZE8uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9flsJrVqKavHiRQEu5Y+h4QL7Y60cUBZJ/Tnul1Jkgd3TAsS5XTzZFQqK6cK25SYNQ3F+ApV86ndNgo116cWwPIS6sSf0kRA4bHNvtE79bxUslaYavZJ4OtAeWgwjgfW/zhkHKRQWE0wICoBAA6nc7U2rcxvnEXsTJGlS3+s80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nO7MpbZX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nO7MpbZX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fb439299so2865705e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774471762; x=1775076562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WnoGtPSMWV4Viq5c2WoNMPTP3OlXM7DpmHbQUZE8uY=;
        b=nO7MpbZX51yiiboCReTmsuDhzYcZZ+yAaM1N0+X1GkDOPmOqXw3cC++GZjC/COJlSK
         G2y6HhZhBixfYz0bPK/e2+x/S6v9SaQnWFlWqNOUIYjZcqCKtMeI1sDGudW5bFFJu5HN
         5tfJPlZNsH2Sx+5Kz6fFxVJV5Ciz2+jLMtVEb0+9sHm4GaQqvI+ymhVlwppoNgldl4Oj
         6bl8wJaPnFS5TqbexD4wBEnPUGeHrVB7J99TfAFbrm04mVMc4V2xPKnR29JwoESMtq4x
         NxuLRqhuNWY+FBuo9UJQXACawtOMhNvDNuNUOCzWH3zhxig8P1A+5sFZ1w7/vFkwwqF9
         i6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774471762; x=1775076562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5WnoGtPSMWV4Viq5c2WoNMPTP3OlXM7DpmHbQUZE8uY=;
        b=I+JNIe8TdxSRAGh9VDKx/I3vFabP+3f5Ps5Oq9jQaMrEyGsMAPm4KRPfXvAkkDst3t
         6uKPHgTG7f1HDih1E/TNnckJd73RsFOB6cahqHjnVACBs/rrwoRWGU/M19ugang4IiTP
         TuO4G1G/eF4tiTagmZ7MfkOjufP9qH1XSkXHJs+eSQamEA7fHh48IQLUKyTOfisLjGD5
         8NExW66fyzWVvhYR/MK2tDscjn0WF0nodiC6KL9+raSsSfFObi6oxJ06n648jKKlJChS
         IX6z9JZoHnKs55Rd90TQVyM7s2aKsuMUdlGbqDe4H2qiXYJRUevUV+Ja3/LiyamZlQj4
         CMjw==
X-Forwarded-Encrypted: i=1; AJvYcCVxb7E2SVy0uTcCq8IMj+3H/+o4s4kHHZQzohqgjJKwoSFYOKHNB1rMd6rps2hA+1hA7R3WO0vQJh12FPEh@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhTPjZEhDrpgdvvHihJE9Dc4HjyThFfiVTkFH2ch6/EBLLrPh
	HpULKkvCaX+VS6gvA0FUrVxJX7t83QzG00WwX2uQkVSdGcYS5uODpayM6U8sSqm1
X-Gm-Gg: ATEYQzwmEIAVYgfAmtyW6Vwt82bWsb8z+lqdzeFmX/vqwkSDBkyhKtmPInkJ8pHO5Bi
	gW3KED+uj4WuWP4/8zcRU5mLJGuyFqY4/25/ylCzCWfAXlWvsRHXFHonKCqaNccN0ryP7yCQhr5
	/IsirwCMyahzD/vMoaNPqM7/ZoFqZ/ulkODbjwaNtjK6+LeBbT2dT4iTtT8MlLXCu4dOLJJJ183
	hy87MFl5/Iq9X34IGlAqvABG41ZAu0pgkzTQh90IXqmV8icjjx24SkkGvQqAzg7EcdVGUrsPI8d
	pHc1tlc1VZvzo4xpLTDnLV/GSOkeogMxv+MTqc76bG6KV5PxaePGGGOK/XZcRbcWsS/UQ0p+Ryk
	LUxy/gjU3QF0b/c2hYwRNOyHMM7jWWYwHa0sq2dVspIlPgzGA02rfMF0CzJ4t0m1hI35ePPEMeo
	U+9dcasjuzOZxrELpHmJk=
X-Received: by 2002:a05:600c:a15:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-487160672afmr82496525e9.25.1774471761669;
        Wed, 25 Mar 2026 13:49:21 -0700 (PDT)
Received: from DESKTOP-I0B9J3E ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbcedabsm1679005e9.26.2026.03.25.13.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:49:20 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
To: joel.granados@kernel.org
Cc: buermarc@googlemail.com,
	davem@davemloft.net,
	elias.rw2@gmail.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opurdila@ixiacom.com,
	ps.report@gmx.net
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in proc_do_large_bitmap
Date: Wed, 25 Mar 2026 21:48:47 +0100
Message-ID: <20260325204847.180125-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <kqjjzsarsqgwtzrrih5hvmbeyrhsbkobvcjaznnxh7oegyin7w@p3u3jenw4h2r>
References: <kqjjzsarsqgwtzrrih5hvmbeyrhsbkobvcjaznnxh7oegyin7w@p3u3jenw4h2r>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joel,

Thanks again for the review and question.

On Wed, 25 Mar 2026 11:07:23 +0100, Joel Joel Granados, wrote:

> I think the correct fix is your original version. Init 'c' to zero only.
> Please resend it without the '---' so I can pull your trailers properly.

Makes sense, will do.

Best Regards,
Marc
