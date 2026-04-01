Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F079A47A0A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060877; cv=none; b=sfGOd0Y9Ub5QC3YNbHzU0lQYUQcrNhAJqFuBC1LHEne3b64mEjBel1uircs+eDK3EIrjo1OOjnHJ+PRqXDCJvOyWxJsUksix9KhM0r83KOk2gYnetPMnAx1xboPcHWdkjt5+2ubmWpJ6nQCifP4S7iTBQHFU6d8InPnNiZkO+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060877; c=relaxed/simple;
	bh=XAfzQTylTBinB+t+8N9G3xACb3CmQH+xFHReeVfcFrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N+qvkmUQkm3b8kM0/sMvTWdBsWLiD2vpsOwUhHHM/ZlEXz9T+RH5UqAFUbUjK3YO+CVBavU/uqvTa/FcM8Qah7uYwePRh8rG4NrGDXlblrVHoddt3dMAtmgh3EBLBRZdnI6f8vt8n9B5jv5D41q8k9tBS/9/2AvaBTUE3pTazXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC/dwLKx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC/dwLKx"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so542643f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060874; x=1775665674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4akAVyXY1f1OKBxiBjzk0kXm5QnvnmnEL585BQTo/7U=;
        b=nC/dwLKxl1VL426XftzqLy6AK+SQL6GZNsdgp8r9uGZRqxhrZT9SyRkiX6SZjViZdW
         06CL8MZd9TBzoRub3LWnoSUmYt0mwKGEcAjay5iTnFF5jadZrFatXR82xIIlgxwn3hdo
         mF6Ed0l1x0MGQFv1q1Rd3KQXS8/XiNts1bO/XOb1oqZu7ClgccnyRtcYdbq/GBN4G/yn
         pX3gPmzuVwx4eQg6uLbxwZ0Stduvzx6ZSqNBMap/BP7CLVbcqPjbKVhf5eQ0Zz37F6xP
         0mftH/j+hmstiNsIWh3JfYujdMV/Mo2CY3g7zCUiXlLDj2qOQFQkVf88+OfdUZOE1cpG
         9ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060874; x=1775665674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4akAVyXY1f1OKBxiBjzk0kXm5QnvnmnEL585BQTo/7U=;
        b=XLETF5ddoRdHTaUnPC5cG4xmDk7+1WxTTn3EXpwODyy1e2pGhufCv5Y1Vzi3Tw7mNR
         2uYBpbC68qs8kJY9NvJuskPQT5oC1byFId+SMSNVMlSn6M0JedEM/TSvS6QecMICnA4p
         r/8FvXDQOHkoLoVPLrubKaW3Dwj6W/ox2VKpsG5/iZRb2fwhs47t5xmehYkODUg5PIGR
         J1Umqj7anC7xhBUEOJzCstlipwM5CMcCu5uPlNnh8KsgkPUJZudRsGTbUWns3oo2rTny
         s+8/hToLvKxMWiCFJd0rQaED2xt8ZgeYWiMeeRNphDoQYsY9ZpRSyb4RwdYbZgEnc8Xt
         fY5g==
X-Forwarded-Encrypted: i=1; AJvYcCUFqLZVE/tV9BdWhbVlt8BHanqFxtJFfGYLQAKMIGH5eL2FXhVtYXeWnn+nmrZwE+Q/H5bWiQQUMhRzska/@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxljVxPF2akXmplJe35EMr8/SqJ5I+jaDfe5uhBjZkFd3DMuV
	mZPOyX7r/ky+1edEmxYCZJWjoyXzyWyu3NBgpc5FOIIoRWjvigteLr5JZO6P
X-Gm-Gg: ATEYQzyjhmuZG8hpZUev6lkMf8sN/NJfGjNwS92RxvXJLTmHAH/y5UgBCYV4gee9kSH
	o7ALYMCUZyf3RKcr0kpdxllgNQDaRE/wnyD9oQtZfSPgsk2e7iTsfUB+eeCL4K6cu3q1ZSMBWE9
	bUTv7YyteollXd1unEVEUikOqsMotSVOEiWKr7LQiIpnxY0fhqOgIfKpOIxR+ntzqXgoutrTI8g
	PcYWF8jDD3jDEam/qhFuRUgFqYt7sF3hOTmP3pzPIp/Lh0b3WTRmzGhqY1Zf5C/GObDFYERcfZi
	KWrrELgXRADfIVbL0StIZEJjYxyNd8uM+Fh3JpYW4q4iRpFHe00JT8yVfxoCX4OUY2UsDUW6VeA
	pJVFTxltV9mkcCJ3CxQOFjzUrtW/10YTHgBnM5a+0PajkMsWo0YxcA/xH1M5Gc7uuOPjDKZwP2E
	ys24WE0zUGWMm26xgQRo01Ob5RyJzo0wwdUobW9dXOtScF7F+t/UHt3+geWtHqfSqq1K0=
X-Received: by 2002:a05:6000:268a:b0:43b:9903:2ba3 with SMTP id ffacd0b85a97d-43d150fe95emr8166544f8f.33.1775060874050;
        Wed, 01 Apr 2026 09:27:54 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-223.brest.telecom.by. [46.53.134.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm878781f8f.31.2026.04.01.09.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:27:53 -0700 (PDT)
Date: Wed, 1 Apr 2026 19:29:40 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel.vger.kernel.org@p183, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: require verified birth date for file creation
Message-ID: <895911a2-f230-4685-b386-e83802ddb747@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Christian Brauner wrote:
> + if (age < 18)
> + 	pr_info_ratelimited("Process %d (comm: %s) registered as minor (age %d). "
> + 		"File creation will be denied. Please ask a "
> + 		"parent or guardian for assistance.\n",

The message and the check needs to be updated:
1) 18 y/o is obviously country dependent,

2) U.S. has this notion of "emancipation of minors" where a child can
   become adult in legal sense:

   https://en.wikipedia.org/wiki/Emancipation_of_minors

   decoupling biological age from ability to act.
