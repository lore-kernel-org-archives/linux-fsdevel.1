Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F935C1B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525820; cv=pass; b=HvTjExLKoPhsVCGtDn9mlR8gYaDWBSg7ogHA9tI1wVdi9uNzfwyJo2XGdH0HNQxCZMDUmCf4t/rnLPtT8dvwUv/7OuK6Z8nRomWk2SgQW2LRi9MFhYu/la5aQ0vwsd+HfE8ob4AQXgx7DG5AT34noprE2Hi0ypp5yvgrUZZj9+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525820; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULszpCLD6XfvOyYN0T6IyiKAsxwGiOXjoTpWT3ZwfTzkpuVQCi2cCJX/hiHVA9r340qdZAIU4cQKVFS9FMuZ0b7fz8nwM6uoRShmqM0Cd9nz0Oa0isWNCo3isqI6FmZZXDsnm7NrcMd5SVgQEqwt+QOFgy7pGK/zsCDRfQtPo1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGVcs7J6; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGVcs7J6"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso9368428a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:56:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525817; cv=none;
        d=google.com; s=arc-20240605;
        b=YypvPNC7VHZYzIOvjWH0GezjrFq+OpVmhuNLOnoKG0jqjRsDk05QpH7vThFuD+Auaw
         Cgz33E2L+6E0IdzZL71IOw/q6Qwl/fd9pisxhpT7vZ6HUXKyNUNnKqzSpUThNOKjLzYS
         qgTzgKnQkj2AtIW5s02ci2WLeyn4+AgCpHWuAiAliah4BBqLRuv1UpTMARVt7iVLoFBL
         ecWlRtZx+9zDQryYJO2OqALQ7y4WxHX19A9peP3GHlb0Sf02c+tl7F0g1p/Gamwo6PVd
         sn6ssw2qONuXaqEcXqEx2sQwb9TA+B4DBGgeG6O6kaPOnv96m88FLRzRU+RbLZIhmCio
         zTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=srryfk9JkEz88QDbHoNnefsN8q+R0m7JLtwlIAG0sZs=;
        b=OMpM+AfQDkOYVcvKAYm346t5mqx9aikg2jsnYzoohWBo4eVb4uzM7gKARhQWnUBPQy
         vcTRzvyUa3x/z8YjyvNLTHIYLvAWBtSRC0FBBxrA/v/xVXZdU/QQsDtVHKVrciwM8lht
         ICS61Do5/diL8Noh1AFIueFNHJV6gZguC5Z++uDEIddxmSho3i+OVO7JIAtUNoN4XI52
         RlnKhqDYyjOSrw6YIeYBi9g7ioRCjDTEx04Ub4Xqt2uI04KJIKmh0Aiggb0ZnNicKrMM
         Ilv/5V9deAk3mv6mpX3QbGKa/PRIMJiCcyYjq4xoeMVP2AD7hMPRC1D57C5+kbDtWqFx
         Yptw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525817; x=1770130617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=MGVcs7J68ktxy9ICcsWR2V6AWM/FCmhb+JcVHOsy8/1lUYI5u3hh64Txijg22Mj8yl
         hA1dS/XvhOQRCr5Xyc7CFdlRyAmbSDTR/11H1W0wDhAlx7dEfQeW/xFkm35QSc9eHkMd
         b2bGDbcKeUCEOmOE1afLn+OgAJtmAHyRX0Tx8vLkOSvf9uJM7NPbi59Z8LKoYER1Nilj
         t6mswqQSR/B8gnzXgSLSPYcSpJZHfclekhaAiS4ejVnXEJ+MVaDYz7df0tKLfETq6q8K
         /X43u2T21VhlqAWxcEhbfo248SQzs9o18+fLsRThiKULs92JUMU5Mc8cYcm32+sUFEts
         Ha9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525817; x=1770130617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=sw1O9y/lLyfHeaRGUHKuloNYvz4MCayx4Sbi7BpW71vEpe9PeeV/a1irfgl9Q0Dyrj
         RD9qdJF9SEhAnITnSI+PTtMY7LA48KPuJOBCG3zKeJPrreAtI/O7NYMplEkYJ8vwRVCE
         vdd7dKJDWP0PDOvWyWWPzaielG5O5SHI8TEwgqCh3P3JJpl3mzeNV8jMp8DtHSruXs2K
         jFf4iVWPMBVxQ5z5KCrXaLJREm0TE7tzvYSMBRbZUIFu7HQNGmRMkiShEaTd6pFGTDSU
         pyyW5Z5kKjH10Uwvcm1Hu+fgtY1EJHwKHE7dpdDrAxbRQ7aM2mtDlMkcNdxZ1rMSeUuO
         wNHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSv89kLe6tsOZswlOvR++hVUwEhe2lrnn217k3rAkrKrXoSu7fSLsBGW3+lRjUNRu2EoXdS/tMhJVd6Rzr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41hysl3iVDCWnh7aFRB5+jzF37X4//VmKd/rel+xtWEBfKLc/
	N121EMFlvhfPDMy7SsgY8YX+L+FXK1wCC/oh5sXMhzGELam/57pr+PukQZGqyNSH1WWbjEedOiM
	TPpe6YzSVfFFkrG9m8HKaYfYdNUJCjA==
X-Gm-Gg: AZuq6aLzmX1pdJdTM045PYiuXPcBbE8A92sGTA+yIqUkagmEWVjnLf0vhJ3YhbckUWI
	GfVyrjSBSH54e+oQRJjIDXjo5KkBsbuPonafaonhRLygtmlGt6lNuUOGKej0sEiTR2LzMlHeRcD
	4mRjfGFlHNlv3O8RJm+hBWPTDtcWRQiVSixmh+6RCRHzektxYjsoFP88uXgIIkGw2kH9Z7M5XJK
	nu94JZUySojC6Mn277lioFxTAsyAMkkImB2Wreb9tb8te8OMwYdreuxcQINzCumeP8nxDcNTekW
	GoEsrOPUQENucCVOACJrWTBOSQI0MYhmciDS2/jeJWz3f3ZMG96Kf1AdTQ==
X-Received: by 2002:a05:6402:13d1:b0:64d:23ac:6ca7 with SMTP id
 4fb4d7f45d1cf-658a6083d59mr1404674a12.20.1769525817398; Tue, 27 Jan 2026
 06:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-5-hch@lst.de>
In-Reply-To: <20260121064339.206019-5-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:26:18 +0530
X-Gm-Features: AZwV_QiDlPiwSdA1exwb_wyngdPHkJQcFo3xsAtPq8Ggx0ZleakNb4Ga8U4ZEd8
Message-ID: <CACzX3As2YHwiBXwHBTh-QHTc9g08V_tkBXqUsKCin8UfrgeLuQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] block: prepare generation / verification helpers
 for fs usage
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
