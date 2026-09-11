Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CC3D667F
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099086; cv=pass; b=s2Ss8WiIVIyNnCLeyrQXnBfR767OSiif2GdNOgt7P4H39pXRj1rMCCo0GHG02ysg4f8OqsH9DpzBQcG2+AadipPtpDTAgEiywBYYoaLSsgTskH3fAaK5dDNWUTA55p5RABHHd1r+yHxWxlcLbel6pnAWy5BerIQ7AieyW/YfHd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099086; c=relaxed/simple;
	bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/WNn+IleWkLB5f67QQG2HtUCZI/x2MSSf7QKNe6DmOBi51AoRMow6E5+H99ErhME8/d1VYcvodPuAZmavwp8ioQITy94R4USQXyHFBxRjqaXT/JfWvmI3QKNrSqifcLhr86ZcwW1a47CvrQRrWYHyC1MCS6tF1bdpa7zSP+Itk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMT0v5ND; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMT0v5ND"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2956d30b56so62980066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 20:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789099083; cv=none;
        d=google.com; s=arc-20260327;
        b=M/r5QyJW4RN67PbUo5R+v/nlpLIQUdMTwWD0fQs2TCKq7MS9wq0XVzvhoIaZPQP6XN
         bLelDZVB0ZwkJ4qBpgdQwpFaXzoLz8PnvmdGnfO7gn/pF+I7vuDkhCsZCLojDA7xrDq5
         xjS9U0xWac4JtEaTzqam9wWHPJso0FS26Y6fKGTeajcuIwQctmy6CDfNhsCA3E3zXx/+
         rVlWwMmoQQH+zAwgEOvIaaGdLP+E04uy87hfqDDGTwnbDTeSatFDvXJEZtGHh+n742kQ
         /+2PYkz80wIQrhdDOacBUoHDrC6RrzkO8PdygomNfPHfYgaz+zu4G02n1lgRNrpktt4d
         6I/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
        fh=hLmDePop/k8pmtj85KbIuHWda9DhrFE+wpQLes8E5N4=;
        b=I+CldiHk3dA4fel8WbF0ur6S/dJ+hhE6MvbQ5wRXLXjwpvD6he2730pitqBDGCvzds
         wCzxjScUVd+raU6wNswqnhQ9jo0h0qFweL48gb8vOJaZ7OFixxmpRe/c1kozs6LO4RlK
         ngBMBOL3NqNI8PHq/yx8Si2pjul8hXrp8CPrPn5pktV0eSa1udTN2lNJj5+DXllWjDcd
         H5MuyiMaXnLFlgUb4KyZI9a6r7Zw85zR7zBJg+ufQUgz8hw9y4jELk/jyYAEiTkhtFrs
         Ac0+SjlyXpm3QSAn2hpBkNTaQIjsk2hTs7PtLRiuIH17LpMR+OlZs376qQlHU9CBA3KX
         6Lvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789099083; x=1789703883; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
        b=CMT0v5NDPn2VfGnpcuasyIOxqomgXCrVtbNq/6TMcEWMsihAheeAzZ/wK6u38YaOBD
         64NA8diXb6jNnARj4K+5x1iT8b2cviRKfs1mCx+qBpTvU6rZ8ddkl5u6evWkUpqug06G
         +nyGxdI89HdzqYjGoW54dmZ7ehCjn6JE01jGiyFDQG77dRU+ukX7LZ81hw4gRqB8oy36
         5h9D4uWC0hOSQtCg7f+UaphcfOmdCHZKuke4Hnl8mvJqzrpG0qPb4g+CQ3+4G02fqFYq
         zaEAZ8egsoV54BXeoxB19YknSdf/45+xifKWaof7+gxAbw0BXcTa8zNDrN74f5h7Vb5M
         MzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789099083; x=1789703883;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
        b=DrswAl6L13NLyLmvTfwFJeXXSLTq5dKbaLtKCom20qtGHHyg0yeoHDUh4Oe75/RY6z
         awJhKgJs4HyH5UPy85o1B5P1tlzsotYhupi8CpNKdd430HC4H9cruacWhyXKRIj7LORe
         E87tPIEoZYrnVKeoovXDM4UFvLY5Qbv6qsmpS1cKaRE5dWlEKl+pDc+qu4yc2Fpb3Awl
         zTw8hggdEt0/mUmy4++Sce2GHvEMTw1IOMQhpoHSYEr2/Vdd/m3ZdmNUiv1CfZw5T+w0
         ibOkWD1OlPcribQAnrB/im45yWVgAPMe/rm+SHSS4+6VgwKCNeaI0w0R5Uczb9qiDlgg
         6HJg==
X-Forwarded-Encrypted: i=1; AKwUvBxnsufD7jPQili6eoJ1CdsoikgQ6GCMfiGNgkdrmHSerWQ+RkRMWEv6VLEP8HMrNcGhozYdVc6CzKe0CgbV@vger.kernel.org
X-Gm-Message-State: AFuF++m8+reMFzFlU3Zz3f1f3GM7efrDIB4m92FtWCvizzpmis6brqdy
	SbfPKlTTHFdNcmztdaXMCr8f+dxemHnsR+5eA8iGcb9rIPyDGinpL7UR3Xg+1UBfCiZXSt1Ihmi
	+p08YzwuDYPSUB94P52bVpcJa1LXFbQ==
X-Gm-Gg: AYBFou3fn2JI25vXcYSTqn8i3aF8f6AA9B6KzFAM9ld4LaBD0nNgv7a4vtIWxrRjazW
	M6qUoOcfG++SmrcbqsTGmsfb1Qo7Ii2E+OJRGF8XgR7dH6du/GaeZpPp3hZWH/Y3kYlYPnmZ5ZX
	swIznLn0lOERCezWg9aeNswPkc4vtiVZvUdXAZBhDs3L5/CRCIMcsfHVTAZisDtGJKA3W4Oew6C
	oz1TZIL7lkOoBwNJpYj89DhbyRe1dtTFwqtJdgJTh4pn1N25MvBW1ms6MGk8yQ047OU2SOlG3DY
	yPHX0f7ts0APIgWRaeTIfcclOxAPSfqLtMihqTo3SZnxNoyGftbysCvlBDqRK6ynDCdiNxeVyK7
	UsLfTgueP4hW6rfxclOD6CgYK+8nFh8heWbjA
X-Received: by 2002:a17:907:ea89:b0:c26:2da7:347f with SMTP id
 a640c23a62f3a-c29661fc502mr78725166b.0.1789099083258; Thu, 10 Sep 2026
 20:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909060924.1102037-1-hch@lst.de>
In-Reply-To: <20260909060924.1102037-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 11 Sep 2026 09:27:25 +0530
X-Gm-Features: AcwNN1VdycSrLLrtn8Jejfnce-6s5eyTxlcZ22co8XHRGHweLJX6Z-Wohcful58
Message-ID: <CACzX3AuraKdrv+VQ5MNT3XcLZiLkZVarpLY1-jfwQdcmRxa8JA@mail.gmail.com>
Subject: Re: lazy bounce buffering for checksummed reads v3
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the series:
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
