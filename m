Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8E3B83F9
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536821; cv=none; b=X98+xQBc72MZ/vPMQ8GPyQveLHsURx2qqLi0pHcDn+71z60Z/uLdmO1+RBDQmmuJszVIZsUOYAIa2g8ljQXEjkuWh1LH/OVgFtYSd5UAg+rH4Pm5Bk/Pht6i9SsF+i77bZVoev9ZiuYo9BBtqfXMGh9FUI9yoAZxH0uW5vh/K+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536821; c=relaxed/simple;
	bh=Dsi+PgjO41x2VtjYExfHIy0tp/9a5bzvYlJ6M6e6TFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU0Bgm4HcxE1jQvCozbVtEp89UyLqBfZzMc6vmmxg/HxaC2Dvr7JM1MMvEeX7sP56OTTYJRi3CitVWfUzEIp+0ZIoE09C7mXgPiQi1EX1tBBbW1Rmh1YXpb8I6KPQZ+3jrsrCjbm4HQNwjmZWbYwcPFqQTsgAlkxAlcrq4L5sec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwONTkPh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwONTkPh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso4335855e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790536818; x=1791141618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCahJ3O+tXX0CfGzclDhULcHGoByJJvACQgWnDRt+Os=;
        b=MwONTkPhRbVr2zKDbdRn8p0CqyWMV4+R2B737dgSDbjBs8C16mXw4RZE39jHm57gSI
         4LPCUebCeTI4ngHVuF/QGCfBM/CwE79njXVVMyMrTIneBB5dLeZGxChiNHElvYdJKdgb
         iHgjSpCZyWFJYCIZGEJcRV4esW5SbnRH5a50EzK946sOvoXND+ge8wwqIF+1AHOaNxrB
         jGqrniW2Dv8n/oDHYvJHwwafHVZoU1ZRTS3Dr2ehhjcYXmrPo/ObWaL0G2U4qLo9W+0h
         QNHFgEM+LpOVzIS2JWdaDh3lxD9otZnOZJ6nMtiwHfa+vlnHjIm58a/VmgsMEz3VY4sX
         4QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790536818; x=1791141618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MCahJ3O+tXX0CfGzclDhULcHGoByJJvACQgWnDRt+Os=;
        b=MwctEnt+YfSa5DkytkTrp838w2GYdGCPHJD0Hg2YCrqEdG+yXcrMFUalXNMl+2CuI2
         UxzkioBVe4BOYpGJ8qG4x5Ncp2cVWDba3VoA8BQRU0z+ot4X2RaRUmsPOOb+4E5cJ5RQ
         f90ZGGHXuFeNwiHH7MgGm5xwcedO8/v9afIfMI/qyPuQm0h5zyKVJLxGQNNNYWZjme9p
         MRRB1C8NA2DDNlcndk5h6ldbivB6tSaSBY/rmyeWDSUqjhnUE2SG+w9f7uIC6zBpYVCS
         JA0oMjQO/vg6rVlmN7Uae61Ghz0gHN7HceMP7OS9MNL+oljpvrM0mala35eKGKsA2B+K
         BG7g==
X-Forwarded-Encrypted: i=1; AKwUvByP2oQn1sz6fQlX2gA8m0nliEEbyB0uBEm3sziPuMmXw7yYWb5hY2XiLZcCz6F96BDHHCUSda0QDnSyovCQ@vger.kernel.org
X-Gm-Message-State: AFuF++nY32iZgbduuuSCX4zNTvqIoxZKXAUDL998mLmLKZ0rd0YIpS/U
	UHy9l1wOwzjw62/WD498jzSWDiSTo99Svi1hHgR58zrPyayfwqTxhQOD
X-Gm-Gg: AYBFou1FBvXd6E7pepCqUEYkh2v2eg+q/CEsHP3kjboCIyosdnidmQfDwRMm9t78v8h
	iOE1Ab1c4cSZTNV1lUHtvaMHwvlk5HFbEAyRmYjCOB8dnPpzQ4stixrSqX7qjGsob0GPC2wAVnv
	IHbCdW28pk67u6ccCAXJOubGGIh/VUVc3v04YtLpoJKRCl+11zUAkc7buVwyA5SMsAeaGNBlUu+
	Xjs7VuvaFSf/X1p/W1XGRXdWJU9llI1WRRonEa+KpVgrhWajT0T2KiBdb68cc2UZdZ0tw4pjrqx
	qJf+SMv7xnhq17ikqKF56MClM9gMnRAWbJE6GcijtUFDXR1SNrk55MgA/6pHfTa9N4a5wEcpeXI
	BeTT42wnlkt5V8NZxjSdydlsMIkBN7CHDs4BFrxRL1NiOnr5sk0zG2mRmAa/qBng1JKglbo7yqU
	wJhk8PXvNNXgJEGMjrz21OjIluUNHYgVrsAy3x5MH+ZMdNMuvVcftjTgZfj8J3b84VxKs/tq2nV
	tkUdu/linCF065YXKFjlPBZVUYHmE2Shrbw37uB7FikP0gGsTXq7NpnzgI=
X-Received: by 2002:a05:600c:4f89:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fe66c80c8mr198488725e9.2.1790536818014;
        Sun, 27 Sep 2026 12:20:18 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017998dbsm117774805e9.14.2026.09.27.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 12:20:17 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	brendan.jackman@linux.dev,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	hannes@cmpxchg.org,
	jan.kiszka@siemens.com,
	kasong@tencent.com,
	kbingham@kernel.org,
	liam@infradead.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	osalvador@suse.de,
	qi.zheng@linux.dev,
	rafael@kernel.org,
	rppt@kernel.org,
	shakeel.butt@linux.dev,
	surenb@google.com,
	vbabka@kernel.org,
	weixugc@google.com,
	yuanchu@google.com,
	ziy@nvidia.com,
	David Carlier <devnexen@gmail.com>,
	devel@lists.crash-utility.osci.io
Subject: Re: [PATCH v2 10/13] mm/sparse: remove SECTION_MARKED_PRESENT
Date: Sun, 27 Sep 2026 20:20:13 +0100
Message-ID: <20260927192013.144672-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-10-54d81d65e125@kernel.org>
References: <20260921-b4-sparsemem_cleanups-v2-10-54d81d65e125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 09:59:02PM +0200, David Hildenbrand (Arm) wrote:
>  enum {
> -	SECTION_MARKED_PRESENT_BIT,
>  	SECTION_HAS_MEM_MAP_BIT,
>  	SECTION_IS_ONLINE_BIT,
>  	SECTION_IS_EARLY_BIT,

Hi David,

It seems dropping SECTION_MARKED_PRESENT_BIT shifts the other section flags down
one bit. crash hardcodes SECTION_HAS_MEM_MAP as (1UL << 1) in
pfn_to_map(), so it now tests SECTION_IS_ONLINE: offline and
ZONE_DEVICE sections no longer resolve to a struct page. makedumpfile
only checks bit 0 and is fine.

Keep bit 0 reserved, or export the bits via vmcoreinfo?

Cheers.
