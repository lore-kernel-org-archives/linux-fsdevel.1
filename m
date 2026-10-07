Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746BD3750A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390682; cv=none; b=Bap8kLpZNTTs1zHb3fxN3PAlSofygJrUK9UUqdVNiUS8SZ33w7pnFlr9mRg5loyf52Rmf5JiRu3K9tCWe4hJ+/7p7oLS9K7DmVSGLhGDWkyduNE8pwCrS2O5odLYqg1ed6PFQCIvtDeXObRQHkzsZzIPORW+m7tWG0KaqR3qQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390682; c=relaxed/simple;
	bh=m9N9r2XMeiiGqnOpn8nyCMQVI95vlWAuCvN525gATcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHUenMvQnIxmu7PqdzBMSy8/JClcIf72+4tFD74Q3i2dNmAgBNR58qCFcM/ZZi2cAJCnqEAXr+SfLeOTtpQyESIv/ovOo09gxFSvU1ifSJAwaxX8YzNJwYqg8r+YTqXO6oTFF8/3haaTUaLS1ICsL2ADkEuE0LOYyBIZknhJegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpVt7JJP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpVt7JJP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e576377715so22306265ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390680; x=1791995480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m9N9r2XMeiiGqnOpn8nyCMQVI95vlWAuCvN525gATcw=;
        b=kpVt7JJPYxtLQN+lkotXm/Sr09Boxg+BTmRnc5z52kiilE5+1F8eviHrC1B8nrHgzr
         xj/iAa/SfoXHJmctM/joWj+WjlIEY9RWFm7kFbyrPm0jwbK4R35FVd9QS2taR6kPmrEH
         7KsSMjvrcaBTr8g1+vGR8bKsXqoEBhqotiSbiKfAUT7DPnvhOR4nMgNT35nxzYWmKpen
         LExIeZ4aW5VE57U6p7DZPiSdzF1uz0NJqqhSNWEyJD4bNPUEzDssFk0nMcZX6WFlnqoQ
         uDKe1CAgLV9sdDroK/PwWw62aPNTO36O/xj9X5dyLFlNUu0PXzA+wDuUccbjL7m2+e6s
         N5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390680; x=1791995480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m9N9r2XMeiiGqnOpn8nyCMQVI95vlWAuCvN525gATcw=;
        b=affuUjOI9h1e6vhJmGs7ldmJwwnJpUCKRTy9ZtbnLPQBjvee8GC/fUP/l3u1OZanDu
         tN0daXS8lVGR0mYj4nEKi/ilCuDLNWrl3rZdFr+yqOP44fyxN8TH6kU8HcViYfhIPXyA
         hcsAOtLhImktXXJapmcsZiZxtvXtFW7R2aAZKb8gz4kmSJwTFLM6nnbON0J+KdI33YdE
         K2FFJ+sZtwXCWy88nHftJ1ygiuITGI86pFLAYKLR3sqADOoZ53qGFM3Uw30kRhqqaUez
         1M9x3n/di0zhi1TPY/yPTwBHGcBvRDjdrAq930sUVcN5z5Td3pk9pnu+qJj9iI2ROkwl
         paCw==
X-Forwarded-Encrypted: i=1; AKwUvBzfgD9UMG4LSONXasT0GCq0BTSJupEh7AeSOj0mc69Eb7/mS9sBbnf/AHQoheNA8B9Z/N7aBN2wQyld/NIl@vger.kernel.org
X-Gm-Message-State: AFq9FYLyyzMDQZLaSr9SWnmwSorBQcYizqJEQrQpHG0Kidw+BoiTFOtz
	DogqF1cm3a6k10k5KLB5y2h2H1hAvsjf0+lldMCtMep27MFTvqw9b6wX
X-Gm-Gg: AYBFou1Z8JP/8pRvyvQiHDiY+CUDWit4sYfSwiEbOgkV/zCwfMKcXB7u8UenC+hoWhy
	MN5UAMgpHKhaljASqweGdckvbslZIiZo67JsM8IitYomUhVQ6/YT8pUFNma4O+oz3tqDSHg6k+v
	PSSt42/iockMkv7R4dqoHealbrvgC13y7IXNp0wHKeQbw8uLZjydxnE0Bu7taTof7WZfPgnvGV/
	xINI+zu95AhkPJs0vPeZeIH+yIfhDt/UGhGtCh+PN6PZ1+uXBhRZNL9fKnlOraX6ELyW2a3LLdN
	5yHsz/kY+Jg0FnihJE059nvaX/VdEWqDptL2jIwLa+MRQCzuOQ0N4AcDM4X4YA/pRSLYLLZsiFi
	QcMA4Nd/KBQOeEV+/TLTV5hDZT50OdiSnXw8hXwpfuCZbekH3aZm2z/uSgZgwD/Q2FFmIFO0MnJ
	nA3/lVse1aqcUVMEwnxSN0WGw2xNfHQrbc5zf7HfGUKX0YT/9+AeJmY0b+0mDC7RSUiSw4hGFjP
	oXzEIy65iWmfueOo+Ntze+9gt5hHYrwDrc=
X-Received: by 2002:a17:902:e94f:b0:2dd:c053:e0f3 with SMTP id d9443c01a7336-2e600516db0mr24203205ad.34.1791390679699;
        Wed, 07 Oct 2026 09:31:19 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604438545sm15267295ad.6.2026.10.07.09.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:31:18 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: ampr.mhd@gmail.com
Cc: brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Bingham <jbingham@gmail.com>
Subject: Re: [PATCH] fs/iomap: document ret parameter of iomap_iter_continue
Date: Wed,  7 Oct 2026 09:31:13 -0700
Message-ID: <20261007163113.891271-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006154005.232338-1-ampr.mhd@gmail.com>
References: <20261006154005.232338-1-ampr.mhd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a useful documentation only change, and documenting what ret does
there seems useful. For whatever it's worth,

Reviewed-by: Jeremy Bingham <jbingham@gmail.com>
