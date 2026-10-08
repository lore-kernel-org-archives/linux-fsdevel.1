Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16D44E672
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460023; cv=pass; b=tL5t2mZRPN4st8+iD1yn7Y2GFPG12Ymum23rnKguTM5gA7xZn8nve+910eVSjeNVxPTkoQIQ6ZdhKwJRbGwGCiL/8CjMy55KPuefu+CcBi0HV0q4WFqdDykkzSaj+uo/rI/XeQoLrPGVCRj2ALZUqDth0VSuXW/28O+YyhqlTtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460023; c=relaxed/simple;
	bh=CO8G9SZWedbhi+5xtVQ96NniUgT/5lP/6mxDhdyYfZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6inFBiJtr5XNWoTRBue8x5qJdOD4uPvb69dPpIu13Vw9r+cWQ5FRVAXjmuzGsSBDpjRkao3PvguXf9uG6oloE855fAboChxft6RnL6pR0Bt76BU0I+JxkehnEB0eNwsU71X4A7jOwnK4Zb1XDrFgo4O7Ro65AUNZlzYLP85mdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ+xJyCe; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ+xJyCe"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so4203104a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 04:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791460020; cv=none;
        d=google.com; s=arc-20260327;
        b=amSzzrKIjXSQBUQHp/cYEXd2gdJ811ZXRja8BJkBR1In1nXgXHg++qKDXDAwdlmp1C
         L+KVAYmmLT/azH0QC9Q5evyyj2leD4TjJxhlvfU2BJJjGRf7XHWOZJiWuQt+Z8Sj77q4
         F0tHyFsDbq2oONpFYJ24nHWKNDptRA1Bt0xeHG175jGV78V5t+zTZkX3A5kYn/myK63T
         kMyoAxLBASVpMpKpjHxsHpsJudMwgpg0RwvElZmj8oaWpIx7nARYlgH5kFca/vlfaneT
         e7gr2xQVxyGterHtoUicPJp/PB2PGwwIEWv8VndOW8W097b4kiqoAzuetywaOLh0iy64
         9YAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HscJ85yNflaCGUtE9aXyJSmi4cngI9gxLp0qRPoZO+s=;
        fh=e/j0zahr5nVbPw5EbgH3pEcL9lPqm6f4BTWx3zMOdxU=;
        b=kbzJgS67jXSUmr2tBdu3uEst0G+iA7cj1+uv3z1aQkhTYjaVTiWTg2l97IPfsTozpb
         ei6RhZgpRhDsRJJw9/xV1OedIy//iXoJV/k9avxrDyNeZcvZGbrFYP76gTyfJTw5NU6i
         TLPWQwQjRIezQXDEj3gPMg5Kt1+OjcNknYlW1fuRGwkA6dcF9xTMkNqGv3XiRIY09S1c
         kMXyCcUviOdjnZQDYReL60x9Zs2GGxz/A27fh4BrLX7SlD6SC13kO3hiND/tXpZp5rEV
         1CUiOpyjPiRdbuuJ65CVDiFcHNQLMl7yT01NzIichwtHSyL3v7K5YB6hCa4nSPefQiP5
         r1tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791460020; x=1792064820; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HscJ85yNflaCGUtE9aXyJSmi4cngI9gxLp0qRPoZO+s=;
        b=jJ+xJyCe4sdFEFE87hvDAcuIjvOOICouw0tpcoas3kR3xM74p1X5mt3F++VUrSowg2
         u6IXFVU5R/d+CxETV9jhxc+ss+XU6Csp0lv0WGciLm/+0DcgYR56hBii8uUF77eOWKkZ
         wpy5Fy27mC3i5BfIdra7036TEXjquXlfLf6FIywDTnMRwMnKDazdbRhDSzRvcH6ppPpu
         2F8KXccxE+j0E9fOikO7mzt3eV4VKOhfRoEx1Vhhty/AN9OTcxlZW/uLl9V1pGikUUCN
         EcYTJZRFMrM0Y/bFru8LcnDABV1zrAn87yc7O2NJQEcchfPdEQyVGa3B0IOqiJ7dknCV
         fGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791460020; x=1792064820;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HscJ85yNflaCGUtE9aXyJSmi4cngI9gxLp0qRPoZO+s=;
        b=pbmDPl1ZH1rHq8FsQbgvxTaOUadbKg+SDXXnwWIr8LyktvKPl3J4pFNhLobD6DcY2m
         yRSR3UGm7bszn+lRcX1cbDtEynNHP4YQ5WtS8TSACELSYssio8V0OdJ1/3QjpY9WSQjn
         qsOWAaws9OOwBNGJWsdZKETg0dW8ujkl74FpZTuc7Cu9d2glP7UIQuwAUY2LY+/joZ9m
         fWIebeipQJ0SI0VQxPVVPvLp+SNiFiJsooA+zwSU6DHNqwvXiWylFGvspuSGqWrnXnTT
         oOx3l9u7brHAmf3M69TmbbnZfshyEMSEiX9ta5mSYMZaADdi0XARORT98ctjZRMuTPqS
         yFzg==
