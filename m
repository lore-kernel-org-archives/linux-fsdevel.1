Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B944307AF0
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968595; cv=none; b=Y+IFUWldWkK5/R3xG5rBIeis+nnzP6xgdY4zgULc5p68/1ugM2DkDUo18U890aKZkYITg6u2S27ELCxBHqJlWXqsu0VD6fJRViher3gXVlxJx23ydRm+/ZFexefFMErxpzJlGvNkqQcL2K1fjt8MLzjyn5FdJD9gDp9ZPCpY6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968595; c=relaxed/simple;
	bh=qDlcsTSS0i/a6koK1dHpA3wrhMr3nawQZ2fGug/ix58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRDYhHhi9IHuZmG/KRZYjTapwbmECxGeOt6xVY2q2VevB1Ckh5wz/QfadFFAkWDxE5/89RAzRARnV/Pd5ewO36cdS1uBDFWPcpQddHzT7/VKZf+df8bd+syADcRaFRYwdKFIUEMnier0xJ5+lAL+ilseQ7HyTNZuwJvWX7jI0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=purplesyringa.moe; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=purplesyringa.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so8791735e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 11:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776968593; x=1777573393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBMP/ZPFjPbIZz2B5VSFwTj55rODg4vXIuq33RZC83g=;
        b=dvF9ClAumOQXzh6znvM0HRjttQsVAhqPJCD5z26jkCeMeQf+ucXS70gOIV3aEiejB+
         fknnuewjgjV1rzHjLQVNCIgzzdrEZGip2Ke6lvbNVCGc/39Wf27TJUfWbRBIC7kT3j8l
         AMDVAbV+OLT/DrXPhDpIZw8Oy4Fn409fYihty0Cq3zEfM/A9QumWDTGxAmlhtUCIpcQ5
         Uy7COYbP5imIZfPkCeD9qYyQf+OuYtOtdwc6McOd7muRy/1vC83DNySbb1h3ocinRogs
         bp5gmfd5Yq6gtwskQI1epHt44fNnUl2lZyFbpcfASL5/SO7b6fMK8u4LSvR2ujrn2tZj
         XDAA==
X-Forwarded-Encrypted: i=1; AFNElJ/8BjvWlP2UKPIc4Naae7kI9lWa8k1/T0pGNGLB4WKUSotbJAVWVdfIGisPoeg6MFOjVtaRlvEOEitCNcc1@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8R+01w3ovSTEoScnSuL/+geoDjYZz2p0NYUblOUttEs5IbAf
	NotXtnkqu+gwg5aK+inHQRYE3Ffy+saDb7i8ObGXjDs2thM/lEYx3pQB
X-Gm-Gg: AeBDiesImN6pX6Tq19/wCFBsJDvV3Ms1jHi8bZV+BIl8695Z8+jIvKXaZKNwmqzlOO7
	UpQOcPwO9Zeh1i9FZ2Oak0ql32YuMNTggnNgG6gpYAdclQN/sriPJu0sQEcluvj8NkqsuOyA+7p
	FWPoCRNTE7wmbebD83uEJjGyqkqyWL0zx2LLnSZUsCCi40h+UIebJZUEoM3Gmn77AZatVDyfNtc
	Xqi+Zt0YqiOda+n+is7hRd5ivHkBddaglNUkxa678YzkFCTIOKqA3aEN7R9AKnJrJnMfIgJDXpG
	VyKT+GaWhWXYa+H8AhPQhCXUMuS9nyX5qncFq18sTZqi9EWQPPEQ7c97eR2Imx5O9ItDZ6Sd7uE
	XRWZ6gA/d4BsGN8nDfvuA+VnUxU8BEwQ7VBYICfc+0S4MS78l9tC/VHUuQTnJIBYFmv0kRnbVXG
	ys8jCO25VpINBqQUcUAU6jOTs6SEnTeM/SXTJE1ngQqrFdSbfgjNUl3jw9uG0LpexnqEDyeBwBg
	2nbDPTOSmE4ozmkswHIg+WLSF30
X-Received: by 2002:a05:6512:3ca8:b0:5a4:10b5:6246 with SMTP id 2adb3069b0e04-5a4172cb407mr8920305e87.3.1776968592559;
        Thu, 23 Apr 2026 11:23:12 -0700 (PDT)
Received: from [192.168.1.8] (95-24-8-205.broadband.corbina.ru. [95.24.8.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ebfd6sm5300694e87.78.2026.04.23.11.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 11:23:12 -0700 (PDT)
Message-ID: <12dda998-0e1e-419b-bac1-0863c02659d3@purplesyringa.moe>
Date: Thu, 23 Apr 2026 21:23:11 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] smb: client: add support for O_TMPFILE
To: Paulo Alcantara <pc@manguebit.org>, viro@zeniv.linux.org.uk,
 smfrench@gmail.com
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20260407195810.993862-1-pc@manguebit.org>
 <20260407195810.993862-2-pc@manguebit.org>
Content-Language: en-US
From: Alisa Sireneva <me@purplesyringa.moe>
In-Reply-To: <20260407195810.993862-2-pc@manguebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 22:58, Paulo Alcantara wrote:
> +	if (oflags & O_TMPFILE)
> +		opts |= CREATE_DELETE_ON_CLOSE;

Shouldn't this (and other similar places) have used __O_TMPFILE instead
of O_TMPFILE? O_TMPFILE is defined as `__O_TMPFILE | O_DIRECTORY`, so
`if (oflags & O_TMPFILE)` includes `oflags = O_DIRECTORY`. I don't know
my way around the kernel well, so I can't tell if this code path is
actually reachable under this condition, but the kernel uses __O_TMPFILE
for this purpose everywhere else, so it's inconsistent at best and may
be a bug at worst.
