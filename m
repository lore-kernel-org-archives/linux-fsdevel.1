Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE745A2A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752981; cv=none; b=Qz88inBmVfYbloNjdi1ywhT8MbIKKmpCkLzkMkx5auPMLa+BMzXaZLcS4d0Qs4KBKAWWsVEWnEkwEWYUNyyaCQGHeBb15JWAb5SJTUa4ZQzu9mfj1GbMQFbwqYL4TCSegMXMDNonJIaHJ7KcACvtSpnGvqnpn/qBYZgtxNcCWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752981; c=relaxed/simple;
	bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4KEfmGamCMPeYTUq56snQb0w4SrghcRaDly7N41+EwGuPA38liRhZffvjewi7Y9p5Fzc2cMINsKqmyrbJexpI80Epz3k1HkN7Ren+e35Vz+GmGRhciOkpUbS9ZkGCrKcBDdAMOkdHEIJz6hGHiPbFNPdhzvUnT7f3kXJMDBzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKgN/k7g; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKgN/k7g"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88582e2153eso1169204b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752979; x=1791357779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=AKgN/k7gRZJu7WmE05CAR7sMFeRUJdwYpV4zoLO1dk2nQhHYD/vwcBkScvpLjH/bTQ
         un0kujJq09kyFVxD9h9GY6YKyr4g7s7uqmPXuaxnj15u4H7poY5XsTcto0VdEHEpE7n4
         jnM4H0D4s7lWLr0759bTfNZ0Q+JcRM4k5baYCacVRhX62jOroIfKbJhYGTOywnX6oLmo
         toq4S/+6KbNcTQac646pt0kWhfWoi7t2W+qAcxMgVLeiSb8eFiXmK71Foj9JSosXmpoS
         0wokDnavkPeuP8cPZ88Ck8WW/HCaW+2lmU9/oZC5JKTKZ0KrBKM/GUfpdFmss45kU+bL
         jS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752979; x=1791357779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=B5DD18PJ53wxoeN9wn3Cl5eiyAQXhmvu1pUHq/Fls3283yMPSGLtHNcqntSrIu/CSC
         xwUX1/jBfBHL4BHUiwXvN3YMakYOG8fx61WvUoyVV49P7PEdtkPwlSe/iYj7QkS6l1NH
         3TpvLK1frzKFNZP4X2urueomucO68HcwXzznQsk1C/P9Xo26prJ3UDhZLXHmZ6tmCZVG
         xherYFU6QUfZ2JCB+uLrXFfxsvuTszX+lmEVPxpebJFIcbvqoqhV/qJECGIhwbaeC5k7
         sBbbt9IlJbTN2vmePR/086AXsvW0pSn9RbTlLeRz8Wwf0kE190+jGiz1egKBaAnMdLtY
         RaUA==
X-Forwarded-Encrypted: i=1; AKwUvBxMhQhR8Tj+BAbRPgxYCwq5BzeIGErQ4ehJm1FcjnZQmXf0ENebnreiPF8wH+dT60Jb5gk3Roye3NSTTfl0@vger.kernel.org
X-Gm-Message-State: AFuF++kLm73CfjiyBGFRuUOk7KtzJ7Yfprn1l+rcceOMgahZY2LRcnJy
	vDHF8lktZVMNyceee/ogwKtpyejJYheVhRNK2u/B78fK1x1yO1vJaJjp
X-Gm-Gg: AYBFou14xRDqVLAQpEjlBiSdatyCabr+ZMwvOEhHJ+EQB98yisv0Jeu5PEx6dQ7MUHt
	sdyroRZAenErLsfJh/91Wqkcy7V4fI9t3DTGUhUeiGymfXp4wmnpre9mFMLsMmOAEhzuXYnz7W9
	iwSW5XTDNsNUdjuk961cQY9VZ3Hfw2rwLUsGISBEqU1U+B6i9aVs9I3cABOsXQ9jm7l5DcDWRdJ
	+EXLQXC+y02KTVrmQNc2vgSy7/aRaD+pgcU/FCvBd8T5nD0EvpNqUFNtcyOFvrwDFxH4BScz1Lz
	cciZMkY3pnwt1wc08ewDL+pOQLmUqEQcDfUYDWwEuehHU9UNy4W3L7kX3JOmLZMeWyEG57QnPqk
	Xyq35aYwkAh1i8/HEtCfI/jQG5fmr6biyyKVOHPELqJQOBFzVhmkBuc0aegLQmaCqzFavj8SVBF
	hcjkqYpq0LQVH75sZEcj1SGCEx6l3EJlXTZo7q3CypJWCsvMN6xMU2lCL5VghyEU7kAZCb34yVC
	UT/VrOh+B/LJ5xm98hXoZ+HtyeA1lZHNOZNqzak9rXJfEernSDjkrUaJEyZFperIk3qEznbnatt
	uMcpzcYbU8fwVSCKLHVM+yzrdw7D9bdO2p1zUK9B7t7xb6x/fXbpNUXJkVo=
X-Received: by 2002:a05:6a00:a253:b0:881:fa65:d507 with SMTP id d2e1a72fcca58-8874ab8ca2amr312784b3a.22.1790752979389;
        Wed, 30 Sep 2026 00:22:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8872643903csm339794b3a.44.2026.09.30.00.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:22:59 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 5/6] qnx6: abort mount on superblock magic mismatch when silent is set in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 15:22:55 +0800
Message-ID: <20260930072255.1167805-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-6-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-6-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to the cover letter.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
