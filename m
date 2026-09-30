Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02237AA95
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739587; cv=none; b=TPIQCLikwd+sPVx8Nt/rlO+cre5phB0/lwecIZ7/7bk8wLTr2+nIjfyCJHn5FDT/WdOeG9nh857MgZdw3gnvrE55PZHhjKYZgWBONBTwvlfWCyxdFQ+3KkurssXKZdHLoBOaO/hU1DzxmeUrmcxCEl2dFvcLNpXixkiPcsylkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739587; c=relaxed/simple;
	bh=GdeZEzx5GKh9ZY0H/ycxz2NRMTcpeYqQQU7x3wrswlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPyRZo2CspEjI+9QMnLkPbZ1cjtWemSmZ1zaoU68j9OuTwNi9DGRdShITNiG/budpvklOhkXM8coO+jJONwG/we1Z+Zgmqa0ls2/dGGDU91K5wv6zg1R0X79l4UnjTF4Uhma9xvUvIFYGKGY+8ji2K5sCkL84mobX7/lb/T2lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS9mc7sR; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS9mc7sR"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso2145424eec.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739584; x=1791344384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ia9CbVKKwRCU5GzXWGPkLwk9XTdQTUAtoP5YeQIZPys=;
        b=JS9mc7sRfqJC3ziAg6EQXugbPKZVKdueuT8W4aUSgx7VNUNlc9Zsjfzik6D78Y6ylK
         SNO1qXgeYlkiE1HONapM6GuzDy8JvGbg3TEl15cR6bkqTKMUHxGGNW7f8K9eZoGNw05e
         yVZZi9EjJaM7LOUMITfuDxZFA30LZOw0cgdPttFX2VxOypqGj66do0AiFSpXdKP755pZ
         ENiHQtNJRN2PZQKjjDLVK09/ZkkViZRhqMmreeHzCBd18qR8j0sM4VcmqgbpJCizMOOM
         vuuc44fOTNPsvZ6008OsNgt4/NBjX4zXhN9Wiejc4ACk2unrkGIN7sHZ2vjJ/Faw+lsO
         sVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739584; x=1791344384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ia9CbVKKwRCU5GzXWGPkLwk9XTdQTUAtoP5YeQIZPys=;
        b=1XgTuP5WrW7RHsATdaBNpH3tj7Q3xuS2c0dUGR2+4l/+kHMMSjzODL2jB4K/c74Rxl
         ri2WkMpPhLokR4us38dR2KvJxlVTLawixlBUa5TYKQGB8AAdqFTPMfsM4VOBq9o/IoL8
         ze4sdKL6/KyJH10/ulxxaXKsdc6XgMWuPf2FKvDTn3vS78HhveFTEttgfwZ0Zhy2YJ4y
         BsHwlRrOzaftFoMhJulBugO3UDA6F+MCly8gVleZ+imcIfIR3bulx4J2IzutTtduusQt
         uQX5epBjZMSQBeG2TyF4OLEaFu3NEyFxUhp1NmblqGIgVmeX9iHVDgoE2ZB8BOLAC0H0
         wVKA==
X-Forwarded-Encrypted: i=1; AKwUvBxNddKKSVStCyrwDlspGGPdWJUglHQ8PRtpKBH9IJBXwv4FWXzAWeNLjnIzQTwct3R9517AsHXToiaBqvQF@vger.kernel.org
X-Gm-Message-State: AFq9FYJoaj9uz/4eke5CftX4t3OawGXpVqbZEr9fd9HLdDLP+Hvm0HOD
	hATrrp1IZsBatfeUcrR/GZuR60an7RBwxzPMD14gmeMxUWtu5Zica49D
X-Gm-Gg: AYBFou0ZcXafwvM5T8Um+4aSevUAN6n744zhZAG5RDUlwBMgiUjCLFdr0yGrXe2hsO7
	ZDA6s4XxlOCs38755Ur9YE9qa3BASk10ytNYf4WiA8Mxz1n/g9hqmGSnvuKBEpM/4ApK3+JU2eI
	JphlNkln4HyY9NZUTop8kvcMhc0lliDoXWdM38au6EtU9sBFVDf+Sn+RDhV/rAX4FUYoF0NmoQg
	3XTemDVpbGNEjmEHCHklEXgcHMX1++Zf04bCOXga1+2Ia+rOqS9xUBFP2U0h6cv8J/dRvAErzqW
	c5ss84e6s4Q8xjoqiY6cbG6qvOoe8NDKN2J0kE890kEicZngo3785fmyIsNIg58j9004vWnIgr5
	UByQiAQH+CWcGfP8W+n2PyLfA+2eZEmy3F0Bb5l257SOuskajH+Ghmpbl02tTzyWX9nfiKepr7U
	eCsaoWRT8fx81Vw3dfmIc9Q0UlL0Xc4BEoEphKruehJWuMHEpaytqliGZIN1EPRbsdjwYYqmUG9
	zbFrvpqYXV9f4tpGwY5ewLbHmifxTStfZD84tjs9+lQnWhcMU/25MF7JHKO6m/fLdMNQqig2b4V
	S8gD97cE4zVI96NwGzTNQfFUbtZHW/hEL78lrnbQt0iK5v8QAgkuH71eELA=
X-Received: by 2002:a05:693c:66c2:20b0:34c:7e54:65e6 with SMTP id 5a478bee46e88-34cd91735a2mr336022eec.5.1790739584070;
        Tue, 29 Sep 2026 20:39:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf22fc6cesm252806eec.2.2026.09.29.20.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:39:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Hui Peng <benquike@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: bound empty directory blocks in isofs_read_level3_size()
Date: Wed, 30 Sep 2026 11:39:40 +0800
Message-ID: <20260930033940.175021-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cm3n7vjwbdnafttuz5ftkzz5wdbalgews4dfs5zlwvkyuzotuq@jo2nhsplhstc>
References: <20260919222553.3792320-1-benquike@gmail.com> <20260923175215.1577791-1-matthias.goergens@gmail.com> <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf> <20260924151356.3287733-1-matthias.goergens@gmail.com> <20260925043804.2091174-1-matthias.goergens@gmail.com> <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n> <20260926083517.556576-1-matthias.goergens@gmail.com> <cm3n7vjwbdnafttuz5ftkzz5wdbalgews4dfs5zlwvkyuzotuq@jo2nhsplhstc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

> Any reason why don't you do just "++i > 100" here and completely
> remove the empty_blocks variable?

Yes: i has one other use.  The "if (i == 1)" further down records
where the second section starts (i_next_section_block/offset).
Counting empty blocks in i would move i past 1 before the second
record is read when an empty block sits between the first two
records, so the next-section link stays 0 and isofs_get_blocks()
reads past the first extent into whatever follows it on disk.  I
tried your variant on a two-section image with one empty block
between the records: v1 reads the file correctly, the variant returns
different bytes.

I'm happy to send a v2 that adds a comment saying why the count stays
out of i, if you'd like one.

Thanks,
Matthias
