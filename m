Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4A448CE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752985; cv=none; b=G2iidGmDhLyA1g673FoD0lNEWiL/9inst5QkqvpNKcr1nW4B1hjGLrcSixVx3F+P3lSZS/NZ7X5rxyAYle5Nq/DbnKByrcF7tIOZFyvt2hODXMULEcJf+KyNxxT+z68ATQpmSvTNONHzy6dCw8pp4OLuJzuyVlfX550dSS0NgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752985; c=relaxed/simple;
	bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTGqHizW9jl5jG/+2Yw210HgAeCGIMH1S0rEAX4mK/N0qWfR+0bp74iJm8ihueXuRg+i44NsJKbe+7pFh1Zy7VK1zghDHJ7gr2IO7gCPiXN4RF4Y6Lq1FnZfVi3jggxWe3WJgbQ7P93kNit1DGe7hef30jD6NPaYakp13X9MLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVuIBfP1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVuIBfP1"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1229562a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752983; x=1791357783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=PVuIBfP1Hkj0GNMbPlHeYSE/ADA0psq9TJpm1sHfqZcx5fUaNTVNAtHLsq+vQxsxzo
         XGoLyAlYfJd7xxh9jBlLLPvhm0kgXhnBLSh8WBvve3l6BdOyRoz/B2qs8QYn0NUdIaIW
         210iHvRxDyLnl63CSfDNQG/jSEjhYq4TEWsL19jHTiQxOfu19rl72B74p53CIINHOk6G
         hHUSifOS3PLhqUTTJZ4mBM3AK7W0TwQL/pFdd5rA4Y9N8RD84zu05YmxfKWw1W9Azc7S
         QbcN9uRZxppsjU84AbY8B6QexNqoji4NU9zCz0itPKKIeXgI9jemKofJBTRTYbGNzIFM
         ufjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752983; x=1791357783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=nEZeMECSwODZUTDWfEkW4KA/6UCjFAOiCmzE61Cg4HNpt2NOx3YBw59If+Zm7gDPVh
         2DKTmoy1XjfHdOBwokfwN7SOOM+IVLNJ5SmaZTzqO8ssBeRiexQlRyGJQm3QbD3B/sdG
         FWvAsPIwrGv8HmPaJgc2Bw1rrSls0HW2QAg7/olTlAjEVgFXNyK8Tjj0BBV99yNE0ROC
         4P9Smo8IN5HQEirP/6lXvs8UxZO+EkPAkIMyFvv0ehZQFbmtRWIIdt4wL2JAj4zHXf2/
         zEDg25Q+yJdlBHRMYt7VvuYaELUuvURVX/AspFgiIsfuZdMRMvzu2J9kqFCqMfP/gL5j
         xvNg==
X-Forwarded-Encrypted: i=1; AKwUvBxoOf0J6/CU9RFvlshrGzL2HoCdTZQ/Ls42f17WQMPaR1MrcA6UpNFRUVAbtj6cpXO5O/nkg7jXl926wi7T@vger.kernel.org
X-Gm-Message-State: AFq9FYIlSLxzeFYLKZXR+6tCyyYO35iV54gWWW3hf3Ml5kJnxxqwBpCS
	mdFb/vGHtm7GkiPdH8RbtNG97Ta+vfJk5IK1naD3/lIRa3RJwhCaGER1
X-Gm-Gg: AYBFou0006shjoBhPKCYvkxSQ/cTpj4yxIc52RUx8zfI1UxEkWeZqjblYgzUVRggcLB
	sc5cm5tirIIbqzjwodFBk9C5GIrrsaMeI5wJQVdlFKJwB2p9ZaSeno6ijzI5p+rDzRcZ4YFP0rL
	+0vy8171Sn8rtzKuNBbmKVUuxfxlFRJ+0dzoPMNOPfbBMSAlESTUpKG+1uLlm19L28scblYh9DR
	DzjQWac85UbXzYVysZd9AJ5zFvtD15axIElRtsMsB9dkp7VTHAJwOAhW4eSo19wk0HJ5Iln7bx7
	3rh2nOpO/tgKfsnfbFPmn1zQnMtHhwNxgKMzSWQ63kXoR86pvYcODtB5NAvs31tcv29G32ZFP8o
	a3c8JTrfGg7vUfKtbwRO9Nz6IQy5pG4geQc+Ba+CUBtHxI2Ldmrerkugxth3QXF7KL/JVGqx34r
	CTpx3APvEHqjn4OW4uqOV/EoodkJk2nUr4/iv8ak6qCSYDE+TcL4LMVhxBjC/kzp7mKxRQvl2he
	n27LT6dfr++JRgchTGcFB6V7DrOhU6o8J5joYcHqBbtsFLoeqLOL2EfRDIzxJgWD7ExrzK97VEm
	zxPVQWMyGn290lZomddH/HlK/IGJQNLY+P4w10JhrJg0n3WaOHxX4VMQNGs=
X-Received: by 2002:a17:90a:fc45:b0:3a4:cbb2:f35c with SMTP id 98e67ed59e1d1-3a4d13a690bmr382719a91.22.1790752983099;
        Wed, 30 Sep 2026 00:23:03 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da14e8c5sm345460a12.12.2026.09.30.00.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:23:02 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 15:22:59 +0800
Message-ID: <20260930072259.1167895-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-7-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-7-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to the cover letter.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
