Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B042046F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185941; cv=none; b=Ardw5Jg6hFwDhBNzOcsDezxwT17HK/F1Vyg0ci+KNp+Fjw9xMm4ffV/U/y5mEFmc2bTWDrZFU0MmISfczGR9ApOhgjLdq5FEMtz5oSOT7NVu4nSZDjGGwzxCo31adWMoFXGUwn+SFt3bEbX5Rj6HA0FuDrPMuP7UZCU/25A/tRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185941; c=relaxed/simple;
	bh=9BF7nwsiGUqrF3NEL0NmSiFpbxcBBQWY7qrXzUs5PRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC506h9wNFxEz9+9JmZqxpLSsH8Fg95Tn9xbDhzdfoQp54MS/SMUaJjqtvaFc6Yfipb8HNstU3PdLi27yGi55Y7REjg882ohJ9KWB2kO5NPW5tYrZV3uAaIHia558+PBFFEePmswc+xYtQlQjXrF+9nzrU/s2H6QkMsupuVdLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw8SCuFL; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw8SCuFL"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so755373a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185939; x=1790790739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ntejg00uo+ObrghLjhgDMWB/RSF/FEi7La0moj2PhdQ=;
        b=gw8SCuFLIddmrWdZbSWI5+m/OviPU50b0c2TFZrl+Y7WFHb/ZUDsdAY1m+TBDuuhvY
         8eDTrcRK1tx4d5btl9M5YqR3YVvoWjEgbB83j/GgnxdCyr15XsMlWk4I5G4jIZMJb+SX
         7a5I0EX/2b7t4r8Lhgrskno3c0auQr2oN+1RA8mYllzjvrzrLLOGNIXbz3xYvQKvlfTr
         hDW88Fp4YUnzs+aei+QMybx5FY7aPoSkNG5fcrrXncE02vlnbncIn/Q8PObD4XCGswct
         nvtlspj8zhN7y4oa3brjAzhtfqwngY6IOkjedrC9joUIJ5yvO2I+pNYTUKp3dxwE2IV9
         2cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185939; x=1790790739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ntejg00uo+ObrghLjhgDMWB/RSF/FEi7La0moj2PhdQ=;
        b=KIJgx5pEiuEqt2vtuB/OfxQvtIiC78zDZ9FcGGPtxqR2FqYhQfwg5jdEL2z2MGbNcN
         23TDTBbcpfwfvLWcgxC6jexi9qXYeHV0AFmFeNud/bLkDuHy/rGb438i3zk2cTO6zhXr
         Hz3UqZBOPGdO3mZZXYXsdNhYlaBVmU+TwE+R6KyHgbuqpfnt4o6XmOLyDzHa+UBSn3eV
         uakFeyAFSicdfEidCA1P7KUDElKYB8uIKBnhyHQc4bWb9Y0f+l6Z6c2dbKmkrlsMrPhq
         9HaPVq+Mkegx2ct6Cyx+p2GyJyGOfkUpYysr701y6pS7pZS19jxCOOAk6Kue4EGkjZMH
         NSHg==
X-Forwarded-Encrypted: i=1; AKwUvBww25DBfZLHBb6OnB841OLn+mQWTB8897zB7iJkxRCj7WSBOi896y0KeH/Lztdaej8HPJesS79YGww+wGLm@vger.kernel.org
X-Gm-Message-State: AFuF++mMMkX/VsLMbHFbBiTAO9Gd0IYfZ+Hfx5tSsYm0oMhUxl0W28BA
	ZlZFVzThEJe3NT3bU6GyDIAFkLyZDYV5CQGZqiKXCqS6ETRp4Tm0MtPb
X-Gm-Gg: AYBFou00TXK8y0aodCBtCGzfz+lBiyoGw/d0wcilqbDn5w1Z2XNetj7CrEYRChs4sjV
	tMBq8tnPvjXsFCrYS2f+0wIhEVvY3w/keyKsuisejKyNFAjcA7nL/q9bvlJSa+29c7OX7OpFYs/
	MpTTpSJcEMq3c6YsQZODZwdVPT+6oh8R6iuyTIi+jhwwEfgxl7xY4ZD2YDFFn2jCMa6I12l5atS
	MW7oRMbLgSKrippgjhAYRyuTsTFvqYCT8WOxHZJkJ4Tmnh3i07/D7SQGpvIAocT4b+7Vb1b7831
	NMMy9GmjHg+gdhobqlOUpG2sSNy1rHjzfxnGyNsn7srZdqVChjNnwgm9khGFE7DuNP1qhJZd8xx
	rAgKJ6LMfkdhHEVobCiXNFpsFf31p0+wPYB2NkfdszIl3msk52YE1WJ90rraFZcA9M+UEwO9CDU
	4Sn7uTWqxTfH4KiPnafs17eoaIoM140/Pw8dFAHjE/Jl+/YKgYsz/uAKevp+FGfLBAHHah9kvQy
	sv1OQE/U/IKvNCqnVxw/hzrvt47A/4OIHTFePsIGuZJvbdtDKrMq91QugiAAV4J67oCQc2h3+9Y
	s168QtHIiaSEwhYZeG23gMU2Tj8gvqUCLMzv6cfbkLGqZCUkbZdF6DOrDNxXGtfHsqOeQA5L
X-Received: by 2002:a17:90b:2fce:b0:3a0:3881:eabe with SMTP id 98e67ed59e1d1-3a07e4ee868mr2866614a91.5.1790185938673;
        Wed, 23 Sep 2026 10:52:18 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097663fdbsm216755a91.10.2026.09.23.10.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:52:18 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: reject short directory records in isofs_read_level3_size()
Date: Thu, 24 Sep 2026 01:52:15 +0800
Message-ID: <20260923175215.1577791-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919222553.3792320-1-benquike@gmail.com>
References: <20260919222553.3792320-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

I'm sorry, I missed your patch when I sent mine for the same function a
few days later ("[PATCH v2] isofs: validate directory records in
isofs_read_level3_size()"), and Jan has since applied mine to his tree.

I did test yours, on mainline and on Jan's for_next, running fs/isofs in
a userspace harness with ASan and UBSan: it fixes the three fuzzer
images that made isofs_read_level3_size() read past a record, and I
found no change on valid multi-extent images.

The part of yours that mine doesn't have is the limit on how many empty
blocks the walk skips.  Without it, a run of zero blocks is walked until
the end of the device.  On top of for_next that would be a small
follow-up, and if you'd like to send it I'm happy to test and review it.
If you'd rather I send it, I'll credit you with Suggested-by, or with
Co-developed-by followed by your Signed-off-by if you prefer.

Thanks,
Matthias
