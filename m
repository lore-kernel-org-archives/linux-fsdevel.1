Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22D348C66
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507090; cv=none; b=orJvXlkA/7opkmBZe3SrhZ4MOwIrJsrGxDbhHLgW4GrPJg9Cmi1cbTBqgNWYbHEmePIVgtY3LXkvKSFbfsflxTaaSPU9/2ucyyh/p/sSRN1mBF1dIq57Hxx8OZzrjjdwb1EZkiIXFpPDINONDXPyMgM4+7fXUnVjE6Lw1JPbOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507090; c=relaxed/simple;
	bh=4ZdjWakCq/Aqizx6AFYC1adkwgp2P7rM4QX9GlA4i94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ICyUmnhvxnXK1lyUGJjYEr54+/viC10TIdxyLE9oB5A0J+VkVn11RmmY1seZn/PDV1tY2RYRmUHQOROOPIyIeHD9Ab48IVJInyf8f0uXjXLDjz4bmexyJfytGnJupS9NIWc93yl63wliocX7J+/2pqI0ZOnFoASVjqU7kU8OTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=OASmQ7sW; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="OASmQ7sW"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-451e22b4773so82946fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785507087; x=1786111887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUpW3doNTk9ZVDYiQz02iPdiZ/HzJ9pbPw8kgbFuw4Y=;
        b=OASmQ7sWtme8vdy9ZeOxOfqadf1ySSahE6U18q4xv78UPiX10WES9aUK/APpGVTZnt
         bVWB66lfMxa9GVrHuaCauvFh3hroZB7UXNJQABlZWxQIl+WDEOkfg6+jtVnvp6jkFrvw
         /2zQH5igkODASSoiCdZaFF1OBTd6pmmyPPuvttpkIPf9nRS0HuZpRis4pKehTdAdYxbo
         OU2bJOcPNm2KUwT7718uOV/9Dr5T2CbO2pgtny29hNvi9FAS2BLVKvQNcSqZQxeo7hDi
         7xHqdXgphMdwR5IAVgqiyA80gowYPlOeVg/XikUWYFk1OBxXXpaCa21cRWVTRh7MiTOf
         IiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507087; x=1786111887;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUpW3doNTk9ZVDYiQz02iPdiZ/HzJ9pbPw8kgbFuw4Y=;
        b=ACfJGyWBKFv2r+ltXPwG7N4+P7hPE3be9pZVy5zejzkTng7+XqqFa/JnOiXqslbDZr
         HFtUBcPXxyi5wSIGX1gddZ3431h75OKFFN6O+VV7wWB8QpBHU5FF7Ajsc5iHThN9+2GI
         wyFNO6oHJAKGdxFU5+IUTlzdaU8Si9IuLyOEytek4zOKZzb2j28zzQWY/dd6PB89bBqS
         AGttYDPxjz4zeQZ+qHiepFvFLClMiroQMJ+pXZHG5TrtUKgrsx7zbR2SjlJy27d3UPE4
         ilwFhtv06PgW7qziK7FGlc0M9t89zG0gR2Uwb7PjAxokSYmRJBRpbc++HiqBYBm9msXN
         0B3g==
X-Forwarded-Encrypted: i=1; AHgh+Rq1PfYS9iApUZciuKDeJ/du9/WAK4n9uQro4evVOGpdVIJ4EmdYrfZpQfKzGK6r81CBVfdswEb5IHHd9KN8@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIl+INfla9Rhad27deoYc08cVpIvOZOPxbl9pet4sR5cyqF6d
	xGS/Z3yo1dj+7FrKfpBbw8S6VK6M3OUdPMBoodVDglyy2VjE8ZeAsVTRaiMhGSx56Ug=
X-Gm-Gg: AR+sD11sZChgKsx7Es7tZI+oMdQbp16YN9Vd46Aby8/ppD9SyivQUs4auAqbEtDuCes
	2W4vLoFcsQv805AnMLdoXe8r7Ul5lX+ZMr5tb82T6OXuzJNq8YFiz/gMECjnjXFSApOBVO35Uic
	TZainaEkDGk/wviepRN43F3Hrj2Qfls8UhfKPQe7WiafAAA5PCvZKLKVXMEtTbDVp7ph7305ReM
	iiefw7O3YuPiSL2wHEoLnl/h+doDJRx+wL+nhWyflh58W8Qxv1ZKYs0u+HnkMe/WxVzvIBRRG1d
	oqiesApr8MXJ4hxY1CWAyaPPAGg/BiW5mXHNxlgOzwCDDnoEICZKWObgqRmHqzTkeBA5P4i+2Sb
	0dTGOis08oKG1DGjrMFAQ40CWcdc6RsKG7KA1frxlySbyaitsc/eVN7aV0496iJ39VO0PoyAxrI
	zMM32LxYa6ykmj3iCjUxBdSov+eZ8YThY1Ua/5UDalfQ0f8WnoqW2s2QrC/CvQBEijMe28shYey
	QMr+HFpN1WzYgBtkJN0MmxcpdmcryR7KI7Qo45A9Vk=
X-Received: by 2002:a05:6870:d40d:b0:448:a0cf:5afd with SMTP id 586e51a60fabf-4590572cc6cmr526052fac.4.1785507087079;
        Fri, 31 Jul 2026 07:11:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f66c1fe3sm1162982fac.14.2026.07.31.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:11:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: dm-devel@lists.linux.dev, hch@lst.de, brauner@kernel.org, 
 djwong@kernel.org, viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20260720201057.1862857-1-kbusch@meta.com>
References: <20260720201057.1862857-1-kbusch@meta.com>
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
Message-Id: <178550708596.3329022.10599196691426679849.b4-ty@b4>
Date: Fri, 31 Jul 2026 08:11:25 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 20 Jul 2026 13:10:52 -0700, Keith Busch wrote:
> Resending in case this got lost.
> 
> This addresses the misaligned direct-io problem behind various threads:
> 
>  https://lore.kernel.org/linux-xfs/20260610145218.141369-1-cem@kernel.org/
>  https://lore.kernel.org/all/CAC_j7i1R7oy+nRhxEjCTba=DUgn02w9X+p94DCu0aHv5+5tKnQ@mail.gmail.com/
>  https://lore.kernel.org/linux-block/ai7rnH20IYeSmY8s@gallifrey/
>  https://lore.kernel.org/linux-block/20260616154009.2123183-1-kbusch@meta.com/
> 
> [...]

Applied, thanks!

[1/5] block: use blkdev_iov_iter_get_pages status for errors
      commit: 75ae18ca942674f9d5b55d7e8a2975485125f715
[2/5] block: fix dio leak on metadata mapping error
      commit: 702a2a9f3dfe066a7481698c858371112f3cb697
[3/5] loop: set dma_alignment from the backing file for direct I/O
      commit: 6c8dec275ccc35e8f86cb9287283d31c5d8e9ab7
[4/5] zloop: set dma_alignment from the backing files for direct I/O
      commit: c5059c1af2bd22bc1435b99d27d800164162cb72
[5/5] block: validate user space vectors during extraction
      commit: 14b007e178811db72fbb1ebb3535160db6ec1e6a

Best regards,
-- 
Jens Axboe



