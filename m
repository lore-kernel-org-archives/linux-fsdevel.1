Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99A2DB790
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759182; cv=none; b=n9h4RqvoSfktVZc8hD9Y1xGJgroTgA4vau0qzYg1R2luSLJLOoD+g4XFkmQ2LEhrxx94Cix03bZMY/1C67DiD1XWHLN64SbiZxnnK2tCVkp299W9vcQvO4qvf85RcZ6ogYzakwj9AOfiT1JVVXZr9RNSDBjSjguNI9DU8Gtu2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759182; c=relaxed/simple;
	bh=o0BZD9IH6Wm9LA6FZVKd53wx5Xefp4azSHsYymlHjGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbGwUyjZ8lT3GznhlyVt0ff7YVVs+iAeC3EDPnLjoY+h+hAa7XbZYGpsTv3s10A5B9F3gq6g/dTuHGN+ym2ByZe59/uHUNDxRCwgyJeUzQlpNWK2cARq4miN2xwH2/nrcSsEHF8kROE3Bk71pUvjDoWCuLyeGh7RRSLguReHnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfQ/ynZM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfQ/ynZM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae527552acso18734725ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 17:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759180; x=1773363980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I91urzijcMU38q9iUTwuOyHJ4IJ/Bmb2eihr6Jnmw6Y=;
        b=HfQ/ynZM37UvSu82shgSdt0OLeYJLMs38gHlKSNJ/0lx2xlUq4/nzqhQiePMxrCWHG
         hGeW2fNv2E3yqb9wbVfab+5iTj8LW+IbDpys2G0HXVpjbxmxyFCHuELWvfDahTeOCvQY
         e033VXyCHxkIj2WuYkIVfRVciSvQoyrtANzCNeq79zlKPpMeiAbSTmMPUr1StpKoNLbY
         U8QmM3r7vug9jCjveUFmqdROJ80GSkm+kdQNUBU3Ou/aEV1ExV2XZSeZ6c6IjDFu3P9g
         /diQHlcR0CgQMTfFRdFK7QmNvDaOQs1CyImr6khUwCMp+muPyW8zmhc3c50aGkxL7TQw
         Xqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759180; x=1773363980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I91urzijcMU38q9iUTwuOyHJ4IJ/Bmb2eihr6Jnmw6Y=;
        b=HsMAXHD2YjfJW3WyhvQ8Cs30fDZDIdlOfLz1QHg7o/qLtwW2iD9QzQat7RWO4a3Qu8
         uavLJBX2MGLtQBRSpHcYdLP8EHPD+vlG3cgG+UT8aJYU5pp////TG/NWYxJVVl9g2H1D
         Y6xDfH0Ss+mQV3haa99Xbgyq/siIEO2cxiWyWE79eWKGFbZA0h8yegn09/3/GKe14A1D
         KgXeE3YQJHh0mNGUK1UUYxUzns+Gwl5cODO6MLnCLjcVpI2SBjgSpngvlI8XYjgnxo71
         JvyX86uHHnN9gWvlFDY9jqTaCSuTz0rm+DSj6IYHPvxhvJg+FNDbYJNOKubWjLOfpI1O
         E9yQ==
X-Gm-Message-State: AOJu0Yz1UKhEtSwGaDo7cPYDtTOcMMVjH+9J4sHn3/amrQci1CtCrjbJ
	eyeoG/4FjXyCuNP/iUlPQQKrKJYLN42nV1aT8izUkV9Zo1cyD2PYl8ekZ++pHg==
X-Gm-Gg: ATEYQzwb9HxYcwmQasrVTQV98+minhWgNFxgK0OVgWF3OBGW3ohrOywt6hLr5xDtsFC
	8P6QkcjWekGknIpGjIT/EPJ9SBzERIG0pV2aHgwcLAN+xczWCaOj8Dqyq58+vvSnjzDK6o9A5ns
	McawfcjS8CQQa8f+PzYGWeRNqhzOWFRwp9ynkaC2hEazPU1EZBiYhphJWfttKdNSF1IbTy4t39w
	nDyEUZxbUXuKtdR1dp1x6inWLqvV7Qmpj0WhNjeV18LEdmwnQ9TJikTSomtrIQdV7s2fjMN8FcR
	ybcow0enMmv1BHsoUAMXngQzQ9vG/gdysYacNM6SlPi00LwrXAzKJaYcNTses5WJQDNqfZkunDb
	iud1CyCiQWLkQqkMoT2vJ4ZSwwBcOQ6Q01JP937ONW8uWXd0K2yAj0osM7OzdKYecUR3kuBJLsN
	XiK24aqHNp2E3raixz+g==
X-Received: by 2002:a17:902:f68a:b0:2ae:7f24:27ec with SMTP id d9443c01a7336-2ae82512971mr4782715ad.47.1772759180340;
        Thu, 05 Mar 2026 17:06:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:18::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm5480831a12.20.2026.03.05.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:06:20 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 0/4] fuse: fuse_dev_do_read() cleanups
Date: Thu,  5 Mar 2026 17:05:21 -0800
Message-ID: <20260306010525.4105958-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains some minor cleanups for the fuse_dev_do_read()
codepath.

Thanks,
Joanne

Joanne Koong (4):
  fuse: remove redundant buffer size checks for interrupt and forget
    requests
  fuse: get rid of err_unlock goto in fuse_dev_do_read()
  fuse: remove stray newline in fuse_dev_do_read()
  fuse: clean up interrupt reading

 fs/fuse/dev.c | 55 +++++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

-- 
2.47.3

