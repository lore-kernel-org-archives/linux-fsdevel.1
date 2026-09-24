Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B03B71A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262843; cv=none; b=Xq6H3LKm5SK+Lk26rPxC72Rz6XVYGh/r7+4fhiLXfeV9Mn3GZ7RAYuVzjCVgFHfUy2WnLyfOmT/bE9neIKXmqWz7EQooRUixPLFXiA0eBk7KnhTGY8L5v11kK+qhNq/fhqq0BpVfTqPn3Bv4ww2saisoK4B9QmOWy9LIAHtn6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262843; c=relaxed/simple;
	bh=x1O8/O2UXdG8bgbf8ctl/AqJuBGjqEjvoL86ZZroXeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYG2rK4DyOWiBddQ2fD0lK8fdCEPrBfDMNK2kCQ6XFbchKEv8/zQ6gbc9vntPmJFNkAKCkbJJWoI8vT9zZyjY8p/BoxIKzfY36UcGgu6lqdyy9hQh9TYgX+7dkBzE3v1psiz5OsXXLxb8djjON9oOk3Uwr8rLcHlIQTN6hg4t0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfJZ0q/U; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfJZ0q/U"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so1239408a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790262841; x=1790867641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBJqmeamutokU7TdhNuVh/m8OPs/5xYX4kjIXATZEUk=;
        b=QfJZ0q/UymG93ySIV7S/xeOlnNyoe9oKiJrMnz/fJO2LsMAi+PEPNfMqvD3YTRxkeS
         ZW7zqk3sryzhVxJAL7QAY3xmZkU6cIioWbMP6BwMD3psFuJTtz3TP6OazxDqQ9EkEgR+
         hTMkOGDzks7amNtjt9IhFnhcBbIF1zFY82G8hAxU5wKEZA9LyJqJw8DU96C4fUnvArwV
         /+8ew6uA9DUMBdMxxzvYERCfLeidmN3JiDjqP9eouilZ1S4UXjCwpusvdb0OozSkLm2m
         zMANra8fJrY83RvzS2Yl78v8JiDil/KadZ4LlrReyDI3fMTGMLpUv6Uz7G/Fb87ilbnY
         GvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262841; x=1790867641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBJqmeamutokU7TdhNuVh/m8OPs/5xYX4kjIXATZEUk=;
        b=oB8TM8/nv/4MGlXvjlvJLqSx+8XyjkB95Zxx7fqpDbbrbmHvMyu39WIbHSzVVfS2Bb
         0OgsgQ2QmB7d55T4aUxIxtRtWSqDRjIOdq0VrtYdw2CTnbVYWXeeA2W09zxV6DCO99pG
         xLep83L4ma40rvH2OvaPmF0uKb5s5o2YfNvKYOG1KUHkCRPlTlhxUeFkDcIW2nLIPXhI
         OmuRSEMW2e95/dZj6JYYklPjj276RNIY2fCaGfwv9XvuM5HAvJUnA/oZqX0dSiY0fHV8
         a6nOWpu2GpqGk0ifjvPeI1K3/TaVeAc4RElfpawaAOcxyfq4vWtXTBp1l93ap/d4oy/u
         39Fw==
X-Forwarded-Encrypted: i=1; AKwUvBz9WB8sJeFWvAQzRmnE6ShS6PnCWkar9d/wHIWnovlRr/iWFevxiLEgCjFfSyw9Qs30FvzJaokgCKzyLEeB@vger.kernel.org
X-Gm-Message-State: AFuF++mLQGdEh1uP33ss3a07b6ZaW51f7xj0OsCQeCGH9HWoyQFnoYne
	OBRFdfRr4VdQN++0FZjireoII5y62lUcPwjgalQup0cXrhFoEZn868NF
X-Gm-Gg: AYBFou0KKUc93jeiKaE9HcChkg9plQnS7TXmVeGnLOZF6kZQt/7g8RgUmCgX7cPlvvJ
	HH/QSLXi9y6KpcLO61Tj2mexMT0C43SvMaas8YRR2uoaLzFnnCqY4eRdXdOwsDik2daa8f6/W1T
	w1cU058ZVc+BUIu997FY0WziDyNrxTsIOJ0eq4SUXXvPUiWt2ch2Q2/i9nG6pv9HXDR4yrt+esQ
	C2j0oUhoxI+JKTyxec3cGhyB9TEMhbqyj0eo6Wmmj9f0HtQ0fnS8gRkFPvV3VNe5qb8UATdl7Pv
	VQybOaJOGV/IWhWYB1bn4BCpk45EHQrLc/FLNT6kPzZcwm3g2bRCyIkXmDmoaZwYuqhKECjbXql
	zr1i5coWmdbZjiglKIH++aGouXpJV0POck5Tj3+4Fc6kdFYMgxk3Uj7JRkqBKZJpkmv5h2T4Cga
	tcBwBatYyHE5/Q+7B60ykol/rm0TQniTwa0aG8E+7syk89kivI5HWCWtkzgkUz5uaK0F9+Hm/Im
	irNDC56fXFEAqxPv9rcCLThs5g+5rk+mxm+dwgjHXgXdV3BgK5WDBzdsZoyWPCoRp+UeRLQWXQe
	z3XainjfIMyFl8JAMpvSE/rtQQ9LygKBQUebqAaCfO4gBsgJMvQGKPgPuzU=
X-Received: by 2002:a05:6a20:9144:b0:3c4:3321:4fe9 with SMTP id adf61e73a8af0-3de0e70bbddmr2888071637.7.1790262840675;
        Thu, 24 Sep 2026 08:14:00 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dbd1e2asm3234800b3a.44.2026.09.24.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:14:00 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: jack@suse.cz
Cc: benquike@gmail.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: reject short directory records in isofs_read_level3_size()
Date: Thu, 24 Sep 2026 23:13:55 +0800
Message-ID: <20260924151356.3287733-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf>
References: <20260919222553.3792320-1-benquike@gmail.com> <20260923175215.1577791-1-matthias.goergens@gmail.com> <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

On Thu 24-09-26 17:03:50, Jan Kara wrote:
> Based on the standard empty directory blocks are not allowed (there must be
> at least one directory record in each directory block). So I'd perhaps just
> add checks to refuse them. Then the limit on the number of sections of inode
> description already present in isofs_read_level3_size() will naturally take
> care of the rest.

That's simpler, thanks.

Hui, would you like to do that?  If not, I'll send it in a few days.
Either way, I'll first check a set of real images for empty directory
blocks, so we know the check doesn't reject discs that mount today.

Thanks,
Matthias
