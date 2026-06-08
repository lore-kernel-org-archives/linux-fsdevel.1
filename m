Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEF2F617C
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 04:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892780; cv=none; b=eYuUDknEAdqicLyW+Pu26Gjz3BKP3T/1VIUb6iASFWkqykf0ei8Iyfd1GzpwjxMhuehA41qlHFUADuk339UFzOjST4zs+TCNpWqLKlmZ6kB84MLPpPZFgzlgR/FnmAnjtaZLdCuR85LhFgceuMLGQ/KsxSKsJWUzfX7D+HgGHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892780; c=relaxed/simple;
	bh=FK66q514EVgPzk1rVgp4Jk7Gq3cD8XfvIQWXd7mXCaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrATiYFQZBQalAa2GAHQPaQgn6lPCcq8a15cVvcdupf1ZMkJXvFrYZlCCbLQsLvr7D2zcT1Fc7qUarPcv0I85D6pQMJ4SrmkgEm7QyxhqDy8pWMqnWO0cRoJ4H2VR6K5G7N2xq+kEVgjozCitJO5X6AIRhCUxCrDOCH5t06X9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P897U6Nl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P897U6Nl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so2795381f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 21:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780892777; x=1781497577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK66q514EVgPzk1rVgp4Jk7Gq3cD8XfvIQWXd7mXCaY=;
        b=P897U6NlKo5FQUQzjTy+zRuDqV0m18P6e4yKXxoQgZ8rYnMDB7joS3o7OHfgMEmei4
         /TOjALFAnTxdUNkVq1dphG62BOrzwIqMdF3ejqH2pwHY4pmq+e8vsMv8n0O+wBno7zk4
         BDtqwvTFd1mQRb9cnIHihz1Y/hE9NRLuuFmnzNm9NbTDMO90cPz8WjiOyASUnQZKXtGQ
         kJ6igNbK65OJY4XCrlU/sRAFgYkUpI1vuE9LR+Dh+oONyZhTbAUQvjFqFezEIEDoTSas
         yHFJSUfbxTrLA3b6IRVWYZ+oW1iWKjWAf/peyC/nU24OfFxXh2n8aIZs1MC+mkMVdrdO
         EGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780892777; x=1781497577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FK66q514EVgPzk1rVgp4Jk7Gq3cD8XfvIQWXd7mXCaY=;
        b=S4P30o8Q+vexHcPb05YGc7TjFuvDuwmwv1TsCLHj86UOXCxyTQFvFLYpp78oRXJo3m
         9FWwesvkLtpSH6NyfSBWhyMIASCqan1c0kqhz+FOu8Gr3kNQHXTkFUCrvi5Wu0tv77nu
         PxSR+Jvjb+wSI3GlLjH4+EWmSx+EergQUuyjYUGzs49Z2y7IF9GrAX5JEX57pyyHjXv2
         7Ump4+6VTSl1gDs2awzt2GA9pdIfYJ/rC7ykSjJdpICbCOPjF9V9JLeDY+hbgI7BlcYF
         XeX1lJedxAzQlqKCS3nrd9+by8B2VAdAb90J+vNdhMYbPTMMey6FbcN3HfR1Q9zOppKg
         E7iQ==
X-Forwarded-Encrypted: i=1; AFNElJ9s3btCXjBO7wgksKcMOg7fqQuGVaeR9grlV4Fvs/FvDfsTN5/VmKGdNi5iZKOYGIFHNaz9ArKHnO+jo5dq@vger.kernel.org
X-Gm-Message-State: AOJu0YyODqP4D0CFAlOewTfarSaeG/OfdZwi8z5R7NiM3kZgGzIU3QK1
	/9PyIqglq8SftJKZiCeRpZ227oM5OPRcmGmdqqFqw2UAHOdePmBuDl7j
X-Gm-Gg: Acq92OEnxhBL+cO+43TifnoRK0e5U+I6PMA1WJFiJIMeZ6xWHislgVUPGQSdIWEyXzU
	aurgL+G0WnM6Q7o31OgNGINEyo6v9GMO0kwGlpQgDQh8HsEcavYw/dkv17sEXta9vQ1nw6dwiFL
	uISUfl/y/51HvKRZ5pJ0bAQLXlL6tcXhtkdEBvfsjGqAGOfgytifthGGWJJL65Qyqbc1tjzsV7R
	guEPSCD+r2vtRuicJwqpSEe7AFhlUd8MYzJm8TeK9gmh0qojh2Io+ybrYbObWVqMkSqCniZqFsr
	ZYVAD5byVLHI0ygtDT93D4tfAZrbDnWgxccB8TfdZCm+qj/78T1Y1TvrFHo3v53h/MT8Rks+yJ9
	dQQ6M8psuPtFQ1MjlXNju80V01KNJoqi4WGvlnNOCQxpwWgLs3ccXrUuhuVdkdCJTagx7ClJmFu
	V9wVpXT9yd4MZA6J3bVSCrDWphxqrb8PDsQtC9Hv0d3NJqI9DdchtE7wKT9nqw6Dhpt1JyRaiNP
	4OMutP4nAvAsyHitA9MwA0mW/wRWxFKcfWXyRB/O/ihEKbeI16bTbJ3CfULfAnUXXh4wgFRLeRr
	czxLz/7JeW9iWsSKPse0
X-Received: by 2002:adf:e004:0:20b0:460:2eee:4e21 with SMTP id ffacd0b85a97d-460302f0702mr15376677f8f.17.1780892777279;
        Sun, 07 Jun 2026 21:26:17 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm38444434f8f.14.2026.06.07.21.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 21:26:16 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: Re: [PATCH v2] hfs: return -EFSCORRUPTED instead of BUG() in hfs_write_inode()
Date: Mon,  8 Jun 2026 04:24:25 +0000
Message-ID: <20260608042425.1085828-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607035339.1015062-1-davemadmaxxx@gmail.com>
References: <20260607035339.1015062-1-davemadmaxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review.

That makes sense. I agree that replacing the BUG() with a silent return is probably not enough if this state indicates serious filesystem corruption.

At this point I would prefer not to slow down the fix by guessing the best HFS/VFS error-handling policy. My main goal was to report and narrow down the reachable BUG() site and provide a minimal tested patch showing that the crash can be avoided.

If someone with more HFS/VFS experience wants to take over the final form of the fix, I would be happy with that. I can also help retest a proposed v3 against the public syzbot reproducer.

Thanks again for taking a look.
