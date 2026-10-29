Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256321;
	b=mVbEyzcc/ASKYJOnmifEyBn0PdSuTC1gRP24+cVoivu0syUOYrDuG23Kx6rs0Y8u0mO4
	 BOEeCRNg8hb/5TuKYkI9KyO8rUptWTS9N5LZu1mBLvO0vjAtnxQE7eQf/cYBju9RrcwGg
	 rZHhd2puZgvRCGct0R/ih+MjwzkW7WcnPfrUmD5N0CSbKenzowcSDlSpNwIx2i8TfnZYh
	 KlYKQIk/nIrHSWEYIiF0S6s6ScKZ2sFuVtGu6po72o5CKjwjpAlExChCB5YpGlCQAL7NK
	 BysVnJjDp521h5ZL5BTce9vFmCEapJDBnJRDHigCzJDWXdeTnpn59aXsAhxX4Ep0nvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=PpZwiOLy+qBSQ8PQ3tlsCfW6m/0pXMByVlZ/42AmEx0=;
	b=YoLpR3HqRxkM7EtZQiXIsoZOqCIJQGHbZG1JsK/7mLsbt38ABI4joJeDWl2XE/Bwn6wB
	 TiqZikHuHYbD2If1Wi26heaPfyMnK5IVtge+peRmgwsK7PU4dWCRzqlnxkLQz6gw2yprG
	 9dDMDMqc2H79MMO0OBeW8DAGDJBjugxvTEFTXXAqUpgibCKOe52owQMJ3GI7413sl3Bxz
	 sx4U+CN1aQ7XcNqi927vrpfBcOaRhpGNfu9y88WBWS4x3NzvnyHmLVdyYe4ZJkN02fAJC
	 8JsN/NKWOnBEyhuOsHzcVKJhACYo3dKIFQxEoQObPSkPHRB979m8cdKB6kUiUr8J/NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KCg5n/Q8";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E0606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 06:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 273E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KCg5n/Q8
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea94541adbso7909495ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793256320; x=1793861120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PpZwiOLy+qBSQ8PQ3tlsCfW6m/0pXMByVlZ/42AmEx0=;
        b=KCg5n/Q8XqL00OlgFFq3nv6XZvSJbvibwOIUf3l4ieuhRJh02MJd3TmHNL8ItAvBb6
         DQI7zORWyFVVog+kbdHN/hAjpeFznKr71mR13ljhlNkwi/XxIpA2gM2IQ7y8YAQ+0G3H
         ji7h8gpO2SHejHiHeGkBF7sakQPW7l1YdGaqRXkXMFRuxljqORyfWpIq0YHu7SCZ6iVS
         kye+V+d3VcqR+mnKfGJi3n6/Q4Yd+xqIXxBtOLaP8gROLPokcoy9TYDEdztFWQUwCpQ5
         bETn4zmz0nsCFsoruMBK6xUnzv+Hfawie6E/LuJYrcqEEaNK3MZ0HvwhMP7lgfZhK9T0
         kgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793256320; x=1793861120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PpZwiOLy+qBSQ8PQ3tlsCfW6m/0pXMByVlZ/42AmEx0=;
        b=2NLSroNDnCKAwxygWBxFPyR1hZoNcdRvZtst1+WbxGUFtIDDaCx6S/oTVZWPzZPb0Q
         hiQ7soE3ejjwaJ+DP44WtYejXibsezjXFGHbSolq3dlFXShtr15/ocmNYN8ugSCaGNqE
         daH7uR9/g4fL8oBYuN3MNVYpp1rNpumbqT56jrgp9l+sPQF67NMHK/n2PfdvSQv/UXOo
         vu03gcM7i3mMvGGiZberjERmY5D0PQCb+UteXx1OAe8zkG1vSwUE3QVO9ZgzURW7S3Cx
         LBrupboL4diPaDeOYKQzRJPcgGMLRPNbOUxhXb/hRZw5diKZo5tY3IarEh0jNTtNMxXM
         YeGA==
X-Forwarded-Encrypted: i=1; AKwUvBydiciqlTQzuH//zefcuLvAhvWFzYOLFcIamtqV6US1gIUUuqowT+heLUePWDwSwTbpsX5FiaiwT32/1uTA@vger.kernel.org
X-Gm-Message-State: AFq9FYKFH2tbTPvHsEXYOICSHW6y6l7nldYq5CNl9k1a0I2s3SC8Gqjp
	aIw+t46EZDsKnGfQkwSVq+a+cjY7dDWkkXadomtvI8Ku3Z81lxc0V2TW
X-Gm-Gg: AYBFou1GoLIWiLgxSg6KqcBPg/8EV3E8BYRv+wX17hrqf3/jNiXKJ6emNNf3f0HFY2N
	iR+CpTdVz5RfhjHSS6WaTsOLQcY+9LQnPivTqofB/JkU+rFY+sj2YRQ6VToHLNpyY4I7DbZrW5e
	CBrMSxw/Ui4OqmdbZpFmzZAd0UXZdaLM6VqWB8tlbQ0if85au3p55FUCt1Rwck7Cti4sKSie70F
	RHBl96UimneDMdkH18aDYWa9wxdhx5MGTdi/Jlm/87EyVjkTOoc/L2BT88reYBDQTBpXgRGuwsq
	3ws6q+hm9X7E45QE//JJLBsH3s1ImhW/1KnygAe+0uG/mNmXLWoSsg9wzhEroELsqe6cSL5XrEj
	eSVDZWavzuYS1C3lVsxtvOdO5KG5s4gwoPFgJItsFNmu3axcLOGZEulD/yQW2nhOJOfWJMgLmZW
	rmTVsQNt7rCpRmyqMPJ0qFeYCZA1bLjRpB/JXccJeKQlcjJ2xSAdecj6rm4yipdfL6iM+iiRZ5a
	4jyWOKSrL5BNha5c6KdX3rxjbBrWfSHSsTh771zmJz0Rv1JQifm4eZWf07jc2F3UxQGivab1FsV
	46riBT6MRBTFeiRAuk39jbn5f7dlcAEqbodgT5dFO4foMlHjYnT7QA==
X-Received: by 2002:a17:90b:2543:b0:3a0:e1f7:9b04 with SMTP id 98e67ed59e1d1-3ae58172e4emr3338233a91.12.1793256320522;
        Wed, 28 Oct 2026 23:45:20 -0700 (PDT)
Received: from localhost.localdomain ([101.44.96.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8401casm2729502a91.11.2026.10.28.23.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 23:45:20 -0700 (PDT)
Sender: Yilei Zheng <trilithzheng@gmail.com>
From: Yilei Zheng <trilith.zheng@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
Date: Thu, 29 Oct 2026 14:45:10 +0800
Message-Id: <20261029064510.17667-1-trilith.zheng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com> <20260903122128.12264-4-songmuchun@bytedance.com> <20261027065723.66564-1-trilith.zheng@gmail.com> <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev> <20261029030511.12004-1-trilith.zheng@gmail.com> <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What's the size of the roots image? And I just want to know how much
> memory this series could save in your workload.

In our setup, the rootfs is an EROFS image exported from the OCI
container image, so the pmem device size follows the image size.

Most of our workloads are simple today, with images around 1 to 2 GiB,
which means 16 to 32 MiB of vmemmap overhead per guest. And we expect
the average image size to reach about 5 GiB as we add heavier desktop
and agentic RL environments. That would save roughly 80 MiB per guest.

At our target density of about 200 sandboxes per node, this adds up
to around 16 GiB of guest RAM saved per node. Memory is what caps
density here, so this saving helps a lot.
