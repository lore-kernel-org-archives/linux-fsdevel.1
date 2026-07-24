Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77541DF75A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896859; cv=none; b=dibnmXwoIqyp4SO7G1FZmvP4Tt5nFMK6M8KuOhye/woCXNQBiybsj4NZZ4u4kzFifElW7lE2YTK86DgHphm3SbhJQUWprHeRztykqtB0p0WpPhJLuyZp3P/Lcp1+zpqLOKSwFKAo4g6EW3n42u0tuJE3kgI0rXlblMqEoaR23fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896859; c=relaxed/simple;
	bh=6TlwezWM4AFq2yI2DeU12+GAlAO7JwgsJl+amDoGhe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXBP8WVgBmLqeXvUGbi2M0RHHDSCmENwJInVAumBJBs35lZEuvVgAuNF2ss0HhLAXVi5xO7H9uAFJc65yImrzYMjdqrwLnBYng5IcSyd5m+8vS9xxnYm++It/COBJEY89hZAWoA59STeMa+bCOuPgKZJBhmvPpKKjoguXmlrkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSQIOevP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSQIOevP"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e08baf860so335113a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784896857; x=1785501657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TlwezWM4AFq2yI2DeU12+GAlAO7JwgsJl+amDoGhe4=;
        b=mSQIOevPe8jcGJ2UwollWz61dTfScnfH8tvAhJAfLfgHIPCFouvKU7Rxs2pb77cA3y
         R+awTI1aUQFVYB0gPqb081P0B7P/oqthzISyZYOwzlSOXc21ees3UCs+KCNlzaowS/Uv
         k2VQn6/V9JA7JRUXsVlt+xasIYLOQU86UWvpwPNy1x/HJKH2MRQ1IyyOT0dhghZV9AY1
         CdY6TCpjZBKsP0zYeqsmxAGNYShUMebW3ZoknzOEF+s6lJOPCMZHyDhjmubGYp1v7kAv
         GPn3zTluRdvG+qWXj/yrq7+/lK1V7RhIQZSNy6txQr21LluGjH/mWHAQs8ynYgDUyKhN
         4PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896857; x=1785501657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6TlwezWM4AFq2yI2DeU12+GAlAO7JwgsJl+amDoGhe4=;
        b=PMq5pbrFPLIbirh1y22Wlm5UmBIWXOp528kwzK714cN/3jKdi3ugdNX0zOZr6dZVSV
         JdggSsaLM/09W4dIH46xvenQNcQ4apsJ2kUg+PEuI/XFlIWwlfIucxyaYyFJFhKV1gMB
         pazi0FWWIvCl6ios6ZtRewBMZI30d05NincRCNIQe5T3QAKYLV37nH69obx6tTn6/8rt
         SUVe7qcHuOGFDwL4tvC5LqoRBN+PHOruWxlCgrvGXnY9Mt9ud+bAxLNl2GUb+OWbFmAu
         IRgryR9FTGV8Sx/Q2zU2nQn8qOC8r3p9XAneWaNv4qp9s9RtGQy6ClJG7RlOXyOMRH/q
         ejXQ==
X-Gm-Message-State: AOJu0YycDzE7jCReDvzwapGQh+V0o5Dg31oJZ1vN0THpdlt/pm/4WMvs
	N7T4Lw4hXLpk4L4GSL+JQsyotoBqaH2olzz3/3oo3Dk+2mwFyKDIn63P
X-Gm-Gg: AR+sD10yDd7tYxSJRQccEGhIbzCw5Q7jeU79TLXyQFvd36hYeaVw8xoI/Ylq0ljjcCl
	aNIAMi6j40sTd0vhPUmuwwOLEjfEdyxbD32i5ekhTzgU68EIXJo5ei1bEbTxInZDE2Zshjzyai/
	G/W+M4+5kwF1klawpvOqVKnKC1VzuNfYftlYgQl7ZI5rYYT/7MJ8SbjaaCq7yE5HZAU1celPNmE
	kZkRp7ecCj+NNcb3eMjksATmgB9DLZ5QJn53bqF6dofnSzTuUXe3VZWM6EdbTib/QmO6uEypxHD
	gGkcTES1YS5F1+/awQj6zzAxodKXTXqiM/GYb07x2/Zdl2ffd0SE7RZNkEG4NNy/gAaCogWcBA+
	YDj7GU3lAWE4gmklDgIzhwHl7XddKtgkWxAuiwp4v+/8wxszVHGcAmX8hV04K9TK6cs0WqMUPXS
	g0QKgwxNDfDC4=
X-Received: by 2002:a17:90a:d647:b0:384:d509:7274 with SMTP id 98e67ed59e1d1-38ec650160cmr6840896a91.15.1784896857167;
        Fri, 24 Jul 2026 05:40:57 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:9261:769c:50a5:6d0e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03c20c06sm1431025a91.12.2026.07.24.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:40:56 -0700 (PDT)
From: mdshahid03@gmail.com
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: hfsplus: remove redundant NULL check before kfree()
Date: Fri, 24 Jul 2026 18:10:32 +0530
Message-ID: <20260724124032.123471-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703102256.58959-1-mdshahid03@gmail.com>
References: <20260703102256.58959-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping on this patch.

Could you please take a look when time permits?

Thanks!

Mohammad Shahid

