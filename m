Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8843D4F5
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849767; cv=none; b=dOQrcQS51ihd9LPicQhP83294wlOrHj7L7aWL20HspWUMFr3kWJCZfs/L3z2xoH9AmZRC3HLNc/lht0L/eG2xcmm6UZKHX0wq/3xmkARntkq3q7M/9JnQhNH+cmr9DsOZizJyKFEQ4CxghL/WsmsTPJhyLAgm+BnRQNo6GYlipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849767; c=relaxed/simple;
	bh=FevyRYJfa7aLcNPNfj5fxSj6PUN+bEmuYe7JDXhkGoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pzqlqh6Utaus6HOs9uCj/ekr7EybEEEEe1qpXcEMFKgEClug/5fm6jHK9ga288bNYgjNeKFkcCkaRVbog8k7njgSlbAS4H81wY9S/S0kwOxnwoU4L5ks6khs5iKUYcmdEZU1KNRKVJ+u3VBLCYnn3iRPm2gVf3f/OXyHvDNMmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bJ4ZY/ys; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bJ4ZY/ys"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ec3b429a3aso3172498a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785849764; x=1786454564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Son60ydP+iiCgzZN46L5iW0372a03THY3apQWLtWwgo=;
        b=bJ4ZY/ys+X2o7SSyKlp9gqCf8RVnaQ5zsDFEQ27YYGK28uNgXTV46FwE0smb13wj/V
         2nDJtcNBflNtDJryyeurU8qEf89XELvXurEsgy75lfhuxBBFdCxqMQyBJ5VpJJ4mV29C
         YPUbngxZOvMG31Air0dco7372BJmSxMdCBCVg+zg/pFEyecYz+bDnQQTx4TbAhmb4NqU
         TtOee6dLO5krN1QRMW6X7s2AySUWcuALiGmoty3Ogdqrqb31fandqog+NAxaSivkeGch
         PF+gk81dc9bRgeTqSOfYf6StizOVZt5acNy7ZbxTO8WIXuChFtJlxWYVYNrhbQPPtSy/
         YvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849764; x=1786454564;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Son60ydP+iiCgzZN46L5iW0372a03THY3apQWLtWwgo=;
        b=X4jbEicJOLBkuU5simrmO81tr3kGb2zkQxEiShq22KV6+poH51m37SaKn0ITMOORVI
         kX4dx460lGQ9/6NhxkzZLSZS+3lxdJfSuF+7YviPFU20jp/KelyuyvMJlXfhwEgf7Q5t
         KMsRUKfBQ5Hbo2pdaxRADya+bqZ4Elp96wwKvI1udCeLa2u7wWaE1PLLF5ZlNCH5gfA6
         YDjFs0IW/eYfKUUflZv23sV6w0eo5pp40biLy4gYBqeZxPQL3jgpFD9Gr0lCNSvgfjnL
         +q3oz1zO0pmab46uF2b7QSPP/HWxtv+d9rOReTGSa4o5wvQOMU2DkkNwERFMNH02jPki
         Kw8Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro2OnlMAAtRntGw4Y5RfEitYsWatrzZT35T42ddIpOG1IszERAgWG6hKf2nMs+LPTTdT2uQuRBjxcx3gw+x@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EDNv6b64cvD8PJBFGbKECA+/b/S8VzeMFbvDFSjweX0Qws4T
	6HPCPYg/WqmLdo6pl9YFR7cdWmsB8TSPDtMJMVjlrn1caWifnKMSFwFLlLJgOMMm1S4=
X-Gm-Gg: AR+sD13SCnJFJczJAuqDUgXKojjphSHYkeFKPiPpRV1X0T2Rp/23ARHKa8jC7fQ8yUQ
	Qb6QrdhYrpXkZbrfLkBhBPZzkQeGQLcbTWgjiwv1StSSHxp1Uj4fnD4B3pP/eAZnc8A/XUEd5+O
	eyObQLiQYFf7WzbAXRGuXJmc8WutRQ0lsmaYNVpgAXDNqjlx0fUw1g05mlc37qfCLFJMdBnFPNS
	SEl8/uKnjqF1jk4zgXaCe7NIH1mk0ptOytmJDIW2GwZn9NR4yfWLHh9GVeWnPWpaAV9ChwMCXBh
	C60pPEq3CYiPqjmkmZ2STPeVAnRquS+jIiDw2vvaD2ieZbZQWyOuxs+Kmo6piTvqArzPH1J3cbW
	XbAJxQ42TOiUpCRTmXFV1FUDK/73fRpggAg7KK7vfMFANilXLaHnwJMvYAqj0YFOBPQH17X+l2O
	UwBPL25O4U1WudTOyrPI8f4ixX+4aeMgOx2AAN6CjYVNgcVK9+HyxENw6oVbB0neOm5odacXSpT
	PiGCqFPxRDcVWztWyL2Y6LWmWPqZTVEu2ytYVrxcA==
X-Received: by 2002:a05:6808:318b:b0:495:f85b:d08f with SMTP id 5614622812f47-4af5e31fe13mr22655308b6e.18.1785849764329;
        Tue, 04 Aug 2026 06:22:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af60f08b56sm7447037b6e.1.2026.08.04.06.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:22:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
 Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260804123928.736596-2-hch@lst.de>
References: <20260804123928.736596-2-hch@lst.de>
Subject: Re: [PATCH 1/3] block: remove bip_should_check
Message-Id: <178584976213.949603.6178092261493847339.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:22:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 05:39:23 -0700, Christoph Hellwig wrote:
> There is no benefit in using this helper over the simple flags check.

Applied, thanks!

[1/3] block: remove bip_should_check
      commit: 6c13180dba60f835d6909e2a3b4f50862de156c6
[2/3] block: lift BIP_CHECK_FLAGS to include/linux/bio-integrity.h
      commit: 738f01912a1ad68c81a6aed06cac94e09b5f609d
[3/3] block: handle nogenerate/noverify properly in fs-integrity
      commit: 3bf9a21e7bccfd8c35b440efd114c61cc9838a41

Best regards,
-- 
Jens Axboe



