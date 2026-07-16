Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B653D3339
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218205; cv=none; b=bCJQP5/YZI6IwTwKwzbxYMG1ZkM+e35wqzvrH476ICO9ZjsCj6QqjFLKs59Wez65r02+x+7dP84m3IaClM4odrbBx58iCdx8hCya/heouXOP7qVZlNu5Ts9yNMOH7mbvHGP7HoMTjn5tn7oQ/pyU0MLCQJ7E8eU59W85hVbvrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218205; c=relaxed/simple;
	bh=UVhKKImv/XnJfr8mwj/45N0a1YY0W55OEUXatiKiLD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFIviV1jvaTHCefKJdaxvGKqFW1DNKeckum6wzS+9243Ng7iOWIkG19tkeqBW/kWbrfTjX3oXszZ3bjzd3kM8Mvm0VpOJMowLL/ehdtNrAung3Hz6OAp2F41Ok/+ZXB5PSD6CwSkxspHXj+4HkiNcldbOgCG6vElxqclm2NRXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=op17IE70; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op17IE70"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3847e8b0f3aso5522081a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218201; x=1784823001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7GjoJ0D2ln/bYYAD1HiEkGDMJdf9tcDcPqZY9IDoNv4=;
        b=op17IE705zdlyZbCsG14+l65nI4JdJAj1a0jYI6Oq/fCowlFy4B57Dhrdg40vZpe61
         lrUwN4BVbRLx1k4cDJ3vMPTrRk8ar6t2pZG93/xKd/lwOG3a1OxsHk/ID9dNvC81FjlI
         j8Y45hh5CcFPWau4/lX7SOlQQlmwbIWYjUs+ku1FoHPHwCR6AT+foO/Lz29bHykL0wqc
         nRR6YLv/MUOdQnu9LC0zflEvNz5F+u0xd7CNktEAkhvEgwSAkype+2z2XUyPRvUBtrki
         Vwe/tOSnquUyBIyL2ZGsCO372JDzswPsToqgsJK80Ad4WlmKpAlFE3eCt1q9wxYeOTCI
         quwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218201; x=1784823001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7GjoJ0D2ln/bYYAD1HiEkGDMJdf9tcDcPqZY9IDoNv4=;
        b=cnLleUJ387a8zltqXNuj8Z/a3YgR6T9VE7qrebnL42sp+602RVBa+Kqthp9zglFM6i
         OO1DWu1U7OAAO41SWFC3C5mvldBj314kFmm/v8nS5C7uy/W5OcK0TkXGtAVjx1mKYCk9
         +OcXz6Ydd3p8IlY7oz3IkHudhP4lli3Z3CV3A6pQwPlPWV5Z77hVzFrro3dF3XLvV99c
         7Be8/+M2S8RsX40fqKnvGO+wTdU47wqWphFo/GCOv0inTcCqAxIep9pjDp2q+mON79mp
         0CCiz93ski1R//oTW4HxyAZ85ZrXF6TDWcNNUrPfzlGeRl4pUlM9zEc6FvQb76DBe80h
         3tPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpI6pT8pBbR80K+6OwBwMehl4u4Iwx+Nc3dCVWaBaO0twrVN8dbfQb0HLSx4u3uRUgfSeka6l1+x9yMBnTU@vger.kernel.org
X-Gm-Message-State: AOJu0YyRijiQP0vq+zL/2UA/vuzwMRIHoq26FMXHFKw57rXTkVvDI68x
	ucPlh10axTDhXwoqp5LUk0CaU6qRj0UkneWS8f4PWxao5LPXtGd/SDhy
X-Gm-Gg: AfdE7ckzOEabIuwYe8LgIWuD7EWI9ciSuYZgAdTTOeuZ15p/+iPUJPoXwaD95Bl1pav
	4vBycDOU9HXh4WboJslwqhRATGcWqT6scge9oKieNecFxXLsq+3+Ltf0YQP//3+Um0OJi2Supsn
	YdYgFqa33evhELD6qrOw0SKiQsBDlbiNfA7QhDwK+S4Ra/qRMAqsV/GiBYvUuTPujyW3qVlZHQ+
	YTrY2iIOsgFl1x+U49+teclWCd23V4aIIQjuXlcy2CF4HfzjFNA6Y4WbWoOdo8rIGW3Kvt2Z03z
	J0tL4QSjHXg6Ut0L4FA8j3PKOYoUQM7j4GqQLslspPOl0u3eDhQ0DMgznRwU+KB1d67QHvIFWV6
	6S6mOa4iFNXAcNkER2EfG+TinGRVMZR4Z7CN37LDmpydZs1jQ9lYhqfYdpuwnGVPMoavr79ZIoZ
	EpJpKDDaQFSniTva8OtUO8Wep83LUY4/qQ3yRIv8Sn1zlfxwg3YPdxpsY=
X-Received: by 2002:a17:90b:52cd:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-38e29fad10bmr6467740a91.1.1784218201476;
        Thu, 16 Jul 2026 09:10:01 -0700 (PDT)
Received: from fedora ([2405:201:a412:78a0:40cb:342e:9c1b:a9a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd26sm12318446eec.5.2026.07.16.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:10:00 -0700 (PDT)
From: Shivank Sharma <shivanksharma2376543@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivank Sharma <shivanksharma2376543@gmail.com>
Subject: [PATCH] initramfs: fix typo in reserve_initrd_mem comment
Date: Thu, 16 Jul 2026 21:39:44 +0530
Message-ID: <20260716160944.1331096-1-shivanksharma2376543@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a minor typo in the comment inside reserve_initrd_mem.
Change "virtul" to "virtual".

Signed-off-by: Shivank Sharma <shivanksharma2376543@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 20a18fcda..55c17c8f3 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -618,7 +618,7 @@ void __init reserve_initrd_mem(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* Ignore the virtul address computed during device tree parsing */
+	/* Ignore the virtual address computed during device tree parsing */
 	initrd_start = initrd_end = 0;
 
 	if (!phys_initrd_size)
-- 
2.55.0

