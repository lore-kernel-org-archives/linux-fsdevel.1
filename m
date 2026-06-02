Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A830C148
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434773; cv=none; b=scPGQzIjaYs9rwDK+i8veCLO224WLvsCDikL7Ts6czk58QXx3CyAnldczIXwGd4/p8A5ZtepwT1sUm/uShFP67QP8toYSAu2sIjnsZ/qbFoG42Z5x30bjbtsBMHJe9c9hdeLkxBBZCFjJffjhUGmuOc34hfLLEgavfuLUY/WGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434773; c=relaxed/simple;
	bh=uij0fPrYXhiLn/hkkJMC6Jmrz2271TCJpQyuyCz9648=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJBdvjrzlcbMFuL6S9F2esEeqyi9zpfpuaAvlqlDRQMCiGwIsuAjaT798PQCroAfnkZ7olFcMHc12bmeWTSmQco+jF8Ix7wwgmxVaYo0VJnh/YHl+Xuobsb9ZYI16wHaTvdvSr2ARPBo/3mOymiUjLhtmMCfWC6e8v4IKoZ7uq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBbMtFsm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBbMtFsm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso65895e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780434771; x=1781039571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9XdL0UcpSaON9fzpANOcoqtpqZ13Zvjis5WLumIDqM=;
        b=PBbMtFsm7wChxpUx03NtaBWtFJn/EfXqGpb/VEcyERZ2iLqzHMNLMatuyuVR7QWPfu
         8WW8Km1XEKgRVtRqCtPHN3gEyqhtnScsvDIixgY+SJJkqmbpV3efaZaYV/MpDC8bTm8e
         gYdss33U+liT52p6RMSvYoxy2QyNaXnuzCa+sKtK8nUIqJ5pYU6Cy+mxQU8F5dPVe7u1
         oNwY08o05liz3y3GSjB05k6kCEfRohwJ/l9HSMdThLORfytOf2+NyxgPK2L06LQokybP
         6i/kZCzq/KcwJurNssCq+GZzk+85sMQ5Y6AcSdxc6gYMOO3mzAywpIfUxoG+CJ/gzeha
         1nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434771; x=1781039571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9XdL0UcpSaON9fzpANOcoqtpqZ13Zvjis5WLumIDqM=;
        b=ITTpUSVsaR5GR7R+bMraMLZLWc1Gcw9pZbXD2qBlnGtXw53mLAxhVVMefB8b29TJQ/
         PJKZYeJgFfytQvK1Gkcke60vec7Ig+ntpslRuqCbiM7XWp1PxxAJCZYludiKgWY/GBb0
         UDbomPlqNfHrjR9O2x8rg/LD5FfYSTWhLQ5iT3x46xYm/6HDvMX6rQ/JjzOxPJF8zDAF
         AdOsWQFdAzQE3mjOfYLqd5KXjhqkCm5n8cmDtBVLA3wEhm6qvwA7fKB01coSAvNGHuc9
         Jp4uDyc+EmrfbFILe0+mDe+1jMiMTg6FyKXPZ2bE4+Sq5dzcrErnAPzDiELN43AGa2qM
         ymIg==
X-Forwarded-Encrypted: i=1; AFNElJ+kqkhmNOmpt0q/269oKxvilsp8fd3JqEdOuPC5nO9UaLrDl9dMMDIpB4i8Z+kUWC+C1lX+3AlmC1Vb6NIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjKaWqUyJXvDQVehMtwVmh3cWmOAzN4Yw+xe/bqr5TN+KuRMI
	ovaiILNbUAqQ15JP7Gy+SksbnyVShOer5iA6tmhEtNoBaN2+ZJNRoRgQ
X-Gm-Gg: Acq92OFF07+107KM4B4dJ5RQQ2e7Ugq+Ax59Cyqz2JVNAGk9cRXCn+L6N+UVFr4ym52
	COZslyoAS/L+pibF9HaLSonpIJ7evTchwJpEUnnTNKtjCZoujUM7Jq9/cPVl/wTNySLeEetilQd
	L0YKU8M/Bu97DD3hz0qmT0F1FCxlTS47mE19BjcpgC20G2C3xGK/pCmR9W3iw+RDLli3JMU1D6q
	vsCyWIONPea6cmEAAUh9lQVhMW1VfdRN7IdIXbomP6rbF6gHeDHg27dVpCuuPyia0aE/LQb0kk7
	UAyQc4ZcrPbEMXkGRRqWyV1jNncn4x1ULgt4xpwQUbWypO6YwlD4sNODV3FnvJzhZa3cBRscmA7
	nGoewzH+CYgtwaMuRt7a2Xm4sOBClXIR1O8kO989NR2XfLJ0Dl6w6F56JbBHaBx5JXC8T9uDvz0
	jhIV9hdnB8jjORdrHUpm5R1JzvHI38AA==
X-Received: by 2002:a05:600c:3b98:b0:490:b11e:e4be with SMTP id 5b1f17b1804b1-490b611105bmr5959595e9.3.1780434771026;
        Tue, 02 Jun 2026 14:12:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b0e13f91sm111429715e9.3.2026.06.02.14.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 14:12:50 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: pfalcato@suse.de
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 00:12:42 +0300
Message-ID: <20260602211242.13870-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
References: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pedro Falcato <pfalcato@suse.de>:
> On Sun, May 31, 2026 at 01:01:04AM +0000, Askar Safin wrote:
> > See recent discussion here:
> > https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u
> 
> So, you took an ongoing discussion with an ongoing RFC patchset, and you
> decided to reimplement part of the idea on your own, as a concurrent patchset.
> 
> Riiiiiight.... I don't think I have to NAK this, do I?

Okay, possibly this was indeed inappropriate.

So this time I'm asking explicitly: is it okay to post new patchset?

I want to post patchset, which will remove pagecache-to-pipe splice.

-- 
Askar Safin
