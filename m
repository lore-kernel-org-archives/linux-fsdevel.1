Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01D2FFF88
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147666; cv=none; b=AUVMtjACPatXG3XCMNRt8LCj1EJZbG7AZXJ3FaIwJFCX2cfoSCwRvYIFk+68cDUDVosr3j0kv65FipY+F84npWb7A1ZO4obgvy34tAHoKE0INxPgJ1DlWPuPodFucQBXYu+86HhFfEjplQcIfZv7yokEJmWSJM/HcTGXx2JzTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147666; c=relaxed/simple;
	bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggtO2mw22Gw0TftoWneFzzyIS4/BLHlALqYsv5qXcnD6Y4nUU7nwx9q+cRmcjemrAXy8eqipCUMozJeMjc5gAchMC0Pxf2B952+B5MUYm/reN4SQ/Fmk+Fay+KfE7gnGqBUL2JVcpyFZTzcEuWa7LKpVcnTn6IBK6tR1OsPMSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0wkHkJ7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0wkHkJ7"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a29e6110so56108745e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776147664; x=1776752464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
        b=S0wkHkJ7ORc0R3LP8RCvjc5lptWlgn3Z8vzk6q/H7+waAfTU94rW3YgbdeAx6yngoC
         n+1qgAlpMZSn2nZCIiJUck2vN2lnkzwMpFOlFCtjmoHlQlZoYkWRrPKKiHoVg9ZC0qsZ
         K+TX2mQsEoxLLMO5SxtZBOF6anFOvs666/Jw/dbzjwGqab0XksWFHhqV3sD6/wj0Yy1l
         3v8iO95x1+HK2139wF8AsyP4Bd8GH2XbDe+IPGRbplYOCuta/Abjvqw81uV8MQb9Jatg
         AYU5L5y3XplYX4GQv91ErBdK7BoxBkh6kROTPQz+J1nIHo65nX6Cc7HmMT+Jt35om7UP
         8KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776147664; x=1776752464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
        b=O4sScbH4q27yk/E/PmQ7NmQM2BSduhkI0nKS3iTBVPWaDpRk5kZDqxrny5y0D+QkEp
         GTnItz7OwjoFCRkWjX0Pdog8p9K/au5WXxep6luerYUL5iwlrPaetiubbCGybct+1/L7
         /5KN0Bfc1vn6HSjdoTvnO9lrrN996W0TJjmyea06/22myNHKhBjUmQ0hPgXpNxal63iz
         TbPNl3/oXv0Y5h24K/x5sQwgb4DeGQ0sXC2F4xvxfcvDgSycmv1HDlEwV8sM9oxADaU2
         mNzKPdJ91TW9pjOb2dpVp5QdljTBBvpl89G+3kZ1ZgTFUCh2898QZwoELeI7g0Aypcr2
         ouAA==
X-Gm-Message-State: AOJu0YzyIEzmC6rxWR5ffaIh9lg2/Ii5q9YVSGCG8MwvuUNXwEBUAAF2
	ufZwltHAMVclewqlHHeFa8WiIpkaBIQ33DIZXyGY8zSi6SMi3huGd2CU
X-Gm-Gg: AeBDiesA3bp9q/xD5P7wpdT+UdVRil9TMGofHUu6xZpnTh5Y5O9qFGc7JopnibQ5Xeb
	4NHyPrJqmU1pxZpAU15keCDiLoscnVx/Bs3thz/n9sZrR+fWV/e7tjKKt0VepXRyDZllgdxgado
	g+Qwczge30C92A3sxXoZ9tC5rH0BEoMB9ALqoCMKjSOS3NuP41LNDQlALcTiUjYuUR38jbCpYtw
	iT2Qhr2iEZ9M6Hre+Gq0OUZGo/YXv7167EBBqLOIl7SNv+5SwcHgUKF9vHCi2oqFA0JCE34lM/U
	6wDCXLU7CyZcod/0wQZP+aqmpMVFeyE0dAhIfyMCfBTqHtrHrxOpCEerCivW4qzFgaTjwKJvyDB
	aEvvyEz+XgnotiXv9phsLUUS6fUh1E1KW87znLure3apb+zDZjD6Ed7MxMhy7VKGic0XhIXYqEa
	G2U102W8xm26isJA1+
X-Received: by 2002:a05:600c:5292:b0:486:fe39:28b7 with SMTP id 5b1f17b1804b1-488d67fa48emr227366225e9.9.1776147663887;
        Mon, 13 Apr 2026 23:21:03 -0700 (PDT)
Received: from localhost ([41.210.143.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee018b34sm26347715e9.13.2026.04.13.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:21:03 -0700 (PDT)
Date: Tue, 14 Apr 2026 09:20:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: hubcap@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
	devel@lists.orangefs.org, arnd@arndb.de
Subject: Re: [PATCH v2]    bufmap: manage as folios, V2.
Message-ID: <ad3cyW96dQwBgevw@stanley.mountain>
References: <20260413204351.196857-1-hubcap@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413204351.196857-1-hubcap@kernel.org>

Thanks!

regards,
dan carpenter

