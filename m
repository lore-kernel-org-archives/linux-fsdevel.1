Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476FD3CFF4C
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224317; cv=none; b=gmOaBssz87wL/lrrtFHN8NS2sW8c8znE1uXL9IqG5iDBZ2w4xnOnnwypP99SEl2hfo03RlhvErFjGAnh4TAPft1qIM6FCDUOytxD3jpctF1VLAdnvN+NoU3WTMqLBo/xk7LREHIrd80lcPtPfgSdYF6mUTQr7Ox9cBKR94EsB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224317; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltVO4Mytb0EA7EjRUV0MThwzcoEuRzATcJGIPZUVMnZBlKM8Oha6NoXHHpTrti+Dgwwxd4dffj5sb2G1ZLFRT7rHwIW2cS7464vRqRZcjxCkm5yKU4TOzilScoIZ2cE8wp5nMaDjr4swxrV8UueJXt5jI2B7uNKMovBmw0H+gAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6QUi51w; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6QUi51w"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a856865so743415b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224315; x=1790829115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=O6QUi51w2N9AjF6xq+I2SOxm3120l5gvM/q2UUuP8ydbXQ7W9DUrrf/X9OMrb5ooHa
         M+jIoQKT8ZrTt83fs/knotPnqrEVCca2rdOa3aXwrf9Y6+R+twDEN2AVfvexhMNwpl2X
         7KUPoPfXj9saP0Dsp0dt284l/kzv6JdUmAtWJoRPABaxiCoRtQEX43jG7iBWOMavX94v
         V6txZOdN1Z6ZxtDgsjKqAmjEkQd/25WyEmQ/5LFsmH4wprJJd5Aj3SA7wqXdUbGh823Q
         jzQGlpZT+BeE7aOWLuVlUXhlwABBDfE/wCxF4MtaskH5egE3hTOW5PjRcA4s+vHKvArv
         c3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224315; x=1790829115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=fnJml991IE2d3nzGQ7mpAWXZ7QranrsyJ6p0GlxrSQb0TCCO/BWVv++EQn5fnW+F66
         l37u9vgWhXsS1WI7g2G4ViWOkc9yicTwtK26a/ggqwPMp7Q4Y90WV388T8IZRJjJPVsH
         4OafxyAsb7/7/dQBDZGyibsON6Xsk6eYQXXljTsPU5x1Y5rBC8lB1ZjCdRpg98b15Bhu
         u+7vRjYgb+ZIvcdzqE64JoPcoahc+OLbMTmuFDLAJozPe7GDo5Jv9JpiaNqsfP1v2HZ8
         Birpoc0GHHELYmvQUYmvPaSKbOU98UWEpIWbs47pOIB6OFy6B5r9fQcuhm1DmFUsM/hl
         t8lQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2rX3HUqDRmg+s0cgoDyekt6ZjUSubZYBrSaaRbTeBq2L5/Vk9P93VooDsJkSFN8Nb8KFBdUiC0IePgdCT@vger.kernel.org
X-Gm-Message-State: AFuF++lvVetqD3oN6oBT8+zSrQSrFOU8dJU0nUUwiFvYDk9ODRaP1KEO
	UZRhwUKmKf3H/7jnOivqKtFdwx1W7RzP99qgmIIQnRSgw/PFcFEPlRMr
X-Gm-Gg: AYBFou0h40IVIGeUvMxFb3Vi5PF3E+J+PuQT2TP3ADYRAEbcnGC3dd2lrwNwRohvt+3
	w+scU7SdJBBz2CKZamo6D3e/Jcx2vZtBT6CT7wA5H/EBH2lmlUIEtu2R7lBfVfzEIjdGEaKTEpZ
	4wEVFPel92XP6oofI0cG9pM79lTFs2GKGT9Mi7WfCnf6tmmkoRdsRW1YGnjCvWqGb8paPlWo4l0
	SDChoFri4245fJz6z6az7XjuJIWOYniWnPRdyMNF/8rrGJuU5UKp2tI56Y86nSsvfZ6wXK9cPtt
	H3S/e+3lnTltKtDB698cCBKhiNufAxLId+0x8Mkf5z+mmb30JAh4EcKv1dwx/gtixN08IImKET9
	09ylxls3bzqW+xXFEBG6+0LoBIqnw0T94SVqG425euKAs9o0DI9fKNYXtA4kug/wBBafoT73PBo
	tHQC4nbDjTpdo9AN+JxQowGcK96IFSX15qRlkyb8/uSz/lIMtLMMEWuSq9YtgzeF/KvPDOL0zxi
	IaaSYXY5V79OFpLY0WOktR9o6cfePQbqNFgYInrNl6CIr7h/3tfcxiqWaeafhUm9/uHzTIll/wa
	681uN8YGeSz6+qXmDVPyAFesZAYW9esjrnwl06S3sk8zcsBL8ecxvnSvhhM=
X-Received: by 2002:a05:6a00:854:b0:857:72ba:ff0e with SMTP id d2e1a72fcca58-87e9947181dmr975987b3a.22.1790224315411;
        Wed, 23 Sep 2026 21:31:55 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1b0b505bsm2219376b3a.8.2026.09.23.21.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:55 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] qnx6: abort mount on superblock magic mismatch when silent is set
Date: Thu, 24 Sep 2026 12:31:51 +0800
Message-ID: <20260924043151.3897375-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-5-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-5-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to 1/6.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