X-Forwarded-Encrypted: i=1; AKwUvBydVBeps9fKcuyUvj4WY1AgC8kmuXQh6LQ5PEj01ZhrV8jkLDP98CWSlrKSR5Kl5Wp1/UMoxVB7N0De5uIP@vger.kernel.org
X-Gm-Message-State: AFq9FYLXGOkLwynzgGlI0KTJPZsVbn4cu2V6e1/MKpOHqNrpm9kS0bip
	rmnGfu0yxUvjhuqnCYjmxwv11b/wsH8p+5i5zoM9zXGhKv5mSvmfIPEi2dvACp5CaSgRWi7wMKi
	jazAsCwallzb8nGeZjtEbwIBr9T9nGQ==
X-Gm-Gg: AYBFou1yz9jDeQvHjLvYbO/XRNMnBL0LMcizMSabp8UKk66iXyh2fxi3q4V8z2VJrdU
	syfIkQJy2EKyF4dLLPuw8Ys7pQKEJX8ENRMfgXtSvdwtC2Yu6pmysKG5m9dlcGjmCs5CHIAAxks
	1GZVT35uHcnWky47F0lnsVf1No5Ky7IWf3+1su7n5yJRt16KkuSvkKUlhjQIcfei8EA7OfwhNFU
	N9UGDrxx2Jpyyv9/Wi0KxM7uIxIS+8IRWDsbztVYU1wnj5b4IfF9+zkVBFV3lXk6F/zx8F+sP15
	9PQHK6Aieg7vGeX5f6/mpZ5wZz93grfclzaOPLR62PGoKoYsS4ZLS1jyyhvRaFD+lITzrwSB8VP
	/d5tTiCseCk/cpI9vqtOyAl7IG5pvTHGUKCq+KKqyxGc2o5iqX5/ftcBDP24Qprs=
X-Received: by 2002:a05:6402:a0c6:b0:6ac:980f:315b with SMTP id
 4fb4d7f45d1cf-6aff4591ffbmr4517486a12.22.1791460020083; Thu, 08 Oct 2026
 04:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924100032.2733101-1-hch@lst.de> <20260924100032.2733101-6-hch@lst.de>
In-Reply-To: <20260924100032.2733101-6-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 8 Oct 2026 17:16:22 +0530
X-Gm-Features: AclHuK8vcwC-F7HYofed39vmarIL9j-KUcWwNdTgImZwbLqxh0Xib30p2nmAgMs
Message-ID: <CACzX3AuHPCbqDPV3hMxkE+wZfcPpaydDO1UVnC5Y9WeA7ym-DQ@mail.gmail.com>
Subject: Re: [PATCH 05/21] xfs: introduce XFS_BLI_PREALLOC
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>
Cc: Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +       if (bip->bli_flags & XFS_BLI_PREALLOC)
> +               *nbytes = xfs_calc_buf_res(bip->bli_format_count, bp->b_length);
> +

The *nbytes assignment here is immediately overwritten by the
unconditional round_up(bytes, 512) below, so the PREALLOC pre-sizing
never takes effect. Move the PREALLOC block after the round_up line.
