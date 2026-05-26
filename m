Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16963CFF56
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813452; cv=none; b=fsC9APd/CPiUN/F69i7HawaFmPHFo2zOd32UkUqpOOwbu9FjrfHQ7zoJu7mXTbf5ZOgxdRd0+5caHXzrD4woZkaWa53hVcjjWSvA5l0cDgQO+z/W8KY0UVEs3T8ghyY8kymshQJ1pnVa07Id/3R5whYDXmgn5llHZWCSHf9JaDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813452; c=relaxed/simple;
	bh=4wUdcMoXIqdQqLqCu3PyBpLhPzwc0EO1WLuZNMtdfmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b32RlmGkIdIAvpfBLkHuRIZ3RYWyKPPZfWtCBadmy/OJncXCBKS01o9D8DLUJAcErkFd+wR4Szzwmhy/wu0ccOMLtYz7OWoUmP08G6W+s5XejxcIJXnn5ZD7su+xc6xTYQs/Cq/rsLwmQg2C2Zo7VAnnWYAXrhcOw5Rhkmtc/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=aLtFNFre; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="aLtFNFre"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43587e63a8eso6808654fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813450; x=1780418250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCd1gSuaIf46mkqpuuPeXA37mC71Ui24TOtMakL59tc=;
        b=aLtFNFresiZTZghWb/EYlhNZlV/Sxnef3JdZcGmKME/AO2xsSQR9r3X8WtMyyj+2hT
         D5cTeQj+oeDo9JfKSNtLxoI6JOVHCFlw0+4hSl8tcGNDNTlh0QCeWiN1hp1phiqDkOXm
         dFZ2u2VGz3RlOzViwZF3ilBypUBY+sROAMclJ41LGaCFtoumWpdfahwFl5XvTr/xQCVF
         vwY72Xm1UZW5r7gCNxvOP/TE8yZ/zwRuXF+U3PYIn/oNfYXwSf0V2N6fjC01oIyAp614
         M+dXobI3f2/akO8ORL/fDMR/ntpfAwknFgnZDjN0N96Y8nvk1BwFqu4gbcmizs7IzDUt
         /LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813450; x=1780418250;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCd1gSuaIf46mkqpuuPeXA37mC71Ui24TOtMakL59tc=;
        b=UVZJfj9uSQ+6SBqpdaUBEOxECVwOWnc1xPFSPYb62z8gD8kG8qUXujw+JRd1Yky3ba
         fhid4lQNALhajTKqUpNldt5hDfrTe9wDXK458TloK4SaUiiiZxJhV3zn8ZbTDc6ZQurm
         GqghIlGdA/+t71PNojoxxvHdO1RRYS4bbZoLdX2E8LiX2gINVweTnWCEuDN7gnQvWW/T
         170QildqYKscLu1lUP1D1ehM3qIxrS2psqMN4l/uISGM112QOZDgsrJ/6Lvy0Fia09Qj
         WVTmrcdPsjlvdb1jkTm5DovD/YpX4St11Cl0WmPZK9M6aa0lxBU6Byvo9JN66zyNpFPg
         9YeA==
X-Forwarded-Encrypted: i=1; AFNElJ+EmxG+PM+8FDV2nFHH+1EdpjVQ0X1nxG9o8Eo1FAdeXvRklPv/WJlRy1ymGyaB/ziMQX6EfSP1SwBB0WG0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+C82JJC7GBaMmLcKoZF+bWpe4qcopHzd6lH5Z/sLx3zJBLZsz
	edqlwDg17aVP8T8AOEslPFA1Yy3ZXE0anXlzI6cgko5QU61vQi08xSykGbi+k7bh8jw=
X-Gm-Gg: Acq92OHSGVw8Np+UMb1vHlyt74fZKFmm23iBSL4hHGZ4GQi7iasX2rH6ikBeOvOU/Y8
	uEr0SFNRx3VpB8L7Vv06DHq+Q9MV7I4BSIOTQCla63bZfvObXyMX9hUhS3bvzE2boVTsibdurc7
	kTug9G+Ao5lcdaYRPofkNRRP85M9I4ddmgoQ7weCDfhnedcIV9tvKlu5fOUy3rY8rV8L8asR47M
	vEvhPHDwM/H7jbw2abX1XAOSHlFGj2zlweXJAFIDRa7cZbDA0BoY+EG+MzoU9AXebTWhopl24KY
	JdexGphEIEqTbPoAl5UqLi3ANiV28dWwoLTPIbFsLBxzUoIjd8/rVkTtM4x0JqZs79HsRwTaoG+
	TTtm1k8JUIC+AX8JrkiDnWEzZvOpanW1lPwQ3cX5bqu6cIZo6KAld4OIyP4OX1TEdM+fZiXnNrG
	flGpdtU/5zWqUFxxjMcu7/b83b1MpqX2RoDmI2WdLz2DaH2GlO6KUvhjdiNGwrxLAD+DbVoUj/Y
	tstoGOgzc67Kg==
X-Received: by 2002:a05:6870:95a4:b0:42c:22ed:165 with SMTP id 586e51a60fabf-43b5aa19ae8mr11678694fac.3.1779813449931;
        Tue, 26 May 2026 09:37:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260518063336.507369-1-hch@lst.de>
References: <20260518063336.507369-1-hch@lst.de>
Subject: Re: REQ_NOAIT cleanups
Message-Id: <177981344688.464267.1292458994150059710.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:26 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 18 May 2026 08:33:28 +0200, Christoph Hellwig wrote:
> this series cleans up spurious code related to REQ_NOWAIT handling.
> 
> I have block layer work depending on this pending, so merging it through
> the block tree would be helpful.
> 
> Diffstat:
>  fs/direct-io.c      |   15 ++++-----------
>  include/linux/bio.h |    1 -
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] direct-io: remove IOCB_NOWAIT support
      commit: ef9049ec8b9fd6c508832d9f7ab12029f3355102
[2/2] block: don't set BIO_QUIET for BLK_STS_AGAIN
      commit: 481105a949c8d11f7aa770b45fc4c8efcc53f205

Best regards,
-- 
Jens Axboe



