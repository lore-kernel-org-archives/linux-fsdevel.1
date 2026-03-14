Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71911E5205
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 03:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773460090; cv=none; b=CQnRGgiYNzq5FFMK6zuiEqk3jC4YZrjJZ+1aRlOYVw/izxi5Ki3za+9lY0pLp7G8rkZeWhbCWRF3l1+zdI3+peHo2PoCnuqbLPTkKGfEkTvH5aSfSwRIlRUHgUshoJm46rnw0SVvdSx+n7QiInyeXtYpQj8n7fQtLYufvJR7oEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773460090; c=relaxed/simple;
	bh=jyVRorbQfQEu+S7gl8MI6cSLss8UFtLXipQvnZJfASM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd9aJFHxttu70sKIrAaDtQ/6pe/SJncBuKKtad86Rdtf36JiaO4NIJa18I0jroI8LvQ7fEJ1hPWjIBbClSRt6Wc/+tW9d7WiPwhoVUq9oCv3zKKoVKZFoGdhOIKE4WzuwdT/a5vRUZdxgkwelDfAhyUNM3BVx05tOtMxyLtj+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=Xj2QuaiO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="Xj2QuaiO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aece3546e9so16432365ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773460088; x=1774064888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV0t/dqzSE156GqkAAZgS45ZhHgnhgFYawmC6jkXx0o=;
        b=Xj2QuaiOIg7+nF0CJVVXVIEgmpArc6zmlGGdAdKf88DrMER8zSNiz/TRhwiC6TpCes
         kT78GM/B9E4Gbxs1fy8hzNqCcRI3PMESa4scAGpuKAyrrKdhjkEBk7Byv9JzohKblK2u
         GBDy7Nnad6DjY9oHKUu/B5LsWrK4+Nm2UqbLDXYuhNthjOk+av+TTy4QKPCMLjWElBbz
         wtjM+3GbxRf10DyVWTJyU0eikn7urP0Hz0Dft++q3X1LvNU11RonP2ZnlZlO5gcycBhQ
         Ilb4uq9VEL9ilk7njfnDV5hVukEENrepkZqt2QfhSBTx7bCR26z+KONHvkt71TwqwzXv
         xzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773460088; x=1774064888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DV0t/dqzSE156GqkAAZgS45ZhHgnhgFYawmC6jkXx0o=;
        b=h7K43RP3seq+xbDyooqHtOS+rP432jME+w16hQMvvLA9wtH7NjfX9XPipI3mqWYTK3
         X78yXj+v4CjyXapn2kJ0V236sXnQ7A/ds0r4PV5WO79g5V57T/88rgT63BZrNF23pF+k
         0s7n1qj7BAaqyrJVZKJpOQlGjtky6tdC+o3QjJO9oIq7GKI/iaj0kA2PpASjbpwbVyE1
         cKNKzdTc1/LgU1923RAMIRwQmRNrJ1Aodb6WMUDOOJ1yq+ycM6OcD3jGz2HM4WAUtiQ0
         sqFuTcpRFIilpXmQuJJf50uaMznWcc26pveNrw/PXGjBl3cG+7OSgOsYO0ZsPsK7x11y
         UnTA==
X-Forwarded-Encrypted: i=1; AJvYcCUxOGPB6Ggj+/6tjR42rBAW14/m+mo5k8qaymELvDOec78UwxBWspFZEc3LYNaU6AsqfVK6cCNL5LeQDM7A@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0eFHn1EUIYqYDb04hlvVjACcGRkZdy8XMSGnZscCPdHA9JZI
	5Zt0zNLoBywk6IwX197nQJCKPOeRZ/4rn0Q556r+rm0XEZ/33OWuqROVhjoIaS3uQDs=
X-Gm-Gg: ATEYQzxY5d2RbhYL1s/p4ShZEsj31EmPomXAM7DJvH+7b9CLcjf8e0ySOp4fydWFPbh
	8E7WC6iIC2OhcQiUuGXOj0EEaRW1LWKTBN0iORoGDcFkhH7Vj37Ke399Q0Lv0noiHdVQ+B0+KA0
	/Xlc7cbkspiDZWZ1WBgi/Q5DFrgCywoSqjbT3QvYTjD/IX+D71mn0R/EIn3lH2Qvl3WL9XrQOb5
	5M+CkTXcIj4fY9c3YWT06h5vD1lqj6hMpKXZB5dZnwrFvePgQYC9DMPX6fu/P2hxEghAfll9698
	wdzA0JnlrT+bljL9+71eQGJO/UcRaDVBceMdHa23WaCn4I4WC4Y+b5U8EEltw5bRvrK1luKmBPk
	Pvww8vTtQHcpjGskh1kuLq/WhwdNBnxRejABdMJLtdvKwROSFo9pdaPcAr2THONVPtKGerInNaq
	/c
X-Received: by 2002:a17:902:e74a:b0:2ae:cefd:18d6 with SMTP id d9443c01a7336-2aecefd216bmr50709525ad.2.1773460088122;
        Fri, 13 Mar 2026 20:48:08 -0700 (PDT)
Received: from gpc ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece838d3fsm50446025ad.77.2026.03.13.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:48:07 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: usama.arif@linux.dev
Cc: Liam.Howlett@oracle.com,
	ajd@linux.ibm.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	david@kernel.org,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	kas@kernel.org,
	kees@kernel.org,
	kernel-team@meta.com,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	rmclure@linux.ibm.com,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	WANG Rui <r@hev.cc>
Subject: Re: [PATCH 4/4] mm: align file-backed mmap to exec folio order in thp_get_unmapped_area
Date: Sat, 14 Mar 2026 11:47:44 +0800
Message-ID: <20260314034745.168715-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310145406.3073394-5-usama.arif@linux.dev>
References: <20260310145406.3073394-5-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> +	if (exec_folio_order()) {
> +		unsigned long folio_size = PAGE_SIZE << exec_folio_order();
> +
> +		ret = __thp_get_unmapped_area(filp, addr, len, off, flags,
> +					      folio_size, vm_flags);
> +		if (ret)
> +			return ret;
> +	}
> +

I noticed that even when the code segment of a user-space shared library
satisfies PMD_SIZE (32MB), it still doesn’t end up at a PMD-aligned virtual
address. This might be the fallback you mentioned. Adjusting p_align in the
ld.so ELF loader does work, though it also avoids extremely large PMD_SIZE
values (capped at ≤32M).

It would probably be better to skip the PMD_SIZE == folio_sz case here,
so we don’t end up calling __thp_get_unmapped_area() twice with the same
parameters.

Thanks,
Rui
