Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57013A48E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224305; cv=none; b=JCWNxj9IDj/0vz9OnOUPRYrzVx4KWl+KC43Q7d4GeqildmASsu4KX1crvZ2H6fE1H0zG3gB3TnPrQSsLxdTpHo5MeCLCm0vErHaCJFqrJhFNFw3q/4fAAjtG1Da1sNJzUN62FA6Q6Ofhm9abe8d0pao/RlRWOeFmqGKbGr5gbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224305; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig2DCuyGxoHntfSAM4dE8+Z8f9ZWapbtO8Ir+M93nb6zrO5dR+xIlbk+KQeB0QP14FLZbwUbDiGrpvWxcT1YCSicBKoBdevgoIwAAh0JaQXZ5cRvAhNxHXEyX7QLxjoY3WtZPHHvUJVfa65hgkywxTP9z0bMRSrDBgBMJWIZjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f07ABrTh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f07ABrTh"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso997740a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224304; x=1790829104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=f07ABrThenmPAoZggDsncPQzi45hJXPN6tRdYyKQJeFi6jByNb0GtfRwE5VAoTC8P1
         CdTaKCmJkRKcxSfhJwYhoK23GbIPRaliVa5xNnsXntG3qyToLJ+QuxxkEaQim5J1ApN0
         HBnfU8L2iWy/b0DcejsRCU8Jrt16bKKjLXY2ILC+OQhey7AFNVgMsfRtkXJ2mnFVfkLT
         Fvb+JSbEKoojAFm5e+zOOpLp8++QpfCdec5p9G2x9JoKqiD5Pfv1JcPiObhpJSluFFyp
         g+omvjrJANnZJV2ouvsq0N/xRKEunvKH60BCFDPbJr7XU06kZCRCiRxfTQPdHNbOVb48
         uU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224304; x=1790829104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=XbvYczI02fyk+rQVK1L52i0SNO99LFBe29vGbD5gQjyfws6/QI6OuKTO2sRJt/nHej
         Rv3gxC1m2xS76+vnQdbLM+Tnx/pNvSFRTVHfKdc37srseI6Ky8JVVb11IKaAAK2jalD0
         ih7sqbpIEBoWmWsjbenHKNjsYlWecd+J7RYL1nYpuFk5F4L/hjTN40OB9y6fnnrfbDWd
         2jGrWpjgAi224/xvY9RycyiJn/TLHNGkuQn/jLPGqrpwN+CbHZOLEu2/CmDlkwImoDKi
         4kFRMX9lFDr1ffRHsGLzdM1XQXrbBhosmO5ujqGd/w2+U8MbDZ0T8f/u3pisNL0JaAZi
         mMUQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/Psv2AkZ69uxTp9UvlR1LMR6e09HJYnEY+vojSFQhjUPR26i7zZBMwxO/3JKBpST00RoaAJsKVqcPrGU+@vger.kernel.org
X-Gm-Message-State: AFuF++nX7CNOAYqJ0b+9JAdW9gMm/HHi0E8vAkyKXw8aFoAT6pcbdJ6i
	8u52UnCqTvyjvILlpsweR+IWDyMXfWKTMD1le7cfzsrsyJpBulTBHK7t
X-Gm-Gg: AYBFou2ueDAdlPBeGsXY4TsGfW/7ge/MxfvgM9J8nrrqldC7dWzjGXFcjgW93QTS1T1
	jGpcLMbhtE35Y9++Fy/llrFJLhrll8xH7SNkHBdUy5m0H0vfkZYf3HDqcSnXNEB00cCjUtgTgVP
	pHFBFGweCeTc9i4HiCSZ6qrQA22QXfwmSwT1Bjbyr1/b7oANTSKfEbMHoLWRyWldzGRxr2bSzSl
	Mouc6CBVYkWnGhoM0tLLDLeyoR+OjKkCBqBfGW38g1fc1hbKFVXOxVx4EoXBviGWH3m704GHlVG
	qMvov+5RZVVh9n/OpG+YRpL/zAfqI14CQDkAOMYScf4hRD56IycGjFWpRPZiYE2SA/hhVB+KH/g
	4JDw9caOhly3wZbA4VmgkW6ktNHC+2CMZukinuzYJgQ8KXu+iyh2Qmgytq5mq4FB5UsXOVBRdu4
	ImPrG3e9N6gwgEnVuaFl0YqynkWmVXzLn0vrEYvLR17N4Hm7JmakjsUyNWJ+yw8PSLH1K8sWCSm
	iu6bjzqy/H53zh2+R9XhTVbIsm9pFuqXwYTgyJvxOhkPee0/1A1yZTTSLTdO5zPnI02XRpuwsMQ
	pmR8CTY7xvnbYC6Xh3dW2FJWZezcqs4DzS2CgrM1N+5t6nDYm2KG92aNhFY=
X-Received: by 2002:a17:90b:1652:b0:3a0:9640:8043 with SMTP id 98e67ed59e1d1-3a098ccdd41mr1110650a91.15.1790224303753;
        Wed, 23 Sep 2026 21:31:43 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773e7c3sm2181929a91.17.2026.09.23.21.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] qnx6: release buffer_head on error in qnx6_block_map()
Date: Thu, 24 Sep 2026 12:31:39 +0800
Message-ID: <20260924043139.3894954-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-2-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to 1/6.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
