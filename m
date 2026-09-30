Received: from mail-pz2-f17.google.com (mail-pz2-f17.google.com [74.125.228.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D207457E5A
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752977; cv=none; b=eZpOPOiExk2b/2bc+jLNTbTA2XB4hl04fR6SgW93NkldjXjIt/AH1aeSu1oShw9KnlJvK4AvytHYfMlUl8AKH/XhNKMx6bPu/PW+Iflt0I5yZMa2kn24Nosw5WS5zlU/GldMfMsmd/QJJTSC3I1h/2EBVa0YOumwU3o0Omhz39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752977; c=relaxed/simple;
	bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvjoo5q8DKwf821QcOxqZ0QUcUweE7K2+7bEikHMKJmrUXcfXm03hAHB/km/uKxnQbh+/8BizyTSp00d8IwpnBZBpHnfDmEL0JOU4wIQx71TqFHizdbcgzAMrPK4jNC5FYYPhnvxgy/zHVTeZG8doSifbWZfw6+TBPDqaEYVPmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKooYsxu; arc=none smtp.client-ip=74.125.228.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKooYsxu"
Received: by mail-pz2-f17.google.com with SMTP id 41be03b00d2f7-cc4c3304784so2155947a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752976; x=1791357776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=OKooYsxuxS7mVDS1ykhNyBazFIJl7y547ngTCQA2R52NjYlEFoQajPS6A1oM1C0u/C
         YK2WM+qjAZt75vUYmXc+g0TRpInUL3B8n4EQ/1DEMx0FHhVKSWn4LOviAounEE6g29Z3
         fV0/xAPpHQP6flJp6fCOcRGqfwZ3pjdu2z3Y0+oxFH8/m7lfxK20O15dHYzZRsqCkjdS
         mcInj2+aQTdcP2xRSr8H9frycNRepsDr258+juLkxJYODGnJ5DCJoQPCI+yEB1ojYU8f
         PK5i0KjdxGesex4fCdHxsgTFe2s8/wDYjkyTVQ7+xrfHcgpVdQVda35RKv0lV2GvyK2O
         i6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752976; x=1791357776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=GgPzh9Bzs+MKsauBSbcfWV5cjMqCGGcTjB7h1LHSWfMzDTx61lEvnoBTjEVYI8bOOH
         rWPCLw66nUMWhjzOFQ1m6zO3GUNSFfCnNseUOrPWMOCQAz5uOyp881NIN2BHBHaWnPCx
         PB9JDfyWgKuYeTImlLh04mlm7GAM5/9YZqij76Re2seDejJdQn2D0iEyMAqntLpSVnp4
         CMtra7MSnOrBaKX5NvJLAPBR6ZijAYb1xtUVXQeFENuyPtv6zooCXUEhixu/5I3iPjGM
         srSOj19lDciq65xTZsPPFGd0dcubJw7fv2kmRW75yNYFuXHzDkjdjYRca6qH3v/oZs+8
         DczA==
X-Forwarded-Encrypted: i=1; AKwUvBzmxjVGsm6jTsZQA2WMuD04KS2kA/FqCXZqa0CHPWrZDTObgsvE7iocSZ0X9temTyHa6k4f0ayoYmXyFC2u@vger.kernel.org
X-Gm-Message-State: AFuF++kwACEazkjgWwfBSDGCeTTDx7Nu61qPtp97dI+utzkGRIdtbffN
	u3zrZpbIF8O8m1P1lRAE0xLwty6drb6CPsps4nPfl4Dafp7kSHQRELkF
X-Gm-Gg: AYBFou3r2KRsC+owzpKZvCdgobCHdjJBp2uALLJ+s4TODzOySXEUSnt6iF6EDGuGW7B
	RiAlMVnoZ/4xaZ6YqikSbA2WnmTG9A9QM4PYlsbzCzLycTI5K+VDSiuNyigzG6+dWUMR4P/LspZ
	q5xUF/UAziBSBz63R8/J3jHgaD9wCdIN6O9ZSeO6EDMelb9nSgCRxXqq9hCtQ34CRotdltNKz9U
	C5pd9EWytoF65vD51ypKlLMimn4na3tWhvjW07sM2IPDivu5IswGre8IlN0x/f5IOsKwMKwxSU2
	Jisbt5mqlCpDWYvamJdw8DcROF26eSbpPg2vdm1UUutR7vPDyGVH36yPXs3uReNrvdkVeC/b/lC
	B5xCZ+JgQ1J4YSVH7nnDlqRmjbSBmYHX9IIPOcO6JkthwQZFHyN/U/CqBj80pTAYTJ4yXcMPWrj
	f+rLbe5hot+L4juUru3Sv5sJuTd1owXGNhiwd02mmlPrSxczQgKm74tuFNAV/Zo+ibt3kTfd6OX
	SpdQuqlbjl4qZKbEtH5q6R2WiDSRdLCabeu1SHGMzX7kABu0CvDibSoYWRmxAEtQaEPTxjY8OSD
	ohD8wviVlGN3dHcZAAjnyyrOS4l8J59WaC+9XpB76ufImykQTrxnQs5rJds=
X-Received: by 2002:a05:6a20:5681:b0:3de:79fe:142 with SMTP id adf61e73a8af0-3de9e6ef0f2mr581578637.49.1790752975531;
        Wed, 30 Sep 2026 00:22:55 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm342045b3a.27.2026.09.30.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:22:55 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/6] qnx6: release bh on error path in qnx6_block_map()
Date: Wed, 30 Sep 2026 15:22:52 +0800
Message-ID: <20260930072252.1167730-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-3-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-3-benquike@gmail.com>
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
