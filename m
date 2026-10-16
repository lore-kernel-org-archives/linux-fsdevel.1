Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360938C423
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151556; cv=none; b=Gr04xLUGMYgEG4B3cVVzhwma3wKHi3JHXDnHs0Ks9xqUcrUewL2PJj4mHYwYvxYk0dvNH9b/4XdtbsaD6MqPMYkgmMx2yYLYPXpo8GfgoM++YqTtsbo03S3eyTI46+zwicvCTtfDQizPdyJ2ntoVJiHoDstcakXaeAkjyq1Qz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151556; c=relaxed/simple;
	bh=d9G64pB4fQsDosXmi5gxtmcIMh0MZcXAcfkKy1mG1LM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eDMZq3DzWulQiSjgka84ecjo+OMKcVYDGSw4erYNL8iFEbV5F0ZzIveAnoDGYo953V2eZSE9NjqhpyYV+Maq+zwnM5/Xaf3XAN8KB66Wnjne++lK8crtMACuuwVXMhpI82fZCrO9iav/tROXwMmxpvbonDIeUWGBYRwD9YaM+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K+SYItSI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K+SYItSI"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso1236786a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792151554; x=1792756354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXYDFkn2ySA9cGPfoqTWvjPqTd4qZvAgRBnTI9wDoKs=;
        b=K+SYItSInblXGjLC7dkBh/TzRqVRsKmcSzDGPo0t0c6Io/S11HdoNmzXxYEikGZAuZ
         3jsqyMtTXauUnMmKo59yjBHb7f6MyBO4RO1cOcIUNHql9pWff/WL5bWqozJfA7E5Cjzo
         O5DpFBUq+3BK2keg2xP5y8UpTa7D2ey8DNj/ka6eLX8DvrhZ46Axy8qL5YaaDZDpROHo
         jPrA0ece1CFr9cFbAQDfWqqStRzjzWfJHJ1ILFWOMIOgEvyD86btkveqR1sraW1amsaY
         Du/QtTZHAEu1Tql6PhZfMRkT7d4YD1NuIsaYkZ0xR1cYH6JSHuZ7erZ4A4P0B3WhDD5Q
         dN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151554; x=1792756354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXYDFkn2ySA9cGPfoqTWvjPqTd4qZvAgRBnTI9wDoKs=;
        b=DUtCix1r/UXScp/jSuhdlda1s44PsO0hFGWv4M6mbbMwNX3DLdjHlbvCNrywKBnha4
         SFcaaR9/+/ZSUaB+lAcT3Y4uoeOXdRbrxiwOBMFHk28FMgseO2ubnZawfHBYvJQgzRoU
         knzx2afXeCHkeiq0W9tHoq5tgdY6nw7QsPthXs+DhtCadAtxO7cAeyWE4m9u3FwRBDdp
         l7h8jpvs90X7DmMt48Dxa0YRdhZBiRT0N5o/W0i7LIU5YomHet4N4NvYG4PzFEzfHqYt
         V69Lt+1kRHlzs62gCHOiCGi14OV1VnPA/vWNZjVPj5/OEGRBZ4gsBbZLfd0fob/WddPe
         BC/A==
X-Gm-Message-State: AFq9FYLywW6JjKQsCSeWjLqVqC7ZzlC+rJrcYl4bCEs2d9RwG4JKOTMD
	RB+XEFNXb/HL9qmBgJVevJOLCM/b+p8Nl0ZKcGqYb2a+4bLCNlc8HlXzDWmBfD3v4KDmswdzgj6
	vDeTQ
X-Gm-Gg: AYBFou0fZJJePsIs+SQWVSohKoNpT3C7zve6a6/rdKe3r+NU2Ym6Oqqtx1PyZ9DpVnR
	xr+LRXnqapENhLz6YyoBQ/ov5syhP73+o8kpYSTa0UpSB/zGmADTqvC7wQl6yBcTPYKgvEeWuo9
	hUZziER4dMvthu30BQQv7Df9+lHZESE+osb0/EHbvOiPDvblMNwnMX653815XOPI5fNbSAUgv5q
	6Ofq1yT+fOINa8rBm6vY+NErZFnbt/fBDWu1KDIDDrau3zAmu3r/XGIpuxCczIcovGV7v0/I05w
	LwSoUD7gQKWOT4j7d2LP5UA6+WoxAU6Uwa4XxuvXFneJQ2pFdiUijngvGanrPgw7IXbJAgrNatn
	Tf3TUqoXpkgwaD6MOtUe2tBAJmukb+4C8G2MQAhpcZCsgvPcBUtXBIQUmw9HiOXr2NWPes/eXq/
	EkXf2g9+yq3THrJbnpF2NL/Yt5TYOcfCK0ndUTi9Mh5EYt3GVv44LR+3W6wHT4BvRGsV9N2KOuP
	Ik=
X-Received: by 2002:a17:90b:3890:b0:3ac:a521:95e with SMTP id 98e67ed59e1d1-3aca52109b9mr4731061a91.47.1792151554011;
        Fri, 16 Oct 2026 04:52:34 -0700 (PDT)
Received: from localhost ([106.38.226.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc492fa54sm3903354a91.13.2026.10.16.04.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:52:33 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	dennis@kernel.org
Subject: [PATCH 0/2] writeback: fix timestamp and dirty-state handling in wb switches
Date: Fri, 16 Oct 2026 19:52:28 +0800
Message-Id: <20261016115230.3640770-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes two issues when moving inodes between writeback
structures:

1. Update dirtied_when rather than dirtied_time_when when inserting an
   inode at the newest end of the target dirty list. This maintains the
   list ordering without resetting the lazytime expiration timestamp.
2. Clear the source wb's dirty-I/O state and bandwidth contribution when
   inode migration leaves its dirty-I/O lists empty.

Julian Sun (2):
  writeback: reset dirtied_when when switching wbs
  writeback: clear old wb dirty state after inode switches

 fs/fs-writeback.c  | 7 ++++---
 include/linux/fs.h | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)


base-commit: 6af5ad50442eacebf18174e487efbd8c192e73e7
-- 
2.39.5
